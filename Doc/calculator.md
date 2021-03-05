<a name="top-anchor"/>

| [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|

# [Calculator example](https://www.w3.org/TR/scxml/#N11630)
The example below shows the implementation of a simple calculator in SCXML.

![calculator](https://user-images.githubusercontent.com/18611095/46285473-4774ec00-c584-11e8-9c0a-003b5998fd2e.png)

```xml
<scxml datamodel="ecmascript" initial="wrapper" name="CalculatorStateMachine" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<datamodel>
		<data id="long_expr"/>
		<data id="short_expr"/>
		<data id="res"/>
	</datamodel>
	<state id="wrapper" initial="on">
		<transition event="CALC.DO" type="internal">
			<assign location="short_expr" expr="''+ res"/>
			<assign location="long_expr" expr="''"/>
			<assign location="res" expr="0"/>
		</transition>
		<transition event="CALC.SUB" type="internal">
			<if cond="short_expr!=''">
				<assign location="long_expr" expr="long_expr+'('+short_expr+')'"/>
			</if>
			<assign location="res" expr="eval(long_expr)"/>
			<assign location="short_expr" expr="''"/>
			<send event="DISPLAY.UPDATE"/>
		</transition>
		<transition event="DISPLAY.UPDATE" type="internal">
			<log label="'result'" expr="short_expr==''?res:short_expr"/>
			<send event="updateDisplay">
				<param name="display" expr="short_expr==''?res:short_expr"/>
			</send>
		</transition>
		<transition event="OP.INSERT" type="internal">
			<log expr="_event.data.operator"/>
			<if cond="_event.data.operator == 'OPER.PLUS'">
				<assign location="long_expr" expr="long_expr+'+'"/>
				<elseif cond="_event.data.operator=='OPER.MINUS'"/>
				<assign location="long_expr" expr="long_expr+'-'"/>
				<elseif cond="_event.data.operator=='OPER.STAR'"/>
				<assign location="long_expr" expr="long_expr+'*'"/>
				<elseif cond="_event.data.operator=='OPER.DIV'"/>
				<assign location="long_expr" expr="long_expr+'/'"/>
			</if>
		</transition>
		<state id="on" initial="ready">
			<onentry>
				<send event="DISPLAY.UPDATE"/>
			</onentry>
			<transition event="C" target="on" type="internal"/>
			<state id="operand1">
				<transition event="OPER" target="opEntered"/>
				<state id="int1">
					<onentry>
						<assign expr="short_expr+_event.name.substr(_event.name.lastIndexOf('.')+1)" location="short_expr"/>
						<send event="DISPLAY.UPDATE"/>
					</onentry>
					<transition event="POINT" target="frac1"/>
					<transition event="DIGIT" type="internal">
						<assign location="short_expr" expr="short_expr+_event.name.substr(_event.name.lastIndexOf('.')+1)"/>
						<send event="DISPLAY.UPDATE"/>
					</transition>
				</state>
				<state id="frac1">
					<onentry>
						<assign expr="short_expr+'.'" location="short_expr"/>
						<send event="DISPLAY.UPDATE"/>
					</onentry>
					<transition event="DIGIT" type="internal">
						<assign location="short_expr" expr="short_expr+_event.name.substr(_event.name.lastIndexOf('.')+1)"/>
						<send event="DISPLAY.UPDATE"/>
					</transition>
				</state>
				<state id="zero1">
					<transition cond="_event.name != 'DIGIT.0'" event="DIGIT" target="int1"/>
					<transition event="POINT" target="frac1"/>
				</state>
			</state>
			<state id="ready" initial="begin">
				<transition event="OPER" target="opEntered"/>
				<transition event="DIGIT.0" target="zero1">
					<assign location="short_expr" expr="''"/>
				</transition>
				<transition event="DIGIT" target="int1">
					<assign location="short_expr" expr="''"/>
				</transition>
				<transition event="POINT" target="frac1">
					<assign location="short_expr" expr="''"/>
				</transition>
				<state id="begin">
					<onentry>
						<assign expr="''" location="long_expr"/>
						<assign expr="0" location="short_expr"/>
						<assign expr="0" location="res"/>
						<send event="DISPLAY.UPDATE"/>
					</onentry>
					<transition event="OPER.MINUS" target="negated1"/>
				</state>
				<state id="result"/>
			</state>
			<state id="negated1">
				<onentry>
					<assign expr="'-'" location="short_expr"/>
					<send event="DISPLAY.UPDATE"/>
				</onentry>
				<transition event="DIGIT.0" target="zero1"/>
				<transition event="DIGIT" target="int1"/>
				<transition event="POINT" target="frac1"/>
			</state>
			<state id="operand2">
				<transition event="OPER" target="opEntered">
					<raise event="CALC.SUB"/>
					<raise event="OP.INSERT"/>
				</transition>
				<transition event="EQUALS" target="result">
					<raise event="CALC.SUB"/>
					<raise event="CALC.DO"/>
				</transition>
				<state id="int2">
					<onentry>
						<assign expr="short_expr+_event.name.substr(_event.name.lastIndexOf('.')+1)" location="short_expr"/>
						<send event="DISPLAY.UPDATE"/>
					</onentry>
					<transition event="DIGIT" type="internal">
						<assign location="short_expr" expr="short_expr+_event.name.substr(_event.name.lastIndexOf('.')+1)"/>
						<send event="DISPLAY.UPDATE"/>
					</transition>
					<transition event="POINT" target="frac2"/>
				</state>
				<state id="frac2">
					<onentry>
						<assign expr="short_expr +'.'" location="short_expr"/>
						<send event="DISPLAY.UPDATE"/>
					</onentry>
					<transition event="DIGIT" type="internal">
						<assign location="short_expr" expr="short_expr +_event.name.substr(_event.name.lastIndexOf('.')+1)"/>
						<send event="DISPLAY.UPDATE"/>
					</transition>
				</state>
				<state id="zero2">
					<transition cond="_event.name != 'DIGIT.0'" event="DIGIT" target="int2"/>
					<transition event="POINT" target="frac2"/>
				</state>
			</state>
			<state id="opEntered">
				<onentry>
					<raise event="CALC.SUB"/>
					<send event="OP.INSERT" target="#_internal">
						<param expr="_event.name" name="operator"/>
					</send>
				</onentry>
				<transition event="OPER.MINUS" target="negated2"/>
				<transition event="POINT" target="frac2"/>
				<transition event="DIGIT.0" target="zero2"/>
				<transition event="DIGIT" target="int2"/>
			</state>
			<state id="negated2">
				<onentry>
					<assign expr="'-'" location="short_expr"/>
					<send event="DISPLAY.UPDATE"/>
				</onentry>
				<transition event="DIGIT.0" target="zero2"/>
				<transition event="DIGIT" target="int2"/>
				<transition event="POINT" target="frac2"/>
			</state>
		</state>
	</state>
</scxml>
```

| [TOP](#top-anchor) | [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|---|
