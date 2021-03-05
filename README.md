<a name="top-anchor"/>

| [Contents](#table-of-contents) | [Overview](#scxml-overview) | [Examples](Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) | 
|---|---|---|---|---|

# SCXML Tutorial

This project is an attempt to illustrate the current [SCXML standard](https://www.w3.org/TR/scxml)

**New!** [Video version of the tutorial](https://youtu.be/5ebxa-nIpiE?list=PLUbY_L_9E-b_YuK-IWjUWYxcpcKccSX1N)

## Hello world

![hello world](Images/1%20-%20Hello%20world.gif)

```xml
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<final id="Final">
		<onentry>
			<log expr="Hello, world!" label="INFO"/>
		</onentry>
	</final>
</scxml>
```

## Table of contents
[1. \<scxml\>](Doc/scxml.md)

[2. \<state\>](Doc/state.md)

[3. \<parallel\>](Doc/parallel.md)

[4. \<transition\>](Doc/transition.md)

[5. \<initial\>](Doc/Introduction.md#initial-state)

[6. \<final\>](Doc/final.md)

[7. \<onentry\>](Doc/onentry.md)

[8. \<onexit\>](Doc/onexit.md)

[9. \<history\>](Doc/history.md)

[10. \<raise\>](Doc/raise.md)

[11. \<if\>](Doc/if_else_elseif.md#if)

[12. \<else\>](Doc/if_else_elseif.md#else)

[13. \<elseif\>](Doc/if_else_elseif.md#elseif)

[14. \<foreach\>](Doc/foreach.md)

[15. \<log\>](Doc/log.md)

[16. \<datamodel\>](Doc/datamodel.md)

[17. \<data\>](Doc/datamodel.md#data)

[18. \<assign\>](Doc/assign.md)

[19. \<donedata\>](Doc/donedata.md)

[20. \<content\>](Doc/content.md)

[21. \<param\>](Doc/param.md)

[22. \<script\>](Doc/script.md)

[23. \<send\>](Doc/send.md)

[24. \<cancel\>](Doc/cancel.md)

[25. \<invoke\>](Doc/invoke.md)

[26. \<finalize\>](Doc/finalize.md)

[27. Basic HTTP Event I/O Processor](Doc/BasicHTTPEventIO.md)

## [SCXML Frameworks W3C Standard Specification Compliance](Tests/README.md)

## [Examples](Examples/README.md)
[1. Microwave owen](Doc/microwave_example.md)

[2. Microwave owen (using parallel)](Doc/microwave_parallel.md)

[3. Calculator](Doc/calculator.md)

[4. Salus RT500 (Digital Room Thermostat) Simulator](https://github.com/alexzhornyak/Salus-RT500-Simulator)

[5. Morse Code Trainer](https://github.com/alexzhornyak/SCXML-tutorial/tree/master/Examples/Qt/Morse)

[6. StopWatch](https://github.com/alexzhornyak/SCXML-tutorial/tree/master/Examples/Qt/StopWatch)

[7. Infotainment Radio Bolero Simulator](https://github.com/alexzhornyak/SCXML-tutorial/tree/master/Examples/Qt/SkodaBoleroInfotainment)
[![Preview](Examples/Qt/SkodaBoleroInfotainment/Qml/Images/BoleroPreview.gif)](https://github.com/alexzhornyak/SCXML-tutorial/tree/master/Examples/Qt/SkodaBoleroInfotainment)

### [Qt SCXML Examples](Examples/Qt/README.md)

### Articles
[1. Inheritance (Visual) in SCXML (State Machines)](Doc/Inheritance_SCXML.md)

## [W3C Examples](Doc/W3C.md#w3c-examples)
## [W3C IRP tests](Doc/W3C.md#w3c-irp-tests)

# SCXML Overview

## Basic State Machine Notation

The most basic state machine concepts are [**\<state\>**](Doc/state.md), [**\<transition\>**](Doc/transition.md) and **event**. Each state contains a set of transitions that define how it reacts to events. Events can be generated by the state machine itself or by external entities. In a traditional state machine, the machine is always in a single state. This state is called the active state. When an event occurs, the state machine checks the transitions that are defined in the active state. If it finds one that matches the event, it moves from the active state to the state specified by the transition (called the "target" of the transition.) Thus the target state becomes the new active state.

![state transition event](Images/2%20-%20Hello%20world%20with%20event.gif)
```xml
<scxml initial="Start" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<final id="Final">
		<onentry>
			<log expr="Finished!" label="INFO"/>
		</onentry>
	</final>
	<state id="Start">
		<transition event="Event" target="Final"/>
	</state>
</scxml>
```


## [Atomic state](Doc/state.md#atomic-state)

Does not contain any child [states](Doc/state.md)

![atomic_state_img](Images/readme%20-%20atomic.gif)
```xml
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Level 1"/>
</scxml>
```


## [Compound states](Doc/state.md#compound-state)

May contain nested [\<state\>](Doc/state.md) elements and the nesting may proceed to any depth
	
![compound_state_img](Images/readme%20-%20compound.gif)
```xml
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Level 1">
		<state id="Level 2">
			<state id="Level 3"/>
		</state>
	</state>
</scxml>
```


## [Parallel states](Doc/parallel.md)

The [\<parallel\>](Doc/parallel.md) element represents a state whose children are executed in parallel.

![start_page_parallel](Images/3%20-%20Parallel%20with%20tree.gif)

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

## Initial state

Represents the default initial state for a complex [\<state\>](Doc/state.md) element

![initial](Images/7%20-%20Initial.gif)

```xml
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Work">
		<initial>
			<transition target="Ready"/>
		</initial>
		<state id="Ready"/>
	</state>
</scxml>
```

## [Final state](Doc/final.md)

Represents a final state of an [\<scxml\>](Doc/scxml.md) or compound [\<state\>](Doc/state.md) element.

![final](Images/4%20-%20Final.gif)
```xml
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

## [History state](Doc/history.md)

The [\<history\>](Doc/history.md) pseudo-state allows a state machine to remember its state configuration. A [\<transition\>](Doc/transition.md) taking the [\<history\>](Doc/history.md) state as its target will return the state machine to this recorded configuration.

![history](Images/5%20-%20History.gif)

```xml
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

## [Transitions](Doc/transition.md)
Transitions between states are triggered by events and conditionalized via guard conditions. They may contain executable content, which is executed when the transition is taken.

![transitions](Images/8%20-%20Intro%20-%20Transitions.gif)

```xml
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

## [Invoke](Doc/invoke.md)
SCXML provides an element [**\<invoke\>**](Doc/invoke.md) which can create external services. For example: it can create instances of external state machines
![invoked_example](Images/simple_tasks_invoked_example.gif)

## [Traffic light example](https://github.com/alexzhornyak/UscxmlCLib/tree/master/Examples/BCB/TrafficLight)
![traffic_light](https://raw.githubusercontent.com/alexzhornyak/UscxmlCLib/master/Examples/Images/TrafficLight.gif)
```xml
<?xml version="1.0" encoding="UTF-8"?>
<scxml initial="working" name="TrafficLightStateMachine" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="working" initial="red">
		<onexit>
			<cancel sendid="ID_startGoingGreen"/>
			<cancel sendid="ID_startGoingRed"/>
		</onexit>
		<transition event="switch" target="broken" type="internal"/>
		<state id="red">
			<onentry>
				<send delay="3s" event="startGoingGreen" id="ID_startGoingGreen"/>
			</onentry>
			<transition event="startGoingGreen" target="redGoingGreen" type="internal"/>
		</state>
		<state id="yellow">
			<onexit>
				<cancel sendid="ID_goGreen"/>
				<cancel sendid="ID_goRed"/>
			</onexit>
			<state id="redGoingGreen">
				<onentry>
					<send delay="1s" event="goGreen" id="ID_goGreen"/>
				</onentry>
				<transition event="goGreen" target="green" type="internal"/>
			</state>
			<state id="greenGoingRed">
				<onentry>
					<send delay="1s" event="goRed" id="ID_goRed"/>
				</onentry>
				<transition event="goRed" target="red" type="internal"/>
			</state>
		</state>
		<state id="green">
			<onentry>
				<send delay="3s" event="startGoingRed" id="ID_startGoingRed"/>
			</onentry>
			<transition event="startGoingRed" target="greenGoingRed" type="internal"/>
		</state>
	</state>
	<state id="broken" initial="blinking">
		<onexit>
			<cancel sendid="ID_blink"/>
		</onexit>
		<transition event="switch" target="working" type="internal"/>
		<state id="blinking">
			<onentry>
				<send delay="1s" event="blink" id="ID_blink"/>
			</onentry>
			<transition event="blink" target="unblinking" type="internal"/>
		</state>
		<state id="unblinking">
			<onentry>
				<send delay="1s" event="blink" id="ID_blink"/>
			</onentry>
			<transition event="blink" target="blinking" type="internal"/>
		</state>
	</state>
</scxml>
```

## Time generator example
![TimeGenerator](Images/TimerGenerator.gif)
```xml
<scxml datamodel="lua" initial="Off" name="ScxmlTimeGenerator" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<datamodel>
		<data expr="0" id="tm_ELAPSED"/>
	</datamodel>
	<state id="Off">
		<transition event="Start" target="Generator"/>
	</state>
	<state id="Generator">
		<onentry>
			<assign expr="os.clock()" location="tm_ELAPSED"/>
		</onentry>
		<onexit>
			<cancel sendid="ID_TIMER"/>
		</onexit>
		<transition event="Stop" target="Off"/>
		<state id="StateShape1">
			<onentry>
				<log expr="string.format('Elapsed:%.2fs', os.clock() - tm_ELAPSED)" label="INFO"/>
				<send delay="1000ms" event="Do.Timer" id="ID_TIMER"/>
			</onentry>
			<transition event="Do.Timer" target="StateShape1"/>
		</state>
	</state>
</scxml>
```

## [Microwave owen example](Doc/microwave_example.md)
![microwave_owen](Images/6%20-%20Microwave%20Owen.gif)
```xml
<?xml version="1.0"?>
<scxml xmlns="http://www.w3.org/2005/07/scxml"
       version="1.0"
       datamodel="ecmascript"
       initial="off">

  <!--  trivial 5 second microwave oven example -->
  <datamodel>
    <data id="cook_time" expr="5"/>
    <data id="door_closed" expr="true"/>
    <data id="timer" expr="0"/>
  </datamodel>

  <state id="off">
    <!-- off state -->
    <transition event="turn.on" target="on"/>
  </state>

  <state id="on">
    <initial>
        <transition target="idle"/>
    </initial>
    <!-- on/pause state -->

    <transition event="turn.off" target="off"/>
    <transition cond="timer &gt;= cook_time" target="off"/>

    <state id="idle">
      <!-- default immediate transition if door is shut -->
      <transition cond="door_closed" target="cooking"/>
      <transition event="door.close" target="cooking">
        <assign location="door_closed" expr="true"/>
        <!-- start cooking -->
      </transition>
    </state>

    <state id="cooking">
      <transition event="door.open" target="idle">
        <assign location="door_closed" expr="false"/>
      </transition>

      <!-- a 'time' event is seen once a second -->
      <transition event="time">
        <assign location="timer" expr="timer + 1"/>
      </transition>
    </state>

  </state>

</scxml>
```

## [StopWatch example](https://github.com/alexzhornyak/SCXML-tutorial/tree/master/Examples/Qt/StopWatch)
![StopWatchPreview](Images/StopWatchScxml.gif)
```xml
<?xml version="1.0" encoding="UTF-8"?>
<scxml datamodel="ecmascript" initial="ready" name="ScxmlStopWatch" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<datamodel><!--CONSTS-->
		<data expr="100" id="i_UPDATE_DELAY_MS"/>
		<data id="FormatTimeStr"><![CDATA[function (ms){// time(ms)
    function pad(number) {
      if (number < 10) {
        return '0' + number;
      }
      return number;
    }  
  
    var time = new Date(ms)
    var days = time.getUTCDate()
    var hours = time.getUTCHours()
    var minutes = time.getUTCMinutes()
    var seconds = time.getUTCSeconds()
    var milliseconds = time.getUTCMilliseconds()    
    
    var t = []
    if (days > 1)
        t.push(pad(days - 1) + 'T')
  
    if (hours > 0 || t.length > 0)
        t.push(pad(hours) + ':')
  
    t.push(pad(minutes) + ':')
    t.push(pad(seconds))
   
    if (milliseconds > 0)
        t.push('.' + (time.getUTCMilliseconds() / 1000).toFixed(3).slice(2, 5))
  
    return t.join('')
}]]>
		</data>
		<data id="StopWatchClass">function() {
    var timeMS = undefined
    var pauseTimeMS = undefined
    var pauseDurationMS = 0

    this.start = function() {

        this.reset()

        timeMS = Date.now()
    }

    this.suspend = function() {
        pauseTimeMS = Date.now()        
    }

    this.resume = function() {
        pauseDurationMS += Date.now() - pauseTimeMS
        pauseTimeMS = undefined
    }

    this.reset = function() {
        timeMS = undefined
        pauseTimeMS = undefined
        pauseDurationMS = 0    
    }
    
    this.elapsed = function() {
        return timeMS!==undefined ?
            ((pauseTimeMS!==undefined ? pauseTimeMS : Date.now()) - timeMS - pauseDurationMS) : 0
    }
}
		</data><!--TEMP-->
		<data expr="new StopWatchClass()" id="Timer"/>
		<data expr="0" id="iLapElapsed"/>
		<data expr="0" id="iLapCount"/>
	</datamodel>
	<state id="stopWatch" initial="ready">
		<transition event="display">
			<send event="out.display">
				<param expr="FormatTimeStr(Timer.elapsed())" name="ElapsedMS"/>
				<param expr="FormatTimeStr(Timer.elapsed() - iLapElapsed)" name="LapMS"/>
				<param expr="iLapCount" name="LapCount"/>
			</send>
		</transition>
		<state id="ready">
			<onentry>
				<script>iLapElapsed = 0
iLapCount = 0
				</script>
				<raise event="display"/>
			</onentry>
			<transition event="button.1" target="active">
				<script>Timer.start()</script>
			</transition>
		</state>
		<state id="active">
			<transition event="button.1" target="pause">
				<script>Timer.suspend()</script>
			</transition>
			<state id="generator">
				<onentry>
					<raise event="display"/>
					<send delayexpr="i_UPDATE_DELAY_MS + 'ms'" event="update" id="ID.update"/>
				</onentry>
				<onexit>
					<cancel sendid="ID.update"/>
				</onexit>
				<transition event="update" target="generator"/>
				<transition event="button.2" target="generator">
					<script>iLapElapsed = Timer.elapsed()
iLapCount++
					</script>
				</transition>
			</state>
		</state>
		<state id="pause">
			<onentry>
				<raise event="display"/>
			</onentry>
			<transition event="button.1" target="active">
				<script>Timer.resume()</script>
			</transition>
			<transition event="button.2" target="ready">
				<script>Timer.reset()</script>
			</transition>
		</state>
	</state>
</scxml>
```

---

| [TOP](#top-anchor) | [Contents](#table-of-contents) | [Overview](#scxml-overview) | [Examples](Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|---|
