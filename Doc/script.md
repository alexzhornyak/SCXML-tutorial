# \<script\>
The \<script\> element adds scripting capability to the state machine.

## Attribute Details
Name	|Required	|Attribute Constraints	|Default Value	|Valid Values	|Description
---|---|---|---|---|---|
src	|false	|May not occur if the element has children.		|none	|A valid URI	|Gives the location from which the script should be downloaded.

## Children
The child content of the \<script\> element represents the script code to be executed.

A conformant SCXML document must specify either the **'src'** attribute or **child content**, but **not both**. If **'src'** is specified, the SCXML Processor **must download the script from the specified location at load time**. If the script can not be downloaded within a platform-specific timeout interval, the document is considered non-conformant, and the platform **must reject it**.

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### [1. Test 301](https://www.w3.org/Voice/2013/scxml-irp/301/test301.txml)
If the script specified by the 'src' attribute of a script element cannot be downloaded within a platform-specific timeout interval, the document is considered non-conformant, and the platform MUST reject it. N.B. This test is valid only for datamodels that support scripting.

![test301](https://user-images.githubusercontent.com/18611095/28519596-e2b3a050-7074-11e7-8a63-71ebc17a8976.png)

### [2. Test 302](https://www.w3.org/Voice/2013/scxml-irp/302/test302.txml)
The SCXML Processor MUST evaluate any script element that is a child of scxml at document load time. N.B. This test is valid only for datamodels that support scripting.

![test302](https://user-images.githubusercontent.com/18611095/28519688-4a8b2db0-7075-11e7-8dae-5728c2ae2e4b.png)

### [3. Test 303](https://www.w3.org/Voice/2013/scxml-irp/303/test303.txml)
In a conformant SCXML document, the name of any script variable MAY be used as a location expression. N.B. This test is valid only for datamodels that support scripting.

![test303](https://user-images.githubusercontent.com/18611095/28519890-012d2974-7076-11e7-9bfd-87c84bcb6df5.png)

### [4. Test 304](https://www.w3.org/Voice/2013/scxml-irp/303/test303.txml)
In a conformant SCXML document, the name of any script variable MAY be used as a location expression. N.B. This test is valid only for datamodels that support scripting.

![test304](https://user-images.githubusercontent.com/18611095/28520361-dd4455a8-7077-11e7-8b43-f3e89102ba78.png)

