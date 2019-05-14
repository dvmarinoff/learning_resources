#
# 2. Designing Clases with Single Responsibility
#
class Gear
   attr_reader :chainring, :cog, :rim, :tire
   def initialize(chainring, cog, rim, tire)
     @chainring = chainring
     @cog       = cog
     @rim       = rim
     @tire      = tire
   end

   def ratio
     chainring / cog.to_f
   end

   def gear_inches
     ratio * (rim + (tire * 2))
   end
end

# Gear v1
# puts Gear.new(50, 11).ratio
# puts Gear.new(34, 28).ratio

# Gear v2
puts Gear.new(48, 11, 28, 1.25).gear_inches
puts Gear.new(48, 11, 20, 1.75).gear_inches

#
# Depend on Behavior not Data
#

# - Hide Instance Variables
#
# def cog @cog end
# do not use directly @cog
#
# you can change what cog is without affecting client code

# - Hide Data Structures
# depending on complicated data structure is even worse

# data:
# [[622, 25], [622, 28], [622, 32], [622, 38]]
# the knowedge that rims are at 0 should not be duplicated

class ObscuringReference
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def diameter
    # 0 is rim, 1 is tire
    data.collect { |cell|
      cell[0] + (cell[1] * 2) }
  end
  # ... many other methods that index the array (data)
end

class RevealingReferences
  attr_reader :wheels
  def initialize(data)
    @wheels = wheelify(data)
  end

  def diameters
    wheels.collect { |wheel|
      wheel.rim + (wheel.tire * 2) }
  end

  Wheel = Struct.new(:rim, :tire)

  def wheelify(data)
    data.collect { |cell|
      Wheel.new(cell[0], cell[1]) }
  end
end

# All knowledge of the structure of the incoming array has been
# isolated inside the wheelify method, which converts the 2d array
# into an array of Structs.

#
# Enforcing Single Responsibility Everywhere
#

# Extract Extra Responsibilities from Methods

# the diameters method has 2 responsibilities:
# - iterate (map) over the wheels
# - calculate the diameter of each wheel

# Is it Overdesign?
# Will you need to take the diameter of just one Wheel? Yes.

def diameters
  wheels.collect { |wheel| diameter(wheel) }
end

def diameter(wheel)
  wheel.rim + (wheel.tire * 2)
end

def gear_inches
  ratio * diameter
end

# Good practices reveal design.
# SRP methods:
# - Expose previously hidden qualities
# - Avoid the need for comments
# - Encourage reuse
# - Are easy to move to another class

# Isolate Extra Responsibilities in Classes

# When writing changable code, it's best to postpone decisions
# until you are absolutely forces to make them.

# You don't need to commit to full Wheel class yet.

class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @wheel = Wheel.new(rim, tire)
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ration * wheel.diameter
  end

  Wheel = Struct.new(:rim, :tire) do
    def diameter
      wheel.rim + (wheel.tire * 2)
    end
  end
end

# The Real Wheel
# now you need to calculate speed and you need wheel cicumference.

class Wheel
  attr_reader :rim :tire
  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    rim + (2 * tire)
  end

  def circumference
    Math::Pi * diameter
  end
end

class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel=nil)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end
end

@wheel = Wheel.new(28, 38)
puts @wheel.circumference

#
# 3. Managing Dependancies
#

# Because well designed objects have single responsiblity, they need
# to collaborate to accomplish complex tasks.
# To collaborate, an object must know about others.
# Knowing creates dependency.

# An object has dependancy when it knows:
# - the name of another class
# - the name of a message that it intends to send to someone other than self
# - the argument that a message requires
# - the order of those arguments

# Test-to-code over-coupling is as bad as code-to-code over-coupling.

# - Inject Dependencies

# Gear should not care about the class of the object, it's the message
# that is important. Gear needs access to an object that can respond
# to diameter; a duck type.

class Gear
  attr_reader :chainring :cog :wheel
  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  def gear_inches
    ratio * wheel.diameter
  end

  # ...
end

Gear.new(48, 11, Wheel.new(28, 38)).gear_inches

# This technique is known as Dependency Injection.

# - Isolate Dependancies

# If you are so constraint theat you can not move the creation of wheel
# isolate the instance creation to the init or other special method.

# - Isolate Vulnarable External Messages

