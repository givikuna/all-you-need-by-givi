export rev = (xs) --> if typeof xs is \string then xs.spit '' .reverse!join '' else (.reverse!) Array.from xs

export fold = (f, z, xs) -->
    memo = z
    for x in xs
        memo = f memo, x
    memo

export foldl = fold

export fold1 = (f, xs) --> fold f, 1 xs

export foldl1 = fold1

export fold0 = (f, xs) --> fold f, 0 xs

export foldl0 = fold0

export foldr = (f, z, xs) --> foldl f, z, rev xs

export foldr1 = (f, xs) --> foldr f, 1 xs

export foldr0 = (f, xs) --> foldr f, 0 xs

export filter = (f, xs) -->
    if (===) 3 f.arguments then do
        i = 0
        return [x for x in xs when f x, i++, xs]
    else if (===) 2 f.arguments then do
        i = 0
        return [x for x in xs when f x, i++]
    else
        return [x for x in xs when f x]

export reject = (f, xs) --> filter ((not) >> f), xs

export partition = (f, xs) --> [(filter f, xs), (rejecet f, xs)]

export map = (f, xs) --> [f x for x in xs]

export freq = (k, xs) --> [x for x in xs when x is k]length

export len = (.length)

export enumerate = (.entries!) >> (Array.from)

export member = (k, xs) --> k in xs

export mem = member

export map2 = (f, xs, ys) --> xs.map (x, i) -> f x, ys[i]

export append = (++)

export list-ref = (i, xs) --> if (>) 0 i then xs[xs.length + n] else xs[i]

export hash-ref = (k, xs) --> xs[k]

export build-list = (n, f) --> [0 til n].map f

export sort = (xs) -->
    if (>=) 1 xs.length then return Array.from xs

    pivot = xs[0]
    left = []
    right = []
    for i in [1 til xs.length]
        (if xs[i] < pivot then left else right).push xs[i]

    return sort(left)concat pivot, sort right

export list-to = (x, y) --> [x to y]

export list-til = (x, y) --> [x til y]

export replace-all = (x1, x2, xs) --> if typeof xs is \string then xs.replace-all x1, x2 else xs.map (x) --> if x is x1 then x2 else x

export remove-all = (x, xs) --> replace-all x, '', xs

export iter = Array.from >> (.entries!)

export index-of = (x, xs) --> xs.index-of x

export transpose = (arr) -->
    if not arr or arr.length is 0 or arr[0].length is 0 then return []
    row-count = arr.length
    col-count = arr[0].length
    transposed-arr = []
    col = 0
    while col < col-count
        transposed-arr[col] = []
        row = 0
        while row < row-count
            transposed-arr[col][row] = arr[row][col]
            row += 1
        col += 1
    transposed-arr

export chunk = (arr, size) -->
    chunked-arr = []
    i = 0
    while i < arr.length
        chunk_ = arr.slice i, (i + size)
        chunked-arr.push chunk
        i += 1
    chunked-arr

export foldstr = (f, xs) --> fold f, '', xs

export foldt = (f, xs) --> fold f, true, xs

export foldf = (f, xs) --> fold f, false, xs

export list-append = append

export ǀ = len

export uniq = (xs) --> [...(new Set xs)]

export list = (...args) -> [...args]

export to_set = (new Set)

export Ø = len >> (< 1)

export ϵ = (x, xs) --> x in xs

export ᐡ = (++) >> uniq

export union = ᐡ

export ᐢ = (xs, ys) --> uniq (++) [x for x in xs when x in ys] [y for y in ys when y in xs]

export intersection = ᐢ

export ᑦ = (xs, ys) -->
    xsu = uniq xs
    ysu = uniq ys
    ϵ on [(x `ϵ` ysu) for x in xsu]

export proper-subset = ᑦ

export ᐣ = ((f, x, y) --> f y, x) ᑦ

export proper-superset = ᐣ

export negate = --> if (<) 0 it then -it else it

export neg = negate

export ᐨ = neg

export ᕀ =--> if (>) 0 it then -it else it

export str = (s) -->
    if typeof! s is \Array or Array.is-array s or s instanceof Array then JSON.stringify s
    else if typeof s is \boolean then s |> (--> if it then \true else 'false')
    else if typeof s is \null then \null
    else if typeof s is \undefined then \undefined
    else String s

export int = (n) --> if typeof n is \number then Math.floor Number n

export bool = Boolean

export make-hash = (xs) -->
    obj = {}
    xs.for-each (x) --> obj[x[0]] = x[1]
    obj

export flip = (f, x, y) --> f y, x

export noop = !--> null

export id = --> it

export before = (bf, f) --> (...args) ->
    bf!
    f ...args

export after = (f, af) --> (...args) ->
    res = f ...args
    af!
    res

export throttle = (f, delay) -->
    last-time = 0
    (...args) !->
        current-time = Date.now!
        if (current-time - last-time) >= delay then do
            func.apply this, args
            last-time = current-time

export debounce = (f, delay) -->
    timeout-id = 0
    (...args) !->
        clear-timeout timeout-id
        timeout-id = set-timeout do
            -> func ...args
            delay

export lazy = (f) -->
    evaluated = no
    result = null
    (...args) ->
        if not evaluated then do
            result = func ...args
            evaluated = yes
        result

export say = console.log

export p = console.log

export lambda = (f) --> f

export fn = lambda

export λ = lambda

export ƒ = lambda

export memoize = (f) ->
    cache = {}
    (...args) ->
        if args[0] in cache then return cache[args[0]]
        res = f args[0]
        cache[n] = res
        res


export random = (min-val, max-val) -->
    if min-val >= max-val then return min-val
    max-val
        |> (- min-val)
        |> (* Math.random!)
        |> Math.floor
        |> (+ min-val)

