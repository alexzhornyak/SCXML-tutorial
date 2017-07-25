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

