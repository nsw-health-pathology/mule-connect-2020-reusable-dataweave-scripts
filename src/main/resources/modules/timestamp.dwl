%dw 2.0

fun fhirDateFromTimestampString(str: String) =
    if (sizeOf(str) > 8)
        str as Date { format: "yyyyMMddHHmmss" } as String {format: "yyyy-MM-dd"}
    else
        str as Date {format: "yyyyMMdd"} as String {format: "yyyy-MM-dd"}

fun fhirDateFromTS(TS) =
    if (TS != null) fhirDateFromTimestampString(TS default "")
    else null
