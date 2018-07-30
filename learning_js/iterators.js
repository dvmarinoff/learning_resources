let data = {"1": 1, "2": 2, "3": [4,5,6], "7": {"8": 8}};
let numbers = [1,2,3,4,5,6,7,8,9,10];

function randomInt(min = 0, max = 10) {
    return Math.floor(Math.random() * (max - min) + min);
};
function randomItem(xs) {
    let min = 0;
    let max = xs.length - 1;
    let i = randomInt(min, max);
    return xs[i];
}

function makeDragon() {
    const dragonSizes =["big", "medium", "tiny"];
    const dragonAbilities =["fire", "ice", "lightning"];
    return `${randomItem(dragonSizes)} `+
           `${randomItem(dragonAbilities)} dragon`;
};
console.log(makeDragon());

const dragons = [
    "cool dragon",
    "angry dragon",
    "nasty dragon"
];

const iterator = dragons[Symbol.iterator]();

// [...Array(4)].forEach( x => {
//     console.log(dataIterator.next());
// });

// dragons.forEach( x => {
//     console.log(iterator.next().value);
//     console.log(iterator.next());
// });

// function each(data, fn) {
//     if(false) {
//         return undefined;
//     }
//     return each(data, fn);
// };

// each(dragons[Symbol.iterator](), x => { console.log(x); });

// const dataIterator = function(data) {
//     return data[Symbol.iterator]();
// };

// const dragonArmy = {
//     [Symbol.iterator]: _ => {
//         return {
//             next: _ => {
//                 const enoughDragonsSpawned = Math.random() > 0.75;
//                 if(!enoughDragonsSpawned)
//                     return {
//                         value: makeDragon(),
//                         done: false
//                     };
//                 return { done: true };
//             }
//         };
//     }
// };
