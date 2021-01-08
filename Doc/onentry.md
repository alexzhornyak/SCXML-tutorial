# [\<onentry\>](https://www.w3.org/TR/scxml/#onentry)

**[Video version](https://youtu.be/CLj1mYw5b7M)**

A wrapper element containing executable content to be executed when the state is entered.

The SCXML processor must execute the \<onentry\> handlers of a state in document order when the state is entered. In doing so, it must treat each handler as a separate block of executable content.

![onentry-onexit - onentry](../Images/onentry%20-%201.gif)

```
<scxml initial="State1" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="State1">
		<onentry>
			<log expr="Hello from 'State1'!"/>
		</onentry>
		<transition target="Container"/>
	</state>
	<final id="End">
		<onentry>
			<log expr="Hello from 'End'!"/>
		</onentry>
	</final>
	<state id="Container" initial="State2">
		<onentry>
			<log expr="Hello from 'Container'!"/>
		</onentry>
		<transition target="End"/>
		<state id="State3">
			<onentry>
				<log expr="Hello from 'State3'!"/>
			</onentry>
		</state>
		<state id="State2">
			<onentry>
				<log expr="Hello from 'State2'!"/>
			</onentry>
			<transition target="State3"/>
		</state>
	</state>
</scxml>
```

**Output:**

>[Log] "Hello from 'State1'!"
>
>[Log] "Hello from 'Container'!"
>
>[Log] "Hello from 'State2'!"
>
>[Log] "Hello from 'State3'!"
>
>[Log] "Hello from 'End'!"

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### [1. Test 375](https://www.w3.org/Voice/2013/scxml-irp/375/test375.txml)
The SCXML processor MUST execute the onentry handlers of a state in document order when the state is entered.

![test375](https://user-images.githubusercontent.com/18611095/28672336-2a80d1ee-72e8-11e7-9ed9-eef66faa9a54.png)

### [2. Test 376](https://www.w3.org/Voice/2013/scxml-irp/376/test376.txml)
The SCXML processor MUST treat each \<onentry\> handler as a separate block of executable content.

![test376](https://user-images.githubusercontent.com/18611095/28672666-091bb298-72e9-11e7-8e91-f6acb5720c8a.png)
