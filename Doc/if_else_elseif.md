# [\<if\>](https://www.w3.org/TR/scxml/#if)
Container for conditionally executed elements. 

Execution is defined by attribute 'cond', which is the boolean conditional expression.

# [\<else\>](https://www.w3.org/TR/scxml/#else)
Empty element that partitions the content of an \<if\>. It is equivalent to an \<elseif\> with a "cond" that always evaluates to true.

# [\<elseif\>](https://www.w3.org/TR/scxml/#elseif)
Empty element that partitions the content of an \<if\>, and provides a condition that determines whether the partition is executed.

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### [1. Test 147](https://www.w3.org/Voice/2013/scxml-irp/147/test147.txml)
When the if element is executed, the SCXML processor MUST execute the first partition in document order that is defined by a tag whose 'cond' attribute evaluates to true, if there is one.

![test147](https://user-images.githubusercontent.com/18611095/28814051-a96107f8-76a4-11e7-8a1e-9783bf0ce0de.png)

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

### [2. Test 148](https://www.w3.org/Voice/2013/scxml-irp/148/test148.txml)
When the if element is executed, if no 'cond'attribute evaluates to true, the SCXML Processor must execute the partition defined by the else tag, if there is one.

![test148](https://user-images.githubusercontent.com/18611095/28814245-7c05a9de-76a5-11e7-90b5-bc122578d286.png)

### [3. Test 149](https://www.w3.org/Voice/2013/scxml-irp/149/test149.txml)
When it executes an if element, if no 'cond' attribute evaluates to true and there is no else element, the SCXML processor must not evaluate any executable content within the element.

![test149](https://user-images.githubusercontent.com/18611095/28814451-5228639e-76a6-11e7-842f-973187a32c8c.png)
