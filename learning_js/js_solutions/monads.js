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
    return Container.of(f(this.__value));
}

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

var addM = memoize(function(x, y) { return x + y; });
console.log(addM(1,2));
console.log(addM(1,2));

var sub = (y) => x => x - y;
var add = (y) => x => x + y;
var inc = add(1);
var dec = sub(1);
var log = (str) => console.log(str);
var stringify = (obj, msg) => log(msg + JSON.stringify(obj));
// var msg = (msg) => obj => stringify(obj);

// var msg = function (str) {
//     return msg;
// };

// var msg = Container.of('');
// var msg1 =

var self = (v) => v;

var sub320 = sub(320);
var width = Container.of(320);
var point = {x: 320, y: 320};

log(width.inspect());
var a = width.map(sub320).map(inc);
log(a.inspect());
stringify(point);

var Menu = function () {
  var self = this;
  this.some = 0;
  this.open = function () {
    this.color = 'red'
  }
};

// module.exports Container;
