export rev = (Array.from) >> (.reverse!)

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

export enumerate = (.entries!) >> Array.from

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
    for i in [1 til xs.length] (if xs[i] < pivot then left else right).push xs[i]

    return sort left .concat pivot, sort right

export list-to = (x, y) --> [x to y]

export list-til = (x, y) --> [x til y]

export replace-all = (x1, x2, xs) --> typeof xs is \string then xs.replace-all x1, x2 else xs.map ((x) --> x is x1 then x2 else x)

export remove-all = (x, xs) --> replace-all x, '', xs

export iter = Array.from >> (.entries!)

export index-of = (x, xs) --> xs.index-of x
