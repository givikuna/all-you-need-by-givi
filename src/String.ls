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
