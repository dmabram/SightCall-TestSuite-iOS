//
//  CallReceiver.m
//  SightCallClient
//
//  Created by Ihawk on 4/24/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "CallReceiver1.h"
#import "RtccCallManager_Protected.h"
#import "CallsTester.h"

@implementation CallReceiver1

+(NSString*)infoMessage{
	return @"onWillStart: reset. onStart: start round. onRinging: pickup. onCallFinished: disconnect. onStopped: reset, end round, start. startRound:start ";
}

-(void)onWillStart{
	[super reset];
	[super onWillStart];
}

- (void)onStarted{
	[super onStarted];
	[self.tester onRoundStarted];
}

- (void)onStopped{
	[super onStopped];
	[super reset];
	
	[self.tester onRoundEnded];
	//restart receiver
	[super start];
}

- (void)onConnectionLost{
	[super onConnectionLost];
}

- (void)onConnectionRepaired{
	[super onConnectionRepaired];
}

- (void)onRinging:(id<CMCall>)call{
	[super onRinging:call];
	[self resumeCall];
}

- (void)onCallCreated:(id<CMCall>)call{
	[super onCallCreated:call];
}

- (void)onCallStarted:(id<CMCall>)call{
	[super onCallStarted:call];
}

- (void)onCallProceeding:(id<CMCall>)call{
	[super onCallProceeding:call];
}

- (void)onCallFinished:(id<CMCall>)call{
	[super onCallFinished:call];
	[self disconnect];
}

- (void)onHangupCall:(id<CMCall>)call{
	[super onHangupCall:call];
}

- (void)onError:(NSError*)error
		 reason:(CMFailureReason)reason{
	[super onError:error reason:reason];
}

- (void)onStatusChanged:(sdkStatus_t)status{
	[super onStatusChanged:status];
}

#pragma mark Used by Calls Tester, not by RTCC

- (void)stopCurrentRound:(CallsTester*)tester{
}

- (void)startNextRound:(CallsTester*)tester{
	[super start];
}
@end
