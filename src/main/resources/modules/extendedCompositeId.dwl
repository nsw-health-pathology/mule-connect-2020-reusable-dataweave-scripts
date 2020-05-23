%dw 2.0

fun fhirIdentifierFromCX(CX) =  {
    use: "official",
    "type": {
        coding: [{
            code: CX."CX-05" default null
        }]
    },
    value: CX."CX-01" default null
}
