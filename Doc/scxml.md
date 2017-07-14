# \<scxml\>

[Description](https://www.w3.org/TR/scxml/#scxml)

The top-level wrapper element, which carries version information. The actual state machine consists of its children. 

### 1. Attribute 'initial'

The id of the initial state(s) for the document. If not specified, the default initial state is the first child state in document order.

  **1.1. The id is not specified**
  
  ![scxml - initial not specified](https://user-images.githubusercontent.com/18611095/28070804-da550da4-6656-11e7-82b7-4d50e7b05a20.png)
  ```
  <scxml name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
  	<state id="Start">
  		<onentry>
	  		<log expr="Hello from 'start'"/>
		  </onentry>
		  <transition target="Work"/>
	  </state>
	  <state id="Work">
		  <onentry>
			  <log expr="Hello from 'work'"/>
		  </onentry>
	  </state>
  </scxml>
  ```
  Output:
  > [Log] "Hello from 'start'"  
  [Log] "Hello from 'work'"
  
  **1.2. The id is specified**
  
  ![scxml - initial specified](https://user-images.githubusercontent.com/18611095/28071346-54b1c212-6658-11e7-9eb0-1ec5363a1f33.png)
  
```
  <scxml initial="Work" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Start">
		<onentry>
			<log expr="Hello from 'start'"/>
		</onentry>
		<transition target="Work"/>
	</state>
	<state id="Work">
		<onentry>
			<log expr="Hello from 'work'"/>
		</onentry>
	</state>
</scxml>
```
Output:
  > Issue (WARNING) at //state[@id="Start"]: State with id 'Start' is unreachable  
  >  [Log] "Hello from 'work'"

### 2. Attribute 'datamodel'
The datamodel that this document requires. "null" denotes the Null datamodel, "ecmascript" the ECMAScript datamodel, and "xpath" the XPath datamodel or other platform-defined values.
![scxml - datamodel](https://user-images.githubusercontent.com/18611095/28104254-cf2e29e2-66e2-11e7-84ff-669b4fde192d.png)

```
<scxml datamodel="lua" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<final id="End">
		<onentry>
			<log expr="string.format(&quot;Datamodel based on [%s]&quot;,_VERSION)"/>
		</onentry>
	</final>
</scxml>
```
Output:
> [Log] "Datamodel based on [Lua 5.3]"

### 3. Attribute 'binding'
The data binding to use.

![scxml - binding](https://user-images.githubusercontent.com/18611095/28104477-e64e97f0-66e3-11e7-922b-93164f933ce3.png)

#### 3.1. Early
When 'binding' is assigned the value "early" (the default), the SCXML Processor must create all data elements and assign their initial values at document initialization time.

```
<scxml datamodel="lua" initial="Step1" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Step1">
		<onentry>
			<log expr="VarA" label="VarA"/>
		</onentry>
		<transition target="Step2"/>
	</state>
	<state id="Step2">
		<datamodel>
			<data expr="1" id="VarA"/>
		</datamodel>
	</state>
</scxml>
```

Output:
> [Log] VarA: 1

#### 3.2. Late
When 'binding' is assigned the value "late", the SCXML Processor must create the data elements at document initialization time, but must assign the specified initial value to a given data element only when the state that contains it is entered for the first time, before any <onentry> markup.

```
<scxml binding="late" datamodel="lua" initial="Step1" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Step1">
		<onentry>
			<log expr="VarA" label="VarA"/>
		</onentry>
		<transition target="Step2"/>
	</state>
	<state id="Step2">
		<datamodel>
			<data expr="1" id="VarA"/>
		</datamodel>
	</state>
</scxml>
```

Output:
> [Log] VarA: nil