# gear_inches sends diameter to wheel and if the method was more complex
# you want to move the message to its own diameter method (DRY the code).

def gear_inches
  # ... scary math
  res = some_intermediate_result * diameter()
  # ... more scary math
end

def diameter
  wheel.diameter
end

# Now if Wheel changes the name or signature of diameter you have only
# one method to change in Gear.

# - Removing Argument Order Dependency

# Arguments, and their order change especially early on.
# Use hashes to initialize arguments.

class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(args)
    @chainring = args[:chainring]
    @cog = args[:cog]
    @wheel = args[:wheel]
  end
  # ...
end

Gear.new(
  :chainring => 48
  :cog => 11
  :wheel => Wheel.new(28, 38)
).gear_inches

# - Explicitly Define Defaults
# use with care when you have boolean values in agrs

class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(args)
    @chainring = args[:chainring] || 48
    @cog = args[:cog] || 11
    @wheel = args[:wheel]
  end
  # ...
end

class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(args)
    args = defaults.merge(args)
    @chainring = args[:chainring]
    @cog = args[:cog]
    @wheel = args[:wheel]
  end

  def defaults
    {:chainring => 48, :cog => 11}
  end
end

# especially useful when the defaults are more complicated
# (not just numbers and strings).
# Note that this will set the defaults only if the fields are entirly
# missing from args. => the caller can set them to false and nil,
# something that is not possible with the || technique.

# - Isolate Multiparameter Initialization

# Imagine that Gear is part of a framework you have no control over.

module SomeFramework
  class Gear
    attr_adder :chainring, :cog, :wheel
    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog = cog
      @wheel = wheel
    end
    # ...
  end
end

module GearWrapper
  def self.gear(args)
    SomeFramework::Gear.new(
      args[:chainring],
      args[:cog],
      args[:wheel]
    )
  end
end

GearWrapper.gear(
  :chainring => 48,
  :cog => 11,
  :wheel => Wheel.new(28, 38).gear_inches
)

# separate object to which you can send the gear message while
# simultaneously conveying the idea that you don't expect to have
# instances of GearWrapper.

# GearWrapper is a factory. Its sole purpose is to create instances
# of some other class.

# Managing Dependency Direction

# - Reversing Dependencies

# The direction of dependency could be easily reversed.
# This rises question does direction of dependency matters?
# Yes and it has far reaching consequences that manifest
# themselves for the life of your application.

class Wheel
  attr_reader :rim, :tire, :gear
  def initialize(rim, tire, chainring, cog)
    @rim = rim
    @tire = tire
    @gear = Gear.new(chainring, cog)
  end

  def diameter
    rim + (tire * 2)
  end

  def gear_inches
    gear.gear_inches(diameter)
  end

  # ...
end

Wheel.new(28, 38, 48, 11).gear_inches

# - Choosing Dependency Direction

# Tell to your classes to depend on things that change less often
# than they do.

# - Some classes are more likely to change
# - Concrete classes are more likely to change than abstract classes
# - Changing a class that has many dependents will result in widespread consequences

# y
# | A D
# | B C
# +----x
#
# x - # dependencies
# y - likelihood to change
#
# A - Abstract Zone: unlikely changes, but broad effect
# B - Neutral Zone: unlikely changes and small effect
# C - Neutral Zone: likely changes, but small effect
# D - Danger Zone: likely changes, broad effect

# It can be way more worse if Zone D classes were more likely to
# change than their dependencies.

# Summary
#
# Dependency management is core to creating future-proof applications.
# Injecting dependencies creates loosely coupled objects that can be
# reused in novel ways.
# Isolating dependencies allows objects to quickly adapt to unexpected changes.
# Depending on abstractions decreases the likelihood of facing these changes.
# The key to managing dependencies is to control their direction.
# The road to maintenance nirvana is paved with classes that depend on things
# that change less often than they do.

#
# 4.
#

# Understanding Interfaces

# The many meanings of Interface:
# - the kind of interface that is within a class
#   (methods intended to be used by others)
# - the kindof interface that spans across classes
#   (a set of messages, the messages themselves define the interface)

# Defining Interfaces

# public interfaces
# - reveal primary responsibility
# - are expected to be envoked by others
# - will not change on a whim, are safe to use

