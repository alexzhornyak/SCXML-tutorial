# \<if\>
Container for conditionally executed elements. 

Execution is defined by attribute 'cond', which is the boolean conditional expression.

# \<else\>
Empty element that partitions the content of an \<if\>. It is equivalent to an \<elseif\> with a "cond" that always evaluates to true.

# \<elseif\>
Empty element that partitions the content of an \<if\>, and provides a condition that determines whether the partition is executed.

## Examples:

![if](https://user-images.githubusercontent.com/18611095/28257177-64d20828-6ad1-11e7-8e89-4a40ac50ad29.png)

```
<scxml datamodel="lua" initial="s0" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<datamodel>
		<data expr="0" id="Var1"/>
	</datamodel>
	<state id="s0">
		<onentry>
			<if cond="false">
				<raise event="foo"/>
				<assign expr="Var1 + 1" location="Var1"/>
				<elseif cond="true"/>
				<raise event="bar"/>
				<assign expr="Var1 + 1" location="Var1"/>
				<else/>
				<raise event="baz"/>
				<assign expr="Var1 + 1" location="Var1"/>
			</if>
			<raise event="bat"/>
		</onentry>
		<transition cond="Var1==1" event="bar" target="pass"/>
		<transition event="*" target="fail"/>
	</state>
	<final id="pass">
		<onentry>
			<log expr="'pass'" label="Outcome"/>
		</onentry>
	</final>
	<final id="fail">
		<onentry>
			<log expr="'fail'" label="Outcome"/>
		</onentry>
	</final>
</scxml>
```
