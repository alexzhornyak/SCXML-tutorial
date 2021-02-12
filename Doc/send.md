<a name="top-anchor"/>

| [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|

# [\<send\>](https://www.w3.org/TR/scxml/#send)
The element is used to send events and data to external systems, including external SCXML Interpreters, or to raise events in the current SCXML session.

![send_example](../Images/TimerGenerator.gif)
```xml
<scxml datamodel="lua" initial="Off" name="ScxmlTimeGenerator" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<datamodel>
		<data expr="0" id="tm_ELAPSED"/>
	</datamodel>
	<state id="Off">
		<transition event="Start" target="Generator"/>
	</state>
	<state id="Generator">
		<onentry>
			<assign expr="os.clock()" location="tm_ELAPSED"/>
		</onentry>
		<onexit>
			<cancel sendid="ID_TIMER"/>
		</onexit>
		<transition event="Stop" target="Off"/>
		<state id="StateShape1">
			<onentry>
				<log expr="string.format('Elapsed:%.2fs', os.clock() - tm_ELAPSED)" label="INFO"/>
				<send delay="1000ms" event="Do.Timer" id="ID_TIMER"/>
			</onentry>
			<transition event="Do.Timer" target="StateShape1"/>
		</state>
	</state>
</scxml>
```

## Attribute Details
### 1. 'event'
A string indicating the name of message being generated. Must not occur with 'eventexpr'. If the type is http://www.w3.org/TR/scxml/#SCXMLEventProcessor, either this attribute or 'eventexpr' must be present.

### 2. 'eventexpr'
A dynamic alternative to 'event'. If this attribute is present, the SCXML Processor must evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of 'event'.
Must not occur with 'event'. If the type is http://www.w3.org/TR/scxml/#SCXMLEventProcessor, either this attribute or 'event' must be present.

### 3. 'target'
The unique identifier of the message target that the platform should send the event to. See [6.2.4 The Target of Send](https://www.w3.org/TR/scxml/#SendTargets) for details. Must not occur with 'targetexpr'. <br/>
#### When using the SCXML Event I/O Processor, SCXML Processors must support the following special targets for \<send\>:
**`#_internal`**. The Processor must add the event to the internal event queue of the sending session.
```xml
<state id="Parent">
	<invoke autoforward="true" id="ID_MODULE_CHILD" src="Child.scxml"/>
	<onentry>
		<!-- event 'Timeout' will not come to any invoked session -->
		<send event="Timeout" target="#_internal"/>
	</onentry>
</state>
```
**`#_scxml_sessionid`**. If the target is the special term `#_scxml_sessionid` (`#_scxml_` + `sessionid`), where `sessionid` is the id of an SCXML session that is accessible to the Processor, the Processor must add the event to the external queue of that session. The set of SCXML sessions that are accessible to a given SCXML Processor is platform-dependent.
```xml
<state id="Parent">
	<transition event="Msg.From.Child">
		<send delay="1s" event="Quit.Child" targetexpr="'#_scxml_' + _event.data"/>
	</transition>
</state>
```
**`#_parent`**. The Processor must add the event to the external event queue of the SCXML session that invoked the sending session, if there is one. See [\<invoke\>](invoke.md) for details.
```xml
<state id="Child">
	<onentry>
		<send event="Msg.From.Child" target="#_parent">
			<content expr="_sessionid"/>
		</send>
	</onentry>
</state>
```
**`#_invokeid`**. If the target is the special term `#_invokeid` (`#_` + `invokeid`), where `invokeid` is the invokeid of an SCXML session that the sending session has created by [\<invoke\>](invoke.md), the Processor must add the event to the external queue of that session. See [\<invoke\>](invoke.md) for details. <br/>
```xml
<state id="Parent">
	<invoke id="ID_MODULE_CHILD" src="Child.scxml" autoforward="false" />
	<onentry>
		<!-- invoked session with id 'ID_MODULE_CHILD' will receive event 'Timeout' after 2 seconds -->
		<send delay="2s" event="Timeout" target="#_ID_MODULE_CHILD"/>
	</onentry>
</state>
```
### 4. 'targetexpr'
A dynamic alternative to 'target'. If this attribute is present, the SCXML Processor must evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of 'target'. Must not occur with 'target'.
### 5. 'type'
The URI that identifies the transport mechanism for the message. See [6.2.5 The Type of Send](https://www.w3.org/TR/scxml/#SendTypes) for details. Must not occur with 'typeexpr'.
#### 5.1. [SCXML Event I/O Processor (Default)](https://www.w3.org/TR/scxml/#SCXMLEventProcessor).
Target is an SCXML session. The transport mechanism is platform-specific.
```xml
<send delay="2s" event="Timer"/>
<send delay="2s" event="Timer" type="http://www.w3.org/TR/scxml/#SCXMLEventProcessor"/>
```
#### 5.2. [Basic HTTP Event I/O Processor](BasicHTTPEventIO.md)
Target is a URL. Data is sent via HTTP POST
```xml
<send event="ToRemoteMachine" type="http://www.w3.org/TR/scxml/#BasicHTTPEventProcessor"/>
```
### 6. 'typeexpr'
A dynamic alternative to 'type'. If this attribute is present, the SCXML Processor must evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of 'type'. Must not occur with 'type'.

### 7. 'id'
A string literal to be used as the identifier for this instance of \<send\>. See [3.14 IDs](https://www.w3.org/TR/scxml/#IDs) for details. Must not occur with 'idlocation'.
```xml
<state id="start">
	<onentry>
		<send delay="5s" event="Timer2" id="ID_Timer2"/>
	</onentry>
	<onexit>
		<cancel sendid="ID_Timer2"/>
	</onexit>
</state>
```
### 8. 'idlocation'
Any location expression evaluating to a data model location in which a system-generated id can be stored. Must not occur with 'id'.

### 9. 'delay'
A time designation as defined in CSS2 format. Indicates how long the processor should wait before dispatching the message. Must not occur with 'delayexpr' or when the attribute 'target' has the value `#_internal`.
```xml
<send delay="4s" event="Timer1"/>
<send delay="500ms" event="Timer2"/>
```
### 10. 'delayexpr'
A value expression which returns a time designation as defined in CSS2 format. A dynamic alternative to 'delay'. If this attribute is present, the SCXML Processor must evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of 'delay'. Must not occur with 'delayexpr' or when the attribute 'target' has the value `#_internal`.
```xml
<send delayexpr="2*2 + 's'" event="Timer1"/>
<send delay="5*100 + 'ms'" event="Timer2"/>
```

### 11. 'namelist'
List of valid location expressions. A space-separated list of one or more data model locations to be included as attribute/value pairs with the message. (The name of the location is the attribute and the value stored at the location is the value.) See [5.9.2 Location Expressions](https://www.w3.org/TR/scxml/#LocationExpressions) for details.

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

Number|Name and link|Source|
---|---|---|
1|[Test 172](send.md#1-test-172)|https://www.w3.org/Voice/2013/scxml-irp/172/test172.txml
2|[Test 173](send.md#2-test-173)|https://www.w3.org/Voice/2013/scxml-irp/173/test173.txml
3|[Test 174](send.md#3-test-174)|https://www.w3.org/Voice/2013/scxml-irp/174/test174.txml
4|[Test 175](send.md#4-test-175)|https://www.w3.org/Voice/2013/scxml-irp/175/test175.txml
5|[Test 176](send.md#5-test-176)|https://www.w3.org/Voice/2013/scxml-irp/176/test176.txml
6|[Test 178](send.md#6-test-178)|https://www.w3.org/Voice/2013/scxml-irp/178/test178.txml
7|[Test 179](send.md#7-test-179)|https://www.w3.org/Voice/2013/scxml-irp/179/test179.txml
8|[Test 183](send.md#8-test-183)|https://www.w3.org/Voice/2013/scxml-irp/183/test183.txml
9|[Test 185](send.md#9-test-185)|https://www.w3.org/Voice/2013/scxml-irp/185/test185.txml
10|[Test 186](send.md#10-test-186)|https://www.w3.org/Voice/2013/scxml-irp/186/test186.txml
11|[Test 187](send.md#11-test-187)|https://www.w3.org/Voice/2013/scxml-irp/187/test187.txml
12|[Test 194](send.md#12-test-194)|https://www.w3.org/Voice/2013/scxml-irp/194/test194.txml
13|[Test 198](send.md#13-test-198)|https://www.w3.org/Voice/2013/scxml-irp/198/test198.txml
14|[Test 199](send.md#14-test-199)|https://www.w3.org/Voice/2013/scxml-irp/199/test199.txml
15|[Test 200](send.md#15-test-200)|https://www.w3.org/Voice/2013/scxml-irp/200/test200.txml
16|[Test 201](send.md#16-test-201)|https://www.w3.org/Voice/2013/scxml-irp/201/test201.txml
17|[Test 521](send.md#17-test-521)|https://www.w3.org/Voice/2013/scxml-irp/521/test521.txml
18|[Test 553](send.md#18-test-553)|https://www.w3.org/Voice/2013/scxml-irp/553/test553.txml


### [1. Test 172](https://www.w3.org/Voice/2013/scxml-irp/172/test172.txml)
If **'eventexpr'** is present, the SCXML Processor MUST evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of **'event'**.

![test172](https://user-images.githubusercontent.com/18611095/28521593-11854426-707d-11e7-8876-075887333714.png)

### [2. Test 173](https://www.w3.org/Voice/2013/scxml-irp/173/test173.txml)
If **'targetexpr'** is present, the SCXML Processor MUST evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of **'target'**.

![test173](https://user-images.githubusercontent.com/18611095/28521711-8806b954-707d-11e7-997a-052c1c3e189a.png)

### [3. Test 174](https://www.w3.org/Voice/2013/scxml-irp/174/test174.txml)
If **'typexpr'** is present, the SCXML Processor MUST evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of **'type'**.

![test174](https://user-images.githubusercontent.com/18611095/28521813-0220660e-707e-11e7-92d3-44d522b70339.png)

### [4. Test 175](https://www.w3.org/Voice/2013/scxml-irp/175/test175.txml)
If **'delayexpr'** is present, the SCXML Processor MUST evaluate it when the parent \<send\> element is evaluated and treat the result as if it had been entered as the value of **'delay'**.

![test175](https://user-images.githubusercontent.com/18611095/28522084-512088c8-707f-11e7-9570-3b3b0914137c.png)

### [5. Test 176](https://www.w3.org/Voice/2013/scxml-irp/176/test176.txml)
The SCXML Processor MUST evaluate param when the parent \<send\> element is evaluated and pass the resulting data unmodified to the external service when the message is delivered.

![test176](https://user-images.githubusercontent.com/18611095/28522966-f8f59ca2-7082-11e7-8e2f-d6c925f61ce8.png)

### [6. Test 178](https://www.w3.org/Voice/2013/scxml-irp/178/test178.txml)
The SCXML Processor MUST include all attributes and values provided by [**param**](param.md) and/or **'namelist'** even if duplicates occur.

![test178](https://user-images.githubusercontent.com/18611095/28523387-db107b2e-7084-11e7-9717-1a6ad70da477.png)

```xml
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
```
External Event: event1, interpreter [Scxml_Test178]
[Log] _event : {
    "data": {
        "Var1": 3 
    },
    "name":       "event1",
    "origin":     "#_scxml_7927b337-addb-4eb5-bcf6-f12e42828924",
    "origintype": "http://www.w3.org/TR/scxml/#SCXMLEventProcessor",
    "type":       "external"
}
```
   
### [7. Test 179](https://www.w3.org/Voice/2013/scxml-irp/179/test179.txml)
The SCXML Processor MUST evaluate the [\<content\>](content.md) element when the parent \<send\> element is evaluated and pass the resulting data unmodified to the external service when the message is delivered.

![test179](https://user-images.githubusercontent.com/18611095/28558230-b41e4fce-7119-11e7-947f-24310d2e4225.png)

### [8. Test 183](https://www.w3.org/Voice/2013/scxml-irp/183/test183.txml)
If 'idlocation' is present, the SCXML Processor MUST generate an id when the parent \<send\> element is evaluated and store it in this location.

![test183](https://user-images.githubusercontent.com/18611095/28558378-5637fefe-711a-11e7-9dd6-321ae90d20dc.png)

### [9. Test 185](https://www.w3.org/Voice/2013/scxml-irp/185/test185.txml)
If a delay is specified via **'delay'** or **'delayexpr'**, the SCXML Processor MUST interpret the character string as a time interval. the SCXML Processor MUST dispatch the message only when the delay interval elapses.

![test185](https://user-images.githubusercontent.com/18611095/28558561-ff3621de-711a-11e7-8190-897b5d05087c.png)

### [10. Test 186](https://www.w3.org/Voice/2013/scxml-irp/186/test186.txml)
The Processor MUST evaluate all arguments to send when the send element is evaluated, and not when the message is actually dispatched.

![test186](https://user-images.githubusercontent.com/18611095/28559885-19d57d0e-7121-11e7-847f-1f555df8fd75.png)

### [11. Test 187](https://www.w3.org/Voice/2013/scxml-irp/187/test187.txml)
If the SCXML session terminates before the delay interval has elapsed, the SCXML Processor MUST discard the message without attempting to deliver it.

![test187](https://user-images.githubusercontent.com/18611095/28560628-2f6b17f2-7124-11e7-9ff6-59c517a6974c.png)

![test187 - child](https://user-images.githubusercontent.com/18611095/28560641-3a0b5000-7124-11e7-8beb-41a3a01c2e7b.png)

### [12. Test 194](https://www.w3.org/Voice/2013/scxml-irp/194/test194.txml)
If the value of the **'target'** or **'targetexpr'** attribute is not supported or invalid, the Processor MUST place the error **error.execution** on the internal event queue.

![test194](https://user-images.githubusercontent.com/18611095/28561091-b30dd724-7125-11e7-9929-eb2e5192ef6d.png)

### [13. Test 198](https://www.w3.org/Voice/2013/scxml-irp/198/test198.txml)
If neither the **'type'** nor the **'typeexpr'** is defined, the SCXML Processor MUST assume the default value of http://www.w3.org/TR/scxml/#SCXMLEventProcessor.

![test198](https://user-images.githubusercontent.com/18611095/28561419-0082acb8-7127-11e7-997c-494c0d81dc65.png)

### [14. Test 199](https://www.w3.org/Voice/2013/scxml-irp/199/test199.txml)
If the SCXML Processor does not support the type that is specified, it MUST place the event **error.execution** on the internal event queue.

![test199](https://user-images.githubusercontent.com/18611095/28561552-95405ad0-7127-11e7-99f3-f85ba7ac71d9.png)

### [15. Test 200](https://www.w3.org/Voice/2013/scxml-irp/200/test200.txml)
SCXML Processors MUST support the type http://www.w3.org/TR/scxml/#SCXMLEventProcessor.

![test200](https://user-images.githubusercontent.com/18611095/28561706-14eefcf0-7128-11e7-96db-638e3cb9b8fa.png)

### [16. Test 201](https://www.w3.org/Voice/2013/scxml-irp/201/test201.txml)
Processors that support HTTP POST must use the value http://www.w3.org/TR/scxml/#BasicHTTPEventProcessor for the **'type'** attribute.

![test201](https://user-images.githubusercontent.com/18611095/28561917-ea2b7e2a-7128-11e7-9cdc-0edb5362df53.png)

The sending SCXML Interpreter MUST not alter the content of the send and include it in the message that it sends to the destination specified in the target attribute of send.

![test205](https://user-images.githubusercontent.com/18611095/28562107-ae58d23e-7129-11e7-9504-1672d149e8e8.png)

### [17. Test 521](https://www.w3.org/Voice/2013/scxml-irp/521/test521.txml)
If the Processor cannot dispatch the event, it MUST place the error **error.communication** on the internal event queue of the session that attempted to send the event.

![test521](https://user-images.githubusercontent.com/18611095/28562292-57e4be3a-712a-11e7-9340-a341cbc81300.png)

### [18. Test 553](https://www.w3.org/Voice/2013/scxml-irp/553/test553.txml)
If the evaluation of send's arguments produces an error, If the evaluation of send's arguments produces an error, the Processor MUST discard the message without attempting to deliver it.

![test553](https://user-images.githubusercontent.com/18611095/28562498-20012dae-712b-11e7-9d11-bc101df19923.png)

| [TOP](#top-anchor) | [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|---|
