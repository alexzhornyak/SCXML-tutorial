<a name="top-anchor"/>

| [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|

# [\<parallel\>](https://www.w3.org/TR/scxml/#parallel)

**[Video version](https://youtu.be/VOKu7TYXN_s)**

The element represents a state whose children are executed in parallel. Children are simultaneously active when the parent element is active.

![parallel - desc](../Images/3%20-%20Parallel%20with%20tree.gif)

```xml
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
### Event `done.state.id`
Parallel state is active while all children states has not reached their [final states](final.md). When all the \<parallel\> element's other children are in [final states](final.md), the Processor must generate the event `done.state.id`, where `id` is the id of the \<parallel\> element.

![join_regions](../Images/parallel%20-%20join%20regions.gif)

```xml
<scxml name="ScxmlJoinParallel" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<parallel id="p">
		<transition event="done.state.p" target="someOtherState"/>
		<state id="S1" initial="S11">
			<state id="S11">
				<transition event="e4" target="S12"/>
			</state>
			<state id="S12">
				<transition event="e1" target="S1Final"/>
			</state>
			<final id="S1Final"/>
		</state>
		<state id="S2" initial="S21">
			<state id="S21">
				<transition event="e1" target="S22"/>
			</state>
			<state id="S22">
				<transition event="e2" target="S2Final"/>
			</state>
			<final id="S2Final"/>
		</state>
	</parallel>
	<state id="someOtherState"/>
</scxml>
```

### [Microwave owen (using parallel) example](https://www.w3.org/TR/scxml/#N11619)
The example below shows the implementation of a simple microwave oven using [**\<parallel\>**](parallel.md) and the SCXML **`In()`** predicate.

![microwave_owen_parallel](../Images/microwave_owen_parallel.gif)

```xml
<scxml datamodel="ecmascript" initial="oven" name="ScxmlMicrowaveOwenParallel" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<datamodel>
		<data expr="5" id="cook_time"/>
		<data expr="true" id="door_closed"/>
		<data expr="0" id="timer"/>
	</datamodel>
	<parallel id="oven">
		<state id="engine">
			<initial>
				<transition target="off"/>
			</initial>
			<state id="off">
				<onentry>
					<assign expr="0" location="timer"/>
				</onentry>
				<transition event="turn.on" target="on"/>
			</state>
			<state id="on">
				<transition event="turn.off" target="off"/>
				<transition cond="timer &gt;= cook_time" target="off"/>
				<initial>
					<transition target="idle"/>
				</initial>
				<state id="idle">
					<transition cond="In('closed')" target="cooking"/>
				</state>
				<state id="cooking">
					<transition cond="In('open')" target="idle"/>
					<transition event="time">
						<assign location="timer" expr="timer + 1"/>
					</transition>
				</state>
			</state>
		</state>
		<state id="door">
			<initial>
				<transition target="closed"/>
			</initial>
			<state id="closed">
				<transition event="door.open" target="open"/>
			</state>
			<state id="open">
				<transition event="door.close" target="closed"/>
			</state>
		</state>
	</parallel>
</scxml>
```

| [TOP](#top-anchor) | [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|---|
