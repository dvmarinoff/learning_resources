var sorting = (function () {
    'use strict';
    //    swap :: Int, Int, [Int] -> [Int]
    const swap = (x, y, arr) => {
        let b = arr[y];
        arr[y] = arr[x];
        arr[x] = b;
        return arr;
    };
    //    insert :: Int, [Int] -> [Int]
    const insert = (i, arr) => {
        if( arr[i] > arr[i+1] ) {
            return insert(i-1 , swap(i, i+1, arr));
        }
        return arr;
    };
    //    insertionSort :: Int, Int, [Int] -> [Int]
    const insertionSort = (i, len, arr) => {
        console.log(arr); // uncomment to log sorting steps
        if(i < len) {
            insertionSort(i+1, len, insert(i, arr));
        }
        return arr;
    };

    //    insertionBinarySort :: [Int] -> [Int]
    const insertionBinarySort = (arr) => {
        // TODO:
        return arr;
    };
    //    selectionSort :: [Int] -> [Int]
    const selectionSort = (arr) => {
        return arr;
    };
    //    bubbleSort :: [Int] -> [Int]
    const bubbleSort = (arr) => {
        return arr;
    };
    //    mergeSort :: [Int] -> [Int]
    const mergeSort = (arr) => {
        return arr;
    };
    //    heapSort :: [Int] -> [Int]
    const heapSort = (arr) => {
        return arr;
    };
    //    quickSort :: [Int] -> [Int]
    const quickSort = (arr) => {
        return arr;
    };
    //    librarySort :: [Int] -> [Int]
    const librarySort = (arr) => {
        return arr;
    };

    return {
        insertionSort: insertionSort,
        mergeSort: mergeSort,
        heapSort: heapSort,
        quickSort: quickSort
    };
}());

var searching = (function () {
    //    middle :: Int, Int -> Int
    const middle = (start, end) => {
        return Math.floor(((end - start) / 2) + start);
    };
    //    binarySearch :: Int, Int, Int, [Int] -> Int
    const binarySearch = function (x, start, end, arr) {
        let m = middle(start, end);
        // console.log(x, m, start, end, arr); // uncomment to log steps
        if(x == arr[m]) {
           return m;
       } else if (end - start === 0) {
           return -1;
        } else if(x > arr[m]) {
            return binarySearch(x, m+1, end, arr);
        } else if(x < arr[m]) {
            return binarySearch(x, start, m, arr);
        } else {
            return -1;
        }
    };

    return {
        binarySearch: binarySearch
    };
}());

;(function () {
    'use strict';
    var testArray = [1, 3, 2, 8, 4, 2, 10, 9 , 8, 7, 6, 5, 1, 14];
    var sortedArray = [1, 2, 3, 4, 5, 6, 7, 8, 10, 14];
    var reversedArray = [14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1];
    var emptyArray = [];
    var smallArray = [1, 2, 3, 4];
    // var insertionSort = sorting.insertionSort(0, reversedArray.length, reversedArray);
    // console.log(insertionSort);

    //var binarySearch = searching.binarySearch(14, 0, sortedArray.length-1, sortedArray);
    // console.log(binarySearch);
    // console.log(sortedArray[binarySearch] == 14);
}());

var digitOperations = (function () {
    'use strict';
    // Big Integer with arithmetic on digits in array
    const add = (x, y) => x => y => x + y;
    const inc = add(1);
    const sum = (acc, x) => acc + x;
    const product = (acc, x) => acc * x;
    const absDiff = (x, y) => Math.abs(x - y);

    const pos = x => x > 0;
    const neg = x => x < 0;
    const zero = x => x === 0;
    const ifEl = (predicate, onTrue, onFalse) => predicate ? onTrue : onFalse;

    var toFixedFraction = (x, y) => {
        if(y < 21) return (x / y).toFixed(y);
        return (x / y).toFixed(20) + ( [...Array(y - 20)].reduce( (acc, _) => acc + '0', 0) );
    };

    var range = N => [...Array(N)].map(Number.call, Number);
    var range1 = N => Array(N).fill().map( (e, i) => i + 1 );
    var range2 = N => Array.from({ length: N }, (v, k) => k + 1 );
    var rangeRand = N => [...Array(N)].map(Number.call, Math.random);
    var randInt = (min, max) => Math.floor(Math.random() * (max - min + 1)) + min;


//     function getRandomIntInclusive(min, max) {
//   min = Math.ceil(min);
//   max = Math.floor(max);
//   return Math.floor(Math.random() * (max - min + 1)) + min; //The maximum is inclusive and the minimum is inclusive
// }

    var x = [4,8];
    var y = [4,9];

    //  Result :: Int -> {Int, Int}
    var Result = (x) => ({ digit: x % 10, carry: Math.floor( x / 10 ) });

    //  sumDigits :: Int, Int, Int -> Result
    var sumDigits = (x=0, y=0, carry=0) => {
        let sum = x + y + carry;
        return Result(sum);
    };
    //  subDigits :: Int, Int, Int, -> Result
    var subDigits = (x=0, y=0, carry=0) => {
        let sub = x - y - carry;
        return Resulf(sub);
    };

    //  productDigits :: Int, Int, Int -> Result
    var productDigits = (x=1, y=1, carry=0) => {
        let product = (x * y) + carry;
        return Result(product);
    };

    var sumIntArrays = (x=[0], y=[0], c=0, i=0, acc=[]) => {
        if(i === x.length) {
            if(c > 0) acc.push(c);
            return acc;
        };
        let sd = sumDigits(x[i], y[i], c);
        acc[i] = sd.digit;
        return sumIntArrays(x, y, sd.carry, i+=1, acc);
    };

    var line = (x, y, i=0, c=0, acc=[]) => {
        if(i === x.length) {
            if(c > 0) acc.push(c);
            return acc;
        }
        let pd = productDigits(x[i], y, c);
        console.log(pd);
        acc.push(pd.digit);
        return line(x, y, i+=1, pd.carry, acc);
    };
    var productIntArrays = (x, y) => {
        return y.map( (v, i, arr) => {
            let l = line(x, v);
            if(i > 0) {
                [...Array(i)].forEach( _ => l.unshift(0) );
            }
            return l;
        }).reduce( (acc, next) => sumIntArrays(next, acc) , [0]);
    };
    // console.log(productIntArrays([4,9,1], [9, 1, 4]));

    var fact = (n, acc=1) => {
        if(n === 0) return acc;
        return fact(n - 1, n * acc);
    }
}());
