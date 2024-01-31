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

export pipe = (x, fs) -> Array.from fs .reduce ((f, val) -> f val), x

export say = console.log

export p = console.log

export lambda = (f) --> (..args) -> f ...args

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

export before = (before-func, func) -->
    (...args) ->
        before-func!
        func ...args

export after = (func, after-func) -->
    (...args) ->
        result = func ...args
        after-func!
        result

export throttle = (func, delay) ->
    last-time = 0
    (...args) ->
        current-time = Date.now!
        if (current-time - last-time) >= delay then do
            func.apply this, args
            last-time = current-time
        return

export debounce = (func, delay) ->
    timeout-id = null
    (...args) ->
        clear-timeout timeout-id
        timeout-id = set-timeout do
            -> func ...args
            delay
        return

export lazy = (f) ->
    evaluated = no
    result = null
    (...args) ->
        if not evaluated
            result = func ...args
            evaluated = yes
        result

