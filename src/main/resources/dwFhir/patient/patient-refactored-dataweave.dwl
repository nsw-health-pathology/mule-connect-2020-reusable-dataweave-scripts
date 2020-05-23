%dw 2.0

import modules::gender
import modules::humanName
import modules::timestamp

output application/json
---
{
     // Patient Resource
     // See https://www.hl7.org/fhir/stu3/patient.html for Patient Specification
     resourceType: "Patient",
     id: uuid(),
     identifier: payload.Data.ADT_A04.PID."PID-03" map (value, index) -> {
     	use: "official",
     	"type": {
     		coding: [{
     			code: value."CX-05" default null
     		}]
     	},
     	value: value."CX-01" default null
     },
     active: true,
     name: payload.Data.ADT_A04.PID."PID-05" map (value, index) -> humanName::humanNameFromXPN(value),

    gender: gender::genderFromPid(payload.Data.ADT_A04.PID),
    birthDate: timestamp::fhirDateFromTS(payload.Data.ADT_A04.PID."PID-07"."TS-01")


}