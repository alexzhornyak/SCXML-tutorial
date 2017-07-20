# \<assign\>
The element is used to modify the data model.

## Attribute Details
Name	|Required	|Attribute Constraints	|Type	|Default Value	|Valid Values	|Description
---|---|---|---|---|---|---|
location	|true		||path expression	|none	|Any valid location expression.	|The location in the data model into which to insert the new value. See [5.9.2 Location Expressions](https://www.w3.org/TR/scxml/#LocationExpressions) for details.
expr	|false	|This attribute must not occur in an \<assign\> element that has children.	|value expression	|none	|Any valid value expression	An expression returning the value to be assigned. See [5.9.3 Legal Data Values and Value Expressions](https://www.w3.org/TR/scxml/#ValueExpressions) for details.

## Children
The children of the \<assign\> element provide an in-line specification of the legal data value (see [5.9.3 Legal Data Values and Value Expressions](https://www.w3.org/TR/scxml/#ValueExpressions)) to be inserted into the data model at the specified location.

## Examples:

### 1. Assigning data by value from 'expr' attribute.
![assign - location expr](https://user-images.githubusercontent.com/18611095/28417848-4934c91e-6d62-11e7-9225-63e33609e087.png)

```
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
>[Log] Var1: 0
>
>[Log] Var1: 5
>
>[Log] Var1: 15
>
>[Log] Var1: 150

### 2. Multi-level location and assigning data by children element value.
![assign - location to table](https://user-images.githubusercontent.com/18611095/28418385-2adfba8a-6d64-11e7-9c6d-f57765c1a46a.png)

```
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
>[Log] VarTable.Name: "default"
>
>[Log] VarTable.Name: "new name"
