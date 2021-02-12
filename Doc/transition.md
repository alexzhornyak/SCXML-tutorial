<a name="top-anchor"/>

| [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|

# [\<transition\>](https://www.w3.org/TR/scxml/#transition)

**[Video version](https://youtu.be/-AtkiRAzRRE)**

Transitions between states are triggered by events and conditionalized via guard conditions. They may contain executable content, which is executed when the transition is taken.

## 1. Attribute 'event'
A space-separated list of event descriptors. Like an event name, an event descriptor is a series of alphanumeric characters (optionally segmented into tokens by the "." character)

### 1.1. Event name not specified
If condition is also not specified, transition will be executed immediately.

![transition - eventless](../Images/transition%20-%201.gif)

```xml
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="State1">
		<transition target="State2"/>
	</state>
	<state id="State2"/>
</scxml>
```

![transition - eventless - call stack](https://user-images.githubusercontent.com/18611095/28110712-e753ce14-66fb-11e7-8020-09b6114887f9.png)

### 1.2. Event name fully case sensitive matched
A transition matches an event if at least one of its event descriptors matches the event's name.

![transition - event name match](../Images/transition%20-%202.gif)

```xml
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="State1">
		<transition event="Step" target="State2"/>
	</state>
	<state id="State2"/>
</scxml>
```

![transition - event name match - callstack](https://user-images.githubusercontent.com/18611095/28114425-874255e6-6709-11e7-8109-4f26d0bd978b.png)

### 1.3. Event name case sensitive matched by token
An event descriptor matches an event name if its string of tokens is an exact match or a prefix of the set of tokens in the event's name. In all cases, the token matching is case sensitive.

![transition - partial match](../Images/transition%20-%203.gif)

In this example, a transition will match event names "Step", "Step.Next", "Step.Next.Completed", etc. but would not match events named "Steps.My.Custom", "StepHandler.mistake", etc.

## 2. Attribute 'cond'
The guard condition for this transition. Any boolean expression.

![transition_cond](../Images/transition%20-%20cond.gif)
```xml
<scxml datamodel="lua" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Off">
		<transition cond="_event.data==1" event="Choice" target="Select1"/>
		<transition cond="_event.data==2" event="Choice" target="Select2"/>
	</state>
	<state id="Selection">
		<transition cond="_event.data==0" event="Choice" target="Off"/>
		<state id="Select1"/>
		<state id="Select2"/>
	</state>
</scxml>
```

## 3. Attribute 'target'
The identifier(s) of the state or parallel region to transition to. 
#### If target is not present then transition is executed internally and is called 'Self-transition'
```xml
<state id="S1">
	<transition event="e">
```
![no_target](../Images/transition%20-%20target_not_stored.gif)
```xml
<state id="S" initial="S1">
    <state id="S1">
        <onentry>
            <log expr="entering S1"/>
        </onentry>
        <onexit>
            <log expr="leaving S1"/>
        </onexit>
        <transition event="e" target="S1">
            <log expr="'executing transition'"/>
        </transition>
    </state>
</state>
```
#### If target of transition is its source state it is also called 'Self-transition' but is executed externally
```xml
<state id="S1">
	<transition event="e" target="S1"/>
```
![target_present](../Images/transition%20-%20target_stored.gif)
```xml
<state id="S" initial="S1">
    <state id="S1">
        <onentry>
            <log expr="entering S1"/>
        </onentry>
        <onexit>
            <log expr="leaving S1"/>
        </onexit>
        <transition event="e" target="S1">
            <log expr="'executing transition'"/>
        </transition>
    </state>
</state>
```

## 4. Attribute 'type'
Determines whether the source state is exited in transitions whose target state is a descendant of the source state
### 4.1. External (Default)
```xml
<transition event="e" target="s11">
```
![transition_external](../Images/transition%20-%20type%20-%20external.gif)

<details><summary>Source code</summary>
<p>

```xml
<scxml name="ScxmlTransitionsBehaviour" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="S" initial="s1">
		<state id="s1" initial="s11">
			<onentry>
				<log expr="entering S1"/>
			</onentry>
			<onexit>
				<log expr="'leaving s1'"/>
			</onexit>
			<transition event="e" target="s11">
				<log expr="'executing transition'"/>
			</transition>
			<state id="s11">
				<onentry>
					<log expr="entering s11"/>
				</onentry>
				<onexit>
					<log expr="'leaving s11'"/>
				</onexit>
			</state>
		</state>
	</state>
</scxml>
```

</p>
</details>

### 4.2. Internal
The behavior of transitions with 'type' of `internal` is identical, except in the case of a transition whose source state is a compound state and whose target(s) is a descendant of the source. In such a case, an internal transition **will not exit and re-enter its source state**, while an external one will, as shown in the example below.
```xml
<transition event="e" target="s11" type="internal">
```
![transition_internal](../Images/transition%20-%20type%20-%20internal.gif)

<details><summary>Source code</summary>
<p>

```xml
<scxml name="ScxmlTransitionsBehaviour" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="S" initial="s1">
		<state id="s1" initial="s11">
			<onentry>
				<log expr="entering S1"/>
			</onentry>
			<onexit>
				<log expr="'leaving s1'"/>
			</onexit>
			<transition event="e" target="s11" type="internal">
				<log expr="'executing transition'"/>
			</transition>
			<state id="s11">
				<onentry>
					<log expr="entering s11"/>
				</onentry>
				<onexit>
					<log expr="'leaving s11'"/>
				</onexit>
			</state>
		</state>
	</state>
</scxml>
```

</p>
</details>

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### 1. Test 403
To execute a microstep, the SCXML Processor MUST execute the transitions in the corresponding optimal enabled transition set, where the optimal transition set enabled by event E in state configuration C is the largest set of transitions such that: 
#### [a) each transition in the set is optimally enabled by E in an atomic state in C](https://www.w3.org/Voice/2013/scxml-irp/403/test403a.txml)

![test403a](https://user-images.githubusercontent.com/18611095/28820966-4b9dfc76-76bc-11e7-9811-ffc2e3b01933.png)

#### [b) no transition conflicts with another transition in the set](https://www.w3.org/Voice/2013/scxml-irp/403/test403b.txml)

![test403b](https://user-images.githubusercontent.com/18611095/28822879-b7adfa0e-76c3-11e7-92ba-4a6b68f9eead.png)

#### [c) there is no optimally enabled transition outside the set that has a higher priority than some member of the set.](https://www.w3.org/Voice/2013/scxml-irp/403/test403c.txml)

![test403c](https://user-images.githubusercontent.com/18611095/28823335-aa24d856-76c5-11e7-9b51-cb3e93d41d24.png)

### [2. Test 404](https://www.w3.org/Voice/2013/scxml-irp/404/test404.txml)
To execute a set of transitions, the SCXML Processor MUST first exit all the states in the transitions' exit set in exit order.

![test404](https://user-images.githubusercontent.com/18611095/28823515-a1e9e054-76c6-11e7-922f-d381db341cbb.png)

### [3. Test 405](https://www.w3.org/Voice/2013/scxml-irp/405/test405.txml)
[the SCXML Processor executing a set of transitions](https://www.w3.org/TR/scxml/#SelectingTransitions) MUST then [after the onexits] execute the executable content contained in the transitions in document order.

![test405](https://user-images.githubusercontent.com/18611095/28823703-98d0af88-76c7-11e7-84da-c7704a768ade.png)

### [4. Test 406](https://www.w3.org/Voice/2013/scxml-irp/406/test406.txml)
[the SCXML Processor executing a set of transitions](https://www.w3.org/TR/scxml/#SelectingTransitions) MUST then [after the exits and the transitions] enter the states in the transitions' entry set in entry order.

![test406](https://user-images.githubusercontent.com/18611095/28824064-1c65f910-76c9-11e7-90bd-8bf9ed034a55.png)

| [TOP](#top-anchor) | [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|---|
