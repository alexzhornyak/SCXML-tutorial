# \<param\>
The \<param\> tag provides a general way of identifying a key and a dynamically calculated value which can be passed to an external service or included in an event.

## Attribute Details
Name	|Required	|Attribute Constraints	|Type	|Default Value	|Valid Values	|Description
---|---|---|---|---|---|---|
name	|true		||NMTOKEN	|none	|A string literal	|The name of the key.
expr	|false	|May not occur with 'location'	|value expression	|none	|Valid value expression	|A value expression (see 5.9.3 Legal Data Values and Value Expressions) that is evaluated to provide the value.
location	|false	|May not occur with 'expr'	|location expression	|none	|Valid location expression	|A location expression (see 5.9.2 Location Expressions) that specifies the location in the datamodel to retrieve the value from.

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### [1. Test 298](https://www.w3.org/Voice/2013/scxml-irp/298/test298.txml)
If the **'location'** attribute on a param element does not refer to a valid location in the data model, the processor MUST place the error **error.execution** on the internal event queue.

![test298](https://user-images.githubusercontent.com/18611095/28515277-acc356fc-7065-11e7-91ec-666e36fe931a.png)

### [2. Test 343](https://www.w3.org/Voice/2013/scxml-irp/343/test343.txml)
If the **'location'** attribute on a param element does not refer to a valid location in the data model, or if the evaluation of the **'expr'** produces an error, the processor MUST ignore the name and value.

![test343](https://user-images.githubusercontent.com/18611095/28515473-6ff1de6e-7066-11e7-9875-d2e8b5d4ee1e.png)

### [3. Test 488](https://www.w3.org/Voice/2013/scxml-irp/488/test488.txml)
If the evaluation of the **'expr'** produces an error, the processor MUST place the error **error.execution** on the internal event queue.

![test488](https://user-images.githubusercontent.com/18611095/28515717-4eca4a04-7067-11e7-9eae-d66e5e4ee2d6.png)
