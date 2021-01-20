<a name="top-anchor"/>

| [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../README.md#examples) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|

# [W3C Examples](https://www.w3.org/TR/scxml/#Examples)
## [1. Language Overview](https://www.w3.org/TR/scxml/#N11608)
This SCXML document gives an overview of the SCXML language and shows the use of its state machine transition flows
![LangOverview](../Images/W3C_LanguageOverview.gif)

## [2. Microwave Example](https://www.w3.org/TR/scxml/#N11619)
The example below shows the implementation of a simple microwave oven using SCXML
![MicrowaveSimple](../Images/6%20-%20Microwave%20Owen.gif)

## [3. Microwave Example (Using parallel)](https://www.w3.org/TR/scxml/#MicrowaveParallel)
The example below shows the implementation of a simple microwave oven using **\<parallel\>** and the SCXML **'In()' predicate**
![MicrowaveParallel](../Images/microwave_owen_parallel.gif)

## [4. Calculator Example](https://www.w3.org/TR/scxml/#N11630)
The example below shows the implementation of a simple calculator in SCXML
![Calculator](https://user-images.githubusercontent.com/18611095/46285473-4774ec00-c584-11e8-9c0a-003b5998fd2e.png)

# [W3C IRP tests](https://www.w3.org/Voice/2013/scxml-irp)

Test|Description|Source|
---|---|---|
[Test 144](raise.md#test-144)|\<raise\>|https://www.w3.org/Voice/2013/scxml-irp/144/test144.txml
[Test 147](if_else_elseif.md#1-test-147)|\<if\>, \<elseif\> 'cond'|https://www.w3.org/Voice/2013/scxml-irp/147/test147.txml
[Test 148](if_else_elseif.md#2-test-148)|\<else\>|https://www.w3.org/Voice/2013/scxml-irp/148/test148.txml
[Test 149](if_else_elseif.md#3-test-149)|\<if\> without else|https://www.w3.org/Voice/2013/scxml-irp/149/test149.txml
[Test 150](foreach.md#1-test-150)|\<foreach\> 'item' not defined|https://www.w3.org/Voice/2013/scxml-irp/150/test150.txml
[Test 151](foreach.md#2-test-151)|\<foreach\> 'index'|https://www.w3.org/Voice/2013/scxml-irp/151/test151.txml
[Test 152](foreach.md#3-test-152)|\<foreach\> illegal 'array' or 'item'|https://www.w3.org/Voice/2013/scxml-irp/152/test152.txml
[Test 153](foreach.md#4-test-153)|\<foreach\> right order|https://www.w3.org/Voice/2013/scxml-irp/153/test153.txml
[Test 155](foreach.md#5-test-155)|\<foreach\> executable content|https://www.w3.org/Voice/2013/scxml-irp/155/test155.txml
[Test 156](foreach.md#6-test-156)|\<foreach\> child eval error|https://www.w3.org/Voice/2013/scxml-irp/156/test156.txml
[Test 172](send.md#1-test-172)|\<send\> 'eventexpr'|https://www.w3.org/Voice/2013/scxml-irp/172/test172.txml
[Test 173](send.md#2-test-173)|\<send\> 'targetexpr'|https://www.w3.org/Voice/2013/scxml-irp/173/test173.txml
[Test 174](send.md#3-test-174)|\<send\> 'typeexpr'|https://www.w3.org/Voice/2013/scxml-irp/174/test174.txml
[Test 175](send.md#4-test-175)|\<send\> 'delayexpr'|https://www.w3.org/Voice/2013/scxml-irp/175/test175.txml
[Test 176](send.md#5-test-176)|\<send\> param|https://www.w3.org/Voice/2013/scxml-irp/176/test176.txml
[Test 178](send.md#6-test-178)|\<send\> param duplicates|https://www.w3.org/Voice/2013/scxml-irp/178/test178.txml
[Test 179](send.md#7-test-179)|\<send\> content|https://www.w3.org/Voice/2013/scxml-irp/179/test179.txml
[Test 183](send.md#8-test-183)|\<send\> 'idlocation'|https://www.w3.org/Voice/2013/scxml-irp/183/test183.txml
[Test 185](send.md#9-test-185)|\<send\> 'delay'|https://www.w3.org/Voice/2013/scxml-irp/185/test185.txml
[Test 186](send.md#10-test-186)|\<send\> evals args|https://www.w3.org/Voice/2013/scxml-irp/186/test186.txml
[Test 187](send.md#11-test-187)|\<send\> session terminates|https://www.w3.org/Voice/2013/scxml-irp/187/test187.txml
[Test 194](send.md#12-test-194)|\<send\> invalid target|https://www.w3.org/Voice/2013/scxml-irp/194/test194.txml
[Test 198](send.md#13-test-198)|\<send\> default type|https://www.w3.org/Voice/2013/scxml-irp/198/test198.txml
[Test 199](send.md#14-test-199)|\<send\> unsupported type|https://www.w3.org/Voice/2013/scxml-irp/199/test199.txml
[Test 200](send.md#15-test-200)|\<send\> SCXML Event I/O|https://www.w3.org/Voice/2013/scxml-irp/200/test200.txml
[Test 201](send.md#16-test-201)|\<send\> Basic HTTP Event I/O|https://www.w3.org/Voice/2013/scxml-irp/201/test201.txml
[Test 207](cancel.md#1-test-207)|\<cancel\> events in same session|https://www.w3.org/Voice/2013/scxml-irp/207/test207.txml
[Test 208](cancel.md#2-test-208)|\<cancel\> delayed events|https://www.w3.org/Voice/2013/scxml-irp/208/test208.txml
[Test 210](cancel.md#3-test-210)|\<cancel\> 'sendidexpr'|https://www.w3.org/Voice/2013/scxml-irp/210/test210.txml
[Test 215](invoke.md#1-test-215)|\<invoke\> 'typeexpr'|https://www.w3.org/Voice/2013/scxml-irp/215/test215.txml
[Test 216](invoke.md#2-test-216)|\<invoke\> 'srcexpr'|https://www.w3.org/Voice/2013/scxml-irp/216/test216.txml
[Test 220](invoke.md#3-test-220)|\<invoke\> 'type'|https://www.w3.org/Voice/2013/scxml-irp/220/test220.txml
[Test 223](invoke.md#4-test-223)|\<invoke\> 'idlocation'|https://www.w3.org/Voice/2013/scxml-irp/223/test223.txml
[Test 224](invoke.md#5-test-224)|\<invoke\> stateid.platformid|https://www.w3.org/Voice/2013/scxml-irp/224/test224.txml
[Test 225](invoke.md#6-test-225)|\<invoke\> unique 'platformid'|https://www.w3.org/Voice/2013/scxml-irp/225/test225.txml
[Test 226](invoke.md#7-test-226)|\<invoke\> pass data to invoked|https://www.w3.org/Voice/2013/scxml-irp/226/test226.txml
[Test 228](invoke.md#8-test-228)|\<invoke\> unique invokeid|https://www.w3.org/Voice/2013/scxml-irp/228/test228.txml
[Test 229](invoke.md#9-test-229)|\<invoke\> 'autoforward'|https://www.w3.org/Voice/2013/scxml-irp/229/test229.txml
[Test 230](invoke.md#10-test-230)|\<invoke\> same fields in autoforwarded|https://www.w3.org/Voice/2013/scxml-irp/230/test230.txml
[Test 232](invoke.md#11-test-232)|\<invoke\> multiple events from child|https://www.w3.org/Voice/2013/scxml-irp/232/test232.txml
[Test 233](finalize.md#1-test-233)|\<finalize\> before event processed|https://www.w3.org/Voice/2013/scxml-irp/233/test233.txml
[Test 234](finalize.md#2-test-234)|\<finalize\> execute first|https://www.w3.org/Voice/2013/scxml-irp/234/test234.txml
[Test 235](invoke.md#14-test-235)|\<invoke\> 'done.invoke.id'|https://www.w3.org/Voice/2013/scxml-irp/235/test235.txml
[Test 236](invoke.md#15-test-236)|\<invoke\> check 'done.invoke.id' last|https://www.w3.org/Voice/2013/scxml-irp/236/test236.txml
[Test 237](invoke.md#16-test-237)|\<invoke\> cancelling the invoked|https://www.w3.org/Voice/2013/scxml-irp/237/test237.txml
[Test 239](invoke.md#17-test-239)|\<invoke\> content or 'src'|https://www.w3.org/Voice/2013/scxml-irp/239/test239.txml
[Test 240](invoke.md#18-test-240)|\<invoke\> param or 'namelist'|https://www.w3.org/Voice/2013/scxml-irp/240/test240.txml
[Test 241](invoke.md#19-test-241)|\<invoke\> param and namelist identically|https://www.w3.org/Voice/2013/scxml-irp/241/test241.txml
[Test 242](invoke.md#20-test-242)|\<invoke\> 'src' and content identically|https://www.w3.org/Voice/2013/scxml-irp/242/test242.txml
[Test 243](invoke.md#21-test-243)|\<invoke\> param 'name' matches data 'id'|https://www.w3.org/Voice/2013/scxml-irp/243/test243.txml
[Test 244](invoke.md#22-test-244)|\<invoke\> namelist matches data 'id'|https://www.w3.org/Voice/2013/scxml-irp/244/test244.txml
[Test 245](invoke.md#23-test-245)|\<invoke\> param, namelist mismatch|https://www.w3.org/Voice/2013/scxml-irp/245/test245.txml
[Test 247](invoke.md#24-test-247)|\<invoke\> 'done.invoke.id'|https://www.w3.org/Voice/2013/scxml-irp/247/test247.txml
[Test 250](invoke.md#25-test-250)|\<invoke\> onexit handlers in invoked|https://www.w3.org/Voice/2013/scxml-irp/250/test250.txml
[Test 252](invoke.md#26-test-252)|\<invoke\> not process after cancel|https://www.w3.org/Voice/2013/scxml-irp/252/test252.txml
[Test 253](invoke.md#27-test-253)|\<invoke\> type 'scxml'|https://www.w3.org/Voice/2013/scxml-irp/253/test253.txml
[Test 276](datamodel.md#1-test-276)|\<datamodel\> top-level data elements|https://www.w3.org/Voice/2013/scxml-irp/276/test276.txml
[Test 277](datamodel.md#2-test-277)|\<data\> illegal value|https://www.w3.org/Voice/2013/scxml-irp/277/test277.txml
[Test 279](datamodel.md#3-test-279)|\<data\> early binding|https://www.w3.org/Voice/2013/scxml-irp/279/test279.txml
[Test 280](datamodel.md#4-test-280)|\<data\> late binding|https://www.w3.org/Voice/2013/scxml-irp/280/test280.txml
[Test 286](assign.md#1-test-286)|\<assign\> not valid location|https://www.w3.org/Voice/2013/scxml-irp/286/test286.txml
[Test 287](assign.md#2-test-287)|\<assign\> valid location|https://www.w3.org/Voice/2013/scxml-irp/287/test287.txml
[Test 294](donedata.md#1-test-294)|\<donedata\> evaluate children|https://www.w3.org/Voice/2013/scxml-irp/294/test294.txml
[Test 298](param.md#1-test-298)|\<param\> invalid 'location'|https://www.w3.org/Voice/2013/scxml-irp/298/test298.txml
[Test 343](param.md#2-test-343)|\<param\> evaluation error|https://www.w3.org/Voice/2013/scxml-irp/343/test343.txml
[Test 364](state.md#test-364)|\<state\> 'initial'|https://www.w3.org/Voice/2013/scxml-irp/364/test364.txml
[Test 372](final.md#1-test-372)|\<final\> 'done.state.id'|https://www.w3.org/Voice/2013/scxml-irp/372/test372.txml
[Test 375](onentry.md#1-test-375)|\<onentry\> document order|https://www.w3.org/Voice/2013/scxml-irp/375/test375.txml
[Test 376](onentry.md#2-test-376)|\<onentry\> separate blocks|https://www.w3.org/Voice/2013/scxml-irp/376/test376.txml
[Test 387](history.md#1-test-387)|\<history\> default state|https://www.w3.org/Voice/2013/scxml-irp/387/test387.txml
[Test 388](history.md#4-test-388)|\<history\> states work correctly|https://www.w3.org/Voice/2013/scxml-irp/388/test388.txml
[Test 403.a](transition.md#a-each-transition-in-the-set-is-optimally-enabled-by-e-in-an-atomic-state-in-c)|\<transition\> optimal enablement|https://www.w3.org/Voice/2013/scxml-irp/403/test403a.txml
[Test 403.b](transition.md#b-no-transition-conflicts-with-another-transition-in-the-set)|\<transition\> no conflicts|https://www.w3.org/Voice/2013/scxml-irp/403/test403b.txml
[Test 403.c](transition.md#c-there-is-no-optimally-enabled-transition-outside-the-set-that-has-a-higher-priority-than-some-member-of-the-set)|\<transition\> optimally enabled set|https://www.w3.org/Voice/2013/scxml-irp/403/test403c.txml
[Test 404](transition.md#2-test-404)|\<transition\> exit order|https://www.w3.org/Voice/2013/scxml-irp/404/test404.txml
[Test 405](transition.md#3-test-405)|\<transition\> exec content order|https://www.w3.org/Voice/2013/scxml-irp/405/test405.txml
[Test 406](transition.md#4-test-406)|\<transition\> exec content order|https://www.w3.org/Voice/2013/scxml-irp/406/test406.txml
[Test 487](assign.md#3-test-487)|\<assign\> not valid expression|https://www.w3.org/Voice/2013/scxml-irp/487/test487.txml
[Test 488](param.md#3-test-488)|\<assign\> 'expr' produces an error|https://www.w3.org/Voice/2013/scxml-irp/488/test488.txml
[Test 521](send.md#17-test-521)|\<send\> non-existent target|https://www.w3.org/Voice/2013/scxml-irp/521/test521.txml
[Test 525](foreach.md#7-test-525)|\<foreach\> shallow copy|https://www.w3.org/Voice/2013/scxml-irp/525/test525.txml
[Test 527](content.md#1-test-527)|\<content\> evaluate 'expr'|https://www.w3.org/Voice/2013/scxml-irp/527/test527.txml
[Test 528](content.md#2-test-528)|\<content\> 'expr' produces an error|https://www.w3.org/Voice/2013/scxml-irp/528/test528.txml
[Test 529](content.md#3-test-529)|\<content\> evaluate children|https://www.w3.org/Voice/2013/scxml-irp/529/test529.txml
[Test 530](invoke.md#28-test-530)|\<invoke\> child content|https://www.w3.org/Voice/2013/scxml-irp/530/test530.txml
[Test 550](datamodel.md#5-test-550)|\<data\> assign 'expr'|https://www.w3.org/Voice/2013/scxml-irp/550/test550.txml
[Test 551](datamodel.md#6-test-551)|\<data\> assign child content|https://www.w3.org/Voice/2013/scxml-irp/551/test551.txml
[Test 552](datamodel.md#7-test-552)|\<data\> assign 'src'|https://www.w3.org/Voice/2013/scxml-irp/552/test552.txml
[Test 553](send.md#18-test-553)|\<send\> evaluation error|https://www.w3.org/Voice/2013/scxml-irp/553/test553.txml
[Test 554](invoke.md#29-test-554)|\<invoke\> arguments error|https://www.w3.org/Voice/2013/scxml-irp/554/test554.txml
[Test 570](final.md#2-test-570)|\<final\> 'done.state.id' in parallel|https://www.w3.org/Voice/2013/scxml-irp/570/test570.txml
[Test 579](history.md#2-test-579)|\<history\> default content|https://www.w3.org/Voice/2013/scxml-irp/579/test579.txml
[Test 580](history.md#3-test-580)|\<history\> never ends up part of the configuration|https://www.w3.org/Voice/2013/scxml-irp/580/test580.txml

| [TOP](#top-anchor) | [Contents](../README.md#table-of-contents) | [Overview](../README.md#scxml-overview) | [Examples](../Examples/README.md) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|
