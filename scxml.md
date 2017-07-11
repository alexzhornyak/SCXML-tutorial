# \<scxml\>

[Description](https://www.w3.org/TR/scxml/#scxml)

The top-level wrapper element, which carries version information. The actual state machine consists of its children. 

### 1. Initial

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
