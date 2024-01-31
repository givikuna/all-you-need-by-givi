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

