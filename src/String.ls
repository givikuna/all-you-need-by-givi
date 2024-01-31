export lower = (.to-lower-case!)

export upper = (.to-upper-case!)

export supertrim = (.replace /\r?n|\r/g '') >> (.trim!)

export string-append = (+)

export char-at = (n, s) --> s.char-at n

export title = (s) --> s |> char-at 0 |> upper |> (+ s.slice 1)

export uniq = (xs) --> [...(new Set xs)]

export memoize = (f) -->export cond = (conditions) ->
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

export expt = ((f, x, y) -->)
    cache = {}
    (...args) ->
        if args[0] in cache then return cache[args[0]]
        res = f args[0]
        cache[n] = res
        res

export is-numeric = /^[-+]?\d+(\.\d+)?$/.test

export trim-start = (.trim-start!)

export trim-end = (.trim-end!)

export trim = (.trim!)

export charcode = (.char-code-at 0)

export palindrome = (s) --> s is s.split '' .reverse!join ''
