;(function () {
    'use strict';

    var test_1 = {
        len: 5,
        lines: ['1 is before 2', '4 is after 2', '3 is is before 4', '6 is after 4', '6 is before 8'],
        result: '123468'
    };
    var test_2 = {
        len: 6,
        lines: ['8 is before 7', '6 is before 5', '3 is after 4', '1 is after 2', '2 is before 1', '1 is after 2'],
        result: '21436587'
    };
    var input = test_1;

    var sortRule =  function (rule, couple) {
        if(rule[5] === 'b') {
            return [couple[0], couple[1]];
        } else {
            return [couple[1], couple[0]];
        }
    };
    var getNumbers = function (rule) {
        return [rule[0],rule[rule.length -1]];
    };
    var getCouples = function (rules, i, len) {
        var couples = [];
        var rule = rules[i];
        var couple = sortRule(rule, getNumbers(rule));
        couples.push(couple);
        if(i === (len - 1)) {
            console.log(couples);
            return couples;
        } else {
            i+=1;
            getCouples(rules, i , len);
        }
    };

    var couples = getCouples(input.lines, 0, input.len);
}());
