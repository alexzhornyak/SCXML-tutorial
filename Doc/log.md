<a name="top-anchor">
	
<table class="table table-striped table-bordered">
<thead>
<tr>
<th><a href="../README.md#table-of-contents">Contents</a></th>
<th><a href="../README.md#scxml-overview">Overview</a></th>
<th><a href="../README.md#examples">Examples</a></th>
<th><a href="https://github.com/alexzhornyak/SCXML-tutorial/discussions">Forum</a></th>
</tr>
</thead>
<tbody></tbody>
</table>

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

<table class="table table-striped table-bordered">
<thead>
<tr>
<th>Name</th>
<th>Required</th>
<th>Type</th>
<th>Default Value</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>label</td>
<td>false</td>
<td>string</td>
<td>empty string</td>
<td>A character string with an implementation-dependent interpretation. It is intended to provide meta-data about the log string specified by ‘expr’.</td>
</tr>
<tr>
<td>expr</td>
<td>false</td>
<td>Value expression</td>
<td>none</td>
<td>An expression returning the value to be logged. <a href="https://www.w3.org/TR/scxml/#ValueExpressions">See 5.9.3 Legal Data Values and Value Expressions</a> for details. The nature of the logging mechanism is implementation-dependent. For example, the SCXML processor may convert this value to a convenient format before logging it.</td>
</tr>
</tbody>
</table>

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

<table class="table table-striped table-bordered">
<thead>
<tr>
<th><a href="#top-anchor">TOP</a></th>
<th><a href="../README.md#table-of-contents">Contents</a></th>
<th><a href="../README.md#scxml-overview">Overview</a></th>
<th><a href="../README.md#examples">Examples</a></th>
<th><a href="https://github.com/alexzhornyak/SCXML-tutorial/discussions">Forum</a></th>
</tr>
</thead>
<tbody></tbody>
</table>
