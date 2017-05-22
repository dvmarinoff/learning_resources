
Description:


Content:

I.Javascript Basics
I. Javascript OOP
II. Javascript FP

I. Javascript Basics

    1. What is Javascript?
    - MDN: a lightweight, interpreted, object-oriented language with first-class functions. It is a prototype-based,
     multi-paradigm scripting language that is dynamic, and supports object-oriented, imperative,
     and functional programming styles.

     WHAT ????

     In short: // TODO: short simple explanation

     And here are some definition for all the cs word:

    - interpreted:
       - a question of language implementation. Compiled languges (like C) can have interpreters.
       - the CPU's "native" language is assembly language

       - a language can have compiled or interpreted implemantaion

           - In a compiled implementation, the original program is translated into native machine instructions,
            which are executed directly by the hardware

           - In an interpreted implementation, the original program is translated into something else.
            Another program, called "the interpreter", then examines "something else" and performs whatever
            actions are called for.

    - object-oriented - a programming paradigm based on the concept of "objects", which may contain data,
     in the form of fields, often known as attributes; and code, in the form of procedures, often known as methods.
     A feature of objects is that an object's procedures can access and often modify the data fields of the object
     with which they are associated (objects have a notion of "this" or "self"). In OOP, computer programs are designed
     by making them out of objects that interact with one another.

    - first-class functions - the language supports passing functions as arguments to other functions, returning them
     as the values from other functions, and assigning them to variables or storing them in data structures.

    - prototype-based - a style of object-oriented programming in which behaviour reuse (known as inheritance)
    is performed via a process of reusing existing objects via delegation that serve as prototypes.

    - scripting language:
       - scripts are programs written for a special run-time environment that automate the execution of tasks
       - A scripting language is a language that "scripts" other things to do stuff. The primary focus isn't
        primarily building your own apps so much as getting an existing app to act the way you want, e.g.
        JavaScript for browsers, VBA for MS Office.

    - dynamic language
       - is a class of high-level programming languages which, at runtime, execute many
        common programming behaviors that static programming languages perform during compilation.
        These behaviors could include extension of the program, by adding new code, by extending objects
        and definitions, or by modifying the type system. Many of these features were first implemented
        as native features in the Lisp.

       - Reflection - is the ability of a computer program to examine, introspect, and modify its own
        structure and behavior at runtime

       - Macros - A limited number of dynamic programming languages provide features which combine
        code introspection (the ability to examine classes, functions and keywords to know what they are,
        what they do and what they know) and eval in a feature called macros. Most programmers today who
        are aware of the term macro have encountered them in C or C++, where they are a static feature
        which are built in a small subset of the language, and are capable only of string substitutions
    on the text of the program. In dynamic languages, however, they provide access to the inner workings
    of the compiler, and full access to the interpreter, virtual machine, or runtime, allowing
    the definition of language-like constructs which can optimize code or modify the syntax
    or grammar of the language.


- imperative style:
   - uses a sequence of statements to determine how to reach a certain goal. These statements are
    said to change the state of the program as each one is executed in turn.
   - a programming paradigm that uses statements that change a program's state.
    In much the same way that the imperative mood in natural languages expresses commands,
    an imperative program consists of commands for the computer to perform.
    Imperative programming focuses on describing how a program operates.

- functional style
   - a type of declarative programming focused on referential transperancy and pure functions
   - declarative programming - The focus is on what the computer should do rather than how it should do it (ex. SQL).
   - referential transperancy:
        - The term "referential transparency" comes from analytical philosophy, the branch of philosophy that
         analyzes natural language constructs, statements and arguments based on the methods of logic and mathematics.
         In other words, it is the closest subject outside computer science to what we call programming language semantics.
         The philosopher Quine was responsible for initiating the concept of referential transparency, but it was
         also implicit in the approaches of Bertrand Russell and Alfred Whitehead.

         At its core, "referential transparency" is a very simple and clear idea. The term "referent" is used
         in analytical philosophy to talk about the thing that an expression refers to. It is roughly the same as what
         we mean by "meaning" or "denotation" in programming language semantics.
         "the capital of Scotland" refers to the city of Edinburgh. That is a straightforward example of a "referent".

         A context in a sentence is "referentially transparent" if replacing a term in that context by another term that
         refers to the same entity doesn't alter the meaning. For example

         The Scottish Parliament meets in the capital of Scotland. Means the same as
         The Scottish Parliament meets in Edinburgh.

         So the context "The Scottish Parliament meets in ..." is a referentially transparent context.
         On the other hand, in the sentence,

         Edinburgh has been the capital of Scotland since 1999.

         we can't do such a replacement. If we did, we would get "Edinburgh has been Edinburgh since 1999",
         which is a nutty thing to say, and doesn't convey the same meaning as the original sentence.
         So, it would seem that the context "Edinburgh has been ... since 1999" is referentially opaque.

        - An expression is said to be referentially transparent if it can be replaced with its corresponding
         value without changing the program's behavior. As a result, evaluating a referentially transparent function
         gives the same value for same arguments. Such functions are called pure functions.
    - pure functions:
        - The function always evaluates the same result value given the same argument value(s).
         The function result value cannot depend on any hidden information or state that may change while program
         execution proceeds or between different executions of the program, nor can it depend on any external
         input from I/O devices

        - Evaluation of the result does not cause any semantically observable side effect or output,
         such as mutation of mutable objects or output to I/O device

