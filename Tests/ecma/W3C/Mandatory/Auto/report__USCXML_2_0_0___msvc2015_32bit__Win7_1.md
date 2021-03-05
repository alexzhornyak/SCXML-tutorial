# [uSCXML](https://github.com/tklab-tud/uscxml) [W3C Mandatory tests](https://www.w3.org/Voice/2013/scxml-irp/) passing results
USCXML 2.0.0 EcmaScript datamodel with JavaScriptCore

## OS
Windows 7 Version 6.1 (Build 7601: SP 1) [winnt version 6.1.7601]

## Tools
[uscxml-browser: A standards compliant command-line interpreter of SCXML documents](https://github.com/tklab-tud/uscxml#on-the-command-line)

<details><summary><b>Test passing log</b></summary>
<p>
  
```
[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test144.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test147.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test148.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test149.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test150.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test151.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test152.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "'Var4' does not evaluate to an array.", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  622
    }
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "ReferenceError: Left side of assignment is not a reference.", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  773
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test153.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test155.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test156.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "SyntaxError: Unexpected keyword 'return'", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  773
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test158.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test159.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Target 'baz' not supported in send", 
      "file":  USCXML\\src\\uscxml\\plugins\\ioprocessor\\scxml\\SCXMLIOProcessor.cpp", 
      "line":  72, 
      "xpath": "//state[@id=\"s0\"]/onentry[1]/send[1]"
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test172.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test173.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test174.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test175.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test176.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test179.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test183.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test185.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test186.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test187.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test189.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test190.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test191.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test192.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test194.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Target 'baz' not supported in send", 
      "file":  USCXML\\src\\uscxml\\plugins\\ioprocessor\\scxml\\SCXMLIOProcessor.cpp", 
      "line":  72, 
      "xpath": "//state[@id=\"s0\"]/onentry[1]/send[1]"
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test198.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test199.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Type '27' not supported for sending", 
      "file":  USCXML\\src\\uscxml\\interpreter\\InterpreterImpl.cpp", 
      "line":  486, 
      "xpath": "//state[@id=\"s0\"]/onentry[1]/send[1]"
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test200.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test205.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test207.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test208.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test210.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test215.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test216.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test216sub1.scxml

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test220.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test223.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test224.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test225.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test226.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test226sub1.scxml

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test228.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test229.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test232.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test233.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test234.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test235.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test236.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test237.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test239.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test239sub1.scxml

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test240.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test241.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test242.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test242sub1.scxml

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test243.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test244.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test245.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "ReferenceError: Can't find variable: Var2", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  773
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test247.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test252.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test253.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test276.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test276sub1.scxml
[Error]   Platform Event 
    "name": error.communication
    "data": {
      "cause": "Sending to parent invoker, but none is set", 
      "file":  USCXML\\src\\uscxml\\interpreter\\InterpreterImpl.cpp", 
      "line":  624
    }


[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test277.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test279.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test280.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test286.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "ReferenceError: Can't find variable: foo", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  773
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test287.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test294.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test298.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test302.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test303.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test304.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test309.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "SyntaxError: Return statements are only valid inside functions.", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  773
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test310.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test311.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "ReferenceError: Can't find variable: foo", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  773
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test312.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "SyntaxError: Unexpected keyword 'return'", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  773
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test318.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test319.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "ReferenceError: Can't find variable: _event", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  773
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test321.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test322.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Cannot assign to _sessionId", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  719
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test323.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test324.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Cannot assign to _name", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  721
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test325.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test326.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Cannot assign to _ioprocessors", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  723
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test329.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Cannot assign to _sessionId", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  719
    }
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Cannot assign to _event", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  727
    }
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Cannot assign to _name", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  721
    }
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Cannot assign to _ioprocessors", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  723
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test330.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test331.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "ReferenceError: Can't find variable: foo", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  773
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test332.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Target 'baz' not supported in send", 
      "file":  USCXML\\src\\uscxml\\plugins\\ioprocessor\\scxml\\SCXMLIOProcessor.cpp", 
      "line":  72, 
      "xpath": "//state[@id=\"s0\"]/onentry[1]/send[1]"
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test333.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test335.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test336.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test337.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test338.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test339.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test342.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test343.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test344.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "SyntaxError: Return statements are only valid inside functions.", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  773
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test346.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Cannot assign to _sessionId", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  719
    }
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Cannot assign to _event", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  727
    }
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Cannot assign to _ioprocessors", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  723
    }
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Cannot assign to _name", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  721
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test347.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test348.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test349.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test350.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test351.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test352.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test354.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test355.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test364.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test372.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test375.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test376.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Target 'baz' not supported in send", 
      "file":  USCXML\\src\\uscxml\\plugins\\ioprocessor\\scxml\\SCXMLIOProcessor.cpp", 
      "line":  72, 
      "xpath": "//state[@id=\"s0\"]/onentry[1]/send[1]"
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test377.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test378.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "Target 'baz' not supported in send", 
      "file":  USCXML\\src\\uscxml\\plugins\\ioprocessor\\scxml\\SCXMLIOProcessor.cpp", 
      "line":  72, 
      "xpath": "//state[@id=\"s0\"]/onexit[1]/send[1]"
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test387.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test388.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test396.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test399.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test401.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "ReferenceError: Can't find variable: foo", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  773
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test402.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "ReferenceError: Can't find variable: foo", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  773
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test403a.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test403b.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test403c.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test404.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test405.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test406.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test407.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test409.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test411.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test412.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test413.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test416.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test417.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test419.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test421.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test422.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test423.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test487.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "cause": "SyntaxError: Unexpected keyword 'return'", 
      "file":  USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":  773
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test488.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test495.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test496.scxml
[Error]   Platform Event 
    "name": error.communication
    "data": {
      "cause": "Invalid target scxml session for send", 
      "file":  USCXML\\src\\uscxml\\plugins\\ioprocessor\\scxml\\SCXMLIOProcessor.cpp", 
      "line":  136
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test500.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test501.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test503.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test504.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test505.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test506.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test521.scxml
[Error]   Platform Event 
    "name": error.communication
    "data": {
      "cause": "Invalid target scxml session for send", 
      "file":  USCXML\\src\\uscxml\\plugins\\ioprocessor\\scxml\\SCXMLIOProcessor.cpp", 
      "line":  136
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test525.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test527.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test528.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test529.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test530.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test533.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test550.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test551.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test552.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test553.scxml
[Error]   Platform Event 
    "name": error.execution
    "data": {
      "caption": "Syntax error in send element namelist", 
      "cause":   "SyntaxError: Unexpected EOF", 
      "file":    USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":    773, 
      "xpath":   "//state[@id=\"s0\"]/onentry[1]/send[2]"
    }
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test554.scxml
[Warning]   Platform Event 
    "name": error.execution
    "data": {
      "caption": "Syntax error in send element namelist", 
      "cause":   "SyntaxError: Unexpected EOF", 
      "file":    USCXML\\src\\uscxml\\plugins\\datamodel\\ecmascript\\JavaScriptCore\\JSCDataModel.cpp", 
      "line":    773, 
      "xpath":   "//state[@id=\"s0\"]/invoke[1]"
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test570.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test576.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test579.scxml
[Log] Outcome: "pass"

[Info] Processing SCXML-tutorial/Tests/ecma/W3C/Mandatory/Auto\test580.scxml
[Log] Outcome: "pass"
```

</p></details>

| Test | Result | Description |
|---|---|---|
| [test144.scxml](test144.scxml) | Pass | test that events are inserted into the queue in the order in which they are raised. If foo occurs before bar, success, otherwise failure |
| [test147.scxml](test147.scxml) | Pass | test that the first clause that evaluates to true - and only that clause - is executed. Only one event should be raised, and it should be bar |
| [test148.scxml](test148.scxml) | Pass | test that the else clause executes if [\<if\>](../../../../../Doc/if_else_elseif.md#if) and [\<elseif\>](../../../../../Doc/if_else_elseif.md#elseif) evaluate to false. Baz should be the only event generated by the [\<if\>](../../../../../Doc/if_else_elseif.md#if). bat is raised to catch the case where the [\<else\>](../../../../../Doc/if_else_elseif.md#else) clause fails and baz is not generated, i.e. it makes sure that the test doesn't hang. |
| [test149.scxml](test149.scxml) | Pass | test that neither if clause executes, so that bat is the only event raised. |
| [test150.scxml](test150.scxml) | Pass | test that foreach causes a new variable to be declared if 'item' doesn't already exist. Also test that it will use an existing var if it does exist. |
| [test151.scxml](test151.scxml) | Pass | test that foreach causes a new variable to be declared if 'item' doesn't already exist. Also test that it will use an existing var if it does exist. |
| [test152.scxml](test152.scxml) | Pass | test that an illegal array or item value causes `error.execution` and results in executable content not being executed. |
| [test153.scxml](test153.scxml) | Pass | test that foreach goes over the array in the right order. since the array contains 1 2 3, we compare the current value with the previous value, which is stored in var1. The current value should always be larger. If it ever isn't, set Var4 to 0, indicating failure |
| [test155.scxml](test155.scxml) | Pass | test that foreach executes the executable content once for each item in the list '(1,2,3)'. The executable content sums the items into var1 so it should be 6 at the end |
| [test156.scxml](test156.scxml) | Pass | test that an error causes the foreach to stop execution. The second piece of executable content should cause an error, so var1 should be incremented only once |
| [test158.scxml](test158.scxml) | Pass | test that executable content executes in document order. if event1 occurs then event2, succeed, otherwise fail |
| [test159.scxml](test159.scxml) | Pass | test that any error raised by an element of executable content causes all subsequent elements to be skipped. The send tag will raise an error so var1 should not be incremented. If it is fail, otherwise succeed |
| [test172.scxml](test172.scxml) | Pass | we test that eventexpr uses the current value of var1, not its initial value |
| [test173.scxml](test173.scxml) | Pass | we test that targetexpr uses the current value of var1, not its initial value (If it uses the initial value, it will generate an error. If it uses the current value, event1 will be raised |
| [test174.scxml](test174.scxml) | Pass | we test that typeexpr uses the current value of var1, not its initial value (If it uses the initial value, it will generate an error. If it uses the current value, event1 will be raised |
| [test175.scxml](test175.scxml) | Pass | we test that delayexpr uses the current value of var1, not its initial value (If it uses the initial value, event2 will be generated first, before event1. If it uses the current value, event1 will be raised first. Succeed if event1 occurs before event2, otherwise fail |
| [test176.scxml](test176.scxml) | Pass | we test that [\<param\>](../../../../../Doc/param.md) uses the current value of var1, not its initial value. If the value of aParam in event1 is 2 so that var2 gets set to 2, success, otherwise failure |
| [test179.scxml](test179.scxml) | Pass | we test that [\<content\>](../../../../../Doc/content.md) can be used to populate body of a message |
| [test183.scxml](test183.scxml) | Pass | we test that [\<send\>](../../../../../Doc/send.md) stores the value of the sendid in idlocation. If it does, var1 has a value and we pass. Otherwise we fail |
| [test185.scxml](test185.scxml) | Pass | we test that [\<send\>](../../../../../Doc/send.md) respects the delay specification. If it does, event1 arrives before event2 and we pass. Otherwise we fail |
| [test186.scxml](test186.scxml) | Pass | we test that [\<send\>](../../../../../Doc/send.md) evals its args when it is evaluated, not when the delay interval expires and the message is actually sent. If it does, aParam will have the value of 1 (even though var1 has been incremented in the interval.) If var2 ends up == 1, we pass. Otherwise we fail |
| [test187.scxml](test187.scxml) | Pass | we test that delayed [\<send\>](../../../../../Doc/send.md) is not sent if the sending session terminates. In this case, a subscript is invoked which sends the event childToParent delayed by 1 second, and then terminates. The parent session, should not receive childToParent. If it does, we fail. Otherwise the 10 sec timer expires and we pass |
| [test189.scxml](test189.scxml) | Pass | we test that `#_internal` as a target of [\<send\>](../../../../../Doc/send.md) puts the event on the internal queue. If it does, event1 will be processed before event2, because event1 is added to the internal queue while event2 is added to the external queue (event though event2 is generated first) |
| [test190.scxml](test190.scxml) | Pass | we test that `#_scxml_sessionid` as a target of [\<send\>](../../../../../Doc/send.md) puts the event on the external queue. If it does, event1 will be processed before event2, because event1 is added to the internal queue while event2 is added to the external queue (event though event2 is generated first). we have to make sure that event2 is actually delivered. The delayed [\<send\>](../../../../../Doc/send.md) makes sure another event is generated (so the test doesn't hang) |
| [test191.scxml](test191.scxml) | Pass | we test that `#_parent` works as a target of [\<send\>](../../../../../Doc/send.md) . a subscript is invoked and sends the event childToParent to its parent session (ths session) using `#_parent` as the target. If we get this event, we pass, otherwise we fail. The timer insures that some event is generated and that the test does not hang. |
| [test192.scxml](test192.scxml) | Pass | we test that `#_invokeid` works as a target of [\<send\>](../../../../../Doc/send.md) . A child script is invoked and sends us childToParent once its running. Then we send it the event parentToChild using its invokeid as the target. If it receives this event, it sends sends the event eventReceived to its parent session (ths session). If we get this event, we pass, otherwise the child script eventually times out sends invoke.done and we fail. We also set a timeout in this process to make sure the test doesn't hang |
| [test194.scxml](test194.scxml) | Pass | we test that specifying an illegal target for [\<send\>](../../../../../Doc/send.md) causes the event `error.execution` to be raised. If it does, we succeed. Otherwise we eventually timeout and fail. |
| [test198.scxml](test198.scxml) | Pass | we test that if type is not provided [\<send\>](../../../../../Doc/send.md) uses the scxml event i/o processor. The only way to tell what processor was used is to look at the origintype of the resulting event |
| [test199.scxml](test199.scxml) | Pass | we test that using an invalid send type results in `error.execution` |
| [test200.scxml](test200.scxml) | Pass | we test that the processor supports the scxml event i/o processor |
| [test205.scxml](test205.scxml) | Pass | we test that the processor doesn't change the message. We can't test that it never does this, but at least we can check that the event name and included data are the same as we sent. |
| [test207.scxml](test207.scxml) | Pass | we test that that we can't cancel an event in another session. We invoke a child process. It notifies us when it has generated a delayed event with sendid foo. We try to cancel foo. The child process sends us event event success if the event is not cancelled, event fail otherwise. This doesn't test that there is absolutely no way to cancel an event raised in another session, but the spec doesn't define any way to refer to an event in another process |
| [test208.scxml](test208.scxml) | Pass | we test that cancel works. We cancel delayed event1. If cancel works, we get event2 first and pass. If we get event1 or an error first, cancel didn't work and we fail. |
| [test210.scxml](test210.scxml) | Pass | we test that sendidexpr works with cancel. If it takes the most recent value of var1, it should cancel delayed event1. Thus we get event2 first and pass. If we get event1 or an error first, cancel didn't work and we fail. |
| [test215.scxml](test215.scxml) | Pass | we test that typexpr is evaluated at runtime. If the original value of var1 is used, the invocation will fail (test215sub1.scxml is not of type 'foo', even if the platform supports foo as a type). If the runtime value is used, the invocation will succeed |
| [test216.scxml](test216.scxml) | Pass | we test that srcexpr is evaluated at runtime. If the original value of var1 is used, the invocation will fail (assuming that there is no script named 'foo'). If the runtime value is used, the invocation will succeed |
| [test220.scxml](test220.scxml) | Pass | we test that the scxml type is supported. |
| [test223.scxml](test223.scxml) | Pass | we test that idlocation is supported. |
| [test224.scxml](test224.scxml) | Pass | we test that the automatically generated id has the form stateid.platformid. |
| [test225.scxml](test225.scxml) | Pass | we test that the automatically generated id is unique, we call invoke twice and compare the ids. |
| [test226.scxml](test226.scxml) | Pass | this is basically just a test that invoke works correctly and that you can pass data to the invoked process. If the invoked session finds aParam==1, it exits, signalling success. otherwise it will hang and the timeout in this doc signifies failure. |
| [test228.scxml](test228.scxml) | Pass | test that the invokeid is included in events returned from the invoked process. |
| [test229.scxml](test229.scxml) | Pass | test that autofoward works. If the child process receives back a copy of the childToParent event that it sends to this doc, it sends eventReceived, signalling success. (Note that this doc is not required to process that event explicitly. It should be forwarded in any case.) Otherwise it eventually times out and the `done.invoke` signals failure |
| [test232.scxml](test232.scxml) | Pass | test that a parent process can receive multiple events from a child process |
| [test233.scxml](test233.scxml) | Pass | test that finalize markup runs before the event is processed. The invoked process will return 2 in `_event.data.aParam,` so that new value should be in force when we select the transtitions. |
| [test234.scxml](test234.scxml) | Pass | test that only finalize markup in the invoking state runs. the first invoked process will return 2 in `_event.data.aParam,` while second invoked process sleeps without returning any events. Only the first finalize should execute. So when we get to s1 var1 should have value 2 but var2 should still be set to 1 |
| [test235.scxml](test235.scxml) | Pass | test that `done.invoke.id` event has the right id. the invoked child terminates immediately and should generate `done.invoke.foo` |
| [test236.scxml](test236.scxml) | Pass | test that `done.invoke.id` event is the last event we receive. the invoked process sends childToParent in the exit handler of its final state. We should get it before the `done.invoke,` and we should get no events after the `done.invoke.` Hence timeout indicates success |
| [test237.scxml](test237.scxml) | Pass | test that cancelling works. invoked child sleeps for two seconds, then terminates. We sleep for 1 sec in s0, then move to s1. This should cause the invocation to get cancelled. If we receive `done.invoke,` the invocation wasn't cancelled, and we fail. If we receive no events by the time timeout2 fires, success |
| [test239.scxml](test239.scxml) | Pass | test that markup can be specified both by 'src' and by [\<content\>](../../../../../Doc/content.md) |
| [test240.scxml](test240.scxml) | Pass | test that datamodel values can be specified both by 'namelist' and by [\<param\>](../../../../../Doc/param.md). invoked child will return success if its Var1 is set to 1, failure otherwise. This test will fail schema validation because of the multiple occurences of Var1, but should run correctly. |
| [test241.scxml](test241.scxml) | Pass | The child process will return success ifits Var1 is set to 1, failure otherwise. For this test we try passing in Var1 by param and by namelist and check that we either get two successes or two failures. This test will fail schema validation due to multiple declarations of Var1, but should run correctly. |
| [test242.scxml](test242.scxml) | Pass | test that markup specified by 'src' and by [\<content\>](../../../../../Doc/content.md) is treated the same way. That means that either we get `done.invoke` in both cases or in neither case (in which case we timeout) |
| [test243.scxml](test243.scxml) | Pass | test that datamodel values can be specified by param. test240sub1 will return success ifits Var1 is set to 1, failure otherwise. |
| [test244.scxml](test244.scxml) | Pass | test that datamodel values can be specified by namelist. invoked child will return success ifits Var1 is set to 1, failure otherwise. This test will fail schema validation due to multiple occurrences of Var1, but should run correctly. |
| [test245.scxml](test245.scxml) | Pass | test that non-existent datamodel values are not set. Var2 is not defined in invoked child's datamodel. It will will return success if its Var2 remains unbound, failure otherwise. |
| [test247.scxml](test247.scxml) | Pass | test that we get `done.invoke.` timeout indicates failure |
| [test252.scxml](test252.scxml) | Pass | test that we don't process any events received from the invoked process once it is cancelled. child process tries to send us childToParent in an onexit handler. If we get it, we fail. timeout indicates success. |
| [test253.scxml](test253.scxml) | Pass | test that the scxml event processor is used in both directions. If child process uses the scxml event i/o processor to communicate with us, send it an event. It will send back success if this process uses the scxml processor to send the message to it, otherwise failure. For this test we allow 'scxml' as an alternative to the full url. |
| [test276.scxml](test276.scxml) | Pass | test that values passed in from parent process override default values specified in the child, test276sub1.scxml. The child returns event1 if var1 has value 1, event0 if it has default value 0. |
| [test277.scxml](test277.scxml) | Pass | test that platform creates undound variable if we assign an illegal value to it. Thus we can assign to it later in state s1. |
| [test279.scxml](test279.scxml) | Pass | testing that in case of early binding variables are assigned values at init time, before the state containing them is visited |
| [test280.scxml](test280.scxml) | Pass | test late binding. var2 won't get bound until s1 is entered, so it shouldn't have a value in s0 and accessing it should cause an error. It should get bound before the onentry code in s1 so it should be possible access it there and assign its value to var1 |
| [test286.scxml](test286.scxml) | Pass | test that assigment to a non-declared var causes an error. the transition on foo catches the case where no error is raised |
| [test287.scxml](test287.scxml) | Pass | a simple test that a legal value may be assigned to a valid data model location |
| [test294.scxml](test294.scxml) | Pass | test that a param inside donedata ends up in the data field of the done event and that content inside donedata sets the full value of the event.data field |
| [test298.scxml](test298.scxml) | Pass | reference a non-existent data model location in param in donedata and see that the right error is raised |
| [test302.scxml](test302.scxml) | Pass | test that a script is evaluated at load time. \<conf:script\> shoudl assign the value 1 to Var1. Hence, if script is evaluated at download time, Var1 has a value in the initial state s0. This test is valid only for datamodels that support scripting |
| [test303.scxml](test303.scxml) | Pass | to test that scripts are run as part of executable content, we check that it changes the value of a var at the right point. This test is valid only for datamodels that support scripting |
| [test304.scxml](test304.scxml) | Pass | test that a variable declared by a script can be accessed like any other part of the data model |
| [test309.scxml](test309.scxml) | Pass | test that an expression that cannot be interpreted as a boolean is treated as false |
| [test310.scxml](test310.scxml) | Pass | simple test of the `in()` predicate |
| [test311.scxml](test311.scxml) | Pass | test that assignment to a non-existent location yields an error |
| [test312.scxml](test312.scxml) | Pass | test that assignment with an illegal expr raises an error |
| [test318.scxml](test318.scxml) | Pass | test that `_event` stays bound during the onexit and entry into the next state |
| [test319.scxml](test319.scxml) | Pass | test that `_event` is not bound before any event has been raised |
| [test321.scxml](test321.scxml) | Pass | test that `_sessionid` is bound on startup |
| [test322.scxml](test322.scxml) | Pass | test that `_sessionid` remains bound to the same value throught the session. this means that it can't be assigned to |
| [test323.scxml](test323.scxml) | Pass | test that `_name` is bound on startup |
| [test324.scxml](test324.scxml) | Pass | test that `_name` stays bound till the session ends. This means that it cannot be assigned to |
| [test325.scxml](test325.scxml) | Pass | test that `_ioprocessors` is bound at startup. I'm not sure how to test for a set value or how to test that the entries in it do represent I/O processors, since the set that each implementation supports may be different. Suggestions welcome |
| [test326.scxml](test326.scxml) | Pass | test that `_ioprocessors` stays bound till the session ends. This means that it cannot be assigned to |
| [test329.scxml](test329.scxml) | Pass | test that none of the system variables can be modified |
| [test330.scxml](test330.scxml) | Pass | check that the required fields are present in both internal and external events |
| [test331.scxml](test331.scxml) | Pass | test that `_event.type` is set correctly for internal, platform, and external events |
| [test332.scxml](test332.scxml) | Pass | test that sendid is present in error events triggered by send errors |
| [test333.scxml](test333.scxml) | Pass | make sure sendid is blank in a non-error event |
| [test335.scxml](test335.scxml) | Pass | test that origin field is blank for internal events |
| [test336.scxml](test336.scxml) | Pass | test that the origin field of an external event contains a URL that lets you send back to the originator. In this case it's the same session, so if we get bar we succeed |
| [test337.scxml](test337.scxml) | Pass | test that origintype is blank on internal events |
| [test338.scxml](test338.scxml) | Pass | test that invokeid is set correctly in events received from an invoked process. timeout event catches the case where the invoke doesn't work correctly |
| [test339.scxml](test339.scxml) | Pass | test that invokeid is blank in an event that wasn't returned from an invoked process |
| [test342.scxml](test342.scxml) | Pass | test that eventexpr works and sets the name field of the resulting event |
| [test343.scxml](test343.scxml) | Pass | test that illegal [\<param\>](../../../../../Doc/param.md) produces `error.execution` and empty event.data |
| [test344.scxml](test344.scxml) | Pass | test that a cond expression that cannot be evaluated as a boolean cond expression evaluates to false and causes `error.execution` to be raised. In some languages, any valid expression/object can be converted to a boolean, so conf:nonBoolean will have to be mapped onto something that produces a syntax error or something similarly invalid |
| [test346.scxml](test346.scxml) | Pass | test that any attempt to change the value of a system variable causes `error.execution` to be raised. Event1..4 are there to catch the case where the error event is not raised. In cases where it is, we have to dispose of eventn in the next state, hence the targetless transitions (which simply throw away the event.) |
| [test347.scxml](test347.scxml) | Pass | test that the scxml event I/O processor works by sending events back and forth between an invoked child and its parent process |
| [test348.scxml](test348.scxml) | Pass | test that event param of send sets the name of the event |
| [test349.scxml](test349.scxml) | Pass | test that value in origin field can be used to send an event back to the sender |
| [test350.scxml](test350.scxml) | Pass | test that target value is used to decide what session to deliver the event to. A session should be able to send an event to itself using its own session ID as the target |
| [test351.scxml](test351.scxml) | Pass | test that sendid is set in event if present in send, blank otherwise |
| [test352.scxml](test352.scxml) | Pass | test the origintype is 'http://www.w3.org/TR/scxml/#SCXMLEventProcessor' |
| [test354.scxml](test354.scxml) | Pass | test that event.data can be populated using both namelist, param and [\<content\>](../../../../../Doc/content.md) and that correct values are used |
| [test355.scxml](test355.scxml) | Pass | test that default initial state is first in document order. If we enter s0 first we succeed, if s1, failure. |
| [test364.scxml](test364.scxml) | Pass | test that default initial states are entered when a compound state is entered. First we test the 'initial' attribute, then the initial element, then default to the first child in document order. If we get to s01111 we succeed, if any other state, failure. |
| [test372.scxml](test372.scxml) | Pass | test that entering a final state generates `done.state.parentid` after executing the onentry elements. Var1 should be set to 2 (but not 3) by the time the event is raised |
| [test375.scxml](test375.scxml) | Pass | test that onentry handlers are executed in document order. event1 should be raised before event2 |
| [test376.scxml](test376.scxml) | Pass | test that each onentry handler is a separate block. The [\<send\>](../../../../../Doc/send.md) of event1 will cause an error but the increment to var1 should happen anyways |
| [test377.scxml](test377.scxml) | Pass | test that onexit handlers are executed in document order. event1 should be raised before event2 |
| [test378.scxml](test378.scxml) | Pass | test that each onexithandler is a separate block. The [\<send\>](../../../../../Doc/send.md) of event1 will cause an error but the increment to var1 should happen anyways |
| [test387.scxml](test387.scxml) | Pass | test that the default history state works correctly. From initial state s3 we take a transition to s0's default shallow history state. That should generate "enteringS011", which takes us to s4. In s4, we transition to s1's default deep history state. We should end up in s122, generating "enteringS122". Otherwise failure. |
| [test388.scxml](test388.scxml) | Pass | test that history states works correctly. The counter Var1 counts how many times we have entered s0. The initial state is s012. We then transition to s1, which transitions to s0's deep history state. entering.s012 should be raised, otherwise failure. Then we transition to s02, which transitions to s0's shallow history state. That should have value s01, and its initial state is s011, so we should get entering.s011, otherwise failure. |
| [test396.scxml](test396.scxml) | Pass | test that the value in `_event.name` matches the event name used to match against transitions |
| [test399.scxml](test399.scxml) | Pass | test that the event name matching works correctly, including prefix matching and the fact that the event attribute of transition may contain multiple event designators. |
| [test401.scxml](test401.scxml) | Pass | test that errors go in the internal event queue. We send ourselves an external event foo, then perform and operation that raises an error. Then check that the error event is processed first, even though it was raised second |
| [test402.scxml](test402.scxml) | Pass | the assertion that errors are 'like any other event' is pretty broad, but we can check that they are pulled off the internal queue in order, and that prefix matching works on them. |
| [test403a.scxml](test403a.scxml) | Pass | we test one part of 'optimal enablement' meaning that of all transitions that are enabled, we chose the ones in child states over parent states, and use document order to break ties. We have a parent state s0 with two children, s01 and s02. In s01, we test that a) if a transition in the child matches, we don't consider matches in the parent and b) that if two transitions match in any state, we take the first in document order. In s02 we test that we take a transition in the parent if there is no matching transition in the child. |
| [test403b.scxml](test403b.scxml) | Pass | we test that 'optimally enabled set' really is a set, specifically that if a transition is optimally enabled in two different states, it is taken only once. |
| [test403c.scxml](test403c.scxml) | Pass | we test 'optimally enabled set', specifically that preemption works correctly |
| [test404.scxml](test404.scxml) | Pass | test that states are exited in exit order (children before parents with reverse doc order used to break ties before the executable content in the transitions. event1, event2, event3, event4 should be raised in that order when s01p is exited |
| [test405.scxml](test405.scxml) | Pass | test that the executable content in the transitions is executed in document order after the states are exited. event1, event2, event3, event4 should be raised in that order when the state machine is entered |
| [test406.scxml](test406.scxml) | Pass | Test that states are entered in entry order (parents before children with document order used to break ties) after the executable content in the transition is executed. event1, event2, event3, event4 should be raised in that order when the transition in s01 is taken |
| [test407.scxml](test407.scxml) | Pass | a simple test that onexit handlers work. var1 should be incremented when we leave s0 |
| [test409.scxml](test409.scxml) | Pass | we test that states are removed from the active states list as they are exited. When s01's onexit handler fires, s011 should not be on the active state list, so in(S011) should be false, and event1 should not be raised. Therefore the timeout should fire to indicate success |
| [test411.scxml](test411.scxml) | Pass | we test that states are added to the active states list as they are entered and before onentry handlers are executed. When s0's onentry handler fires we should not be in s01. But when s01's onentry handler fires, we should be in s01. Therefore event1 should not fire, but event2 should. Either event1 or timeout also indicates failure |
| [test412.scxml](test412.scxml) | Pass | test that executable content in the [\<initial\>](../../../../../Doc/Introduction.md#initial-state) transition executes after the onentry handler on the state and before the onentry handler of the child states. Event1, event2, and event3 should occur in that order. |
| [test413.scxml](test413.scxml) | Pass | test that the state machine is put into the configuration specified by the initial element, without regard to any other defaults. we should start off in s2p111 and s2p122. the atomic states we should not enter all have immediate transitions to failure in them |
| [test416.scxml](test416.scxml) | Pass | test that the `done.state.id` gets generated when we enter the final state of a compound state |
| [test417.scxml](test417.scxml) | Pass | test that we get the `done.state.id` event when all of a parallel elements children enter final states. |
| [test419.scxml](test419.scxml) | Pass | test that eventless transitions take precedence over event-driven ones |
| [test421.scxml](test421.scxml) | Pass | test that internal events take priority over external ones, and that the processor keeps pulling off internal events until it finds one that triggers a transition |
| [test422.scxml](test422.scxml) | Pass | Test that at the end of a macrostep, the processor executes all invokes in states that have been entered and not exited during the step. (The invokes are supposed to be executed in document order, but we can test that since each invocation is separate and they may take different amounts to time to start up.) In this case, there are three invoke statements, in states s1, s11 and s12. Each invoked process returns an event named after its parent state. The invokes in s1 and s12 should execute, but not the one in s11. So we should receive invokeS1, invokeS12, but not invokeS12. Furthermore, when the timeout fires, var1 should equal 2. |
| [test423.scxml](test423.scxml) | Pass | test that we keep pulling external events off the queue till we find one that matches a transition. |
| [test487.scxml](test487.scxml) | Pass | test illegal assignment. `error.execution` should be raised. |
| [test488.scxml](test488.scxml) | Pass | test that illegal expr in [\<param\>](../../../../../Doc/param.md) produces `error.execution` and empty event.data |
| [test495.scxml](test495.scxml) | Pass | test that the scxml event i/o processor puts events in the correct queues. |
| [test496.scxml](test496.scxml) | Pass |  |
| [test500.scxml](test500.scxml) | Pass | test that location field is found inside entry for SCXML Event I/O processor |
| [test501.scxml](test501.scxml) | Pass | test that the location entry for the SCXML Event I/O processor can be used as the target for an event |
| [test503.scxml](test503.scxml) | Pass | test that a targetless transition does not exit and reenter its source state |
| [test504.scxml](test504.scxml) | Pass | test that an external transition exits all states up the the LCCA |
| [test505.scxml](test505.scxml) | Pass | test that an internal transition does not exit its source state |
| [test506.scxml](test506.scxml) | Pass | test that an internal transition whose targets are not proper descendants of its source state behaves like an external transition |
| [test521.scxml](test521.scxml) | Pass | we test that the processor raises `error.communication` if it cannot dispatch the event. (To create an undispatchable event, we choose a non-existent session as target). If it raises the error event, we succeed. Otherwise we eventually timeout and fail. |
| [test525.scxml](test525.scxml) | Pass | test that [\<foreach\>](../../../../../Doc/foreach.md) does a shallow copy, so that modifying the array does not change the iteration behavior. |
| [test527.scxml](test527.scxml) | Pass | simple test that 'expr' works with [\<content\>](../../../../../Doc/content.md) |
| [test528.scxml](test528.scxml) | Pass | test that illegal 'expr' produces `error.execution` and empty event.data |
| [test529.scxml](test529.scxml) | Pass | simple test that children workn with [\<content\>](../../../../../Doc/content.md) |
| [test530.scxml](test530.scxml) | Pass | test that [\<content\>](../../../../../Doc/content.md) child is evaluated when [\<invoke\>](../../../../../Doc/invoke.md) is. Var1 is initialized with an integer value, then set to an scxml script in the onentry to s0. If [\<content\>](../../../../../Doc/content.md) is evaluated at the right time, we should get invoke.done, otherwise an error |
| [test533.scxml](test533.scxml) | Pass | test that an internal transition whose source state is not compound does exit its source state |
| [test550.scxml](test550.scxml) | Pass | test that expr can be used to assign a value to a var. This test uses early binding |
| [test551.scxml](test551.scxml) | Pass | test that inline content can be used to assign a value to a var. |
| [test552.scxml](test552.scxml) | Pass | test that src content can be used to assign a value to a var. Edit test552.txt to have a value that's legal for the datamodel in question |
| [test553.scxml](test553.scxml) | Pass | we test that the processor does not dispatch the event if evaluation of [\<send\>](../../../../../Doc/send.md)'s args causes an `error..` |
| [test554.scxml](test554.scxml) | Pass | test that if the evaluation of [\<invoke\>](../../../../../Doc/invoke.md)'s args causes an error, the invocation is cancelled. In this test, that means that we don't get `done.invoke` before the timer goes off. |
| [test570.scxml](test570.scxml) | Pass | test that we generate `done.state.id` when all a parallel state's children are in final states |
| [test576.scxml](test576.scxml) | Pass | test that the 'initial' value of scxml is respected. We set the value to deeply nested non-default parallel siblings and test that both are entered. |
| [test579.scxml](test579.scxml) | Pass | test that default history content is executed correctly. The Process MUST execute any executable content in the transition after the parent state's onentry handlers, and, in the case where the history pseudo-state is the target of an [\<initial\>](../../../../../Doc/Introduction.md#initial-state) transition, the executable content inside the [\<initial\>](../../../../../Doc/Introduction.md#initial-state) transition. However the Processor MUST execute this content only if there is no stored history. Once the history state's parent state has been visited and exited, the default history content must not be executed |
| [test580.scxml](test580.scxml) | Pass | test that a history state never ends up part of the configuration |
