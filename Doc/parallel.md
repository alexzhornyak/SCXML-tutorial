# \<parallel\>

The element represents a state whose children are executed in parallel. Children are simultaneously active when the parent element is active.

![parallel - desc](https://user-images.githubusercontent.com/18611095/28107368-2b312c64-66f0-11e7-823b-8fe941904f91.png)

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<parallel id="Airplane_Engines">
		<state id="Engine_1" initial="Engine_1_Off">
			<state id="Engine_1_Off">
				<transition event="Start" target="Engine_1_On"/>
			</state>
			<state id="Engine_1_On">
				<transition event="Shutdown" target="Engine_1_Off"/>
			</state>
		</state>
		<state id="Engine_2" initial="Engine_2_Off">
			<state id="Engine_2_Off">
				<transition event="Start" target="Engine_2_On"/>
			</state>
			<state id="Engine_2_On">
				<transition event="Shutdown" target="Engine_2_Off"/>
			</state>
		</state>
	</parallel>
</scxml>
```
