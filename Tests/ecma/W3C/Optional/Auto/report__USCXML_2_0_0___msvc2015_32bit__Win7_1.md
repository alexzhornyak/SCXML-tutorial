# uSCXML [W3C Optional tests](https://www.w3.org/Voice/2013/scxml-irp/) passing results
USCXML 2.0.0 EcmaScript datamodel with JavaScriptCore
OS: Windows 7 Version 6.1 (Build 7601: SP 1) [winnt version 6.1.7601]

<details><summary><b>Test passing log</b></summary>
<p>
  
```
[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test193.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test201.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test278.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test444.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test445.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test446.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test448.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test449.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test451.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test452.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test453.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test456.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test457.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "'Var4' does not evaluate to an array.", 
      "file":  "USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  622
    }
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "ReferenceError: Left side of assignment is not a reference.", 
      "file":  "USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  773
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test459.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test460.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test509.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test510.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test518.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test519.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test520.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test522.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test531.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test532.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test534.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test557.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test558.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test560.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test561.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test562.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test567.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test569.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test577.scxml
[Error]   Platform Event 
    "name": error.communication
    "data": {
      "cause": "Target '' not supported in send", 
      "file":  "USCXML\\src\\uscxml\\interpreter\\InterpreterImpl.cpp", 
      "line":  490, 
      "xpath": "//state[@id=\"s0\"]/onentry[1]/send[2]"
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Optional/Auto\test578.scxml
[Log] Outcome: "pass"
```

</p></details>

| Test | Result | Description |
|---|---|---|
| [test193.scxml](test193.scxml) | Pass | we test that omitting target and targetexpr of [\<send\>](../../../../../Doc/send.md) when using the SCXML event i/o processor puts the event on the external queue. |
| [test201.scxml](test201.scxml) | Pass | we test that the processor supports the basic http event i/o processor. This is an optional test since platforms are not required to support basic http event i/o |
| [test278.scxml](test278.scxml) | Pass | test that a variable can be accessed from a state that is outside its lexical scope |
| [test444.scxml](test444.scxml) | Pass | test that [\<data\>](../../../../../Doc/datamodel.md#data) creates a new ecmascript variable. |
| [test445.scxml](test445.scxml) | Pass | test that ecmascript objects defined by [\<data\>](../../../../../Doc/datamodel.md#data) have value undefined if [\<data\>](../../../../../Doc/datamodel.md#data) does not assign a value |
| [test446.scxml](test446.scxml) | Pass | in the ECMA data model, test that if the child of [\<data\>](../../../../../Doc/datamodel.md#data) is JSON, the processor assigns it as the value of the var |
| [test448.scxml](test448.scxml) | Pass | test that all ecmascript objects are placed in a single global scope |
| [test449.scxml](test449.scxml) | Pass | test that ecmascript objects are converted to booleans inside cond |
| [test451.scxml](test451.scxml) | Pass | simple test of the `in()` predicate |
| [test452.scxml](test452.scxml) | Pass | test that we can assign to any location in the datamodel. In this case, we just test that we can assign to a substructure (not the top level variable). This may not be the most idiomatic way to write the test |
| [test453.scxml](test453.scxml) | Pass | test that we can use any ecmascript expression as a value expression. In this case, we just test that we can assign a function to a variable and then call it. |
| [test456.scxml](test456.scxml) | Pass | we can't test that `_any_` ecmascript is valid inside [\<script\>](../../../../../Doc/script.md), so we just run a simple one and check that it can update the data model. |
| [test457.scxml](test457.scxml) | Pass | test that an the legal iterable collections are arrays, namely objects that satisfy instanceof(Array) in ECMAScript. the legal values for the 'item' attribute on foreach are legal ECMAScript variable names.. |
| [test459.scxml](test459.scxml) | Pass | test that foreach goes over the array in the right order. since the array contains 1 2 3, we compare the current value with the previous value, which is stored in var1. The current value should always be larger. If it ever isn't, set Var4 to 0, indicating failure. Also check that the final value of the index is 2 (meaning that the initial value was 0, not 1) |
| [test460.scxml](test460.scxml) | Pass | test that [\<foreach\>](../../../../../Doc/foreach.md) does a shallow copy, so that modifying the array does not change the iteration behavior. |
| [test509.scxml](test509.scxml) | Pass | test that Basic HTTP Event I/O processor uses POST method and that it can receive messages at the accessURI |
| [test510.scxml](test510.scxml) | Pass | test that Basic HTTP messages go into external queue. |
| [test518.scxml](test518.scxml) | Pass | test that that namelist values get encoded as POST parameters. |
| [test519.scxml](test519.scxml) | Pass | test that that [\<param\>](../../../../../Doc/param.md) values get encoded as POST parameters. . |
| [test520.scxml](test520.scxml) | Pass | test that that [\<content\>](../../../../../Doc/content.md) gets sent as the body of the message. |
| [test522.scxml](test522.scxml) | Pass | test that location field the entry for Basic HTTP Event I/O processor can be used to send a message to the processor |
| [test531.scxml](test531.scxml) | Pass | test that that the value of the [\<param\>](../../../../../Doc/param.md) `_scxmleventname` gets used as the name of the raised event. |
| [test532.scxml](test532.scxml) | Pass | test that that if `_scxmleventname` is not present, the name of the HTTP method is used as the name of the resulting event. |
| [test534.scxml](test534.scxml) | Pass | test that that [\<send\>](../../../../../Doc/send.md) 'event' value gets sent as the param `_scxmleventname` . |
| [test557.scxml](test557.scxml) | Pass | in the ECMA data model, test that if the child of [\<data\>](../../../../../Doc/datamodel.md#data) is XML, or if XML is loaded via src=, the processor assigns it as the value of the var |
| [test558.scxml](test558.scxml) | Pass | in the ECMA data model, test that if the child of [\<data\>](../../../../../Doc/datamodel.md#data) is not XML, or if XML is loaded via src=, the processor treats the value as a string, does whitespace normalization and assigns it to the var. |
| [test560.scxml](test560.scxml) | Pass | in the ECMA data model, test that processor creates correct structure in `_event.data` when receiving KVPs in an event |
| [test561.scxml](test561.scxml) | Pass | in the ECMA data model, test that processor creates an ECMAScript DOM object `_event.data` when receiving XML in an event |
| [test562.scxml](test562.scxml) | Pass | in the ECMA data model, test that processor creates space normalized string in `_event.data` when receiving anything other than KVPs or XML in an event |
| [test567.scxml](test567.scxml) | Pass | test that that any content in the message other than `_scxmleventname` is used to populate `_event.data.` |
| [test569.scxml](test569.scxml) | Pass | test that location field is found inside entry for SCXML Event I/O processor in the ECMAScript data model. The tests for the relevant event i/o processors will test that it can be used to send events. |
| [test577.scxml](test577.scxml) | Pass | test that that [\<send\>](../../../../../Doc/send.md) without target in basichttp event i/o processor causes `error.communication` to get added to internal queue . |
| [test578.scxml](test578.scxml) | Pass | in the ECMA data model, test that processor creates an ECMAScript object `_event.data` when receiving JSON in an event |
