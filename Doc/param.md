<a name="top-anchor"/>

| [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|

# [\<param\>](https://www.w3.org/TR/scxml/#param)

**[Video version](https://youtu.be/V9hqU9smirw)**

The \<param\> tag provides a general way of identifying a key and a dynamically calculated value which can be passed to an external service or included in an event.

## Attribute Details
<table>
<thead>
<tr>
<th>Name</th><th>Required</th><th>Attribute Constraints</th><th>Type</th><th>Default Value</th><th>Valid Values</th><th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>name</td><td>true</td><td></td><td>NMTOKEN</td><td>none</td><td>A string literal</td><td>The name of the key.</td>
</tr>
<tr>
<td>expr</td><td>false</td><td>May not occur with ‘location’</td><td>value expression</td><td>none</td><td>Valid value expression</td><td>A value expression (see <a href="https://www.w3.org/TR/scxml/#ValueExpressions">5.9.3 Legal Data Values and Value Expressions</a>) that is evaluated to provide the value.</td>
</tr>
<tr>
<td>location</td><td>false</td><td>May not occur with ‘expr’</td><td>location expression</td><td>none</td><td>Valid location expression</td><td>A location expression (see <a href="https://www.w3.org/TR/scxml/#LocationExpressions">5.9.2 Location Expressions</a>) that specifies the location in the datamodel to retrieve the value from.</td>
</tr>
</tbody>
</table>

## Examples:
### 1. Value is provided by 'expr' attribute.
![param - expr](https://user-images.githubusercontent.com/18611095/28515986-4b5121da-7068-11e7-84b9-80f4f8de9ab1.png)

```xml
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

```xml
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

| [TOP](#top-anchor) | [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|---|
