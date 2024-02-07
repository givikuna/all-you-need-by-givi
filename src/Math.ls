export negate = --> if (<) 0 it then -it else it

export neg = negate

export ᐨ = neg

export ᕀ =--> if (>) 0 it then -it else it

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

export pow = Math.pow

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