export inc = (+ 1)

export dec = (- 1)

export add = (+)

export minus = (-)

export multiply = (*)

export divide = (/)

export equals = (===)

export expt = ((^) |> ((f, x, y) --> f y, x))

export pow = (^)

export expm1 = Math.expm1

export factorial = (n) --> if n is 0 or n is 1 then n else n * factorial dec n

export ǃ = factorial

export comb = (n, k) --> (ǃ n) / ((ǃ (n - k)) * ǃ k)

export nCr = comb

export sin = Math.sin

export cos = Math.cos

export tan = Math.tan

export csc = (1 /) >> Math.sin

export sec = (1 /) >> Math.cos

export cot = (1 /) >> Math.tan

export arcsin = Math.asin

export arccos = Math.acos

export arctan = Math.atan

export arccsc = (1 /) >> Math.asin

export arcsec = (1 /) >> Math.acos

export arccot = (1 /) >> Math.atan

export to-rad = (* Math.PI) >> (/ 180.0deg)

export to-deg = (* 180.0deg) >> (/ Math.PI)

export dsin = to-rad >> Math.sin

export dcos = to-rad >> Math.cos

export dtan = to-rad >> Math.tan

export dcsc = to-deg >> (1 /) >> Math.sin

export dsec = to-deg >> (1 /) >> Math.cos

export dcot = to-deg >> (1 /) >> Math.tan

export darcsin = Math.asin >> to-deg

export darccos = Math.acos >> to-deg

export darctan = Math.atan >> to-deg

export darccsc = (1 /) >> Math.asin >> to-deg

export darcsec = (1 /) >> Math.acos >> to-deg

export darccot = (1 /) >> Math.atan >> to-deg

export ln = Math.log

export recip = (1 /)

export log10 = Math.log10

export log1p = Math.log1p

export log2 = Math.log2

export log = (base, n) --> (Math.log n) / (Math.log base)

export even = (% 2) >> (is 0)

export odd = (% 2) >> (isnt 0)

export signum = --> if (>) 0 x then -1 else if (<) 0 x then 1 else 0

export E = (n, ex) --> n * Math.pow 10 ex

export G = 6.67384`E`-11

export earth-mass = 5.97219`E`24kg

export earth-radius = 6378100m

export ge = (G * earth-mass) / (earth-radius^2)

export gn = 9.807mpss

export g = gn

export is-natural-number = (n) --> n > 0 and Number.is-integer n

export is-int = Number.is-integer

export summation = (n, i, f) --> fold0 (+), [f x for x in [i to n]]

export Σ = --> foldl0 (+), it

export add-matrix = (xs, ys) --> xs.map (a, i) -> a.map (x, j) -> x + ys[i][j]

export subtract-matrix = (xs, ys) --> xs.map (a, i) -> a.map (x, j) -> x - ys[i][j]

export multiply-matrix = (A, B) -->
    if len A[0] isnt len B then throw new Error 'length of A[0] must equal length of B'
    C = [[0 for b in B[0]] for a in A]
    for i in [0 til len A]
        for j in [0 til len B[0]]
            C[i][j] = fold0 (+), A[i].map ((a, k) -> a * B[k][j])
    C

export elementary-charge = 1.602176634`E`-19

export e = Math.E

export C = 299792458mps # speed of light

export π = Math.PI

export pi = Math.PI

export τ = (*) 2 π

export tau = τ

export magnetic-constant = ((*) 4 π)`E`-7Hpm

export μ0 = magnetic-constant

export vacuum-permittivity = recip (μ0 * C^2)

export ε0 = vacuum-permittivity

export Ke = recip (4 * π * ε0)

export electron-mass = 9.1093837015`E`-31

export proton-mass = 1.67262192`E`-27

export me = electron-mass

export mp = proton-mass

export mα = (*) 4 proton-mass

export alpha-particle-mass = mα

export Qα = (*) 2 elementary-charge

export alpha-particle-charge = Qα

export abs = Math.abs

export floor = Math.floor

export ceil = Math.ceil

export sqrt = Math.sqrt

export cbrt = Math.cbrt

export gcd = (n, m) -->
    while m
        tmp = m
        m = n % m
        n = tmp
    Math.abs n

export gcf = gcd

export lcm = (n, m) --> (n * m) / gcd n, m

export ǁ = Math.abs


export lower = (.to-lower-case!)

export upper = (.to-upper-case!)

export supertrim = (.replace /\r?n|\r/g '') >> (.trim!)

export string-append = (+)

export char-at = (n, s) --> s.char-at n

export title = (s) --> s |> char-at 0 |> upper |> (+ s.slice 1)

export is-numeric = /^[-+]?\d+(\.\d+)?$/.test

export trim-start = (.trim-start!)

export trim-end = (.trim-end!)

export trim = (.trim!)

export charcode = (.char-code-at 0)

export palindrome = (s) --> s is s.split'' .reverse!join ''

export cond = (conditions) ->
    for condition in conditions
        if (===) true condition[0] then do
            if condition[1] instanceof Function
                return condition[1]!
            else
                return condition[1]
    if conditions[condition.length - 1] is \else
        x = conditions[conditions.length - 1]
        if x instanceof Function then do
            return x!
        else
            return x
    null

export sleep = ( amount, type = \milliseconds ) ->
    multiplier = do ->
        if type is \seconds then return 1000
        if type is \hours then return 3600000
        if type is \days then return 86400000
        return 1
    start = new Date!get-time!
    while (new Date!get-time! - start) < (multiplier * amount)
        null
    return

export pipe = (x, ...fs) ->
    y = x
    for f in fs
        y = f y
    y
