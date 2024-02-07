export cond = (conditions) ->
    for condition in conditions
        if (===) true condition[0] then do
            if condition[1] instanceof Function
                return condition[1]!
            else
                return condition[1]
    if conditions[condition.length - 1][0] is \else
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
