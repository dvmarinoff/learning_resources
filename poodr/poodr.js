// NOTE:
// All examples involve a process of iterative refining thus I'm using
// the 'var' syntax. It also plays better with the repl.

//
// 02. Desinging Classes with Single Responsibiliy
//

// Gear v1
var Gear = class {
    constructor(args) {
        this.chainring = args.chainring;
        this.cog = args.cog;
    }
    get_chainring() { return this.chainring; }
    get_cog() { return this.cog; }
    ratio() { return this.get_chainring() / this.get_cog(); }
}

var Mammal = class {
    constructor(args) {
        this._sound = args.sound;
        this.post_initialize(args);
    }
    read_sound() { return this._sound; };
    post_initialize(args) { return null; }
    talk() { return "NoImplementedError"; }
};

var Dog = class extends Mammal {
    post_initialize(args) {
        this._guard = args.guard || this.default_guard();
    }
    read_guard() { return this._guard; }
    talk() { this.read_sound(); }
    default_guard() { return "rrrrh"; }
};

var Cat = class extends Mammal {
    post_initialize(args) {
        Object.assign(this.defaults(), args);
        this._hunt = args.hunt;
    }
    read_hunt() { return this._hunt; }
    talk() { return this.read_sound(); }
    default_hunt() { return "jump, jump, catch"; }
    defaults() { return { hunt: "jump, jump, catch" }; }
};

var d = new Dog({sound: "woof", guard: "rrrrh rolf"});
d.talk();
d.read_guard();
var t = new Cat({sound: "miay"});
t.talk();
t.read_hunt();



// Gear v2
var Wheel = class {
    constructor(args) {
        this.rim = args.rim;
        this.tire = args.tire;
    }
    get_rim() { return this.rim; }
    get_tire() { return this.tire; }
    diameter() { return this.get_rim() + (2 * this.get_tire()); }
    circumference() { return Math.PI * this.diameter(); }
}

var Gear = class {
    constructor(args) {
        this.chainring = args.chainring;
        this.cog = args.cog;
        this.wheel = args.wheel; // wheel object that responds to diameter
    }
    get_chainring() { return this.chainring; }
    get_cog() { return this.cog; }
    ratio() { return this.get_chainring() / this.get_cog(); }
    gear_inches() { return this.ratio() * this.wheel.diameter(); }
}

//
// 3. Managing Dependancies
//

// - Explicitly Define Defaults
// use with care when you have boolean values in agrs
var Gear = class {
    constructor(args) {
        Object.assign(this.defaults(), args);
        this.chainring = args.chainring;
        this.cog = args.cog;
        this.wheel = args.wheel;
    }
    get_chainring() { return this.chainring; }
    get_cog() { return this.cog; }
    ratio() { return this.get_chainring() / this.get_cog(); }
    gear_inches() { return this.ratio() * this.wheel.diameter(); }
    defaults() { return { chainring: 53, cog: 11 }; };
}

// - Isolate Multiparameter Initialization
// Imagine that Gear is part of a framework you have no control over.

var Gear = class {
    constructor(chainring, cog, wheel) {
        this.chainring = chainring;
        this.cog = cog;
        this.wheel = wheel;
    }
    // ...
}

function GearWrapper () {
    this.gear = function(args) {
        return new Gear(args.chainring, args.cog, args.wheel);
    };
}

// separate object to which you can send the gear message while
// simultaneously conveying the idea that you don't expect to have
// instances of GearWrapper.

// GearWrapper is a factory. Its sole purpose is to create instances
// of some other class.

//
// 4. Creating Flexible Interfaces
//

// Attempt 1:
var Customer = class {
    search() {
        Trip.suitable_trip(on_date, of_difficulty);
    }
};
var Trip = class {
    suitable_trip(on_date, of_difficulty) {
        Bike.suitable_bikes(on_date, route_type);
    }
};
var Bike = class {
    suitable_bikes(trip_date, route_type) {}
};

// Attempt 2:
var Customer = class {
    search() {
        Trip.suitable_trip();
        Bike.suitable_bike();
    }
};

// Asking for "What" instead of "How"

// Case 2:
// Attempt 1:
// 1: I know what I want and I know how you do it
var Mechanic = class {
    clean_bike(bike) {}
    pump_tires(bike) {}
    lube_chain(bike) {}
    check_brakes(bike) {}
};
var Trip = class {
    prepare() {
        Mechanic.clean_bike(bike);
        Mechanic.pump_tires(bike);
        Mechanic.lube_chain(bike);
        Mechanic.chieck_brakes(bike);
    }
};

// Attempt 2:
// 2: I know what I want and I know what you do
var Trip = class {
    prepare() {
        Mechanic.prepare_bikes(bikes);
    }
};
var Mechanic = class {
    prepare_bikes(bikes) {}
    clean_bike(bike) {}
    pump_tires(bike) {}
    lube_chain(bike) {}
    check_brakes(bike) {}
};

// Attempt 3:
// 3: I know what I want and I trust you to do your part
var Trip = class {
    prepare() {
        Mechanic.prepare_trip(self);
        bikes.map(bike => Mechanic.prepare_bike(bike));
    }
    bikes () {}
};
var Mechanic = class {
    prepare_trip(trip) {
        let bikes = trip.bikes();
    }
    prepare_bike(bike) {}
    clean_bike(bike) {}
    pump_tires(bike) {}
    lube_chain(bike) {}
    check_brakes(bike) {}
};

