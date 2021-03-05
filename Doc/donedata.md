<a name="top-anchor"/>
  
| [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|

# [\<donedata\>](https://www.w3.org/TR/scxml/#donedata)

**[Video version](https://youtu.be/VOKu7TYXN_s)**

A wrapper element holding data to be returned when a [\<final\>](https://github.com/alexzhornyak/SCXML-tutorial/blob/master/Doc/Introduction.md#final-state) state is entered.

## [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

### [1. Test 294](https://www.w3.org/Voice/2013/scxml-irp/294/test294.txml)
In cases where the SCXML Processor generates a 'done' event upon entry into the final state, it MUST evaluate the donedata elements \<param\> or \<content\> children and place the resulting data in the **\_event.data** field. The exact format of that data will be determined by the datamodel.

![test294](https://user-images.githubusercontent.com/18611095/28512862-522e6104-705c-11e7-9c12-8c13f814d591.png)

| [TOP](#top-anchor) | [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|---|
