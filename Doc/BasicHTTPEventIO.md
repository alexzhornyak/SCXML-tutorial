# [Basic HTTP Event I/O Processor](https://www.w3.org/TR/scxml/#BasicHTTPEventProcessor)
The Basic HTTP Event I/O Processor is intended as a minimal interoperable mechanism for sending and receiving events to and from external components and SCXML 1.0 implementations. Support for the Basic HTTP Event I/O Processor is optional.

## Receiving Events
An SCXML Processor that supports the Basic HTTP Event I/O Processor must accept messages at the access URI as HTTP POST requests (see [RFC 2616](https://www.w3.org/TR/scxml/#HTTP)).

![http_post](https://user-images.githubusercontent.com/18611095/57123153-786f0680-6d89-11e9-9536-fa7ea20569e6.png)

### How to locate HTTP Post Request URL
SCXML Processors that support the BasicHTTP Event I/O Processor must maintain an 'http://www.w3.org/TR/scxml/#BasicHTTPEventProcessor' entry in the **_ioprocessors** system variable. The Processor must maintain a **'location'** field inside this entry whose value holds an address that external entities can use to communicate with this SCXML session using the Basic HTTP Event I/O Processor.

![HttpClient](https://user-images.githubusercontent.com/18611095/57123442-85402a00-6d8a-11e9-8a4a-e4da2e0721b1.png)

```
<scxml datamodel="lua" name="Scxml" version="1.0" xmlns="http://www.w3.org/2005/07/scxml">
	<state id="Server">
		<onentry>
			<log expr="_ioprocessors['http://www.w3.org/TR/scxml/#BasicHTTPEventProcessor'].location" label="_ioprocessors.basichttp.location"/>
		</onentry>
	</state>
</scxml>
```

**Output:**
> [Log] _ioprocessors.basichttp.location: "http://127.0.01:7081/Scxml/basichttp"
>

