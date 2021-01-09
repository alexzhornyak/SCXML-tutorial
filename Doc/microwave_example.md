<a name="top-anchor"/>

| [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../README.md#examples) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |

# [Microwave owen example](https://www.w3.org/TR/scxml/#N11619)

The example below shows the implementation of a simple microwave oven using SCXML.

![microwave_owen](../Images/6%20-%20Microwave%20Owen.gif)

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

| [TOP](#top-anchor) | [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../README.md#examples) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
