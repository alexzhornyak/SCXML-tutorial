# \<history\>
Allows a state machine to remember its state configuration. A <transition> taking the <history> state as its target will return the state machine to this recorded configuration.

## 1. Shallow history
If the 'type' of a <history> element is "shallow", the SCXML processor must record the immediately active children of its parent before taking any transition that exits the parent.

**Example:**
#### 1.1. Configuration before pause
<img src="/Images/history%20-%20shallow%20-%20before%20pause.png?raw=true" align="left" width="903" height="523"/>

Active states: **Airplane, Engines, Left, Right, LeftOn, RightOn**

#### 1.2. Configuration after pause
<img src="/Images/history%20-%20shallow%20pause.png?raw=true" align="left" width="903" height="523"/>

Active state: **Expecting**

#### 1.3. Configuration after resume
<img src="/Images/history%20-%20shallow%20after%20pause.png?raw=true" align="left" width="903" height="523"/>

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
<img src="/Images/history%20-%20after%20deep%20pause.png?raw=true" align="left" width="903" height="523"/>

Active states: **Airplane, Engines, Left, Right, LeftOn, RightOn**

#### 2.2. Configuration after pause
<img src="/Images/history%20-%20deep%20pause.png?raw=true" align="left" width="903" height="523"/>

Active state: **Expecting**

#### 2.3. Configuration after resume
<img src="/Images/history%20-%20after%20deep%20pause.png?raw=true" align="left" width="903" height="523"/>

Active states: **Airplane, Engines, Left, Right, LeftOn, RightOn**
