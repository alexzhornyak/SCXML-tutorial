# \<param\>
The \<param\> tag provides a general way of identifying a key and a dynamically calculated value which can be passed to an external service or included in an event.

## Attribute Details
Name	|Required	|Attribute Constraints	|Type	|Default Value	|Valid Values	|Description
---|---|---|---|---|---|---|
name	|true		||NMTOKEN	|none	|A string literal	|The name of the key.
expr	|false	|May not occur with 'location'	|value expression	|none	|Valid value expression	|A value expression (see [5.9.3 Legal Data Values and Value Expressions](https://www.w3.org/TR/scxml/#ValueExpressions)) that is evaluated to provide the value.
location	|false	|May not occur with 'expr'	|location expression	|none	|Valid location expression	|A location expression (see [5.9.2 Location Expressions](https://www.w3.org/TR/scxml/#LocationExpressions)) that specifies the location in the datamodel to retrieve the value from.

## Examples:
### 1. Value is provided by 'expr' attribute.
![param - expr](https://user-images.githubusercontent.com/18611095/28515986-4b5121da-7068-11e7-84b9-80f4f8de9ab1.png)

```
<scxml datamodel="lua" initial="s0" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="s0" initial="s01">
		<transition cond="_event.data.someParam==1" event="done.state.s0" target="End"/>
		<state id="s01">
			<transition target="s02"/>
		</state>
		<final id="s02">
			<donedata>
				<param expr="1" name="someParam"/>
			</donedata>
		</final>
	</state>
	<final id="End">
		<onentry>
			<log expr="'Pass'" label="Outcome"/>
		</onentry>
	</final>
</scxml>
```

### 2. Value is provided by 'location' attribute.
![param - location](https://user-images.githubusercontent.com/18611095/28516123-c39f7038-7068-11e7-8c2c-083e82e31f4c.png)

```
<scxml datamodel="lua" initial="s0" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<datamodel>
		<data expr="1" id="VarA"/>
	</datamodel>
	<state id="s0" initial="s01">
		<transition cond="_event.data.someParam==1 and
_event.data.someParam==VarA" event="done.state.s0" target="End"/>
		<state id="s01">
			<transition target="s02"/>
		</state>
		<final id="s02">
			<donedata>
				<param location="VarA" name="someParam"/>
			</donedata>
		</final>
	</state>
	<final id="End">
		<onentry>
			<log expr="'Pass'" label="Outcome"/>
		</onentry>
	</final>
</scxml>
```

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
