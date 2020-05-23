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

fun humanNameFamily(XPN) =
    if (XPN."XPN-01"."FN-01" != null) XPN."XPN-01"."FN-01"
    else if (XPN."XPN-01" != null) XPN."XPN-01"
    else ""

fun humanNameGivenName(XPN) = if (XPN."XPN-02" != null) XPN."XPN-02" else ""

fun humanNameText(XPN) =
    humanNameGivenName(XPN) ++ " " ++ humanNameFamily(XPN)

fun humanNameFromXPN(XPN) = {
    use:    humanNameUseFromXPN(XPN),
    text:   humanNameText(XPN),
    family: humanNameFamily(XPN),
    given:  [ humanNameGivenName(XPN) ],
    suffix: if (XPN."XPN-04" != null) [XPN."XPN-04" default ""] else null,
    prefix: if (XPN."XPN-05" != null) [XPN."XPN-05" default ""] else null
}
