# \<send\>
The element is used to send events and data to external systems, including external SCXML Interpreters, or to raise events in the current SCXML session.

## Attribute Details
### 1. 'event'
A string indicating the name of message being generated. Must not occur with 'eventexpr'. If the type is http://www.w3.org/TR/scxml/#SCXMLEventProcessor, either this attribute or 'eventexpr' must be present.

### 2. 'eventexpr'
A dynamic alternative to 'event'. If this attribute is present, the SCXML Processor must evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of 'event'.
Must not occur with 'event'. If the type is http://www.w3.org/TR/scxml/#SCXMLEventProcessor, either this attribute or 'event' must be present.

### 3. 'target'
The unique identifier of the message target that the platform should send the event to. See [6.2.4 The Target of Send](https://www.w3.org/TR/scxml/#SendTargets) for details. Must not occur with 'targetexpr'.

### 4. 'targetexpr'
A dynamic alternative to 'target'. If this attribute is present, the SCXML Processor must evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of 'target'. Must not occur with 'target'.

### 5. 'type'
The URI that identifies the transport mechanism for the message. See [6.2.5 The Type of Send](https://www.w3.org/TR/scxml/#SendTypes) for details. Must not occur with 'typeexpr'.

### 6. 'typeexpr'
A dynamic alternative to 'type'. If this attribute is present, the SCXML Processor must evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of 'type'. Must not occur with 'type'.

### 7. 'id'
A string literal to be used as the identifier for this instance of \<send\>. See [3.14 IDs](https://www.w3.org/TR/scxml/#IDs) for details. Must not occur with 'idlocation'.

### 8. 'idlocation'
Any location expression evaluating to a data model location in which a system-generated id can be stored. Must not occur with 'id'.

### 9. 'delay'
A time designation as defined in CSS2 format. Indicates how long the processor should wait before dispatching the message. Must not occur with 'delayexpr' or when the attribute 'target' has the value "#_internal".

### 10. 'delayexpr'
A value expression which returns a time designation as defined in CSS2 format. A dynamic alternative to 'delay'. If this attribute is present, the SCXML Processor must evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of 'delay'. Must not occur with 'delayexpr' or when the attribute 'target' has the value "#_internal".

### 11. 'namelist'
List of valid location expressions. A space-separated list of one or more data model locations to be included as attribute/value pairs with the message. (The name of the location is the attribute and the value stored at the location is the value.) See [5.9.2 Location Expressions](https://www.w3.org/TR/scxml/#LocationExpressions) for details.
