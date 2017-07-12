# \<transition\>
Transitions between states are triggered by events and conditionalized via guard conditions. They may contain executable content, which is executed when the transition is taken.

## 1. Attribute 'event'
A space-separated list of event descriptors.

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
