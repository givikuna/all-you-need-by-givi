export str = (s) -->
    if typeof! s is \Array or Array.is-array s or s instanceof Array then JSON.stringify s
    else if typeof s is \boolean then s |> (--> if it then \true else 'false')
    else if typeof s is \null then \null
    else if typeof s is \undefined then \undefined
    else String s

export int = (n) --> if typeof n is \number then Math.floor Number n

export bool = Boolean
