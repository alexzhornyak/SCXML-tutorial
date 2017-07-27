# [\<transition\>](https://www.w3.org/TR/scxml/#transition)
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
