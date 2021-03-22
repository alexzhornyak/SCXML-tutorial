# Qt SCXML [W3C Optional tests](https://www.w3.org/Voice/2013/scxml-irp/) passing results
Qt 5.15.0 (x86_64-little_endian-llp64 shared (dynamic) release build; by MSVC 2015) on "windows"
## OS
Windows 7 Version 6.1 (Build 7601: SP 1) [winnt version 6.1.7601]

## Summary info
- Elapsed: **00:00:00.393**
- All **33** tests were completed!
- Passed: **17**
- Timeout: **0**
- Failed: **16**
- Total Failed: **16**

<details><summary><b>Test passing log</b></summary>
<p>
  
```
Starting test193.scxml...
Test [test193.scxml] passed!
Starting test201.scxml...
DynamicStateMachine(0x29be870) had error "error.execution" : "TypeError: Cannot read property 'location' of undefined in send instruction in state s0 with targetexpr=\"_ioprocessors['basichttp']['location']\""
Test [test201.scxml] failed!
Starting test278.scxml...
Test [test278.scxml] passed!
Starting test444.scxml...
Test [test444.scxml] passed!
Starting test445.scxml...
Test [test445.scxml] passed!
Starting test446.scxml...
Test [test446.scxml] passed!
Starting test448.scxml...
Test [test448.scxml] passed!
Starting test449.scxml...
Test [test449.scxml] passed!
Starting test451.scxml...
Test [test451.scxml] passed!
Starting test452.scxml...
DynamicStateMachine(0x29bee90) had error "error.execution" : "SyntaxError: Unexpected token `;' in assign instruction in state s0 with expr=\"new testobject();\""
Test [test452.scxml] failed!
Starting test453.scxml...
Test [test453.scxml] passed!
Starting test456.scxml...
Test [test456.scxml] passed!
Starting test457.scxml...
DynamicStateMachine(0x29beb10) had error "error.execution" : "invalid array 'Var4' in foreach instruction in state s0"
DynamicStateMachine(0x29beb10) had error "error.execution" : "invalid item ''continue'' in foreach instruction in state s1"
Test [test457.scxml] passed!
Starting test459.scxml...
Test [test459.scxml] passed!
Starting test460.scxml...
Test [test460.scxml] passed!
Starting test509.scxml...
DynamicStateMachine(0x29beb10) had error "error.execution" : "TypeError: Cannot read property 'location' of undefined in send instruction in state s0 with targetexpr=\"_ioprocessors['basichttp']['location']\""
Test [test509.scxml] failed!
Starting test510.scxml...
DynamicStateMachine(0x6a88f60) had error "error.execution" : "TypeError: Cannot read property 'location' of undefined in send instruction in state s0 with targetexpr=\"_ioprocessors['basichttp']['location']\""
Test [test510.scxml] failed!
Starting test518.scxml...
DynamicStateMachine(0x6a89190) had error "error.execution" : "TypeError: Cannot read property 'location' of undefined in send instruction in state s0 with targetexpr=\"_ioprocessors['basichttp']['location']\""
Test [test518.scxml] failed!
Starting test519.scxml...
DynamicStateMachine(0x29beb10) had error "error.execution" : "TypeError: Cannot read property 'location' of undefined in send instruction in state s0 with targetexpr=\"_ioprocessors['basichttp']['location']\""
Test [test519.scxml] failed!
Starting test520.scxml...
DynamicStateMachine(0x29bea30) had error "error.execution" : "TypeError: Cannot read property 'location' of undefined in send instruction in state s0 with targetexpr=\"_ioprocessors['basichttp']['location']\""
Test [test520.scxml] failed!
Starting test522.scxml...
DynamicStateMachine(0x6a89190) had error "error.execution" : "TypeError: Cannot read property 'location' of undefined in send instruction in state s0 with targetexpr=\"_ioprocessors['basichttp']['location']\""
Test [test522.scxml] failed!
Starting test531.scxml...
DynamicStateMachine(0x29be870) had error "error.execution" : "TypeError: Cannot read property 'location' of undefined in send instruction in state s0 with targetexpr=\"_ioprocessors['basichttp']['location']\""
Test [test531.scxml] failed!
Starting test532.scxml...
DynamicStateMachine(0x29bed40) had error "error.execution" : "TypeError: Cannot read property 'location' of undefined in send instruction in state s0 with targetexpr=\"_ioprocessors['basichttp']['location']\""
Test [test532.scxml] failed!
Starting test534.scxml...
DynamicStateMachine(0x6a89190) had error "error.execution" : "TypeError: Cannot read property 'location' of undefined in send instruction in state s0 with targetexpr=\"_ioprocessors['basichttp']['location']\""
Test [test534.scxml] failed!
Starting test557.scxml...
DynamicStateMachine(0x29bedb0, name = "ScxmlTest557") had error "error.execution" : "SyntaxError: Unexpected token `<' in data instruction in state (none) with expr=\"<books xmlns=\"\">\r\n     <book title=\"title1\"/>\r\n     <book title=\"title2\"/>\r\n   </books> \""
DynamicStateMachine(0x29bedb0, name = "ScxmlTest557") had error "error.execution" : "TypeError: Cannot call method 'getElementsByTagName' of undefined in transition instruction in state s0 with cond=\"var1.getElementsByTagName('book')[0].getAttribute('title') == 'title1'\""
Test [test557.scxml] failed!
Starting test558.scxml...
DynamicStateMachine(0x29beb10, name = "ScxmlTest558") had error "error.execution" : "SyntaxError: Expected token `,' in data instruction in state (none) with expr=\"\nthis  is \na string\n\t\t\""
Test [test558.scxml] failed!
Starting test560.scxml...
Test [test560.scxml] passed!
Starting test561.scxml...
DynamicStateMachine(0x29bea30, name = "ScxmlTest561") had error "error.execution" : "TypeError: Property 'getElementsByTagName' of object  is not a function in transition instruction in state s0 with cond=\"_event.data.getElementsByTagName('book')[1].getAttribute('title') == 'title2'\""
Test [test561.scxml] failed!
Starting test562.scxml...
Test [test562.scxml] passed!
Starting test567.scxml...
DynamicStateMachine(0x6a89270) had error "error.execution" : "TypeError: Cannot read property 'location' of undefined in send instruction in state s0 with targetexpr=\"_ioprocessors['basichttp']['location']\""
Test [test567.scxml] failed!
Starting test569.scxml...
Test [test569.scxml] passed!
Starting test577.scxml...
DynamicStateMachine(0x29bee20) had error "error.execution" : "Error in send instruction in state s0: http://www.w3.org/TR/scxml/#BasicHTTPEventProcessor is not a valid type"
Test [test577.scxml] failed!
Starting test578.scxml...
Test [test578.scxml] passed!
Elapsed: 00:00:00.393
All 33 tests were completed!
Passed: 17
Manual or restricted: 0
Timeout: 0
Failed: 16
Total Failed: 16
```

</p></details>

| Test | Result | Description |
|---|---|---|
| [test193.scxml](test193.scxml) | Pass | we test that omitting target and targetexpr of [\<send\>](../../../../../Doc/send.md) when using the SCXML event i/o processor puts the event on the external queue. |
| **[test201.scxml](test201.scxml)** | **Fail** | **we test that the processor supports the basic http event i/o processor. This is an optional test since platforms are not required to support basic http event i/o** |
| [test278.scxml](test278.scxml) | Pass | test that a variable can be accessed from a state that is outside its lexical scope |
| [test444.scxml](test444.scxml) | Pass | test that [\<data\>](../../../../../Doc/datamodel.md#data) creates a new ecmascript variable. |
| [test445.scxml](test445.scxml) | Pass | test that ecmascript objects defined by [\<data\>](../../../../../Doc/datamodel.md#data) have value undefined if [\<data\>](../../../../../Doc/datamodel.md#data) does not assign a value |
| [test446.scxml](test446.scxml) | Pass | in the ECMA data model, test that if the child of [\<data\>](../../../../../Doc/datamodel.md#data) is JSON, the processor assigns it as the value of the var |
| [test448.scxml](test448.scxml) | Pass | test that all ecmascript objects are placed in a single global scope |
| [test449.scxml](test449.scxml) | Pass | test that ecmascript objects are converted to booleans inside cond |
| [test451.scxml](test451.scxml) | Pass | simple test of the `in()` predicate |
| **[test452.scxml](test452.scxml)** | **Fail** | **test that we can assign to any location in the datamodel. In this case, we just test that we can assign to a substructure (not the top level variable). This may not be the most idiomatic way to write the test** |
| [test453.scxml](test453.scxml) | Pass | test that we can use any ecmascript expression as a value expression. In this case, we just test that we can assign a function to a variable and then call it. |
| [test456.scxml](test456.scxml) | Pass | we can't test that `_any_` ecmascript is valid inside [\<script\>](../../../../../Doc/script.md), so we just run a simple one and check that it can update the data model. |
| [test457.scxml](test457.scxml) | Pass | test that an the legal iterable collections are arrays, namely objects that satisfy instanceof(Array) in ECMAScript. the legal values for the 'item' attribute on foreach are legal ECMAScript variable names.. |
| [test459.scxml](test459.scxml) | Pass | test that foreach goes over the array in the right order. since the array contains 1 2 3, we compare the current value with the previous value, which is stored in var1. The current value should always be larger. If it ever isn't, set Var4 to 0, indicating failure. Also check that the final value of the index is 2 (meaning that the initial value was 0, not 1) |
| [test460.scxml](test460.scxml) | Pass | test that [\<foreach\>](../../../../../Doc/foreach.md) does a shallow copy, so that modifying the array does not change the iteration behavior. |
| **[test509.scxml](test509.scxml)** | **Fail** | **test that Basic HTTP Event I/O processor uses POST method and that it can receive messages at the accessURI** |
| **[test510.scxml](test510.scxml)** | **Fail** | **test that Basic HTTP messages go into external queue.** |
| **[test518.scxml](test518.scxml)** | **Fail** | **test that that namelist values get encoded as POST parameters.** |
| **[test519.scxml](test519.scxml)** | **Fail** | **test that that [\<param\>](../../../../../Doc/param.md) values get encoded as POST parameters. .** |
| **[test520.scxml](test520.scxml)** | **Fail** | **test that that [\<content\>](../../../../../Doc/content.md) gets sent as the body of the message.** |
| **[test522.scxml](test522.scxml)** | **Fail** | **test that location field the entry for Basic HTTP Event I/O processor can be used to send a message to the processor** |
| **[test531.scxml](test531.scxml)** | **Fail** | **test that that the value of the [\<param\>](../../../../../Doc/param.md) `_scxmleventname` gets used as the name of the raised event.** |
| **[test532.scxml](test532.scxml)** | **Fail** | **test that that if `_scxmleventname` is not present, the name of the HTTP method is used as the name of the resulting event.** |
| **[test534.scxml](test534.scxml)** | **Fail** | **test that that [\<send\>](../../../../../Doc/send.md) 'event' value gets sent as the param `_scxmleventname` .** |
| **[test557.scxml](test557.scxml)** | **Fail** | **in the ECMA data model, test that if the child of [\<data\>](../../../../../Doc/datamodel.md#data) is XML, or if XML is loaded via src=, the processor assigns it as the value of the var** |
| **[test558.scxml](test558.scxml)** | **Fail** | **in the ECMA data model, test that if the child of [\<data\>](../../../../../Doc/datamodel.md#data) is not XML, or if XML is loaded via src=, the processor treats the value as a string, does whitespace normalization and assigns it to the var.** |
| [test560.scxml](test560.scxml) | Pass | in the ECMA data model, test that processor creates correct structure in `_event.data` when receiving KVPs in an event |
| **[test561.scxml](test561.scxml)** | **Fail** | **in the ECMA data model, test that processor creates an ECMAScript DOM object `_event.data` when receiving XML in an event** |
| [test562.scxml](test562.scxml) | Pass | in the ECMA data model, test that processor creates space normalized string in `_event.data` when receiving anything other than KVPs or XML in an event |
| **[test567.scxml](test567.scxml)** | **Fail** | **test that that any content in the message other than `_scxmleventname` is used to populate `_event.data.`** |
| [test569.scxml](test569.scxml) | Pass | test that location field is found inside entry for SCXML Event I/O processor in the ECMAScript data model. The tests for the relevant event i/o processors will test that it can be used to send events. |
| **[test577.scxml](test577.scxml)** | **Fail** | **test that that [\<send\>](../../../../../Doc/send.md) without target in basichttp event i/o processor causes `error.communication` to get added to internal queue .** |
| [test578.scxml](test578.scxml) | Pass | in the ECMA data model, test that processor creates an ECMAScript object `_event.data` when receiving JSON in an event |