# private interfaces
# - handle implementation detail
# - are not expected to be send by other objects
# - can change, are unsafe

# Finding the Public Interface

# Don't focus on Domain Objects, but on the messages that pass
# between them. These are guides that lead you to discover objects.

# UML diagrams may be useful

# Moe wants a suitable trip and a rental bike for 1 May.

# Case 1:
# Attempt 1
# Customer { Trip.suitable_trips }
# - Customer expects Trip to handle suitable_trip and also find Bike

# Customer                                 Trip                      Bike
# | suitable_trip(on_date, of_difficulty)  |                         |
# |--------------------------------------> |                         |
#                                          | suitable_bicycle        |
#                                          | (trip_date, route_type) |
#                                          |------------------------>|

# Attempt 2
# Customer { Trip.suitable Bike.suitable }
# - Customer owns Trip and Bike

# Customer                                 Trip  Bike
# | suitable_trip(on_date, of_difficulty)  |     |
# |--------------------------------------> |     |
# |                                              |
# | suitable_bicycle(trip_date, route_type)      |
# |--------------------------------------------->|

# Asking for "What" instead of telling "How"

# Case 2:
# Attempt 1:
# Trip                    Mechanic
# |                       |
# | clean_bike(bike)   -> |
# | pump_tires(bike)   -> |
# | lube_chain(bike)   -> |
# | check_brakes(bike) -> |

# Trip knows too much about Mechanic, if Mechanic changes, Trip changes.

# Attempt 2:
# Trip                    Mechanic
# |                       |
# | prepare_bike(bike)    |
# |---------------------->| clean_bike(bike)
# |                       | pump_tires(bike)
# |                       | lube_chain(bike)
# |                       | check_brakes(bike)
# |                       | ...

# Seeking Context Independance

# Attempt 3:
# Trip                    Mechanic
# |                       |
# | prepare_trip(self) -> |
# |            <- bikes() |
# | prepare_bike(bike) -> |

# Trip just tells Mechanic what it wants and passes itself as argument
# public interface for Trip is bikes()
# public interface for Mechanic is prepare_trip() and prepare_bikes()

# Moving from procedural (1) to oop (3) code:
# 1: I know what I want and I know how you do it
# 2: I know what I want and I know what you do
# 3: I know what I want and I trust you to do your part

# Using Messages to Discover Objects

# Attempt 4:
# Customer            TripFinder          Trip   Bike
# |                   |                   |      |
# | suitable_trips -> | suitable_trips -> |      |
# |                   | suitable_bike ---------> |

# Creating a Message-Based Application

# Writing Code That Puts Its Best (Inter)Face Forward

# Create Explicot Interfaces:
# - be about what not how
# - have names that, insofar as you can anticipate, will not change
# - take a hash as an options parameter

# private, proteced and public in Ruby may be useful to explicitly
# communicate which methods are dependable, but they are easy to
# circumvent. Many programmers use conventions instead (_ in RoR).

# while things change and you can not predict the future,
# do not depend on a private method of an external framework.

# Minimize Context

# The Law of Demeter

# A set of coding rules that results in a loosely coupled objects.
# It prohibits routing a message to a 3rd object via a 2nd object of a
# different type.
# "Only talk to your immediate neighbors".
# "Use only one dot".

customer.bike.wheel.rotate
# clear violation

customer.bike.wheel.tire
# violation even with attributes (especially when you intend change)

hash.keys.sort.join(', ')
# We need to check the types of each return object:
# Enumerable -> Enumerable -> Enumerable-of-Strings
# We are fine here.
# Avoid violations with delegation.

# Summary

# The purpose of ood is to reduce the cost of change.
# Shift to a message-based perspective, the messages you find will become
# public interfaces in the objects they lead you to discover. Ask what the
# sender wants instead of telling the receiver how to behave.

#
# 5. Reducing Costs With Duck Typing
#

# Understanding Duck Typing

# Duck types are public interfaces that are not tied to any specific class.
# It's not what an objects is (class/type) that matters, it's what it does.
# If every object trusts all others to be what it expect at any given
# moment, and any object can be any kind of thing, the design possibilities
# are infinite.

# Overlookig the Duck

class Trip
  attr_reader :bicycle, :customers, :vehicles

  # this 'mechanic' arg could be of any class
  def prepare(mechanic)
    mechanic.prepare_bicycles(bycycles)
  end
  # ...
