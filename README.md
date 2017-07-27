# SCXML Tutorial

This project is an attempt to illustrate the current [SCXML standard](https://www.w3.org/TR/scxml)

## Hello world

![hello world](https://user-images.githubusercontent.com/18611095/28060853-2d653f4e-6631-11e7-8d42-acc6f556028b.png)

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<final id="Final">
		<onentry>
			<log expr="Hello, world!" label="Final"/>
		</onentry>
	</final>
</scxml>
```

### Table of contents
[1. \<scxml\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/scxml.md)

[2. \<state\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/state.md)

[3. \<parallel\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/parallel.md)

[4. \<transition\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/transition.md)

[5. \<initial\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/Introduction.md#initial-state)

[6. \<final\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/final.md)

[7. \<onentry\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/onentry.md)

[8. \<onexit\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/onexit.md)

[9. \<history\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/history.md)

[10. \<raise\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/raise.md)

[11. \<if\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/if_else_elseif.md#if)

[12. \<else\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/if_else_elseif.md#else)

[13. \<elseif\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/if_else_elseif.md#elseif)

[14. \<foreach\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/foreach.md)

[15. \<log\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/log.md)

[16. \<datamodel\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/datamodel.md)

[17. \<data\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/datamodel.md#data)

[18. \<assign\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/assign.md)

[19. \<donedata\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/donedata.md)

[20. \<content\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/content.md)

[21. \<param\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/param.md)

[22. \<script\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/script.md)

[23. \<send\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/send.md)

[24. \<cancel\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/cancel.md)

[25. \<invoke\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/invoke.md)

[26. \<finalize\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/finalize.md)

# SCXML Overview

## Basic State Machine Notation

The most basic state machine concepts are [**\<state\>**](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/state.md), [**\<transition\>**](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/transition.md) and **event**. Each state contains a set of transitions that define how it reacts to events. Events can be generated by the state machine itself or by external entities. In a traditional state machine, the machine is always in a single state. This state is called the active state. When an event occurs, the state machine checks the transitions that are defined in the active state. If it finds one that matches the event, it moves from the active state to the state specified by the transition (called the "target" of the transition.) Thus the target state becomes the new active state.

![state transition event](https://user-images.githubusercontent.com/18611095/28061451-46546bae-6633-11e7-8de7-b04793a164a9.png)
```
<scxml initial="Start" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<final id="Final">
		<onentry>
			<log expr="Finished!" label="Final"/>
		</onentry>
	</final>
	<state id="Start">
		<transition event="Event" target="Final"/>
	</state>
</scxml>
```


## [Atomic state](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/state.md#atomic-state)

Does not contain any child states
![2017-07-11 14 35 15](https://user-images.githubusercontent.com/18611095/28066584-3fa428cc-6646-11e7-8a79-e179ee535540.png)
```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Level 1"/>
</scxml>
```


## [Compound states](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/state.md#compound-state)

May contain nested <state> elements and the nesting may proceed to any depth
![2017-07-11 14 26 24](https://user-images.githubusercontent.com/18611095/28066426-87307bb0-6645-11e7-8b93-6fd2844d2082.png)
```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Level 1">
		<state id="Level 2">
			<state id="Level 3"/>
		</state>
	</state>
</scxml>
```


## [Parallel states](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/parallel.md)

The <parallel> element represents a state whose children are executed in parallel.

<img src="https://user-images.githubusercontent.com/18611095/28067259-208edae2-6649-11e7-9273-b209163233ff.png?raw=true" align="left" width="909" height="516"/>

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

## Initial state

Represents the default initial state for a complex [\<state\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/state.md) element

![initial](https://user-images.githubusercontent.com/18611095/28067799-7478e088-664b-11e7-9abf-f38379757be8.png)

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Work">
		<initial>
			<transition target="Ready"/>
		</initial>
		<state id="Ready"/>
	</state>
</scxml>
```

## [Final state](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/final.md)

Represents a final state of an [\<scxml\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/scxml.md) or compound [\<state\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/state.md) element.

![final](https://user-images.githubusercontent.com/18611095/28068129-d5bdb836-664c-11e7-8655-f4a7e6ed9eeb.png)
```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Work">
		<transition event="done.state.Work" target="WorkFinished"/>
		<state id="CompletingTask">
			<transition target="Completed"/>
		</state>
		<final id="Completed"/>
	</state>
	<final id="WorkFinished"/>
</scxml>
```

## [History state](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/history.md)

The \<history\> pseudo-state allows a state machine to remember its state configuration. A [\<transition\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/transition.md) taking the <history> state as its target will return the state machine to this recorded configuration.

![history](https://user-images.githubusercontent.com/18611095/28068981-738e73ea-6650-11e7-9455-95e9225ca315.png)

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Work">
		<transition event="Pause" target="Expecting"/>
		<state id="Off">
			<transition event="Switch" target="On"/>
		</state>
		<state id="On">
			<transition event="Switch" target="Off"/>
		</state>
		<initial>
			<transition target="HistoryPoint"/>
		</initial>
		<history id="HistoryPoint">
			<transition target="Off"/>
		</history>
	</state>
	<state id="Expecting">
		<transition event="Resume" target="HistoryPoint"/>
	</state>
</scxml>
```

## [Transitions](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/transition.md)
Transitions between states are triggered by events and conditionalized via guard conditions. They may contain executable content, which is executed when the transition is taken.

![transitions](https://user-images.githubusercontent.com/18611095/28069895-c481268c-6653-11e7-9ede-f7651fa14aac.png)

```
<scxml datamodel="lua" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Work" initial="Off">
		<transition event="Update" type="internal">
			<log expr="'Updated'" label="OnUpdate"/>
		</transition>
		<transition event="ReInit" target="Work" type="internal"/>
		<transition event="Quit" target="End"/>
		<transition event="error.*" target="Fail"/>
		<state id="Off">
			<transition cond="_event.data==1" event="Switch" target="On"/>
		</state>
		<state id="On">
			<transition cond="_event.data==0" event="Switch" target="Off"/>
		</state>
	</state>
	<final id="End"/>
	<final id="Fail"/>
</scxml>
```
