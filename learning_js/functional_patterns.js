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

// example usage
var f = compose(negate, square, mult2, add1);
console.log(f(2));

////
// memoize
////
function memoize (f) {
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
var addM = memoize(function(x, y) { return x + y; });
console.log(addM(1,2));
console.log(addM(1,2));

////
// MONADS
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
