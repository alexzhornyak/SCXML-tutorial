# [\<onexit>](https://www.w3.org/TR/scxml/#onexit)

**[Video version](https://youtu.be/CLj1mYw5b7M)**

A wrapper element containing executable content to be executed when the state is exited.

The SCXML processor must execute the <onexit> handlers of a state in document order when the state is exited. In doing so, it must treat each handler as a separate block of executable content.

![onentry-onexit - onexit](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Images/onexit%20-%201.gif)

```
<scxml initial="State1" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="State1">
		<onexit>
			<log expr="Bye from 'State1'!"/>
		</onexit>
		<transition target="Container"/>
	</state>
	<state id="Container" initial="State2">
		<onexit>
			<log expr="Bye from 'Container'!"/>
		</onexit>
		<transition target="End"/>
		<state id="State2">
			<onexit>
				<log expr="Bye from 'State2'!"/>
			</onexit>
			<transition target="State3"/>
		</state>
		<state id="State3">
			<onexit>
				<log expr="Bye from 'State3'!"/>
			</onexit>
		</state>
	</state>
	<final id="End">
		<onexit>
			<log expr="Bye from 'End'!"/>
		</onexit>
	</final>
</scxml>
```

**Output:**
>[Log] "Bye from 'State1'!"
>
>[Log] "Bye from 'State2'!"
>
>[Log] "Bye from 'State3'!"
>
>[Log] "Bye from 'Container'!"
>
>[Log] "Bye from 'End'!"

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### [1. Test 377](https://www.w3.org/Voice/2013/scxml-irp/377/test377.txml)
The SCXML processor MUST execute the onexit handlers of a state in document order when the state is exited.

![test377](https://user-images.githubusercontent.com/18611095/28672971-dbaccf6c-72e9-11e7-89d8-ab5dd13f3c71.png)

### [2. Test 378](https://www.w3.org/Voice/2013/scxml-irp/378/test378.txml)
The SCXML processor MUST treat each \<onexit\> handler as a separate block of executable content.

![test378](https://user-images.githubusercontent.com/18611095/28673165-88fb15ac-72ea-11e7-9b6d-111105f7d3d9.png)
