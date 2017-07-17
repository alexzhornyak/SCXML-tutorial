# \<datamodel\>
Wrapper element which encapsulates any number of \<data\> elements, each of which defines a single data object. The exact nature of the data object depends on the data model language used.

# \<data\>
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