end

class Mechanic
  def prepare_bicycles(bycycles)
    bicycles.each { |bicycle| prepare_bicycle(bicycle) }
  end

  def prepare_bicycle(bicycle)
    # ...
  end
end

# While Trip prepare method does not depend directly on Mechanic, but it
# does depent on receving an object that can respond to prepare_bicycles.

# Compounding the Problem

# We have change. In addition to Mechanic, trip preparation now involves
# a trip coordinator and a driver. Explosion of dependencies.

class Trip
  attr_reader :bicycle, :customers, :vehicles

  def prepare(preparers)
    preparers.each { |preparer|
      case preparer
      when Mechanic
        preparer.prepare_bicycles(bycycles)
      when TripCoordinator
        preparer.buy_food(customers)
      when Driver
        preparer.gas_up(vechicle)
        preparer.fill_water_tank(vechicle)
      end
    }
  end
end

# This tension between the costs of concretion and the costs of
# abstraction is fundamential to ood.

# Findng the Duck

# Attempt 1:
# with concreate class
# - simple to understand
# - dangerous to extend

# Attempt 2:
# with a duck type
# - more abstract
# - ease of extension

class Trip
  attr_reader :bicycle, :customers, :vehicles

  def prepare(preparers)
    preparers.each { |preparer| preparer.prepare_trip(self) }
  end
end

class Mechanic
  def prepare_trip(trip)
    prepare_bicycles(trip.bycycles)
  end
end

class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end
end

class Driver
  def prepare_trip(trip)
    gas_up(trip.vechicle)
    fill_water_tank(trip.vechicle)
  end
end

# Polymorphism:
# the ability of many different objects to respond to the same message.
# Senders of the message need not care about the class of the receiver.
# Receivers supply their own specific version of the behavior.

# Recognizing Hidden Ducks:
# Any of those may be a sign for a hidden duck:
# - swtch case on class
# - kind_of? and is_a?
# - responds_to?

# Summary:

# Duck typing detaches public interfaces from specific classes, creating
# virtual types that are defined by what they do instead of who they are.

#
# 6. Aquiring Behavior Through Inheritance
#

# Inheritance is a mechanism for automatic message delegation.
# It defines a forwarding path for not-understood messages.

# Relationships:
# - classical (form class not archaic) uses superclass/subclass mechanism.
# - prototypal
# - ruby modules

# Recognizing Where to Use Inheritance

# Attempt 1:
class Bicycle
  attr_reader :size, :tape_color

  def initialize(args)
    @size = args[:size]
    @tape_color = args[:tape_color]
  end

  def spares
    { chain: '10-speed',
      tire_size: '23',
      tape_color: tape_color
    }
  end
  # ...
end

bike = Bicycle.new(size: 54, tape_color: 'red')

# Bicycle assumes a road bike, what if we add a mtb?
# Attempt 2:

class Bicycle
  attr_reader :size, :tape_color,
              :style, :front_shock, :rear_shock

  def initialize(args)
    @size = args[:size]
    @tape_color = args[:tape_color]

    @style = args[:style]
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  def spares
    if style == :road
      { chain: '10-speed',
        tire_size: '23', # mm
        tape_color: tape_color
      }
    else
      { chain: '10-speed',
        tire_size: '2.1', # inches
        rear_shock: rear_shock
      }
    end
  end
  # ...
end

# Multiple inheritance
# - 2 or more parent objects,
# - but which parent has priority?
#
# Single inheritance
# - 1 parent, many subclasses
#
# Duck types cut across classes and share code via 'Ruby modules'.

# A nil? message is being send, if receiver is:
# NilClass -> true
# String -> AnyOtherClassInBetween -> Object -> false

class Object
  def nil? false end
end

class NilClass
  def nil? true end
end

class AnyOtherClass
  # ...
end

# Attempt 3:
# Sending super
# Sending super in a method passes that message up the superclass chain.
# - super(args) in MTB subclass envokes initialize(args) in Bike superclass

class Bicycle
  attr_reader :size
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock
  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
    super(args)
  end
  def spares
    super.merge(rear_shock: rear_shock)
  end
end

# Creating an Abstract Class

# Bike is now not a class to which you wound send the 'new' message.
# Bike is abstract. The goal is to move there common behavior.

