# \<onexit>
A wrapper element containing executable content to be executed when the state is exited.

The SCXML processor must execute the <onexit> handlers of a state in document order when the state is exited. In doing so, it must treat each handler as a separate block of executable content.

![onentry-onexit - onexit](https://user-images.githubusercontent.com/18611095/28202755-711417ec-687f-11e7-873b-8cc894fc1f64.png)

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
