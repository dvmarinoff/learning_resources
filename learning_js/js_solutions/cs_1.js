/* JS solutions to the autumn 2016 C# Basics exam
*/

/* Task 1: Mytical Numbers
 * You are given a number that is 3 digits long. Depending on the 3rd digit, you need to perform some calculations.
 *   - If the 3rd digit is zero, find the product of the first two digits.
 *   - If the 3rd digit is between 0 and 5 inclusive, find the product of the first two digits and divide the result by the 3rd digit.
 *   - If the 3rd digit is larger than 5, find the sum of the first two digits and multiply the result by the 3rd digit.
 *
 * Input:
 *   - On the only input line, you will receive a number that contains 3 digits.
 * Output:
 *   - Your output should always be a single line. The content of the line should be the result of the calculations with a precision
 *    specifier of 2. (Fixed-point 2).
 * Constraints:
 *   - The input will always contain a number that is 3 digits long.
 *   - The input will always be a positive number.
 */

/* Task 2: Jump, Jump
 * As mentioned above, the instructions are a single string. The instructions can contain digits(0-9) and the party symbol '^'.
 *   You will start jumping from the first symbol of the instructions(at position 0).
 *   If you jump on an even digit, do the following:
 *      - Take it's value P as a number('2' is 2, '4' is 4 and so on)
 *      - Jump P positions forward
 *   If you jump on an odd digit
 *      - Take it's value P as a number('1' is 1, '3' is 3 and so on)
 *      - Jump P positions backwards
 *   If you jump on a '0'(zero), you pass out because you've drank too much alchohol
 *      - Print Too drunk to go on after POSITION!, where POSITION is the index at which you jumped on the '0'
 *      - Stop jumping
 *   If you jump on '^'(party symbol), you did some good jumping
 *      - Print Jump, Jump, DJ Tomekk kommt at POSITION!, where POSITION is the index at which you jumped on the party symbol '^'
 *      - Stop jumping
 *   If you jump outside the boundaries of the instructions, you fall off the dancefloor
 *      - Print Fell off the dancefloor at POSITION!, where POSITION is the index at which you jumped you're out of the instructions
 *      - Stop jumping
 *   Input
 *      - The input will consist of a single line - the instructions how to jump.
 *   Output
 *      - Your output should always be a single line. The content of that line is described in the section The instructions above.
 *   Constraints
 *      - The instructions string will never contain more than 100 symbols.
 *      - The instructions string will always only digits and party symbols '^'.
 *      - You will never jump in loops. Two examples of loops:
 *      - 211 - 2 -> 1 -> 1 -> 2 -> 1 -> 1 -> 2 ... and so on forever
 *      - 212^3^ - 2 -> 2 -> 3 -> 1 -> 2 -> ... and so forever
 */

/*
 * Task 3: Hidden Message
 * Tzacky has a great idea to hide messages in subtitles of movies.
 * But his friend, just started to code and has difficulty decoding the messages.
 * He knows that to do so, he needs to take the numbers that come before each subtitle and use them to decode the message.
 * The first number I is the index of the symbol he should start decoding (starting from 0) and the second number S is
 * the number of symbols he needs to skip to get every other symbol.
 * If the starting index is larger than the length of the line, this means that the line should be skipped.
 *
 *    example               | result | explanation
 *	  4                     | codi   | add 'carb'on a'ddi'tive
 *    4                     |        | start from c	(4th symbol counting form 0) than take every 4th -> o, d and i
 *    add carbon additive   |        |
 *    end                   |        |
 *
 *    - To make things easy, when the subtitles finish Tzacky always adds end instead of the starting index I (see sample tests).
 *    - Sometimes Tzacky wants to be extra sure his message will be hidden, so he decided to add additional complexity.
 *        - If S is negative your program should look for the next symbol to the left of the starting index (go backwards).
 *        - If I is negative your program should take the symbol counting from the end of the line as starting index
 *        - example 1: for I = -1
 *          line of code: "some random text that makes no sence"
 *        - example 2: for I = -6
 *          line of code: "some random text that makes no_sence" (the space)
 *    Input:
 *        - On the first line you can read the index of the first symbol i, if instead of a number you read end your program
 *        should print the hidden message so far and stop.
 *        - On the second line you will get a number, that is the number of symbols to skip to reach
 *        the next symbol for the hidden message.
 *        - On the third line you will get a line of text on witch you have to use the previously read numbers.
 *    Output:
 *        - The output should consist of a single line containing the full hidden message.
 *    Constraints:
 *        - The starting symbol index I will be a valid integer number between -100 and 100 inclusive.
 *        - The number of skipped symbols S will be a valid integer number between -100 and 100 inclusive, excluding 0.
 *        - The length of each line of text will be between 1 and 100 inclusive.
 *             - The text will contain only Latin letters and the symbols:
 *             , (comma), . (dot), ! (exclamation mark) and white space (space)
 *             - [',', '.', '!', ' '].
 *        - The input will always be valid and in the described format. There is no need to check it explicitly.
 *        - Memory limit: 32 MB
 *        - Time limit: 0.10 sec
 */

