%dw 2.0

fun fhirBoolean(booleanValue: String) =
  if (upper (booleanValue) == "Y") true
  else false


fun fhirBooleanFromNullable(nullableBool) =
  if (nullableBool != null) fhirBoolean(nullableBool default "")
  else null

