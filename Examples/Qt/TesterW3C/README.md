# Qt SCXML Tester for checking SCXML compliance
Qt widget-based application that executes [W3C SCXML tests](https://www.w3.org/Voice/2013/scxml-irp/) and custom tests in sequence, and is able to build a report in Markdown format

![Preview](../../../Images/QtScxmlTesterPreview.gif)

# Rules for writing automated Qt SCXML tests
![TestRule1](../../../Images/TestRule_1.png)
![TestRule2](../../../Images/TestRule_2.png)

## 1. Test description
Test **MUST have commented description** as the first comment in XML document or the first comment of XML root [\<scxml\>](../../../Doc/scxml.md) element
> WARNING! Text in comment must be a **valid Markdown text**!

## 2. Top-level [\<final\>](../../../Doc/final.md) state with id 'pass'
Look at the picture above

## 3. Top-level [\<final\>](../../../Doc/final.md) state with id 'fail'
Look at the picture above

## 4. Restriction for stable configuration
We use 5 seconds timeout per stable configuration of the state machine. It means that if your state machine does nothing per 5 seconds it will be marked as failed by timeout.

## 5. Syntax errors and critical SCXML bugs
We validate only tests without XML syntax errors and critical SCXML bugs such as transition deadlock (when two states are connected with empty transitions) etc.
You may previously use either [ScxmlEditor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) which may detect it on the stage of test designing or [uSCXML browser](https://github.com/tklab-tud/uscxml). <br/>
See https://stackoverflow.com/questions/31694832/how-do-i-verify-that-my-scxml-defines-a-valid-state-machine
