# \<state\>
Holds the representation of a state.

![state - atomic](https://user-images.githubusercontent.com/18611095/28104861-bbb59528-66e5-11e7-8141-94691d7dab44.png)

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="StateAtomic"/>
</scxml>
```

## Attribute 'id'
The identifier for this state.

## Attribute 'initial'
The id of the default initial state (or states) for this state.

**Example: 'State1' is specified as initial**

![state - initial 1](https://user-images.githubusercontent.com/18611095/28105233-51cbe67e-66e7-11e7-9c54-faf01ace8496.png)

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Work" initial="State1">
		<state id="State1">
			<onentry>
				<log expr="Hello!" label="State 1"/>
			</onentry>
			<transition event="Step" target="State2"/>
		</state>
		<state id="State2">
			<onentry>
				<log expr="Hello!" label="State 2"/>
			</onentry>
			<transition event="Step" target="State3"/>
		</state>
		<state id="State3">
			<onentry>
				<log expr="Hello!" label="State 3"/>
			</onentry>
			<transition event="Step" target="State1"/>
		</state>
	</state>
</scxml>
```

Output:
> [Log] State 1: "Hello!"

**Example: 'State3' is specified as initial**

![state - initial 2](https://user-images.githubusercontent.com/18611095/28105301-918f4896-66e7-11e7-9ead-d3c70e4543b1.png)

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Work" initial="State3">
		<state id="State1">
			<onentry>
				<log expr="Hello!" label="State 1"/>
			</onentry>
			<transition event="Step" target="State2"/>
		</state>
		<state id="State2">
			<onentry>
				<log expr="Hello!" label="State 2"/>
			</onentry>
			<transition event="Step" target="State3"/>
		</state>
		<state id="State3">
			<onentry>
				<log expr="Hello!" label="State 3"/>
			</onentry>
			<transition event="Step" target="State1"/>
		</state>
	</state>
</scxml>
```

### Warning!
**1. MUST NOT be specified in conjunction with the \<initial\> element.**
![state - initial - warning 1](https://user-images.githubusercontent.com/18611095/28105509-575f14a2-66e8-11e7-8802-accaccf223a5.png)

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Work" initial="State1">
		<state id="State1">
			<onentry>
				<log expr="Hello!" label="State 1"/>
			</onentry>
			<transition event="Step" target="State2"/>
		</state>
		<state id="State2">
			<onentry>
				<log expr="Hello!" label="State 2"/>
			</onentry>
		</state>
		<initial>
			<transition target="State1"/>
		</initial>
	</state>
</scxml>
```

Output:
> Issue (WARNING) at //state[@id="Work"]: State with initial attribute cannot have <initial> child

**2. MUST NOT occur in atomic states.**

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="StateAtomic" initial="StateXXX"/>
</scxml>
```

Output:
> Issue (FATAL) at //state[@id="StateAtomic"]: Initial attribute has invalid target state with id 'StateXXX'

## Atomic state
Has no \<state\>, \<parallel\> or \<final\> children.

![state - atomic](https://user-images.githubusercontent.com/18611095/28104861-bbb59528-66e5-11e7-8141-94691d7dab44.png)

## Compound state
Has \<state\>, \<parallel\>, or \<final\> children (or a combination of these).

![state - compaund - atomic](https://user-images.githubusercontent.com/18611095/28106158-5e12a338-66eb-11e7-8c0b-92637a6275a1.png)

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="StateCompaund">
		<state id="StateAtomic"/>
	</state>
</scxml>
```

## Default initial state
Specified by the 'initial' attribute or \<initial\> element, if either is present. Otherwise it is the state's first child state in document order.

**Example 1**

![state - initial - default](https://user-images.githubusercontent.com/18611095/28106356-3efebcb0-66ec-11e7-801d-fcbc3584d13f.png)

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Work" initial="State2">
		<state id="State1">
			<transition event="Step" target="State2"/>
		</state>
		<state id="State2">
			<onentry>
				<log expr="I am initial!" label="State 1"/>
			</onentry>
			<transition event="Step" target="State1"/>
		</state>
	</state>
</scxml>
```

**Example 2**

![state - initial - default - document order](https://user-images.githubusercontent.com/18611095/28106438-7cc8a240-66ec-11e7-9cf6-9402f8a3edab.png)

```
<scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Work">
		<state id="State1">
			<onentry>
				<log expr="I am initial!" label="State 1"/>
			</onentry>
			<transition event="Step" target="State2"/>
		</state>
		<state id="State2">
			<transition event="Step" target="State1"/>
		</state>
	</state>
</scxml>
```
