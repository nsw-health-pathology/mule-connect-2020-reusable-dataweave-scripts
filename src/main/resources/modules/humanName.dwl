%dw 2.0

fun humanNameUseFromCode(code: String) =
         if ( ["D", "C"]              contains upper (code)) "usual"
    else if ( ["L", "OR"]             contains upper (code)) "official"
    else if ( ["T", "TEMP"]           contains upper (code)) "temp"
    else if ( ["P", "N"]              contains upper (code)) "nickname"
    else if ( ["ANON", "S"]           contains upper (code)) "anonymous"
    else if ( ["OLD", "NOUSE", "BAD"] contains upper (code)) "old"
    else if ( ["M"]                   contains upper (code)) "maiden"
    else "unknown"

fun humanNameUseFromXPN(XPN) =
    if (XPN."XPN-07" != null) humanNameUseFromCode(XPN."XPN-07" default "")
    else null