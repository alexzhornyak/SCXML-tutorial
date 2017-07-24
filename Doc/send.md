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

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### [1. Test 172](https://www.w3.org/Voice/2013/scxml-irp/172/test172.txml)
If 'eventexpr' is present, the SCXML Processor MUST evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of 'event'.

![test172](https://user-images.githubusercontent.com/18611095/28521593-11854426-707d-11e7-8876-075887333714.png)

### [2. Test 173](https://www.w3.org/Voice/2013/scxml-irp/173/test173.txml)
If 'targetexpr' is present, the SCXML Processor MUST evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of 'target'.

![test173](https://user-images.githubusercontent.com/18611095/28521711-8806b954-707d-11e7-997a-052c1c3e189a.png)

### [3. Test 174](https://www.w3.org/Voice/2013/scxml-irp/174/test174.txml)
If 'typexpr' is present, the SCXML Processor MUST evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of 'type'.

![test174](https://user-images.githubusercontent.com/18611095/28521813-0220660e-707e-11e7-92d3-44d522b70339.png)

### [4. Test 175](https://www.w3.org/Voice/2013/scxml-irp/175/test175.txml)
If 'delayexpr' is present, the SCXML Processor MUST evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of 'delay'.

![test175](https://user-images.githubusercontent.com/18611095/28522084-512088c8-707f-11e7-9570-3b3b0914137c.png)

### [5. Test 176](https://www.w3.org/Voice/2013/scxml-irp/176/test176.txml)
The SCXML Processor MUST evaluate param when the parent \<send\> element is evaluated and pass the resulting data unmodified to the external service when the message is delivered.

![test176](https://user-images.githubusercontent.com/18611095/28522966-f8f59ca2-7082-11e7-8e2f-d6c925f61ce8.png)

### [6. Test 178](https://www.w3.org/Voice/2013/scxml-irp/178/test178.txml)
The SCXML Processor MUST include all attributes and values provided by param and/or 'namelist' even if duplicates occur.

![test178](https://user-images.githubusercontent.com/18611095/28523387-db107b2e-7084-11e7-9717-1a6ad70da477.png)

```
<scxml datamodel="lua" initial="s0" name="Scxml_Test178" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="s0">
		<onentry>
			<send event="event1">
				<param expr="2" name="Var1"/>
				<param expr="3" name="Var1"/>
			</send>
		</onentry>
		<transition event="event1" target="final">
			<log label="_event " expr="_event"/>
		</transition>
		<transition event="*" target="fail"/>
	</state>
	<final id="final"/>
	<final id="fail">
		<onentry>
			<log expr="'fail'" label="Outcome"/>
		</onentry>
	</final>
</scxml>
```

**Output:**
> External Event: event1, interpreter [Scxml_Test178] 
  [Log] _event : { 
      "data":       { 
        "Var1": 3 
      }, 
      "name":       "event1", 
      "origin":     "#_scxml_7927b337-addb-4eb5-bcf6-f12e42828924", 
      "origintype": "http://www.w3.org/TR/scxml/#SCXMLEventProcessor", 
      "type":       "external" 
    } 
   
    
