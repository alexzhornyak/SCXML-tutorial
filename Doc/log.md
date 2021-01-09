<a name="top-anchor">

| [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../README.md#examples) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
| --- | --- | --- | --- |

# [\<log\>](https://www.w3.org/TR/scxml/#log)

**[Video version](https://youtu.be/tbFZsiTfOKA)**

Allows an application to generate a logging or debug message.

**Here is an example:**
```xml
<log label="DEBUG" expr="Entered 'State1'"/>
```
**Output:**
> \[Log\] DEBUG: "Entered 'State1'"

## Attribute Details

Name|Required|Type|Default Value|Description|
----|--------|----|-------------|-----------|
label|false|string|empty string|A character string with an implementation-dependent interpretation. It is intended to provide meta-data about the log string specified by 'expr'.
expr|false|Value expression|none|An expression returning the value to be logged. [See 5.9.3 Legal Data Values and Value Expressions](https://www.w3.org/TR/scxml/#ValueExpressions) for details. The nature of the logging mechanism is implementation-dependent. For example, the SCXML processor may convert this value to a convenient format before logging it.

## Example
![log](https://user-images.githubusercontent.com/18611095/28259039-03c5de9a-6add-11e7-8b70-e4384f63beaa.png)

```xml
<scxml initial="Shape1" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Shape1">
		<onentry>
			<log expr="Entered 'Shape1'" label="DEBUG"/>
			<raise event="error"/>
		</onentry>
		<onexit>
			<log expr="Exited 'Shape1'" label="INFO"/>
		</onexit>
		<transition event="error" target="Fail"/>
		<transition event="*" target="End"/>
	</state>
	<final id="End">
		<onentry>
			<log expr="Pass!" label="DEBUG"/>
		</onentry>
	</final>
	<final id="Fail">
		<onentry>
			<log expr="Failed!" label="ERROR"/>
		</onentry>
	</final>
</scxml>
```

**Output:**
> \[Log\] DEBUG: "Entered 'Shape1'"
>
> Internal Event: error, interpreter \[Scxml\]
>
> \[Log\] INFO: "Exited 'Shape1'"
>
> \[Log\] ERROR: "Failed!"

[TOP](#top-anchor)|[Contents](../README.md#table-of-contents)|[Overview](../README.md#scxml-overview)|[Examples](../README.md#examples)|[Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions)|
