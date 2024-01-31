class Vec<T> {
    private arr: T[];

    constructor(arr: Vec<T> | T[] | Set<T> | Iterable<T> | ReadonlyArray<T> | string) {
        const is_iter: (obj: any) => boolean = (obj: any): obj is Iterable<any> => {
            return typeof obj[Symbol.iterator] === "function";
        };

        this.arr = (
            arr instanceof Vec
                ? arr.unwrap()
                : arr instanceof Set || is_iter(arr)
                ? [...arr]
                : typeof arr === "string"
                ? arr.split("")
                : Array.from(arr)
        ) as T[];
    }

    static from<U>(arr: Vec<U> | U[] | Set<U> | Iterable<U> | ReadonlyArray<U> | string): Vec<U> {
        return new Vec(arr);
    }

    static append<N, M>(xs: Vec<N>, ys: Vec<M>): Vec<N | M> {
        return xs.concat(ys);
    }

    unwrap(): T[] {
        return Array.from(this.arr);
    }

    clone(): Vec<T> {
        return new Vec(Array.from(this.arr));
    }

    id(): this {
        return this;
    }

    push(item: T): this {
        this.arr.push(item);
        return this;
    }

    len(): number {
        return this.arr.length;
    }

    get(i: number): T {
        return this.arr[i];
    }

    empty(): boolean {
        return this.len() === 0;
    }

    clear(): this {
        this.arr = [];
        return this;
    }

    for_each(f: (el: T, i?: number) => void): void {
        this.clone().unwrap().forEach(f);
    }

    map<U>(f: (el: T, i?: number) => U): Vec<U> {
        return new Vec(this.clone().unwrap().map(f));
    }

    filter(f: (el: T, i?: number) => boolean): Vec<T> {
        return new Vec(this.clone().unwrap().filter(f));
    }

    reject(f: (el: T, i?: number) => boolean): Vec<T> {
        return new Vec(
            this.clone()
                .unwrap()
                .filter((el: T, i: number): boolean => (f.arguments > 1 ? !f(el, i) : !f(el))),
        );
    }

    partition(f: (el: T, i?: number) => boolean): Vec<Vec<T>> {
        return new Vec([this.clone().filter(f), this.clone().reject(f)]);
    }

    any(f?: (el: T, i?: number) => boolean): boolean {
        return (
            this.clone()
                .filter(f ? f : (el: T): boolean => el as boolean)
                .len() > 0
        );
    }

    all(f?: (el: T, i?: number) => boolean): boolean {
        return (
            this.clone()
                .filter(f ? f : (el: T): boolean => el as boolean)
                .len() === this.len()
        );
    }

    flatten<U>(): Vec<U> {
        return Vec.from(this.clone().unwrap().flat(Infinity) as U[]);
    }

    slice(start?: number, end?: number): Vec<T> {
        return new Vec(
            start
                ? end
                    ? this.clone().unwrap().slice(start, end)
                    : this.clone().unwrap().slice(start)
                : this.clone().unwrap(),
        );
    }

    take(n: number): Vec<T> {
        return Vec.from(this.clone().unwrap().slice(0, n));
    }

    drop(n: number): Vec<T> {
        return Vec.from(this.clone().unwrap().slice(n));
    }

    rev(): Vec<T> {
        return Vec.from(this.clone().unwrap().reverse());
    }

    concat<N>(vec: Vec<N>): Vec<T | N> {
        return new Vec([...this.clone().unwrap(), ...vec.clone().unwrap()]);
    }

    uniq(): Vec<T> {
        return Vec.from([...new Set(this.clone().unwrap() satisfies T[])]);
    }

    chunk(size: number): Vec<Vec<T>> {
        const chunkedArray: Vec<T>[] = [] satisfies Vec<T>[];

        for (let i: number = 0; i < this.len(); i += size) {
            chunkedArray.push(Vec.from(this.arr.slice(i, i + size)));
        }

        return Vec.from(chunkedArray);
    }

    find(pre: (el: T, i?: number) => boolean): T | undefined {
        return this.clone().unwrap().find(pre);
    }

    index_of(el: T): number {
        return this.clone().unwrap().indexOf(el);
    }

    last_index_of(el: T): number {
        return this.clone().unwrap().lastIndexOf(el);
    }

    to_s(): string {
        return JSON.stringify(this.clone().unwrap(), null, 4);
    }

    shuffle(): Vec<T> {
        const shuffledArray = [...this.arr];
        for (let i: number = shuffledArray.length - 1; i > 0; i--) {
            const j: number = Math.floor(Math.random() * (i + 1));
            [shuffledArray[i], shuffledArray[j]] = [shuffledArray[j], shuffledArray[i]];
        }
        return new Vec(shuffledArray);
    }

    fold1(f: (z: number, x: number) => number): number {
        let memo: number = 1;
        (Array.from(this.arr) as number[]).forEach((x: number): void => {
            memo = f(memo, x);
        });
        return memo;
    }

    fold(f: (z: T, x: T) => T, z: T): T {
        let memo: T = z;
        Array.from(this.arr).forEach((x: T): void => {
            memo = f(memo, x);
        });
        return memo;
    }

    foldl(f: (z: T, x: T) => T, z: T): T {
        return new Vec(Array.from(this.arr)).fold(f, z);
    }

    foldr(f: (z: T, x: T) => T, z: T): T {
        let memo: T = z;
        Array.from(this.arr)
            .reverse()
            .forEach((x: T): void => {
                memo = f(memo, x);
            });
        return memo;
    }

    foldr1(f: (z: number, x: number) => number): number {
        let memo: number = 1;
        (Array.from(this.arr).reverse() as number[]).forEach((x: number): void => {
            memo = f(memo, x);
        });
        return memo;
    }

    foldr0(f: (z: number, x: number) => number): number {
        let memo: number = 0;
        (Array.from(this.arr).reverse() as number[]).forEach((x: number): void => {
            memo = f(memo, x);
        });
        return memo;
    }

    foldl0(f: (z: number, x: number) => number): number {
        let memo: number = 0;
        (Array.from(this.arr) as number[]).forEach((x: number): void => {
            memo = f(memo, x);
        });
        return memo;
    }

    foldl1(f: (z: number, x: number) => number): number {
        let memo: number = 1;
        (Array.from(this.arr) as number[]).forEach((x: number): void => {
            memo = f(memo, x);
        });
        return memo;
    }

    fold0(f: (z: number, x: number) => number): number {
        let memo: number = 1;
        (Array.from(this.arr) as number[]).forEach((x: number): void => {
            memo = f(memo, x);
        });
        return memo;
    }

    first(): T | undefined {
        return this.arr[0];
    }

    last(): T | undefined {
        return this.arr[this.arr.length - 1];
    }

    freq(f: Parameters<typeof this.filter>[0]): number {
        return this.clone().filter(f).len();
    }

    freq_of(k: T): number {
        return this.clone()
            .filter((x: T): boolean => x === k)
            .len();
    }

    map2<U, N>(f: (x: T, y: N) => U, arr: Vec<N> | N[] | Set<N>): Vec<U> {
        const xs: T[] = this.clone().unwrap();
        const ys: N[] = arr instanceof Vec ? arr.unwrap() : arr instanceof Set ? [...arr] : arr;
        return new Vec(xs.map((x: T, i: number): U => f(x, ys[i])));
    }

    compact(): Vec<T> {
        return new Vec(this.arr.filter((item) => !!item));
    }

    sum(): number {
        return this.clone().fold0((x: number, y: number): number => x + y);
    }

    avg(): number {
        return this.sum() / this.len();
    }

    product(): number {
        return this.clone().fold1((x: number, y: number): number => x * y);
    }

    mem(k: T): boolean {
        return this.arr.includes(k);
    }

    iter(): IterableIterator<[number, T]> {
        return this.clone().unwrap().entries();
    }

    rem(k: T): this {
        this.arr = this.clone()
            .reject((el: T): boolean => k === el)
            .unwrap();
        return this;
    }

    sort_by(f: (x: T, y: T) => number): Vec<T> {
        return new Vec(this.clone().unwrap().sort(f));
    }

    to_set(): Set<T> {
        return new Set(this.clone().unwrap());
    }

    Ø(): true | false {
        return this.empty();
    }

    difference<N>(arr: ConstructorParameters<typeof Vec<N>>[0]): Vec<N | T> {
        const xs: Vec<T | N> = this.clone();
        const ys: Vec<T | N> = Vec.from(arr);
        return Vec.append(
            Vec.from(xs.filter((x: T | N): boolean => !ys.mem(x))).uniq(),
            Vec.from(ys.filter((x: N | T): boolean => !xs.mem(x))).uniq(),
        );
    }

    Δ<N>(arr: ConstructorParameters<typeof Vec<N>>[0]): Vec<N | T> {
        return this.clone().difference(arr);
    }

    intersection<N>(arr: ConstructorParameters<typeof Vec<N>>[0]): Vec<N | T> {
        const xs: Vec<T | N> = this.clone();
        const ys: Vec<T | N> = Vec.from(arr);
        return Vec.append(
            Vec.from(xs.filter((x: T | N): boolean => ys.ϵ(x))),
            Vec.from(ys.filter((x: N | T): boolean => xs.ϵ(x))),
        );
    }

    ᐢ<N>(arr: ConstructorParameters<typeof Vec<N>>[0]): Vec<N | T> {
        return this.intersection(arr);
    }

    ϵ(x: T): boolean {
        return this.mem(x);
    }

    union<N>(arr: ConstructorParameters<typeof Vec<N>>[0]): Vec<N | T> {
        return this.clone().concat(Vec.from(arr));
    }

    ᐡ<N>(arr: ConstructorParameters<typeof Vec<N>>[0]): Vec<N | T> {
        return this.union(arr);
    }

    properSubset<N>(arr: ConstructorParameters<typeof Vec<N>>[0]): boolean {
        const xs: Vec<T | N> = Vec.from(arr);
        return this.id()
            .ᐡ(xs)
            .map((x: T | N): boolean => xs.ϵ(x))
            .ϵ(true);
    }

    ᑦ<N>(arr: ConstructorParameters<typeof Vec<N>>[0]): boolean {
        return this.properSubset(arr);
    }

    ᑦR(): boolean {
        const R: (x: number) => boolean = (x: number): boolean => typeof x === "number" && !isNaN(x);
        return this.clone()
            .map(R as (x: T) => boolean)
            .any((x: boolean): boolean => x);
    }

    ᑦN(): boolean {
        const N: (x: number) => boolean = (x: number): boolean =>
            typeof x === "number" && Number.isInteger(x) && x > 0;
        return this.clone()
            .map(N as (x: T) => boolean)
            .any((x: boolean): boolean => x);
    }
}
