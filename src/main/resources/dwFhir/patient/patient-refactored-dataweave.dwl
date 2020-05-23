%dw 2.0

import modules::gender
import modules::humanName

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
     name: payload.Data.ADT_A04.PID."PID-05" map (value, index) -> {

		use: humanName::humanNameUseFromXPN(value),
     	text: if (value."XPN-02" != null) value."XPN-02" else ""
			++ " "
			++ (
	     		if (value."XPN-01"."FN-01" != null) value."XPN-01"."FN-01"
	     		else if (value."XPN-01") value."XPN-01"
	     		else ""
	     	),
     	family: if (value."XPN-01"."FN-01" != null) value."XPN-01"."FN-01"
	     		else if (value."XPN-01") value."XPN-01"
	     		else "",
 		given: [ value."XPN-02" ],
 		suffix: if (value."XPN-04" != null) [value."XPN-04"] else null,
		prefix: if (value."XPN-05" != null) [value."XPN-05"] else null
     },

 	 gender: gender::genderFromPid(payload.Data.ADT_A04.PID),
	birthDate:
		if (payload.Data.ADT_A04.PID."PID-07"."TS-01" != null)
			if (sizeOf(payload.Data.ADT_A04.PID."PID-07"."TS-01" default "") > 8)
				(payload.Data.ADT_A04.PID."PID-07"."TS-01" default "") as Date { format: "yyyyMMddHHmmss" } as String {format: "yyyy-MM-dd"}
			else
				(payload.Data.ADT_A04.PID."PID-07"."TS-01" default "") as Date {format: "yyyyMMdd"} as String {format: "yyyy-MM-dd"}
		else null


}