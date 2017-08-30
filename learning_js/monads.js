function Container (spec) {
    const value = spec;
    const open = _ => value;
    const map = f => Container(f(value));
    return Object.freeze({open, map});
}

function Maybe (spec) {
    const value = spec;
    const open = _ => value;
    const isNothing = _ => (value === null || value === undefined);
    const map = f => {
        return isNothing() ? Maybe(null) : Maybe(f(this.__value));
    };
    return Object.freeze({open, map});
}

function Left (spec) {
    const value = spec;
    const {open} = Container(spec);
    const map = f => {
        return Left(value);
    };
    return Object.freeze({open, map});
}

function Right (spec) {
    const {value, open, map } = Container(spec);
    return Object.freeze({open, map});
}

function IO (spec) {
    const unsafePerformIO = spec;
    const open = _ => unsafePerformIO;
    const of = x => IO( _ => x );
    const map = f => IO(compose(f, unsafePerformIO));
    return Object.freeze({of, open, map});
}

// helpers
const add = (x, y) => (y) => x + y;
const inc = add(1);
const compose = (...fns) => fns.reduce((f, g) => (...args) => f(g(...args)));

// Assertion Function
var is = (f, a) => f === a;
var isNot = (f, a) => f !== a;
const colors = {
    green: "\x1b[32m" , red: "\x1b[31m",
};
var assertions = [];
var assert = (msg, p, expected, expr) => {
    let res = p.apply(null, [expr, expected]);
    let report = '';
    if(res) {
        report = `${msg} ${p.name} ${expected} : ${res}`;
    } else {
        report = `${msg} Expected ${expected} but it was ${expr}`;
    }
    let assertion = { pass: res, report: report };
    assertions.push(assertion);
    return res;
};
var runTests = (assertions) => {
    let fails = assertions.filter( assertion => !assertion.pass );
    if(fails.length > 0) {
        console.log(`${fails.length} tests failing`);
        fails.forEach( fail => console.log(fail.report) );
    } else {
        console.log(colors.green, `All ${assertions.length} tests Pass`);
    }
};

// Tests Helper
assert("add 3 4", is, 7, add(3)(4));
assert("inc 3", is, 4, inc(3));
assert("compose add(1) add(1) (1)", is, 3, compose( add(1), add(1) )(1));
assert("compose abc", is, "abcabc", compose( x => x + x, y => y )("abc"));

// Tests Container
var c1 = Container(1);
assert("Container of 1", is, 1, c1.open());
assert("Container of 1 map add(3) ", is, 4, c1.map(add(3)).open());

// Tests Right
var r1 = Right(4);
var r2 = Right("Hello");
assert("Right of 4 map add(4)", is, 8, r1.map(add(4)).open());
assert("Right of 4 map pow", is, 16, r1.map(x => x * x).open());
assert("Right of Hello map World!", is, "Hello World!", ( _ => {
    return r2.map(x => x + " World!").open();
})());

// Tests Left
var l1 = Left(4);
assert("Left of 4 open", is, 4, l1.open());
assert("Left of 4 map", is, 4, l1.map( x => x + 1 ).open());

// Tests IO
var io1 = IO(add(4));
var io2 = IO( s => "hello" + s );
assert("IO of add(4)", is, 8, io1.map(add(4)).open()(0));
assert("IO of add(4)", is, 12, io1.map(add(4)).open()(4));
assert("IO of ", is, "hello world!", io2.map((s) => s + "!").open()(" world"));

// Run Tests
runTests(assertions);
