////
// Some "Lisp-y" javascript
////

// Lists as nested arrays

// A List is one of:
// - null
// - cons(Any, List)
//
// examples:
// []
// [1, null]
// [1, [2, [3, null]]]

// Any Any -> List
function cons (a, b) { return [a, b]; }

// List -> Any
function first (list) {
    if(isEmpty(list)) { throw Error("first: expects a non empty list"); }
    return list[0];
}

// List -> Any
function rest (list) {
    if(isEmpty(list)) { throw Error("rest: expects a non empty list"); }
    return list[1];
}

// List -> Boolean
function isEmpty(list) { return list == null; }

// Commons:
function sum(x, y) { return x + y; };
function sub1(n) { return n - 1; };
function add1(n) { return n + 1; };
function isZero(n) { return n === 0; };
function isPositive(n) { return n > 0; };

// List-of-string String -> N
// determines how often s occurs in los
checkEqual(count(["a", ["a", ["b", ["a", null]]]], "a"), 3);
checkEqual(count(["a", ["a", ["b", ["a", null]]]], "b"), 1);
checkEqual(count(["a", ["a", ["b", ["a", null]]]], "d"), 0);
checkEqual(count(null, "d"), 0);
function count (los, s) {
    if(isEmpty(los)) {
        return 0;
    } else {
        return sum(first(los) === s ? 1 : 0, count(rest(los), s));
    }
}


// Array-of-strings String -> Number
// count the number of occurencies of s in aos
checkEqual(count2(["a", "a", "b", "a"], "a"), 3);
checkEqual(count2(["a", "a", "b", "a"], "b"), 1);
checkEqual(count2(["a", "a", "b", "a"], "d"), 0);
checkEqual(count2([], "d"), 0);
function count2 (aos, s) {
    return aos.reduce((acc, x) => { return acc + (x === s ? 1 : 0) ; }, 0);
}

// Trees
function makeTree(entry, left, right) {
    return [entry, left, right];
}
function entry(tree) {
    if(!isArray(tree)) { return tree; }
    return tree[0];
}
function leftBranch(tree) {
    if(!isArray(tree)) { return tree; }
    return tree[1];
}
function rightBranch(tree) {
    if(!isArray(tree)) { return tree; }
    return tree[2];
}
function isArray(x) {
    return Array.isArray(x);
}
function empty(tree) {
    if(!isArray(tree)) { return false; }
    return tree.length === 0;
}

function elementOfSet(x, set) {
    if(empty(set)) {
        return false;
    } else if(x === entry(set)) {
        return true;
    } else if(!isArray(set)) {
        return false;
    } else if(x < entry(set)) {
        return elementOfSet(x, leftBranch(set));
    } else if(x > entry(set)) {
        return elementOfSet(x, rightBranch(set));
    }
}

function adjoinSet(x, set) {
    if(empty(set)) {
        return makeTree(x, [], []);
    } else if(x === entry(set)) {
        return set;
    } else if(x < entry(set)) {
        return makeTree(entry(set),
                        adjoinSet(x, leftBranch(set)),
                        rightBranch(set));
    } else if(x > entry(set)) {
        return makeTree(entry(set),
                        rightBranch(set),
                        adjoinSet(x, rightBranch(set)));
    }
}
