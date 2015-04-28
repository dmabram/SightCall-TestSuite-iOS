# SightCall-TestSuite-iOS
test suite for SightCall iOS frameworks

Test suite allows to generate multiple calls in a row. 
It gathers statistics about lost connections, errors, captures crashes and logs.

Steps to run test:

0. ViewController.h: 
	set Auth server url at line 
		return @"http://My Auth Server";
	set App ID at line
		return @"My App ID"; 
1. Run SightCallClient on first device (Device 1)
1.1. Move to “Responder” tab, select CallReceiver1 (it is default), Press “Start”
2. Run SightCallClient of second device (Device 2)
2.1. Move to “Caller” tab, select CallManager1 (it is default)
2.2. Set how long whole testing will last in seconds: “Test Time”
2.3. Set length of single call: “Call Time”
2.4. Set interval between calls: “Calls Interval” 
2.4. Press “Start”