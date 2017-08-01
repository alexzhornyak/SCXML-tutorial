# [\<datamodel\>](https://www.w3.org/TR/scxml/#datamodel)
Wrapper element which encapsulates any number of \<data\> elements, each of which defines a single data object. The exact nature of the data object depends on the data model language used.

# [\<data\>](https://www.w3.org/TR/scxml/#data)
The element is used to declare and populate portions of the data model.

## Attribute Details
Name	|Required	|Type	|Default Value	|Valid Values	|Description
---|---|---|---|---|---|
id	|true		|ID	|none		||The name of the data item. See [3.14 IDs](https://www.w3.org/TR/scxml/#IDs) for details.
src	|false		|URI	|none		||Gives the location from which the data object should be fetched. See [5.9.3 Legal Data Values and Value Expressions](https://www.w3.org/TR/scxml/#ValueExpressions) for details.
expr	|false		|Expression	|none	|Any valid value expression	|Evaluates to provide the value of the data item. See [5.9.3 Legal Data Values and Value Expressions](https://www.w3.org/TR/scxml/#ValueExpressions) for details.

## Children
The children of the \<data\> element represent an in-line specification of the value of the data object.
In a conformant SCXML document, a \<data\> element may have either a 'src' or an 'expr' attribute, but must not have both. Furthermore, if either attribute is present, the element must not have any children. Thus 'src', 'expr' and children are mutually exclusive in the \<data\> element.

## Examples:
### 1. Different data types assigned by 'expr' attribute.
![datamodel](https://user-images.githubusercontent.com/18611095/28266363-137761c2-6afd-11e7-86bf-5ca42956d980.png)

```
<scxml datamodel="lua" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<datamodel>
		<data expr="true" id="VarBool"/>
		<data expr="1" id="VarInt"/>
		<data expr="&quot;This is a string!&quot;" id="VarString"/>
		<data expr="{ 1, 2, 3, 4, 5 }" id="VarTable"/>
	</datamodel>
	<state id="Shape1">
		<onentry>
			<log expr="string.format(&quot;Value=[%s] Type=[%s]&quot;,tostring(VarBool),type(VarBool))" label="VarBool"/>
			<log expr="string.format(&quot;Value=[%s] Type=[%s]&quot;,tostring(VarInt),type(VarInt))" label="VarInt"/>
			<log expr="string.format(&quot;Value=[%s] Type=[%s]&quot;,VarString,type(VarString))" label="VarString"/>
			<log expr="string.format(&quot;Value=[%s] Type=[%s]&quot;,tostring(VarTable),type(VarTable))" label="VarTable"/>
		</onentry>
		<transition target="End"/>
	</state>
	<final id="End"/>
</scxml>
```

**Output:**
> [Log] VarBool: "Value=[true] Type=[boolean]"
> 
> [Log] VarInt: "Value=[1] Type=[number]"
> 
> [Log] VarString: "Value=[This is a string!] Type=[string]"
> 
> [Log] VarTable: "Value=[table: 003E7790] Type=[table]"

### 2. Data initialized by 'src' attribute.
![datamodel - data src](https://user-images.githubusercontent.com/18611095/28266265-8f3eb734-6afc-11e7-8b37-d1830ff13b49.png)
#### table1.lua
```
{ 
	1, 
	2, 
	3, 
	true, 
	"This a string!" 
}
```
#### datamodel - data src.scxml
```
<scxml datamodel="lua" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<datamodel>
		<data id="VarTable" src="table1.lua"/>
	</datamodel>
	<state id="Shape1">
		<onentry>
			<log expr="string.format(&quot;Value=[%s] Type=[%s]&quot;,tostring(VarTable),type(VarTable))" label="VarTable"/>
			<foreach array="VarTable" index="indexTable" item="itemTable">
				<log expr="indexTable" label="indexTable"/>
				<log expr="itemTable" label="itemTable"/>
			</foreach>
		</onentry>
		<transition target="End"/>
	</state>
	<final id="End"/>
</scxml>
```

**Output:**
>[Log] VarTable: "Value=[table: 0096B388] Type=[table]"
>
>[Log] indexTable: 1
>
>[Log] itemTable: 1
>
>[Log] indexTable: 2
>
>[Log] itemTable: 2
>
>[Log] indexTable: 3
>
>[Log] itemTable: 3
>
>[Log] indexTable: 4
>
>[Log] itemTable: true
>
>[Log] indexTable: 5
>
>[Log] itemTable: "This a string!"

### 3. Data initialized by child value.
![datamodel - data child value](https://user-images.githubusercontent.com/18611095/28266540-15a39032-6afe-11e7-846e-ff2824c2417b.png)

```
<scxml datamodel="lua" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<datamodel>
		<data id="VarTable">{ 1, true, &quot;This is a string!&quot; }</data>
	</datamodel>
	<state id="Shape1">
		<onentry>
			<log expr="string.format(&quot;Value=[%s] Type=[%s]&quot;,tostring(VarTable),type(VarTable))" label="VarTable"/>
			<foreach array="VarTable" index="indexTable" item="itemTable">
				<log expr="itemTable" label="itemTable"/>
			</foreach>
		</onentry>
		<transition target="End"/>
	</state>
	<final id="End"/>
</scxml>
```

**Output:**
>[Log] VarTable: "Value=[table: 0083F5E8] Type=[table]"
>
>[Log] itemTable: 1
>
>[Log] itemTable: true
>
>[Log] itemTable: "This is a string!"

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### [1. Test 276](https://www.w3.org/Voice/2013/scxml-irp/276/test276.txml)
The SCXML Processor MUST allow the environment to provide values for top-level data elements at instantiation time. (Top-level data elements are those that are children of the datamodel element that is a child of scxml). Specifically, the Processor MUST use the values provided at instantiation time instead of those contained in these data elements.

![test276](https://user-images.githubusercontent.com/18611095/28817008-8e09fae0-76af-11e7-8a9b-00c1c7aa70a1.png)

![test276sub1](https://user-images.githubusercontent.com/18611095/28817007-8e0193c8-76af-11e7-82f1-9527a2fb1e57.png)

### [2. Test 277](https://www.w3.org/Voice/2013/scxml-irp/277/test277.txml)
If the value specified for a data element (by 'src', children, or the environment) is not a legal data value, the SCXML Processor MUST raise place **error.execution** in the internal event queue and MUST create an empty data element in the data model with the specified id.

![test277](https://user-images.githubusercontent.com/18611095/28817301-70d8accc-76b0-11e7-961d-641c81821b84.png)

### [3. Test 279](https://www.w3.org/Voice/2013/scxml-irp/279/test279.txml)
When 'binding' attribute on the scxml element is assigned the value "early" (the default), the SCXML Processor MUST create all data elements and assign their initial values at document initialization time.

![test279](https://user-images.githubusercontent.com/18611095/28817456-f25c6bbc-76b0-11e7-9d07-ff6300feaf65.png)

### [4. Test 280](https://www.w3.org/Voice/2013/scxml-irp/280/test280.txml)
When 'binding' attribute on the scxml element is assigned the value "late", the SCXML Processor MUST create the data elements at document initialization time, but MUST assign the specified initial value to a given data element only when the state that contains it is entered for the first time, before any onentry markup.

![test280](https://user-images.githubusercontent.com/18611095/28817638-8c3ae83a-76b1-11e7-97b0-cb06b7276a99.png)

### [5. Test 550](https://www.w3.org/Voice/2013/scxml-irp/550/test550.txml)
If the 'expr' attribute is present, the Platform MUST evaluate the corresponding expression at the time specified by the 'binding' attribute of scxml and MUST assign the resulting value as the value of the data element.

![test550](https://user-images.githubusercontent.com/18611095/28817796-fd176b6e-76b1-11e7-9f7f-0d5a066a50b3.png)

### [6. Test 551](https://www.w3.org/Voice/2013/scxml-irp/551/test551.txml)
If child content is specified, the Platform MUST assign it as the value of the data element at the time specified by the 'binding' attribute of scxml.

![test551](https://user-images.githubusercontent.com/18611095/28819233-38d9b34c-76b6-11e7-8902-9fd89b4c7ffa.png)

### [7. Test 552](https://www.w3.org/Voice/2013/scxml-irp/552/test552.txml)
If the 'src' attribute is present, the Platform MUST fetch the specified object at the time specified by the 'binding' attribute of scxml and MUST assign it as the value of the data element.

![test552](https://user-images.githubusercontent.com/18611095/28819667-a37e78e4-76b7-11e7-98d2-739a613349d7.png)

**test552.txt**

`1`
