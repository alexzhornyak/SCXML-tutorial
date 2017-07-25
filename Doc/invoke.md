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