// Seeking context Independence

// Using Messages to Discover Objects

// Creating Message-Based Apllication

//
// 5. Reducing Costs With Duck Typing
//

// Duck types are public interfaces that are not tied to any specific class.
// It's not what an objects is (class/type) that matters, it's what it does.
// If every object trusts all others to be what it expect at any given
// moment, and any object can be any kind of thing, the design possibilities
// are infinite.

// Overlooking the Duck
var Trip = class {
    prepare(prepares) {
        preparerers.map( preparer => {
            if(preparer instanceof Mechanic) {
                preparer.prepare_bicycles(this.bikes);
            }
            if(preparer instanceof TripCoordinator) {
                preparer.buy_food(this.customers);
            }
            if(preparer instanceof Driver) {
                preparer.fill_water_tank(this.vehicle);
            }
        });
    }
};

// Finding the Duck Type
var Trip = class {
    prepare(preparers) {
        preparers.for_each(preparer => preparer.prepare_trip(this));
    }
};
var Mechanic = class {
    prepare_trip(trip) {
        prepare_bikes(trip.bikes);
    }
};
var TripCoordinator = class {
    prepare_trip(trip) {
        buy_food(trip.customers);
    }
};
var Driver = class {
    prepare_trip(trip) {
        gas_up(trip.vechicle);
        fill_water_tank(trip.vechicle);
    }
};

// Summary:

// Duck typing detaches public interfaces from specific classes, creating
// virtual types that are defined by what they do instead of who they are.

//
//  6. Aquiring Behavior Through Inheritance
//

// Inheritance is a mechanism for automatic message delegation.
// It defines a forwarding path for not-understood messages.

// Template Method Pattern (all the way):

// The technique of defining a basic structure in the superclass and
// sending messages to acquire subclass-specific contributions is known
// as the template method pattern.
//
// we are defining the defaults as methods, but giving the subclasses the
// opportunity to override them with specializations.

// Managing Coupling Between Superclasses and Subclasses

// Decoupling Subclasses Using Hook Messages

// Hooks give control back to the abstract algorithm and the superclass.
// Bicycle is now responsible for sending post_initialize message.
// RoadBike and MountainBike contain only specializations.
// New subclasses need only implement the template methods.

// Attempt 6:
// The final hierarchy
var Bicycle = class {
    constructor(args) {
        this._size = args.size;
        this._chain = args.chain;
        this._tire_size = args.tire_size;
        this.post_initialize(args);
    }
    get_size() { return this._size; }
    get_chain() { return this._chain; }
    get_tire_size() { return this._tire_size; }
    post_initialize(args) { return null; }
    local_spares() { return {}; }
    spares() { return Object.assign({ tire_size: this.get_tire_size(), chain: this.get_chain() }, this.local_spares); }
    default_chain() { return "10-speed"; }
    default_tire_size() { return Error("NoImplementedError"); }
};

var RoadBicycle = class extends Bicycle {
    post_initialize(args) {
        this._tape_color = args.tape_color || this.default_tape_color();
    };
    get_tape_color() { return this._tape_color; }
    local_spares() { return { tape_color: this.get_tape_color() }; }
    default_tire_size() { return "23"; }
    default_tape_color() { return "black"; };
};

var MountainBike = class extends Bicycle {
    post_initialize(args) {
        this._front_shock = args.front_shock || this.default_front_shock();
        this._rear_shock = args.rear_shock || this.default_rear_shock();
    }
    get_front_shock() { return this._front_shock; }
    get_rear_shock() { return this._rear_shock; }
    local_spares() { return { rear_shock: this.get_rear_shock() }; }
    default_tire_size() { return "2.1"; }
    default_front_shock() { return "RS Front"; }
    default_rear_shock() { return "RS Rear"; }
};

var RecumbentBike = class {
    post_initialize(args) {
        this._flag = args.flag || this.default_flag();
    }
    get_flag() { return this._flag; }
    local_spares() { return { flag: this.get_flaf() }; }
    default_flag() { return  "cool flag"; }
    default_chain() { return  "9-speed"; }
    default_tire_size() { return  "28"; }
};

//
// 7. Sharing Role Behavior with Modules
//

// Some problems require sharing behavior among otherwise unrelated
// objects. This behavior is orthogonal to class, it’s a role an object
// plays.

// Discovering a duck type

// Target isn't a specific class -> it is a duck type

// Domain problem: Schdule

// v1: Schedule knows the lead time for other objects
var Schedule = class {
    is_schedulable(target, starting, ending) {
        if(target instanceof x) lead_days = 1;
        if(target instanceof y) lead_days = 3;
        if(target instanceof z) lead_days = 4;
    }
    // ...
};

// v2: Schedule expects targets to know their own lead days
var Schedule = class {
    is_schedulable(target, starting, ending) {
        let lead_days = target.lead_days;
    }
    // ...
};












// is_scheduled(target, starting, ending) {
// }
// add(target, starting, ending) {}
// remove(target, starting, ending) {}




