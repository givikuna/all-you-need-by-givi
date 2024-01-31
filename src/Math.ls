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

export minus = (-)export is-numeric = /^[-+]?\d+(\.\d+)?$/.test

export multiply = (*)

export divide = (/)

export equals = (===)

export expt = ((^) |> ((f, x, y) --> f y, x))

export pow = (^)

export expm1 = Math.expm1
