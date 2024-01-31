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

export expt = ((f, x, y) --> f y, x) Math.pow
