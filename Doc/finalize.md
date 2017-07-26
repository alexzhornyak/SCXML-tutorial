# [\<finalize\>](https://www.w3.org/TR/scxml/#finalize)
The element enables an invoking session to update its data model with data contained in events returned by the invoked session. \<finalize\> contains executable content that is executed whenever the external service returns an event after the \<invoke\> has been executed. This content is applied before the system looks for transitions that match the event. Within the executable content, the system variable '_event' can be used to refer to the data contained in the event which is being processed. In the case of parallel states, only the finalize code in the original invoking state is executed.

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### [1. Test 233](https://www.w3.org/Voice/2013/scxml-irp/233/test233.txml)
If there is a finalize handler in the instance of invoke that created the service that generated the event, the SCXML Processor MUST execute the code in that finalize handler right before it removes the event from the event queue for processing.

![test233](https://user-images.githubusercontent.com/18611095/28613137-249c9806-71fa-11e7-8f70-c6788e704253.png)

![test233 - child](https://user-images.githubusercontent.com/18611095/28613136-249b354c-71fa-11e7-95f7-29181ac699b6.png)

### [2. Test 234](https://www.w3.org/Voice/2013/scxml-irp/234/test234.txml)
It MUST NOT execute the finalize handler in any other instance of invoke besides the one in the instance of invoke that created the service that generated the event.
  
![test234](https://user-images.githubusercontent.com/18611095/28613739-e94d6b70-71fb-11e7-921d-52fec13157ec.png)
  
![test234 - child 1](https://user-images.githubusercontent.com/18611095/28613738-e94b73c4-71fb-11e7-8363-76d5dbd7adb3.png)

![test234 - child 2](https://user-images.githubusercontent.com/18611095/28613740-e9505a4c-71fb-11e7-9062-324039466305.png)
