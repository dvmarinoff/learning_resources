(function (window, document) {
    var f1 = (x) => f2(x) + f3(x);
    var f2 = (x) => 2 * x;
    var f3 = (x) => x + 1;
    var f4 = (x) => 2 * f1(x);
    var compose = function (flist, x) {
        var len = flist.length;
        var i = len;
        while(i > 0) {
            x = flist[i-1](x);
            i = i - 1;
        };
        return x;
    };

    var input = '2\n' +
                'inc x = x + 1\n' +
                'dec x = x - 1\n' +
                'inc . inc . dec\n' +
                '5';
    var lines = input.split('\n');

    var parseToFunction = function (str) {
        var func = null;
        var f = str.split(' ');
        var fname = f[0];
        var farg = f[1];
        var fbody = 'return ' + str.split(' = ')[1];
        return new Function(farg, fbody);
    };

    var parseInput = function (lines) {
        var composition = lines[3].split(' . '); 
        var param = parseInt(lines[4]);
        var funcNames, funcList = [];
        for(var i = 1; i < 3; i += i ) {
            funcNames.push(lines[i].split(' ')[0]);
            funcList.push(parseToFunction(lines[i]));
        }
        return compose([composition[0], composition[1], composition[2]], param);
    };
    // var inc = parseToFunction(lines[1]);
    // var dec = parseToFunction(lines[2]);

    var tests = {
        "f1": { test: f1(2), expect: 7},
        "f2": { test: f2(2), expect: 4},
        "f3": { test: f3(2), expect: 3},
        "f4": { test: f4(2), expect: 14},
        "f2.f1": { test: compose([f2, f1], 2), expect: 14},
        "f2.f2": { test: compose([f2, f2], 1), expect: 4},
        "f1.f2.f3.f4": { test: compose([f1, f2, f3, f4], 5), expect: 199 },
        // "inc": { test: inc(3), expect: 4 },
        // "dec": { test: dec(4), expect: 3 },
        // "inc.inc.dec": {test: compose([inc, inc, dec], 5), expect: 6}
        "parseInput(inc.inc.dec)": {test: parseInput(lines), expect: 6}
    };
    var check = function (tests) {
        var key, len = 0, isPassing = true;
        for(key in tests) {
            // console.log(tests[key].test === tests[key].expect);
            if(!(tests[key].test === tests[key].expect)) {
                isPassing = false;
                console.log('%cNOT PASSING %s returned %s expected %s', 'color: #ff4444', key, tests[key].test, tests[key].expect);
            }
        }
        if(isPassing) console.log('%cPASSING ALL', 'color: #bada55');
        return isPassing;
    }(tests);
} (windows, document))
