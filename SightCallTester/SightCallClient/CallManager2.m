//
//  CallManager2.m
//  SightCallClient
//
//  Created by Ihawk on 4/27/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "CallManager2.h"
#import "RtccCallManager_Protected.h"
#import "CallsGenerator.h"

@implementation CallManager2

-(CallsGenerator*)cg{
	return (CallsGenerator*)[super tester];
}

+(NSString*)infoMessage{
	return @"onWillStart: reset. onStart: start round, call. onCallFinished: round Ended. onCallProceeding: resumeCall. StopRound: hangup. StartRound: start round, call";
}

-(void)onWillStart{
	[super reset];
	[super onWillStart];
}

- (void)onStarted{
	[super onStarted];
	[[self cg] onRoundStarted];
	[self call:self.cg.contactID contactDisplayName:self.cg.contactID];
}

- (void)onStopped{
	[super onStopped];
}

- (void)onConnectionLost{
	[super onConnectionLost];
}

- (void)onConnectionRepaired{
	[super onConnectionRepaired];
}

- (void)onRinging:(id<CMCall>)call{
	[super onRinging:call];
}

- (void)onCallCreated:(id<CMCall>)call{
	[super onCallCreated:call];
}

- (void)onCallStarted:(id<CMCall>)call{
	[super onCallStarted:call];
}

- (void)onCallProceeding:(id<CMCall>)call{
	[super onCallProceeding:call];
	[super resumeCall];
}

- (void)onCallFinished:(id<CMCall>)call{
	[super onCallFinished:call];
	[[self cg] onRoundEnded];
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

#pragma mark Used by Calls Generator, not by RTCC

- (void)stopCurrentRound:(CallsTester*)tester{
	[super hangupCall];
}

- (void)startNextRound:(CallsTester*)tester{
	[self.cg onRoundStarted];
	[self call:self.cg.contactID contactDisplayName:self.cg.contactID];
}

@end
