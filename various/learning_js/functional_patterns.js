var R = require('rambda');

////
// RECURSION
////

// Recursive implementations look a lot like math definitions, they preserve intuition,
// save us from the horrors of global state management (which is even worse when you
// consider that js is using closures over blocks, and freely mutable dynamic variables).
var fibR = function (n) {
    if(n < 1) return 1;
    return fibR(n - 1) + fibR(n - 2);
};

// Infortunatly in the real world recursion is rarely optimal.
// Without tail call optimization it is limited by the frame stack,
// it is slower than the imperative implementation,
// and without some clever garbidge collection by the vm it will
// use much more memory.
// Iterative example implementations:
var fibI = function (n) {
    if(n === 0) return 0;
    if(n === 1) return 1;
    var current = 1;
    var previous = 0;
    var sum = 1;
    for(var i = 1; i < n; i+=1) {
        sum = previous + current;
        previous = current;
        current = sum;
    }
    return current;
};

var factI = function (n) {
    if(n === 0) return 1;
    var fact = n;
    while(n > 1) {
        fact = fact * (n - 1);
        n--;
    }
    return fact;
};

// console.log('R: ' + fibR(6) + ' I: ' + fibI(6));

// Tail-call optimization is a remedy for the stack over usage problem
// with recursive implementations and by 2015 it is included in ecmascript 6,
// but not yet implemented for most browsers (just apple).

// But what is it?
// It is about the format of the last call of the function. It has to
// obey surtain rules in order to help the vm know what is happening.
// The last call must be in "tail position". Here are some samples:

// return x; -> tail position
// return f(x); -> tail position
// return x * fact(x - 1); -> not tail position
// function foo () { bar(); } -> not in tail position
// var a = () => f() || g(); -> only g in tail position (result of f is needed)
// var a = x => x ? f() : g(); -> both in tail position

// this is not tail recursive
var factR = function (n) {
    if(n === 0) return 1;
    return n * factR(n - 1);
};

// but this is tail recursive
var factTR = function (n) {
    function recur (n, acc) {
        if(n === 0) return acc;
        return recur(n - 1, n * acc);
    }
    return recur(n, 1);
};

// tail recursive with default params
var factTRD = function (n, acc = 1) {
    if(n <= 1) return acc;
    return factTRD(n - 1, n * acc );
};

// console.log('factTR(100) -> ' + factTR(100));

// Until the time tail call optimization gets implemented in all major browsers we can use
// the encapsulated recursive functions that are already there: map, filter, reduce, foreach.
// Here is a classical functional style implementation of factorial as a reduce over a sequence.

// reduce over lazy seq (well not lazy in this case, but maybe someday js will have that too):
var factF = n => Array.from({ length:n }, (v, k) => k + 1).reduce( (acc, x) => acc * x );

// Which one to use?
// map preserves dimentions, while reduce ..., well it reduces dimentions:
[1,2,3,4].map(x => x + 1);            // -> [2,3,4,5]
[1,2,3,4].reduce((acc,x) => acc + x); // -> 10

// TODO:
// tramplines
// continuation-passing style


////
// MEMOIZATION
////

// if using pure function inputs can be safely mapped to outputs
// and can be cached and reused

// basic one-arity function memoizer
function memoize (f) {
    if(f instanceof Function) {
        if(f.length === 0 || f.length > 1) return f;

        var fn = function (x) {
            if(fn.memoizer.values[x] == null) {
                fn.memoizer.values[x] = f.call(f, x);
            }
            return fn.memoizer.values[x];
        };

        fn.memoizer = { values : [] };
        return fn;
    } else {
        return f;
    }
}

// basic implementation
function memoizeB (f) {
    var fTable = {};
    return function () {
        var input = JSON.stringify(arguments);
        console.log(fTable);
        if(!fTable[input]) {
            fTable[input] = f.apply(f, arguments);
        }
        return fTable[input];
    }
}

// example usage
var addM = memoizeB(function(x, y) { return x + y; });
console.log(addM(1,2));
console.log(addM(1,2));

////
// CURRED FUNCTIONS
////

