# \<foreach\>
Allows an SCXML application to iterate through a collection in the data model and to execute the actions contained within it for each item in the collection.

Name	|Required	|Type	|Default Value	|Valid Values	|Description|
---|---|---|---|---|---|
array	|true		|Value expression	|none	|A value expression that evaluates to an iterable collection.	|The \<foreach\> element will iterate over a shallow copy of this collection.
item	|true		|xsd:string	|none	|Any variable name that is valid in the specified data model.	|A variable that stores a different item of the collection in each iteration of the loop.
index	|false		|xsd:string	|none	|Any variable name that is valid in the specified data model.	|A variable that stores the current iteration index upon each iteration of the foreach loop.

![foreach](https://user-images.githubusercontent.com/18611095/28258527-57452600-6ada-11e7-9102-8260dbaecb19.png)

```
<scxml datamodel="lua" initial="Shape1" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<datamodel>
		<data id="VarCollection">{ [1]='a', [2]='b', [3]='c' }</data>
	</datamodel>
	<state id="Shape1">
		<onentry>
			<foreach array="VarCollection" index="indexCollection" item="itemCollection">
				<log expr="indexCollection" label="indexCollection"/>
				<log expr="itemCollection" label="itemCollection"/>
			</foreach>
		</onentry>
		<transition target="End"/>
	</state>
	<final id="End"/>
</scxml>
```

**Output:**
>[Log] itemCollection: "a"
>
>[Log] indexCollection: 1
>
>[Log] itemCollection: "b"
>
>[Log] indexCollection: 2
>
>[Log] itemCollection: "c"
>
>[Log] indexCollection: 3