- Summary: // TODO: summary and meaning of the definitions for the language capabilities and usage

2. The Object

- this
   - the value of this is determined by how a function is called. It can't be set by assignment
    during execution, and it may be different each time the function is called.
   - Global context -  refers to the global object, whether in strict mode or not
		- Function context - depends on how the function is called
       - Simple call
           - not in strict mode - deaults to the global object
           - in strict mode - remains at whatever it was set to when entering the execution context
       - call and apply
           - where a function uses the this keyword in its body, its value can be bound to a particular object
       - The bind method
           - ECMAScript 5 introduced Function.prototype.bind. Calling f.bind(someObject) creates
            a new function with the same body and scope as f, but where this occurs in the original
            function, in the new function it is permanently bound to the first argument of bind,
            regardless of how the function is being used.
       - Arrow functions
           - is set lexically, i.e. it's set to the value of the enclosing execution context's this
   - As an object method - is set to the object the method is called on
   - As a constructor - When a function is used as a constructor (with the new keyword),
    its this is bound to the new object being constructed
   - As a DOM event handler - is set to the element the event fired from

- .prototype -

- new -

- .create() -

- .assign() -

3. The Function

- arguments -

- .bind() -

- .apply() -

- .call() -

2. Javascript behaviour - strict mode, es5, es6

    - scope and scope chain:
    	- evaluating a function establishes a distinct execution context that appends its local scope to the
        scope chain it was defined within. JavaScript resolves identifiers within a particular context by
        climbing up the scope chain, moving locally to globally.

    var ima_celebrity = "Everyone can see me! I'm famous!",
    the_president = "I'm the decider!";

    function pleasantville() {
    	var the_mayor = "I rule Pleasantville with an iron fist!",
    	ima_celebrity = "All my neighbors know who I am!";

    	 	function lonely_house() {
    		var agoraphobic = "I fear the day star!",
    		a_cat = "Meow.";
    	 	}
	 }

- hoisting
   - Because variable declarations (and declarations in general) are processed before any code is executed,
    declaring a variable anywhere in the code is equivalent to declaring it at the top.
    This also means that a variable can appear to be used before it's declared.

   - NOTE: JavaScript only hoists declarations, not initializations.
       x = 4    - is initialization
       var y    - is declaration