// basic
var add = function (x) {
    return function (y) {
        return x + y;
    }
};

// example usage
add(3)(4);         // > 7
var add3 = add(3); // > function
add3(4)            // > 7

// Array.slice implementation
/*
 * Arguments - array like Object corresponding to the arguments passed to the function
 *    - has length, callee, caller and [@@iterator] properties
 * Converting to array:
 *    - var args = Array.prototype.slice.call(arguments); - but this prevents optimization in v8
 *    - var args = Array.from(arguments); - not supported in ie
 *    - var args = [...arguments]; - spread operator
 */
var curryIt = function(uncurried) {
    var parameters = Array.prototype.slice.call(arguments, 1);
    return function() {
        return uncurried.apply(this, parameters.concat(
            Array.prototype.slice.call(arguments, 0)
        ));
    };
};

function curry(fx) {
    var arity = fx.length;
    return function f1() {
        var args = Array.prototype.slice.call(arguments, 0);
        if (args.length >= arity) {
            return fx.apply(null, args);
        }
        else {
            return function f2() {
                var args2 = Array.prototype.slice.call(arguments, 0);
                return f1.apply(null, args.concat(args2));
            }
        }
    };
}

// ramda style implementation
var _curry1 = function (fn) {
    return function f1(a) {
        if(arguments.length === 0) {
            return f1;
        } else {
            return fn.apply(this, arguments);
        }
    }
};
var curry = function (fn) {
    return function f2 (a, b) {
        var arity = arguments.length;
        if (arity === 0) {
            return f2;
        } else if (arity === 1) {
            return _curry1(function (_b) { return  fn(a, _b); });
        } else {
            return fn(a, b);
        }
    }
};

// example usage
var add = curry(function (x, y) {
    return x + y;
});

// Partial application
const partial = (fn, ...fixedArgs) => {
  return function (...remainingArgs) {
    return fn.apply(this, fixedArgs.concat(remainingArgs));
  };
};

const add = (a, b) => a + b;
const inc = partial(add, 1);

////
// COMPOSITION
////

// basic
var compose = function(f, g) {
    return function() {
        return f.call(this, g.apply(this, arguments));
    };
};

// multi argument
var compose = function() {
    var funcs = arguments;
    return function() {
        var args = arguments;
        for (var i = funcs.length; i --> 0;) {
            args = [funcs[i].apply(this, args)];
        }
        return args[0];
    };
};

// es6
const pipe = (...fns) => x => fns.reduce((y, f) => f(y), x);

// example usage
var f = compose(negate, square, mult2, add1);
console.log(f(2));

////
// TRANSDUCERS
////

//       map(inc)  filter(even)
// [1,2,3,4] > [2,3,4,5] > [2,4]
//
//       transducer
// [1,2,3,4] >> [2,4]

[1,2,3,4]
    .map((x) => x + 1)
    .filter((x) => x % 2 === 0);

// -> [2, 4]

// map implemented with reduce
var mapIncReducer = (result, input) => {
    result.push(input + 1);
    return result;
};

[1,2,3,4]
    .reduce(mapIncReducer, []);

// extract operation function increment
var mapReducer = (f) => (result, input) => {
    result.push(f(input));
    return result;
};

[1,2,3,4]
    .reduce(mapReducer( (x) => x + 1 ), []);


// same for filter function
var filterReducer = (predicate) => (result, input) => {
    if(predicate(input)) {
        result.push(input);
    }
    return result;
};

[1,2,3,4]
    .reduce(filterReducer( (x) => x % 2 === 0), []);

// push and + are reducing functions, they take initial value and input,
// and reduce them to a single output value
// array.push(4) -> [1,2,3,4]
// 10 + 1 -> 11

// extract reducing function
var mapping = (f) => (reducing) => (result, input) => reducing(result, f(input));
var filtering = (predicate) => (reducing) => (result, input) => predicate(input) ? reducing(result, input) : result;

// type of reducer is
// result, input -> result
// and composition of reducers has the exact same type

// wrapping in transduce helper function
var transduce = (xform, reducing, initial, input) => input.reduce(xform(reducing), initial);

