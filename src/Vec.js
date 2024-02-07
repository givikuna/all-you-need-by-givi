"use strict";
var __spreadArray = (this && this.__spreadArray) || function (to, from, pack) {
    if (pack || arguments.length === 2) for (var i = 0, l = from.length, ar; i < l; i++) {
        if (ar || !(i in from)) {
            if (!ar) ar = Array.prototype.slice.call(from, 0, i);
            ar[i] = from[i];
        }
    }
    return to.concat(ar || Array.prototype.slice.call(from));
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Vec = void 0;
var Vec = /** @class */ (function () {
    function Vec(arr) {
        var is_iter = function (obj) {
            return typeof obj[Symbol.iterator] === "function";
        };
        this.arr = (arr instanceof Vec
            ? arr.unwrap()
            : arr instanceof Set || is_iter(arr)
                ? Array.from(arr)
                : typeof arr === "string"
                    ? arr.split("")
                    : Array.from(arr));
    }
    Vec.from = function (arr) {
        return new Vec(arr);
    };
    Vec.append = function (xs, ys) {
        return xs.concat(ys);
    };
    Vec.prototype.unwrap = function () {
        return Array.from(this.arr);
    };
    Vec.prototype.clone = function () {
        return new Vec(Array.from(this.arr));
    };
    Vec.prototype.id = function () {
        return this;
    };
    Vec.prototype.push = function (item) {
        this.arr.push(item);
        return this;
    };
    Vec.prototype.len = function () {
        return this.arr.length;
    };
    Vec.prototype.get = function (i) {
        return this.arr[i];
    };
    Vec.prototype.empty = function () {
        return this.len() === 0;
    };
    Vec.prototype.clear = function () {
        this.arr = [];
        return this;
    };
    Vec.prototype.for_each = function (f) {
        this.clone().unwrap().forEach(f);
    };
    Vec.prototype.map = function (f) {
        return new Vec(this.clone().unwrap().map(f));
    };
    Vec.prototype.filter = function (f) {
        return new Vec(this.clone().unwrap().filter(f));
    };
    Vec.prototype.reject = function (f) {
        return new Vec(this.clone()
            .unwrap()
            .filter(function (el, i) { return (f.arguments > 1 ? !f(el, i) : !f(el)); }));
    };
    Vec.prototype.partition = function (f) {
        return new Vec([this.clone().filter(f), this.clone().reject(f)]);
    };
    Vec.prototype.any = function (f) {
        return (this.clone()
            .filter(f ? f : function (el) { return el; })
            .len() > 0);
    };
    Vec.prototype.all = function (f) {
        return (this.clone()
            .filter(f ? f : function (el) { return el; })
            .len() === this.len());
    };
    Vec.prototype.flatten = function () {
        return Vec.from(this.clone().unwrap().flat(Infinity));
    };
    Vec.prototype.slice = function (start, end) {
        return new Vec(start
            ? end
                ? this.clone().unwrap().slice(start, end)
                : this.clone().unwrap().slice(start)
            : this.clone().unwrap());
    };
    Vec.prototype.take = function (n) {
        return Vec.from(this.clone().unwrap().slice(0, n));
    };
    Vec.prototype.drop = function (n) {
        return Vec.from(this.clone().unwrap().slice(n));
    };
    Vec.prototype.rev = function () {
        return Vec.from(this.clone().unwrap().reverse());
    };
    Vec.prototype.concat = function (vec) {
        return new Vec(__spreadArray(__spreadArray([], this.clone().unwrap(), true), vec.clone().unwrap(), true));
    };
    Vec.prototype.uniq = function () {
        return Vec.from(Array.from(new Set(this.clone().unwrap())));
    };
    Vec.prototype.chunk = function (size) {
        var chunkedArray = [];
        for (var i = 0; i < this.len(); i += size) {
            chunkedArray.push(Vec.from(this.arr.slice(i, i + size)));
        }
        return Vec.from(chunkedArray);
    };
    Vec.prototype.find = function (pre) {
        return this.clone().unwrap().find(pre);
    };
    Vec.prototype.index_of = function (el) {
        return this.clone().unwrap().indexOf(el);
    };
    Vec.prototype.last_index_of = function (el) {
        return this.clone().unwrap().lastIndexOf(el);
    };
    Vec.prototype.to_s = function () {
        return JSON.stringify(this.clone().unwrap(), null, 4);
    };
    Vec.prototype.shuffle = function () {
        var _a;
        var shuffledArray = __spreadArray([], this.arr, true);
        for (var i = shuffledArray.length - 1; i > 0; i--) {
            var j = Math.floor(Math.random() * (i + 1));
            _a = [shuffledArray[j], shuffledArray[i]], shuffledArray[i] = _a[0], shuffledArray[j] = _a[1];
        }
        return new Vec(shuffledArray);
    };
    Vec.prototype.fold1 = function (f) {
        var memo = 1;
        Array.from(this.arr).forEach(function (x) {
            memo = f(memo, x);
        });
        return memo;
    };
    Vec.prototype.fold = function (f, z) {
        var memo = z;
        Array.from(this.arr).forEach(function (x) {
            memo = f(memo, x);
        });
        return memo;
    };
    Vec.prototype.foldl = function (f, z) {
        return new Vec(Array.from(this.arr)).fold(f, z);
    };
    Vec.prototype.foldr = function (f, z) {
        var memo = z;
        Array.from(this.arr)
            .reverse()
            .forEach(function (x) {
            memo = f(memo, x);
        });
        return memo;
    };
    Vec.prototype.foldr1 = function (f) {
        var memo = 1;
        Array.from(this.arr).reverse().forEach(function (x) {
            memo = f(memo, x);
        });
        return memo;
    };
    Vec.prototype.foldr0 = function (f) {
        var memo = 0;
        Array.from(this.arr).reverse().forEach(function (x) {
            memo = f(memo, x);
        });
        return memo;
    };
    Vec.prototype.foldl0 = function (f) {
        var memo = 0;
        Array.from(this.arr).forEach(function (x) {
            memo = f(memo, x);
        });
        return memo;
    };
    Vec.prototype.foldl1 = function (f) {
        var memo = 1;
        Array.from(this.arr).forEach(function (x) {
            memo = f(memo, x);
        });
        return memo;
    };
    Vec.prototype.fold0 = function (f) {
        var memo = 1;
        Array.from(this.arr).forEach(function (x) {
            memo = f(memo, x);
        });
        return memo;
    };
    Vec.prototype.first = function () {
        return this.arr[0];
    };
    Vec.prototype.last = function () {
        return this.arr[this.arr.length - 1];
    };
    Vec.prototype.freq = function (f) {
        return this.clone().filter(f).len();
    };
    Vec.prototype.freq_of = function (k) {
        return this.clone()
            .filter(function (x) { return x === k; })
            .len();
    };
    Vec.prototype.map2 = function (f, arr) {
        var xs = this.clone().unwrap();
        var ys = arr instanceof Vec ? arr.unwrap() : arr instanceof Set ? Array.from(arr) : arr;
        return new Vec(xs.map(function (x, i) { return f(x, ys[i]); }));
    };
    Vec.prototype.compact = function () {
        return new Vec(this.arr.filter(function (item) { return !!item; }));
    };
    Vec.prototype.sum = function () {
        return this.clone().fold0(function (x, y) { return x + y; });
    };
    Vec.prototype.avg = function () {
        return this.sum() / this.len();
    };
    Vec.prototype.product = function () {
        return this.clone().fold1(function (x, y) { return x * y; });
    };
    Vec.prototype.mem = function (k) {
        return this.arr.includes(k);
    };
    Vec.prototype.iter = function () {
        return this.clone().unwrap().entries();
    };
    Vec.prototype.rem = function (k) {
        this.arr = this.clone()
            .reject(function (el) { return k === el; })
            .unwrap();
        return this;
    };
    Vec.prototype.sort_by = function (f) {
        return new Vec(this.clone().unwrap().sort(f));
    };
    Vec.prototype.to_set = function () {
        return new Set(this.clone().unwrap());
    };
    Vec.prototype.Ø = function () {
        return this.empty();
    };
    Vec.prototype.difference = function (arr) {
        var xs = this.clone();
        var ys = Vec.from(arr);
        return Vec.append(Vec.from(xs.filter(function (x) { return !ys.mem(x); })).uniq(), Vec.from(ys.filter(function (x) { return !xs.mem(x); })).uniq());
    };
    Vec.prototype.Δ = function (arr) {
        return this.clone().difference(arr);
    };
    Vec.prototype.intersection = function (arr) {
        var xs = this.clone();
        var ys = Vec.from(arr);
        return Vec.append(Vec.from(xs.filter(function (x) { return ys.ϵ(x); })), Vec.from(ys.filter(function (x) { return xs.ϵ(x); })));
    };
    Vec.prototype.ᐢ = function (arr) {
        return this.intersection(arr);
    };
    Vec.prototype.ϵ = function (x) {
        return this.mem(x);
    };
    Vec.prototype.union = function (arr) {
        return this.clone().concat(Vec.from(arr));
    };
    Vec.prototype.ᐡ = function (arr) {
        return this.union(arr);
    };
    Vec.prototype.properSubset = function (arr) {
        var xs = Vec.from(arr);
        return this.id()
            .ᐡ(xs)
            .map(function (x) { return xs.ϵ(x); })
            .ϵ(true);
    };
    Vec.prototype.ᑦ = function (arr) {
        return this.properSubset(arr);
    };
    Vec.prototype.ᑦR = function () {
        var R = function (x) { return typeof x === "number" && !isNaN(x); };
        return this.clone()
            .map(R)
            .any(function (x) { return x; });
    };
    Vec.prototype.ᑦN = function () {
        var N = function (x) {
            return typeof x === "number" && Number.isInteger(x) && x > 0;
        };
        return this.clone()
            .map(N)
            .any(function (x) { return x; });
    };
    return Vec;
}());
exports.Vec = Vec;
