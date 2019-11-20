# [\<parallel\>](https://www.w3.org/TR/scxml/#parallel)

**[Video version](https://youtu.be/VOKu7TYXN_s)**

The element represents a state whose children are executed in parallel. Children are simultaneously active when the parent element is active.

![parallel - desc](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Images/3%20-%20Parallel%20with%20tree.gif)

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<parallel id="Airplane_Engines">
		<state id="Engine_1" initial="Engine_1_Off">
			<state id="Engine_1_Off">
				<transition event="Start.1" target="Engine_1_On"/>
			</state>
			<state id="Engine_1_On">
				<transition event="Shutdown.1" target="Engine_1_Off"/>
			</state>
		</state>
		<state id="Engine_2" initial="Engine_2_Off">
			<state id="Engine_2_Off">
				<transition event="Start.2" target="Engine_2_On"/>
			</state>
			<state id="Engine_2_On">
				<transition event="Shutdown.2" target="Engine_2_Off"/>
			</state>
		</state>
	</parallel>
</scxml>
```
