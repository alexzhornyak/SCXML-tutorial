# \<cancel\>
The element is used to cancel a delayed \<send\> event. The SCXML Processor **must not allow** \<cancel\> to affect events that were not raised in **the same session**. The Processor should make its best attempt to cancel all delayed events with the specified id. Note, however, **that it can not be guaranteed to succeed**, for example if the event has already been delivered by the time the \<cancel\> tag executes.

## Attribute Details
Name	|Required	|Attribute Constraints	|Type	|Default Value	|Valid Values	|Description
---|---|---|---|---|---|---|
sendid	|false	|Must not occur with sendidexpr.	|IDREF	|none	|The sendid of a delayed event	|The ID of the event(s) to be cancelled. If multiple delayed events have this sendid, the Processor will cancel them all.
sendidexpr	|false	|Must not occur with sendid.	|Value Expression	|none	|Any expression that evaluates to the ID of a delayed event	|A dynamic alternative to 'sendid'. If this attribute is present, the SCXML Processor must evaluate it when the parent \<cancel\> element is evaluated and treat the result as if it had been entered as the value of 'sendid'.

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### [1. Test 207](https://www.w3.org/Voice/2013/scxml-irp/207/test207.txml)
The SCXML Processor MUST NOT allow cancel to affect events that were not raised in the same session.

![test207](https://user-images.githubusercontent.com/18611095/28563182-d44070ca-712d-11e7-8285-5dd93092f47e.png)

![test207 - child](https://user-images.githubusercontent.com/18611095/28563194-dd998594-712d-11e7-8b5f-9d2f14fbb4c6.png)

### [2. Test 208](https://www.w3.org/Voice/2013/scxml-irp/208/test208.txml)
The Processor SHOULD make its best attempt to cancel all delayed events with the specified id.

![test208](https://user-images.githubusercontent.com/18611095/28563414-904019a6-712e-11e7-8ad6-4ca295be1620.png)

### [3. Test 210](https://www.w3.org/Voice/2013/scxml-irp/210/test210.txml)
If the **'sendidexpr'** attribute is present, the SCXML Processor MUST evaluate it when the parent cancel element is evaluated and treat the result as if it had been entered as the value of **'sendid'**.

![test210](https://user-images.githubusercontent.com/18611095/28563685-60643a68-712f-11e7-9ea0-f8f66fd3a023.png)
