%dw 2.0

fun genderFromCode(code: String) =
         if (upper(code) == "M") "male"
    else if (upper(code) == "F") "female"
    else if (upper(code) == "O") "other"
    else "unknown"

fun genderFromPid(PID) =
    if (PID."PID-08" != null) genderFromCode(PID."PID-08" default "")
    else null