# When/What to Abstract?
# Creating a hierarchy always has costs. Waiting for a requirement
# for 3rd kind of bike will give you higher chances of getting the
# abstraction right.
# - if duplicated code will changes alot it is better to abstract at 2.
# - if stable and 3rd bike is imminent duplicate and wait for more
#   information when 3.

# Promoting Abstract Behavior
# How to proceed?
# It's easier to promoto code up to a superclass than to demote
# it down to a subclass.
# Many of the difficulties of inheritance are caused by a failure to
# rigoriusly separate the concrete from the abstract.

# What will happen when I am wrong?
# Every decision has:
# - cost to implement it
# - cost to change it
# Minimize costs.

# Attempt 4:
# Step 1:
# RoadBike still works while MountainBike is broken.

class Bicycle
  # This class is now empty.
  # All code has been moved to RoadBike.
end
class RoadBike < Bicycle
  # Now a subclass of Bicycle.
  # Contains all code from the old Bicycle class.
end
class MountainBike < Bicycle
  # Still a subclass of Bicycle (which is now empty).
  # Code has not changed.
end

# Step 2:

class Bicycle
  attr_reader :size
  def initialize(args = {})
    @size = args[:size]
  end

  def spares
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color
  def initialize(args)
    @tape_color = args[:tape_color]
    super(args)
  end

end

class MountainBike < Bicycle
end


# Template Method Pattern (all the way):

# Managing Coupling Between Superclasses and Subclasses

# Attempt 5:
class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args = {})
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
  end

  def spares
    { tire_size: tire_size,
      chain: chain }
  end

  def default_chain
    '10-speed'
  end

  def default_tire_size
    raise NoImplementedError
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(args)
    @tape_color = args[:tape_color]
    super(args)
  end

  def spares
    super.merge({ tape_color: tape_color })
  end

  def default_tire_size
    '25'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
    super(args)
  end

  def spares
    super.merge({ rear_shock: rear_shock})
  end

  def default_tire_size
    '2.1'
  end
end

# This works, but it is not good enough.
# The subclasses know:
# - about each other (spare parts specialization)
# - about the superclass (spares, initialize)
# both created by sending super in the subclasses,
# which now effectively know about the algorithm

# If someone added another bike and forgot to send super in initialize or
# spares methods (maybe yourself in 2 months or more).

# Decoupling Subclasses Using Hook Messages

# Hooks give control back to the abstract algorithm and the superclass.
# Bicycle is now responsible for sending post_initialize message.
# RoadBike and MountainBike contain only specializations.
# New subclasses need only implement the template methods.

# Attempt 6:
# The final hierarchy

class Bicycle
  attr_reader :size, :chain, :tire_size
  def initialize(args = {})
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
    post_initialize(args)
  end

  def spares
    { tire_size: tire_size,
      chain: chain }.merge(local_spares)
  end

  def post_initialize(args)
    nil
  end

  def local_spares
    {}
  end

  def default_chain
    '10-speed'
  end

  def default_tire_size
    raise NoImplementedErrror
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(args)
    @tape_color = args[:tape_color]
  end

  def local_spares
    { tape_color: tape_color }
  end

  def default_tire_size
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  def local_spares
    { rear_shock: rear_shock }
  end

  def default_tire_size
    '2.1'
  end
end

class RecumbentBike < Bicycle
  attr_reader :flag

  def post_initialize(args)
    @flag = args[:flag]
  end

  def local_spares
    { flag: flag }
  end

  def default_chain
    '9-speed'
  end

  def default_tire_size
    '28'
  end
end

# Summary

# When your problem is one of needing numerious specializations of a stable
# common abstraction, inheritance can be a low-cost solution.
# Isolate shared code and common algorithms in an abstract class by pushing
# code from concrete subclasses.
# Template methods are used by superclasses to invite inheritors to supply
# specializations (without coupling with 'super').
# Hook methods allow subclasses to contribute specializetion without
# knowing the abstract algorithm.

#
# 7. Sharing Role Behavior with Modules
#

# What if you need Recumbent-Mountain bikes? (Gravel Bikes?)

# Inheritance has many alternatives.
# No design technique is free. Creating the most cost-effective application
# requires making informed trade-offs.

# Understanding Roles

#