- closures
    - are techniques for implementing lexically scoped name binding in languages with first-class functions.
     Operationally, a closure is a record storing a function[a] together with an environment.

    - are functions that refer to independent (free) variables (variables that are used locally, but defined
     in an enclosing scope). In other words, these functions 'remember' the environment in which they were created.
    - also lexical scoping
    - not the same as anonymous function (function literal, lambda abstraction)

    - anonymous functions
       - arguments being passed to higher-order functions, or
       - used for constructing the result of a higher-order function that needs to return a function

    - Practical usage of closures:
       - closure lets you associate some data (the environment) with a function that operates on that data.
        This has obvious parallels to object oriented programming, where objects allow us to associate some
        data (the object's properties) with one or more methods.

       function makeSizer(size) {
           return function() {
               document.body.style.fontSize = size + 'px';
           };
       }

       var size12 = makeSizer(12);
       var size14 = makeSizer(14);
       var size16 = makeSizer(16);

       document.getElementById('size-12').onclick = size12;
       document.getElementById('size-14').onclick = size14;
       document.getElementById('size-16').onclick = size16;

    - strict mode -


II. JavaScript OOP

    1. OOP principals
    - programming paradigm based on the concept of "objects", which may contain data, in the form of fields,
    often known as attributes; and code, in the form of procedures, often known as methods.
    A feature of objects is that an object's procedures can access and often modify the data fields of the object
    with which they are associated (objects have a notion of "this" or "self").
    In OOP, computer programs are designed by making them out of objects that interact with one another.

    - Inheritance - when an object or class is based on another object (prototypal inheritance)
    or class (class-based inheritance), using the same implementation (inheriting from an object or class)
    or specifying a new implementation to maintain the same behavior.

    - Abstraction - a technique for arranging complexity. It works by establishing a level of complexity
    on which a person interacts with the system, suppressing the more complex details below the current level.
    Abstraction principal - abstract to avoid duplication.

    - Encapsulation - an information-hiding mechanism bundling data with the methods operating on that data.
    If a class does not allow calling code to access internal object data and permits access through methods only,
    this is a strong form of abstraction or information hiding known as encapsulation.

    - Polymorphism - is the provision of a single interface to entities of different types. A polymorphic type
    is one whose operations can also be applied to values of some other type, or types.

       - Ad hoc polymorphism: when a function denotes different and potentially heterogeneous implementations
        depending on a limited range of individually specified types and combinations. Ad hoc polymorphism
        is supported in many languages using function overloading.

       - Parametric polymorphism: when code is written without mention of any specific type and thus can be used
        transparently with any number of new types. In the object-oriented programming community,
        this is often known as generics or generic programming. In the functional programming community,
        this is often shortened to polymorphism.

       - Subtyping (also called subtype polymorphism or inclusion polymorphism): when a name denotes instances
        of many different classes related by some common superclass. Often referred to as simply polymorphism.

- Other relevent stuff:
   - mixin - a class that contains methods for use by other classes without having to be the parent class
    of those other classes.

   - object composition - (not to be confused with function composition) is a way to combine simple objects
    or data types into more complex ones

   - virtual method - inheritable and overridable method

   - static method - meant to be relevant to all the instances of a class rather than to any specific instance
    Math.max(double a, double b)

   - abstract method - An abstract method is one with only a signature and no implementation body.
    It is often used to specify that a subclass must provide an implementation of the method.
    Abstract methods are used to specify interfaces in some computer languages.

- NOTE:
TODO: math refs to type and set theory


3. Classical OOP

4. Prototypal OOP

5. Summary


III. Javascript FP
    - first class functions
    - evaluation
1. FP concepts:
1.1. Pure functions
1.2. Immutability
2. FP techniques:
2.1. Curry
    - With curried functions you get easier reuse of more abstract functions, since you get to specialize.
2.2. Composition
2.3. Partial application
2.4. Monads
3. Vanilla Javascript fp style methods
    - .map()
    - .filter()
    - .reduce()
    - .reduceRight()
    - .forEach()

4. Implementing fp techniques with es5

5. es6 and fp

6. Javascript fp libraries implementation


////
// clojurescript
////

- clojure to js compiler

  - basic setup

    - to run build file:

    java -cp cljs.jar:src clojure.main build.clj

    - directory structure:

    out/
    src/<name>/core.cljs
    cljs.jar
    build.clj
    index.html

    - basic files content:

    :core.cljs
    (ns hello-world.core)

    (enable-console-print!)

    (println "Hello World!")


    :build.clj
    (require 'cljs.build.api)
    (cljs.build.api/bulid "src"
      {:main 'hello-world.core
       :output-to "out/main.js"})

    :index.html
    <html>
      <body>
        <script type="text/javascript" src="out/main.js"></script>
      </body>
    </html>

////
// Compilers, transpilars and others targeting javascript
////


. coffiescript
  influence: python, ruby

  best points:
    brings ruby/python syntactic expressiveness to js

  strenghts:
    simple and similar to javascript

  weaknesses:
    es6/7 makes it mostly obsolete
  
. babel (es6, es7...)
  influence: ...

  best points:
    use latest es6/7/... features today

  strengths:
    interesting libraries like sweet.js

  weaknesses:
    es6/7/...

. clojurescript
  influence: clojure (lisp)

  best points:
    being a lisp, best interactive development posible, almost all of clojure

  strengths:
    most advanced javascript replacement

  weaknesses:
    being a lisp, not very good for mobile

. elm
  influence: ml, haskell

  best points:
    very easy to start, best rendering performance

  strengths:
    - front-end dsl

  weaknesses:
    - js interop is inconvinient making it hard to use js libraries
    - usable only in react type web projects, not in mobile or server

. purescript
  influence: haskell

. reason
  influence: ocaml
