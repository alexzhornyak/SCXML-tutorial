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
![assign - location expr](https://user-images.githubusercontent.com/18611095/28417848-4934c91e-6d62-11e7-9225-63e33609e087.png)

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
![assign - location to table](https://user-images.githubusercontent.com/18611095/28418385-2adfba8a-6d64-11e7-9c6d-f57765c1a46a.png)

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

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### [1. Test 286](https://www.w3.org/Voice/2013/scxml-irp/286/test286.txml)
If the location expression of an assign does not denote a valid location in the datamodel the processor MUST place the error **error.execution** in the internal event queue.

![test286](https://user-images.githubusercontent.com/18611095/28419058-9a6dcf70-6d66-11e7-8cc1-01e7babaab85.png)

### [2. Test 287](https://www.w3.org/Voice/2013/scxml-irp/287/test287.txml)
If the location expression of an assign denotes a valid location in the datamodel and if the value specified by 'expr' is a legal value for the location specified, the processor MUST place the specified value at the specified location.

![test287](https://user-images.githubusercontent.com/18611095/28419375-71e90212-6d67-11e7-9ed1-c70b94948af7.png)

### [3. Test 487](https://www.w3.org/Voice/2013/scxml-irp/487/test487.txml)
If the value specified (by 'expr' or children) is not a legal value for the location specified, the processor MUST place the error **error.execution** in the internal event queue.

![test487](https://user-images.githubusercontent.com/18611095/28419614-39236b7e-6d68-11e7-9303-bf2aaf0dd5e9.png)

| [TOP](#top-anchor) | [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|---|