;(function () {
	'use strict';

	var read = function (selector) {
		return 345;//document.querySelectorAll(selector).value;
	};

	var println = function (selector, x) {
		document.querySelectorAll(selector).innerHTML = x;
	};

	var log = function (x) {
		if(isObject(x)) {
			console.log(JSON.stringify(x));
		} else {
			console.log(x);
		}
	};

	var forEach = function (fn, list) {
		var len = list.length; var i = 0;
		while (i < len) {
			fn(list[i]);
			i+=1;
		}
		return list;
	};

	var isObject = (x) => Object.prototype.toString.call(x) === '[object Object]';
	var isNumber = (x) => Object.prototype.toString.call(x) === '[object Number]';
	var _compose2 = (f, g) => (x) => g(f(x));
	// TODO: implement as compose with reduceRight
	var _pipe = (...funcs) => (value) => funcs.reduce((v, fn) => fn(v), value);
	var add = (x) => y => x + y;
	var multiply = (x) => y => x * y;
	var divide = (x) => y => x / y;
	var equals  = (a) => b => a === b;
	var gt = (a) => b => b > a;
	var lte = (a) => b => b <= a;
	var isEven = (x) => x % 2 === 0;

	var ifElse = function (predicate, onTrue, onFalse) {
		return predicate.apply(this, arguments) ? onTrue.apply(this, arguments) : onFalse.apply(this, arguments);
	};

	var ifEl = function (predicate, onTrue, onFalse) {
		return predicate ? onTrue : onFalse;
	};

	var push = function (item, array) {
		array.push(item);
		return array;
	};

	var stringToNumberArray = function (str) {
		var array = [];
		var str = str.toString();
		forEach(function (n) {
			push(parseFloat(n), array);
		}, str);
		return array;
	};

	var stringToArray = function (str) {
		var array = [];
		var str = str.toString();
		forEach(function (n) {
			push(n, array);
		}, str);
		return array;
	};

	// Task 1 solution:
	var calculateMyticalNumbers = function (digits) {
		var x = digits[0];
		var y = digits[1]
		var z = digits[2];
		if(z === 0) {
			return multiply(x)(y);
		}
		if(z > 0 && z <= 5) {
			// (/ (* x y) z)
			return divide(multiply (x) (y)) (z);
		}
		if(z > 5) {
			return multiply(add (x) (y)) (z);
		}
	};
	var myticalNumbersArray = stringToNumberArray(parseInt(read('#task-input-1')));
	var mysticalNumbersResult = calculateMyticalNumbers(myticalNumbersArray);
	log(mysticalNumbersResult);

	// Task 2 solution:
	var outOfRange = function (idx, array) {
		return idx > (array.length - 1) || idx < 0 ? true : false;
	};

	var jumpZeroTests = ['44^632^283', '8^1231111', '2^1', '4^^02734', '201', '4444444444451', '203'];
	// 0 : jj 6 , 1: jj 1, 2: jj 1, 3: td 3, 4: td 1, 5: fo 14, 6: fo -1

	var path = jumpZeroTests[0];
	var jumpr = function (path, idx, steps, isActive) {
		var pos = path[idx];
		if(parseInt(pos) === 0) {
			isActive = false;
			steps.push('Too drunk '+idx+'!');
			console.log(steps);
			return steps;
		}
		if(outOfRange(idx, path)) {
			isActive = false;
			steps.push('Fell out'+idx+'!');
			console.log(steps);
			return steps;
		}
		if(pos === '^') {
			isActive = false;
			steps.push('Jump, Jump '+idx+'!');
			console.log(steps);
			return steps;
		}
		if(isEven(parseInt(pos))) {
			idx += parseInt(pos);
			steps.push(pos);
		} else {
			idx -= parseInt(pos);
			steps.push(pos);
		}
		if(isActive) {
			jumpr(path, idx, steps, isActive);
		}
	};

	var p = jumpr(path, 0, [], true);
	console.log('jumpr: ' + p);

	// task 3 solution:
	var subtitle =
		/*
	28
	4
	'To molten steel you can add carbon additive.'
	100
	1
	'Carbon additive includes calcined petroleum coke, graphite petroleum coke,'
	0
	8
	'natural graphite etc.'
	21
	4
	'For the steel-making industry the'
	3
	50
	'sulfur in calcined petroleum coke'
	7
	11
	'is a crucial element'
	'end'
	*/

	// binary search
	var sa = [0, 1, 3 , 4 , 8, 9, 14, 18, 19];

	var binSearch = function (sortedArray, target) {
		var idx = Math.floor(sortedArray.length / 2);
		console.log(target + ' ? ' + sortedArray[idx]);
		if(sortedArray[idx] === target) {
			console.log(idx);
			return idx;
		} else if (target < sortedArray[idx] && sortedArray.length > 1) {
			console.log(target + ' < ' + sortedArray[idx] + ' return ' + sortedArray.slice(0, idx));
			binSearch(sortedArray.slice(0, idx), target);
		} else if (target > sortedArray[idx] && sortedArray.length > 1) {
			console.log(arget + ' > ' + sortedArray[idx] + ' return ' + sortedArray.slice(0, idx));
			binSearch(sortedArray.slice(idx), target);
		} else {
			console.log(-1);
			return -1;
		}
	};
}());
