# \<invoke\>
The element is used to create an instance of an external service.

## Attribute Details

### 1. 'type'
A URI specifying the type of the external service. Valid values are http://www.w3.org/TR/scxml/, http://www.w3.org/TR/ccxml/, http://www.w3.org/TR/voicexml30/, http://www.w3.org/TR/voicexml21/ plus other platform-specific values. Must not occur with the 'typeexpr' attribute.

### 2. 'typeexpr'
Any value expression that evaluates to a URI that would be a valid value for 'type'. A dynamic alternative to 'type'. If this attribute is present, the SCXML Processor must evaluate it when the parent <invoke> element is evaluated and treat the result as if it had been entered as the value of 'type'. Must not occur with the 'type' attribute.

### 3. 'src'
A URI to be passed to the external service. Must not occur with the 'srcexpr' attribute or the \<content\> element.

### 4. 'srcexpr'
Any expression evaluating to a valid URI. A dynamic alternative to 'src'. If this attribute is present, the SCXML Processor must evaluate it when the parent <invoke> element is evaluated and treat the result as if it had been entered as the value of 'src'. Must not occur with the 'src' attribute or the <content> element.

### 5. 'id'
A string literal to be used as the identifier for this instance of \<invoke\>. Must not occur with the 'idlocation' attribute.

