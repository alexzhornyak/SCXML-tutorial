# [\<history\>](https://www.w3.org/TR/scxml/#history)

**[Video version](https://youtu.be/PyWD-aI6EmE)**

Allows a state machine to remember its state configuration. A <transition> taking the <history> state as its target will return the state machine to this recorded configuration.

![history_intro](../Images/5%20-%20History.gif)

## 1. Shallow history
If the 'type' of a <history> element is "shallow", the SCXML processor must record the immediately active children of its parent before taking any transition that exits the parent.

**Example:**
#### 1.1. Configuration before pause
![history - shallow - before pause](https://user-images.githubusercontent.com/18611095/28218713-08c93242-68c2-11e7-9760-a964c10b9e83.png)

Active states: **Airplane, Engines, Left, Right, LeftOn, RightOn**

#### 1.2. Configuration after pause
![history - shallow pause](https://user-images.githubusercontent.com/18611095/28218759-35ba1bcc-68c2-11e7-917e-3d4af3eb133c.png)

Active state: **Expecting**

#### 1.3. Configuration after resume
![history - shallow after pause](https://user-images.githubusercontent.com/18611095/28218798-5361ae06-68c2-11e7-9451-f0a1544c7a51.png)

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
![history - after deep pause](https://user-images.githubusercontent.com/18611095/28218825-68aa707c-68c2-11e7-9211-f91395d83c66.png)

Active states: **Airplane, Engines, Left, Right, LeftOn, RightOn**

#### 2.2. Configuration after pause
![history - deep pause](https://user-images.githubusercontent.com/18611095/28218826-68ab72ce-68c2-11e7-8923-234263c9df8b.png)

Active state: **Expecting**

#### 2.3. Configuration after resume
![history - after deep pause](https://user-images.githubusercontent.com/18611095/28218825-68aa707c-68c2-11e7-9211-f91395d83c66.png)

Active states: **Airplane, Engines, Left, Right, LeftOn, RightOn**

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Airplane">
		<transition event="Pause" target="Expecting"/>
		<initial>
			<transition target="HistoryPoint"/>
		</initial>
		<history id="HistoryPoint" type="deep">
			<transition target="Refuel"/>
		</history>
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
		<state id="Refuel">
			<transition event="Finished" target="Engines"/>
		</state>
	</state>
	<state id="Expecting">
		<transition event="Resume" target="HistoryPoint"/>
	</state>
</scxml>
```
## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### [1. Test 387](https://www.w3.org/Voice/2013/scxml-irp/387/test387.txml)
Before the parent state has been visited for the first time, if a transition is executed that takes the history state as its target, the SCXML processor MUST behave as if the transition had taken the default stored state configuration as its target.

![test387](https://user-images.githubusercontent.com/18611095/28674707-dc8cd9c2-72ee-11e7-9aaf-a63002f87687.png)

### [2. Test 579](https://www.w3.org/Voice/2013/scxml-irp/579/test579.txml)
Before the parent state has been visited for the first time, if a transition is executed that takes the history state as its target, the SCXML processor MUST execute any executable content in the transition after the parent state's onentry content and any content in a possible initial transition.

![test579](https://user-images.githubusercontent.com/18611095/28675631-1dead9a8-72f1-11e7-8868-bb84bb81bc75.png)

### [3. Test 580](https://www.w3.org/Voice/2013/scxml-irp/580/test580.txml)
It follows from the semantics of history states that they never end up in the state configuration.

![test580](https://user-images.githubusercontent.com/18611095/28676685-f2a728e8-72f3-11e7-9ab1-291ec3f13877.png)

### [4. Test 388](https://www.w3.org/Voice/2013/scxml-irp/388/test388.txml)
After the parent state has been visited for the first time, if a transition is executed that takes the history state as its target, the SCXML processor MUST behave as if the transition had taken the stored state configuration as its target.

![test388](https://user-images.githubusercontent.com/18611095/28677984-d164acd8-72f7-11e7-9ba6-80696f4fc960.png)
