# [\<transition\>](https://www.w3.org/TR/scxml/#transition)

**[Video version](https://youtu.be/-AtkiRAzRRE)**

Transitions between states are triggered by events and conditionalized via guard conditions. They may contain executable content, which is executed when the transition is taken.

## 1. Attribute 'event'
A space-separated list of event descriptors. Like an event name, an event descriptor is a series of alphanumeric characters (optionally segmented into tokens by the "." character)

### 1.1. Event name not specified
If condition is also not specified, transition will be executed immediately.

![transition - eventless](https://user-images.githubusercontent.com/18611095/28110547-6c42a9a2-66fb-11e7-950a-1ecfe38de867.png)

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="State1">
		<transition target="State2"/>
	</state>
	<state id="State2"/>
</scxml>
```

![2017-07-12 12 11 25](https://user-images.githubusercontent.com/18611095/28110712-e753ce14-66fb-11e7-8020-09b6114887f9.png)

### 1.2. Event name fully case sensitive matched
A transition matches an event if at least one of its event descriptors matches the event's name.

![transition - event name match](https://user-images.githubusercontent.com/18611095/28114420-82ae1088-6709-11e7-9b2c-8ba661f11bd8.png)

```
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

![transition - partial match](https://user-images.githubusercontent.com/18611095/28201126-3c34b4e8-6878-11e7-9f87-6b5be9f74e8b.png)

In this example, a transition will match event names "Step", "Step.Next", "Step.Next.Completed", etc. but would not match events named "Steps.My.Custom", "StepHandler.mistake", etc.

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
