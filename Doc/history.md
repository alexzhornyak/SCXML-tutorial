# \<history\>
Allows a state machine to remember its state configuration. A <transition> taking the <history> state as its target will return the state machine to this recorded configuration.

## 1. Shallow history
If the 'type' of a <history> element is "shallow", the SCXML processor must record the immediately active children of its parent before taking any transition that exits the parent.

**Example:**
#### 1.1. Configuration before pause
![history - before pause 2](https://user-images.githubusercontent.com/18611095/28204303-1a0302b8-6886-11e7-8263-3ff63d4f0c0f.png)

Active states: **Airplane, Engines, Left, Right, LeftOn, RightOn**

#### 1.2. Configuration after pause
![history - after pause 2](https://user-images.githubusercontent.com/18611095/28204573-30815cc8-6887-11e7-8319-240d61618da4.png)

Active state: **Expecting**

#### 1.3. Configuration after resume
![history - after resume - shallow](https://user-images.githubusercontent.com/18611095/28204678-a2ff435a-6887-11e7-997f-72a9ef6a5d28.png)

Active states: **Airplane, Engines, Left, Right, LeftOff, RightOff**

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Airplane" initial="HistoryPoint">
		<transition event="Pause" target="Expecting"/>
		<parallel id="Engines">
			<transition event="NoFuel" target="Refuel"/>
			<state id="Left" initial="LeftOff">
				<state id="LeftOff">
					<transition event="Startup.Left" target="LeftOn"/>
				</state>
				<state id="LeftOn">
					<transition event="Shutdown.Left" target="LeftOff"/>
				</state>
			</state>
			<state id="Right" initial="RightOff">
				<state id="RightOff">
					<transition event="Startup.Right" target="RightOn"/>
				</state>
				<state id="RightOn">
					<transition event="Shutdown.Right" target="RightOff"/>
				</state>
			</state>
		</parallel>
		<initial>
			<transition target="HistoryPoint"/>
		</initial>
		<history id="HistoryPoint">
			<transition target="Refuel"/>
		</history>
		<state id="Refuel">
			<transition event="Finished" target="Engines"/>
		</state>
	</state>
	<state id="Expecting">
		<transition event="Resume" target="HistoryPoint"/>
	</state>
</scxml>
```

## 2. Deep history
If the 'type' of a <history> element is "deep", the SCXML processor must record the active atomic descendants of the parent before taking any transition that exits the parent.

#### 2.1. Configuration before pause
![history - before pause 2](https://user-images.githubusercontent.com/18611095/28204303-1a0302b8-6886-11e7-8263-3ff63d4f0c0f.png)

Active states: **Airplane, Engines, Left, Right, LeftOn, RightOn**

#### 2.2. Configuration after pause
![history - after pause 2](https://user-images.githubusercontent.com/18611095/28204573-30815cc8-6887-11e7-8319-240d61618da4.png)

Active state: **Expecting**

#### 2.3. Configuration after resume
![history - before pause 2](https://user-images.githubusercontent.com/18611095/28204303-1a0302b8-6886-11e7-8263-3ff63d4f0c0f.png)

Active states: **Airplane, Engines, Left, Right, LeftOn, RightOn**
