# \<onentry\>
A wrapper element containing executable content to be executed when the state is entered.

![onentry-onexit - onentry](https://user-images.githubusercontent.com/18611095/28201740-131de090-687b-11e7-8e8e-a01a8cccc347.png)

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

Output:
>[Log] "Hello from 'State1'!"

>[Log] "Hello from 'Container'!"

>[Log] "Hello from 'State2'!"

>[Log] "Hello from 'State3'!"

>[Log] "Hello from 'End'!"
