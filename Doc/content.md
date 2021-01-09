<a name="top-anchor"/>

| [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../README.md#examples) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |

# [\<content\>](https://www.w3.org/TR/scxml/#content)

**[Video version](https://youtu.be/V9hqU9smirw)**

A container element holding data to be passed to an external service.

**Example:**
```xml
<send event="Event1">
	<content>{ 1, 2, 3}</content>
</send>

<send event="Event2">
	<content expr="'Text message'"/>
</send>
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
<td>expr</td><td>false</td><td>must not occur with child content</td><td>Value expression</td><td>none</td><td>Any valid value expression</td><td>A value expression. See <a href="https://www.w3.org/TR/scxml/#ValueExpressions">5.9.3 Legal Data Values and Value Expressions</a> for details.</td>
</tr>
</tbody>
</table>

## Children
When present, the children of \<content\> may consist of text, XML from any namespace, or a mixture of both. 

**A conformant SCXML document must not specify both the 'expr' attribute and child content.**

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### [1. Test 527](https://www.w3.org/Voice/2013/scxml-irp/527/test527.txml)
When the SCXML Processor evaluates the content element, if the **'expr'** value expression is present, the Processor MUST evaluate it and use the result as the output of the content element.

![test527](https://user-images.githubusercontent.com/18611095/28513630-7c2c308c-705f-11e7-8107-f78dd192765a.png)

### [2. Test 528](https://www.w3.org/Voice/2013/scxml-irp/528/test528.txml)
If the evaluation of **'expr'** produces an error, the Processor MUST place **error.execution** in the internal event queue and use the empty string as the output of the content element.

![test528](https://user-images.githubusercontent.com/18611095/28513970-ef37fb82-7060-11e7-9df8-eb9ce5d24c2d.png)

### [3. Test 529](https://www.w3.org/Voice/2013/scxml-irp/529/test529.txml)
If the **'expr'** attribute is not present, the Processor MUST use the children of content as the output.

![test529](https://user-images.githubusercontent.com/18611095/28514396-81d880d2-7062-11e7-8f90-fd47c68c99c5.png)

| [TOP](#top-anchor) | [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../README.md#examples) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
