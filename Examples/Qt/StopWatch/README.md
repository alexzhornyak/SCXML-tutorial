<a name="top-anchor"/>

| [Contents](../../../README.md#table-of-contents) | [Overview](../../../README.md#scxml-overview) | [Examples](../../README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|

# Qt QML SCXML EcmaScript StopWatch
All internal logic is written in SCXML with Ecmascript datamodel

![intro](../../../Images/StopWatchScxml.gif)

```xml
<scxml datamodel="ecmascript" initial="ready" name="ScxmlStopWatch" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<datamodel><!--CONSTS-->
		<data expr="100" id="i_UPDATE_DELAY_MS"/>
	</datamodel><!--GLOBAL FUNCTIONS AND VARS-->
	<script>function FormatTimeStr(ms){// time(ms)
    function pad(number) {
      if (number &lt; 10) {
        return '0' + number;
      }
      return number;
    }  
  
    var time = new Date(ms)
    var days = time.getUTCDate()
    var hours = time.getUTCHours()
    var minutes = time.getUTCMinutes()
    var seconds = time.getUTCSeconds()
    var milliseconds = time.getUTCMilliseconds()    
    
    var t = []
    if (days &gt; 1)
        t.push(pad(days - 1) + 'T')
  
    if (hours &gt; 0 || t.length &gt; 0)
        t.push(pad(hours) + ':')
  
    t.push(pad(minutes) + ':')
    t.push(pad(seconds))
   
    if (milliseconds &gt; 0)
        t.push('.' + (time.getUTCMilliseconds() / 1000).toFixed(3).slice(2, 5))
  
    return t.join('')
}

function StopWatchClass() {
    var timeMS = undefined
    var pauseTimeMS = undefined
    var pauseDurationMS = 0

    this.start = function() {

        this.reset()

        timeMS = Date.now()
    }

    this.suspend = function() {
        pauseTimeMS = Date.now()        
    }

    this.resume = function() {
        pauseDurationMS += Date.now() - pauseTimeMS
        pauseTimeMS = undefined
    }

    this.reset = function() {
        timeMS = undefined
        pauseTimeMS = undefined
        pauseDurationMS = 0    
    }
    
    this.elapsed = function() {
        return timeMS!==undefined ?
            ((pauseTimeMS!==undefined ? pauseTimeMS : Date.now()) - timeMS - pauseDurationMS) : 0
    }
}

var Timer = new StopWatchClass()
var iLapCount = 0
var iLapElapsed = 0
	</script>
	<state id="stopWatch" initial="ready">
		<transition event="display">
			<send event="out.display">
				<param expr="FormatTimeStr(Timer.elapsed())" name="ElapsedMS"/>
				<param expr="FormatTimeStr(Timer.elapsed() - iLapElapsed)" name="LapMS"/>
				<param expr="iLapCount" name="LapCount"/>
			</send>
		</transition>
		<state id="ready">
			<onentry>
				<script>iLapElapsed = 0
iLapCount = 0
				</script>
				<raise event="display"/>
			</onentry>
			<transition event="button.1" target="active">
				<script>Timer.start()</script>
			</transition>
		</state>
		<state id="active">
			<transition event="button.1" target="pause">
				<script>Timer.suspend()</script>
			</transition>
			<state id="generator">
				<onentry>
					<raise event="display"/>
					<send delayexpr="i_UPDATE_DELAY_MS + 'ms'" event="update" id="ID.update"/>
				</onentry>
				<onexit>
					<cancel sendid="ID.update"/>
				</onexit>
				<transition event="update" target="generator"/>
				<transition event="button.2" target="generator">
					<script>iLapElapsed = Timer.elapsed()
iLapCount++
					</script>
				</transition>
			</state>
		</state>
		<state id="pause">
			<onentry>
				<raise event="display"/>
			</onentry>
			<transition event="button.1" target="active">
				<script>Timer.resume()</script>
			</transition>
			<transition event="button.2" target="ready">
				<script>Timer.reset()</script>
			</transition>
		</state>
	</state>
</scxml>
```

| [TOP](#top-anchor) | [Contents](../../../README.md#table-of-contents) | [Overview](../../../README.md#scxml-overview) | [Examples](../../README.md) | [Editor](https://alexzhornyak.github.io/ScxmlEditor-Tutorial/) | [Forum](https://github.com/alexzhornyak/SCXML-tutorial/discussions) |
|---|---|---|---|---|---|