var add = (x, y) => (y) => x  + y;
var inc = add(1);
var even = (x) => x % 2 === 0;

// usage:
var xform = R.compose(
    mapping(inc),
    filtering(even));

transduce(xform, (xs, x) => {
    xs.push(x);
    return xs;
}, [], [1, 2, 3, 4]);

// -> [2, 4]



////
// TUPLES
////

// used for interfunction communication

const Tuple = function () {
    const typeInfo = Array.prototype.slice.call(arguments, 0);
    const _T = function () {
        const values = Array.prototype.slice.call(arguments, 0);
        if(values.some( (val) => val === null || val === undefined )) {
            throw new ReferenceError('Tuples may not have any null vales');
        }
        if(values.length !== typeInfo.length) {
            throw new TypeError('Tuple arity does not match its protptype');
        }
        values.map(function (val, index) {
            this['_' + (index + 1)] = checkType(typeInfo[index])(val);
        }, this);
        Object.freeze(this);

        _T.prototype.values = function () {
            return Object.keys(this).map(function (k) {
               return this[k];
            }, this);
        };

        return _T;
    };
};

const Status = Tuple(Boolean, String);

////
// FUNCTORS
////

// basic container
function Container (x) {
    this.__value = x;
    // redefined just for node
    this.inspect = function () {
        return "Container(" +  x + ")";
    }
}
Container.of = function (x) {
    return new Container(x);
};
Container.prototype.map = function (f) {
    if(this.__value === undefined) {
        return this;
    }
    if(this.__value === null) {
        return this;
    }
    return Container.(f(this.__value));
};

// example usage
var inc = (x) => x + 1;
var dec = (x) => x - 1;
var minus100 = (x) => x - 100;
var weird = function (x) {
    if(x < 0) {
        return null;
    }
    return x * 2;
};
a = Container.of(4);
a.map(inc).map(inc).map(inc); // => 7
a.map(weird).map(weird).map(minus100); // => Container(null)

// maybe monad
var Maybe = function (val) {
    this.__value =  val;
}
Maybe.of = function (val) {
    return new Maybe(val);
};
Maybe.prototype.isNothing = function () {
    return (this.__value === null || this.value === undefined);
};
Maybe.prototype.map = function (f) {
    if(this.isNothing()) {
        return Maybe.of(null);
    }
    return Maybe.of(f(this.value));
};
Maybe.prototype.orElse = function (defaultValue) {
    if(this.isNothing()) {
        return Maybe.of(defaultValue);
    }
    return this;
};

// example usage
// TODO: example usage

////
// MONADS
////
var IO = function (f) {
    this.__value(f);
};
IO.of = x => return new IO( _ => x)
IO.map = function (f) {
    return new IO(R.compose(f, this.__value));
};

//  $ :: String -> IO [DOM]
var $ = selector => {
    return new IO( _ => document.querySelectorAll(selector))
}



////
// Crockford Object
////
// not as much functional as just being a new pattern by Douglas Crockford.
// It is much like the revealing module pattern with es6 destructuring and
// Object.freeze() for security
function constructor (spec) {
    let {member} = spec,
        {other} = other_constructor(spec),
        method = function () {
            // member, other, method, spec
        };
        return Object.freeze({method, other});
}

function Dollar (spec) {
    let { amount = 0,
          signiture = 'No signiture' } = spec;
    const getAmount = _ => amount;
    const getSigniture = _ => signiture;
    const times = multiplier => Dollar(amount * multiplier);
    const equals = money => true;
    return Object.freeze({getAmount, getSigniture, times, equals, spec});
}

function Franc (spec) {
    let { amount = 0,
          signiture = 'No signiture' } = spec;
    function getAmount () {
        return amount;
    }
    function getSigniture () {
        return signiture;
    }
    function times (multiplier) {
        return Dollar(amount * multiplier);
    }
    function equals (money) {
        return true;
    }
    return Object.freeze({getAmount, getSigniture, times, equals, spec});
}

const five = Dollar({ amount: 5, signiture: 'USD' });
const ten = Franc({ amount: 10, signiture: 'CHF' });