### 6. 'idlocation'
Any valid data model expression evaluating to a data model location. See [5.9.2 Location Expressions](https://www.w3.org/TR/scxml/#LocationExpressions) for details. Must not occur with the 'id' attribute.

### 7. 'namelist'
A space-separated list of one or more data model locations to be passed as attribute/value pairs to the invoked service. (The name of the location is the attribute and the value stored at the location is the value.). Must not occur with the \<param\> element.

### 8. 'autoforward'
A boolean flag indicating whether to forward events to the invoked process. Default value is **'false'**.

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### [1. Test 215](https://www.w3.org/Voice/2013/scxml-irp/215/test215.txml)
If the 'typeexpr' attribute is present, the SCXML Processor MUST evaluate it when the parent invoke element is evaluated and treat the result as if it had been entered as the value of 'type'.

![test215](https://user-images.githubusercontent.com/18611095/28564690-81021260-7132-11e7-9d85-60d77feed20c.png)

![test215 - child](https://user-images.githubusercontent.com/18611095/28564691-8102a7de-7132-11e7-8ec1-c3dd93b8dc93.png)

### [2. Test 216](https://www.w3.org/Voice/2013/scxml-irp/216/test216.txml)
If the srcexpr attribute is present, the SCXML Processor MUST evaluate it when the parent invoke element is evaluated and treat the result as if it had been entered as the value of 'src'.

![test216](https://user-images.githubusercontent.com/18611095/28572935-92bece20-7151-11e7-9a7e-44bb83642bdc.png)

![test216sub1](https://user-images.githubusercontent.com/18611095/28573035-db860bf0-7151-11e7-953b-bb1fad23edc5.png)

### [3. Test 220](https://www.w3.org/Voice/2013/scxml-irp/220/test220.txml)
Platforms MUST support http://www.w3.org/TR/scxml/, as a value for the 'type' attribute.

![test220](https://user-images.githubusercontent.com/18611095/28573225-a3f7bfc0-7152-11e7-829a-6bf632cce875.png)

![test220 - child](https://user-images.githubusercontent.com/18611095/28573226-a3fa0b72-7152-11e7-8bfd-376306be4b9e.png)

### [4. Test 223](https://www.w3.org/Voice/2013/scxml-irp/223/test223.txml)
If the 'idlocation' attribute is present, the SCXML Processor MUST generate an id automatically when the invoke element is evaluated and store it in the location specified by 'idlocation'.

![test223](https://user-images.githubusercontent.com/18611095/28573412-3ebb5922-7153-11e7-9ac5-2e5a086a6c82.png)

![test220 - child](https://user-images.githubusercontent.com/18611095/28573226-a3fa0b72-7152-11e7-8bfd-376306be4b9e.png)

### [5. Test 224](https://www.w3.org/Voice/2013/scxml-irp/224/test224.txml)
When the platform generates an identifier for 'idlocation', the identifier MUST have the form **stateid.platformid**, where **stateid** is the id of the state containing this element and **platformid** is automatically generated.

![test224](https://user-images.githubusercontent.com/18611095/28573731-3ad761ce-7154-11e7-9421-a289e295748e.png)

![test220 - child](https://user-images.githubusercontent.com/18611095/28573226-a3fa0b72-7152-11e7-8bfd-376306be4b9e.png)

### [6. Test 225](https://www.w3.org/Voice/2013/scxml-irp/225/test225.txml)
In the automatically generated invoke identifier, **platformid** MUST be unique within the current session.

![test225](https://user-images.githubusercontent.com/18611095/28573936-03d10b48-7155-11e7-90c6-8e7fc277962b.png)

![test225 - child1](https://user-images.githubusercontent.com/18611095/28573935-03d0924e-7155-11e7-9397-0d25c2da9769.png)

![test225 - child2](https://user-images.githubusercontent.com/18611095/28573934-03cf5f14-7155-11e7-8b5b-2ae5e9f0883f.png)

### [7. Test 226](https://www.w3.org/Voice/2013/scxml-irp/226/test226.txml)
When the invoke element is executed, the SCXML Processor MUST start a new logical instance of the external service specified in 'type' or 'typexpr', passing it the URL specified by 'src' or the data specified by content, or param.

![test226](https://user-images.githubusercontent.com/18611095/28574248-0a920f6c-7156-11e7-82c6-50627c45ca81.png)

![test226sub1](https://user-images.githubusercontent.com/18611095/28574247-0a91d22c-7156-11e7-9775-ef94be48730d.png)

### [8. Test 228](https://www.w3.org/Voice/2013/scxml-irp/228/test228.txml)
The Processor MUST keep track of the unique invokeid and insure that it is included in all events that the invoked service returns to the invoking session.

![test228](https://user-images.githubusercontent.com/18611095/28610411-eba946a6-71f0-11e7-8cef-3121565e4c22.png)

![test220 - child](https://user-images.githubusercontent.com/18611095/28573226-a3fa0b72-7152-11e7-8bfd-376306be4b9e.png)

### [9. Test 229](https://www.w3.org/Voice/2013/scxml-irp/229/test229.txml)
When the 'autoforward' attribute is set to true, the SCXML Processor MUST send an exact copy of every external event it receives to the invoked process.

![test229](https://user-images.githubusercontent.com/18611095/28610868-90f781da-71f2-11e7-9e31-741633bc0b81.png)

![test 229 - child](https://user-images.githubusercontent.com/18611095/28610869-916c0c08-71f2-11e7-97f9-2cbf12b46c43.png)

### [10. Test 230](https://www.w3.org/Voice/2013/scxml-irp/230/test230.txml)
When the SCXML Processor autoforwards an event to the invoked process, all the fields specified in [5.10.1 The Internal Structure of Events](https://www.w3.org/TR/scxml/#SystemVariables) MUST have the same values in the forwarded copy of the event.

![test230](https://user-images.githubusercontent.com/18611095/28611718-64081808-71f5-11e7-8acd-3805f4d89eb3.png)

![test230 - child](https://user-images.githubusercontent.com/18611095/28611717-6406d8ee-71f5-11e7-85de-ca45e77cc3b0.png)

**Output:**
```
External Event: childToParent, interpreter [Scxml_Test230]
[Log] name is : "childToParent"
[Log] type is : "external"
[Log] sendid is : nil
External Event: childToParent, interpreter [ScxmlChild]
[Log] origin is : "#_scxml_35ebd509-4b45-419f-b021-3df9060f38cf"
[Log] origintype is : "http://www.w3.org/TR/scxml/#SCXMLEventProcessor"
[Log] name is : "childToParent"
[Log] invokeid is : "s0.3b6c2a1a-8bdf-42fe-bc0d-386cd510bf74"
[Log] type is : "external"
[Log] data is : nil
[Log] sendid is : nil
[Log] origin is : "#_scxml_35ebd509-4b45-419f-b021-3df9060f38cf"
[Log] origintype is : "http://www.w3.org/TR/scxml/#SCXMLEventProcessor"
[Log] invokeid is : "s0.3b6c2a1a-8bdf-42fe-bc0d-386cd510bf74"
[Log] data is : nil
Platform Event: done.invoke.s0.3b6c2a1a-8bdf-42fe-bc0d-386cd510bf74, interpreter [Scxml_Test230]
```

### [11. Test 232](https://www.w3.org/Voice/2013/scxml-irp/232/test232.txml)
The invoked external service MAY return multiple events while it is processing.

![test232](https://user-images.githubusercontent.com/18611095/28612131-ea94794c-71f6-11e7-890d-7e8ffa59af10.png)

![test232 - child](https://user-images.githubusercontent.com/18611095/28612132-ea94e8f0-71f6-11e7-9cf6-4b2223c86657.png)

### [12. Test 233](https://www.w3.org/Voice/2013/scxml-irp/233/test233.txml)
If there is a finalize handler in the instance of invoke that created the service that generated the event, the SCXML Processor MUST execute the code in that finalize handler right before it removes the event from the event queue for processing.

![test233](https://user-images.githubusercontent.com/18611095/28613137-249c9806-71fa-11e7-8f70-c6788e704253.png)

![test233 - child](https://user-images.githubusercontent.com/18611095/28613136-249b354c-71fa-11e7-95f7-29181ac699b6.png)

### [13. Test 234](https://www.w3.org/Voice/2013/scxml-irp/234/test234.txml)
It MUST NOT execute the finalize handler in any other instance of invoke besides the one in the instance of invoke that created the service that generated the event.
  
![test234](https://user-images.githubusercontent.com/18611095/28613739-e94d6b70-71fb-11e7-921d-52fec13157ec.png)
  
![test234 - child 1](https://user-images.githubusercontent.com/18611095/28613738-e94b73c4-71fb-11e7-8363-76d5dbd7adb3.png)

![test234 - child 2](https://user-images.githubusercontent.com/18611095/28613740-e9505a4c-71fb-11e7-9062-324039466305.png)

### [14. Test 235](https://www.w3.org/Voice/2013/scxml-irp/235/test235.txml)
Once the invoked external service has finished processing it MUST return a special event 'done.invoke.id' to the external event queue of the invoking process, where id is the invokeid for the corresponding invoke element.

![test235](https://user-images.githubusercontent.com/18611095/28616607-034b189c-7206-11e7-8cd7-f04e1338d39d.png)

![test220 - child](https://user-images.githubusercontent.com/18611095/28573226-a3fa0b72-7152-11e7-8bfd-376306be4b9e.png)

### [15. Test 236](https://www.w3.org/Voice/2013/scxml-irp/236/test236.txml)
The external service MUST NOT generate any other events after the invoke.done.invokeid event.

![test236](https://user-images.githubusercontent.com/18611095/28617057-91e0d01e-7207-11e7-8a6a-6e1829842e98.png)

![test236 - child](https://user-images.githubusercontent.com/18611095/28617056-91d9bb30-7207-11e7-99e6-2f726c3272ce.png)

### [16. Test 237](https://www.w3.org/Voice/2013/scxml-irp/237/test237.txml)
If the invoking session takes a transition out of the state containing the invoke before it receives the 'done.invoke.id' event, the SCXML Processor MUST automatically cancel the invoked component and stop its processing.

![test237](https://user-images.githubusercontent.com/18611095/28617375-c578cb42-7208-11e7-8716-089620df21c8.png)

![test237 - child](https://user-images.githubusercontent.com/18611095/28617374-c578962c-7208-11e7-8260-3c901f8bfd54.png)

### [17. Test 239](https://www.w3.org/Voice/2013/scxml-irp/239/test239.txml)
Invoked services of type **http://www.w3.org/TR/scxml/**, **http://www.w3.org/TR/ccxml/**, **http://www.w3.org/TR/voicexml30/**, or **http://www.w3.org/TR/voicexml21** MUST interpret values specified by the content element or 'src' attribute as markup to be executed.

![test239](https://user-images.githubusercontent.com/18611095/28618069-ae6d3fca-720b-11e7-805c-bdb3f3483790.png)

![test239 - child](https://user-images.githubusercontent.com/18611095/28618068-ae6c3544-720b-11e7-988b-e81f9aa7791b.png)

![test239sub1](https://user-images.githubusercontent.com/18611095/28618067-ae6bbdf8-720b-11e7-9a1d-368ff91746b2.png)

### [18. Test 240](https://www.w3.org/Voice/2013/scxml-irp/240/test240.txml)
Invoked services of type **http://www.w3.org/TR/scxml/**, **http://www.w3.org/TR/ccxml/**, **http://www.w3.org/TR/voicexml30/**, or **http://www.w3.org/TR/voicexml21** MUST interpret values specified by param element or 'namelist' attribute as values that are to be injected into their data models.

![test240](https://user-images.githubusercontent.com/18611095/28618479-3e60eba8-720d-11e7-86a3-b51f3ad579df.png)

![test240 - child 1](https://user-images.githubusercontent.com/18611095/28618478-3e5cc8ac-720d-11e7-9a6c-12107a5d74c5.png)

![test240 - child 2](https://user-images.githubusercontent.com/18611095/28618477-3e5b2100-720d-11e7-8f00-4f1005e14fab.png)

### [19. Test 241](https://www.w3.org/Voice/2013/scxml-irp/241/test241.txml)
Invoked services MUST treat values specified by param and namelist identically.

![test241](https://user-images.githubusercontent.com/18611095/28619005-355bb31a-720f-11e7-82a4-b3ecc18cdc88.png)

![test241 - child 1](https://user-images.githubusercontent.com/18611095/28619007-35787ce8-720f-11e7-8203-50af81594de8.png)

![test241 - child 2](https://user-images.githubusercontent.com/18611095/28619004-3559e10c-720f-11e7-83cb-afaa626ae749.png)

![test241 - child 3](https://user-images.githubusercontent.com/18611095/28619006-355d932e-720f-11e7-8b68-79519079fdc8.png)

### [20. Test 242](https://www.w3.org/Voice/2013/scxml-irp/242/test242.txml)
Invoked services MUST also treat values specified by 'src' and content identically.

![test242](https://user-images.githubusercontent.com/18611095/28619522-6e50cfaa-7211-11e7-8edb-5f0657b40e8d.png)

![test242sub1](https://user-images.githubusercontent.com/18611095/28619519-6e2bb594-7211-11e7-9754-da530db5f2b1.png)

![test242 - child 1](https://user-images.githubusercontent.com/18611095/28619523-6e553d24-7211-11e7-8229-fbe42aad6cfb.png)

![test242 - child 2](https://user-images.githubusercontent.com/18611095/28619521-6e5056f6-7211-11e7-902b-7639a53b3372.png)

### [21. Test 243](https://www.w3.org/Voice/2013/scxml-irp/243/test243.txml)
If the invoked process is of type http://www.w3.org/TR/scxml/ and 'name' of a param element in the invoke matches the 'id' of a data element in the top-level data declarations of the invoked session, the SCXML Processor MUST use the value of the param element as the initial value of the corresponding data element.

![test243](https://user-images.githubusercontent.com/18611095/28619686-409974c6-7212-11e7-9f6c-e124a55428ef.png)

![test243 - child](https://user-images.githubusercontent.com/18611095/28619687-4099a0b8-7212-11e7-956f-e34c08a876f1.png)

### [22. Test 244](https://www.w3.org/Voice/2013/scxml-irp/244/test244.txml)
If the invoked process is of type http://www.w3.org/TR/scxml/ and the key of namelist item in the invoke matches the 'id' of a data element in the top-level data declarations of the invoked session, the SCXML Processor MUST use the corresponding value as the initial value of the corresponding data element.

![test244](https://user-images.githubusercontent.com/18611095/28619840-120ec52e-7213-11e7-897b-738ca4ee7db4.png)

![test244 - child](https://user-images.githubusercontent.com/18611095/28619839-120e713c-7213-11e7-8f5e-19cc022cff21.png)

### [23. Test 245](https://www.w3.org/Voice/2013/scxml-irp/245/test245.txml)
If the invoked process is of type **http://www.w3.org/TR/scxml/**, and the name of a param element or the key of a namelist item do not match the name of a data element in the invoked process, the Processor MUST NOT add the value of the param element or namelist key/value pair to the invoked session's data model.

![test245](https://user-images.githubusercontent.com/18611095/28620098-307e01d6-7214-11e7-8483-279f2f825b1b.png)

![test245 - child](https://user-images.githubusercontent.com/18611095/28620099-307e7cc4-7214-11e7-8819-f3869064aac5.png)

### [24. Test 247](https://www.w3.org/Voice/2013/scxml-irp/247/test247.txml)
If the invoked state machine is of type **http://www.w3.org/TR/scxml/** and it reaches a top-level final state, the Processor MUST place the event **done.invoke.id** on the external event queue of the invoking machine, where id is the invokeid for this invocation.

![test247](https://user-images.githubusercontent.com/18611095/28620271-de1edb80-7214-11e7-9a08-418fae40e7f2.png)

![test247 - child](https://user-images.githubusercontent.com/18611095/28620270-de1e6506-7214-11e7-85b8-24e921a25c02.png)

### [25. Test 250](https://www.w3.org/Voice/2013/scxml-irp/250/test250.txml)
When an invoked process of type **http://www.w3.org/TR/scxml/** is cancelled by the invoking process, the Processor MUST execute the onexit handlers for all active states in the invoked session.

![test250](https://user-images.githubusercontent.com/18611095/28620482-c4561a46-7215-11e7-8e73-33b2c6a2dbd6.png)

![test250 - child](https://user-images.githubusercontent.com/18611095/28620481-c4554efe-7215-11e7-9c17-447267ccbe60.png)

**Output:**
```
External Event: foo, interpreter [Scxml_Test250]
[Log] "Exiting sub01"
[Log] "Exiting sub0"
```

### [26. Test 252](https://www.w3.org/Voice/2013/scxml-irp/252/test252.txml)
Once it cancels an invoked session, the Processor MUST NOT insert any events it receives from the invoked session into the external event queue of the invoking session.

![test252](https://user-images.githubusercontent.com/18611095/28620716-d7328068-7216-11e7-8ecf-5b48b5adfb8e.png)

![test252 - child](https://user-images.githubusercontent.com/18611095/28620717-d732a8ae-7216-11e7-96f9-bc5d5c47d538.png)

### [27. Test 253](https://www.w3.org/Voice/2013/scxml-irp/253/test253.txml)
When the invoked session is of type **http://www.w3.org/TR/scxml/**, The SCXML Processor MUST support the use of [SCXML Event/IO processor](https://www.w3.org/TR/scxml/#SCXMLEventProcessor) to communicate between the invoking and the invoked sessions.

![test253](https://user-images.githubusercontent.com/18611095/28621289-1f6ff322-7219-11e7-810a-a2efaba2eea4.png)

![test253 - child](https://user-images.githubusercontent.com/18611095/28621288-1f6f7e6a-7219-11e7-9dc5-1caaa4dcace8.png)

### [28. Test 530](https://www.w3.org/Voice/2013/scxml-irp/530/test530.txml)
The SCXML Processor MUST evaluate a child content element when the parent invoke element is evaluated and pass the resulting data to the invoked service.

![test530](https://user-images.githubusercontent.com/18611095/28621709-818fd1ac-721a-11e7-9f05-af3d42b0b614.png)

![test530 - child](https://user-images.githubusercontent.com/18611095/28621710-81917020-721a-11e7-8470-749f22bbe71c.png)

### [29. Test 554](https://www.w3.org/Voice/2013/scxml-irp/554/test554.txml)
If the evaluation of the invoke element's arguments produces an error, the SCXML Processor MUST terminate the processing of the element without further action.

![test554](https://user-images.githubusercontent.com/18611095/28621921-3ad5b03c-721b-11e7-8a42-72ed8eb955b3.png)

![test554 - child](https://user-images.githubusercontent.com/18611095/28621920-3ad40b38-721b-11e7-8684-3b8ba36c884c.png)
