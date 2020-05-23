%dw 2.0

import modules::gender
import modules::humanName
import modules::timestamp
import modules::extendedCompositeId
import modules::boolean

var pid = payload.Data.ADT_A04.PID

output application/json skipNullOn="everywhere"
---
{
    // Patient Resource
    // See https://www.hl7.org/fhir/stu3/patient.html for Patient Specification
    resourceType: "Patient",
    id: uuid(),
    identifier: pid."PID-03" map (value, index) -> extendedCompositeId::fhirIdentifierFromCX(value),
    active: true,
    name: pid."PID-05" map (value, index) -> humanName::humanNameFromXPN(value),
    gender: gender::genderFromPid(pid),
    birthDate: timestamp::fhirDateFromTS(pid."PID-07"."TS-01"),
	deceasedBoolean: boolean::fhirBooleanFromNullable(pid."PID.30"),
    deceasedDateTime: timestamp::fhirDateFromTS(pid."PID.29"."TS.1")
}