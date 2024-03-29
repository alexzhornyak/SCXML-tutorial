<a name="top-anchor"/>

| [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|

# [\<assign\>](https://www.w3.org/TR/scxml/#assign)

**[Video version](https://youtu.be/5_GQeRFCe8M)**

The element is used to modify the data model.

**Example:**
```xml
<assign location="Var1" expr="5"/>
```

## Attribute Details
<table class="table table-striped table-bordered">
<thead>
<tr>
<th>Name</th><th>Required</th><th>Attribute Constraints</th><th>Type</th><th>Default Value</th><th>Valid Values</th><th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>location</td><td>true</td><td></td><td>path expression</td><td>none</td><td>Any valid location expression.</td><td>The location in the data model into which to insert the new value. See <a href="https://www.w3.org/TR/scxml/#LocationExpressions">5.9.2 Location Expressions</a> for details.</td>
</tr>
<tr>
<td>expr</td><td>false</td><td>This attribute must not occur in an &lt;assign&gt; element that has children.</td><td>value expression</td><td>none</td><td>Any valid value expression An expression returning the value to be assigned. See <a href="https://www.w3.org/TR/scxml/#ValueExpressions">5.9.3 Legal Data Values and Value Expressions</a> for details.</td><td></td>
</tr>
</tbody>
</table>

## Children
The children of the \<assign\> element provide an in-line specification of the legal data value (see [5.9.3 Legal Data Values and Value Expressions](https://www.w3.org/TR/scxml/#ValueExpressions)) to be inserted into the data model at the specified location.

## Examples:

### 1. Assigning data by value from 'expr' attribute.
![assign - location expr](../Images/assign_data_expr.png)

```xml
<scxml datamodel="lua" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<datamodel>
		<data expr="0" id="Var1"/>
	</datamodel>
	<state id="Shape1">
		<onentry>
			<log expr="Var1" label="Var1"/>
			<assign expr="5" location="Var1"/>
			<log expr="Var1" label="Var1"/>
			<assign expr="Var1 + 10" location="Var1"/>
			<log expr="Var1" label="Var1"/>
			<assign expr="Var1 * 10" location="Var1"/>
			<log expr="Var1" label="Var1"/>
		</onentry>
		<transition target="End"/>
	</state>
	<final id="End"/>
</scxml>
```

**Output:**
>\[Log\] Var1: 0
>
>\[Log\] Var1: 5
>
>\[Log\] Var1: 15
>
>\[Log\] Var1: 150

### 2. Multi-level location and assigning data by children element value.
![assign - location to table](../Images/assign_location_table.png)

```xml
<scxml datamodel="lua" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<datamodel>
		<data expr="{ Name=&quot;default&quot; }" id="VarTable"/>
	</datamodel>
	<state id="Shape1">
		<onentry>
			<log expr="VarTable.Name" label="VarTable.Name"/>
			<assign location="VarTable.Name">&quot;new name&quot;</assign>
			<log expr="VarTable.Name" label="VarTable.Name"/>
		</onentry>
		<transition target="End"/>
	</state>
	<final id="End"/>
</scxml>
```

**Output:**
>\[Log\] VarTable.Name: "default"
>
>\[Log\] VarTable.Name: "new name"

### 2.1 Assign data to EcmaScript array element
![Foreach_Example](../Images/Foreach_Example.gif)
<details><summary><b>Source code</b></summary>
<p>
  
```xml
<scxml datamodel="ecmascript" name="ScxmlForeach" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<datamodel>
		<data expr="[ 0, 0, 0 ]" id="t_INPUTS"/>
	</datamodel>
	<parallel id="p">
		<state id="state_3">
			<state id="state_3_off">
				<transition cond="_event.data==1" event="event.2" target="state_3_on"/>
			</state>
			<state id="state_3_on">
				<transition cond="! (_event.data==1)" event="event.2" target="state_3_off"/>
			</state>
		</state>
		<state id="state_2">
			<state id="state_2_off">
				<transition cond="_event.data==1" event="event.1" target="state_2_on"/>
			</state>
			<state id="state_2_on">
				<transition cond="! (_event.data==1)" event="event.1" target="state_2_off"/>
			</state>
		</state>
		<state id="state_1">
			<state id="state_1_off">
				<transition cond="_event.data==1" event="event.0" target="state_1_on"/>
			</state>
			<state id="state_1_on">
				<transition cond="! (_event.data==1)" event="event.0" target="state_1_off"/>
			</state>
		</state>
		<state id="inputs">
			<state id="configuration">
				<onentry>
					<foreach array="t_INPUTS" index="varIndex" item="varItem">
						<send eventexpr="'event.' + varIndex">
							<content expr="varItem"/>
						</send>
					</foreach>
				</onentry>
				<transition event="change.inputs" target="configuration">
					<assign expr="_event.data.x" location="t_INPUTS[0]"/>
					<assign expr="_event.data.y" location="t_INPUTS[1]"/>
					<assign expr="_event.data.z" location="t_INPUTS[2]"/>
				</transition>
			</state>
		</state>
	</parallel>
</scxml>
```

</p></details>

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### [1. Test 286](https://www.w3.org/Voice/2013/scxml-irp/286/test286.txml)
If the location expression of an assign does not denote a valid location in the datamodel the processor MUST place the error **error.execution** in the internal event queue.

![test286](../Images/W3C/test286.gif)

### [2. Test 287](https://www.w3.org/Voice/2013/scxml-irp/287/test287.txml)
If the location expression of an assign denotes a valid location in the datamodel and if the value specified by 'expr' is a legal value for the location specified, the processor MUST place the specified value at the specified location.

![test287](../Images/W3C/test287.gif)

### [3. Test 487](https://www.w3.org/Voice/2013/scxml-irp/487/test487.txml)
If the value specified (by 'expr' or children) is not a legal value for the location specified, the processor MUST place the error **error.execution** in the internal event queue.

![test487](../Images/W3C/test487.gif)

| [TOP](#top-anchor) | [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|---|
