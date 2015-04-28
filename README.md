# SightCall-TestSuite-iOS
test suite for SightCall iOS frameworks

Test suite allows to generate multiple calls in a row. 
It gathers statistics about lost connections, errors, captures crashes and logs.

##Steps to run test:

0. ViewController.m:  set Auth server url at line return @"http://My Auth Server";
1. ViewController.m:  set App ID at line	return @"My App ID"; 
2. Run SightCallClient on first device (Device 1)
3. Move to “Responder” tab, select CallReceiver1 (it is default), Press “Start”
4. Run SightCallClient on second device (Device 2)
5. Move to “Caller” tab, select CallManager1 (it is default)
6. Set how long whole testing will last in seconds: “Test Time”
7. Set length of single call: “Call Time”
8. Set interval between calls: “Calls Interval” 
9. Press “Start”
