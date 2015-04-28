//
//  CallReceiver3.m
//  SightCallClient
//
//  Created by Ihawk on 4/27/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "CallReceiver3.h"
#import "RtccCallManager_Protected.h"
#import "CallsTester.h"

@implementation CallReceiver3

+(NSString*)infoMessage{
	return @"onWillStart: reset. onStart: start round. onRinging: pickup. onCallFinished: end round. onStopped: reset. onCallProceeding: resumeCall. ";
}

-(void)onWillStart{
	[super reset];
	[super onWillStart];
}

- (void)onStarted{
	[super onStarted];
	
}

- (void)onStopped{
	[super onStopped];
	[super reset];
	
	//restart receiver
	[super start];
}

- (void)onConnectionLost{
	[super onConnectionLost];
	[self hangupCall];
	[self reset];
	dispatch_async(dispatch_get_main_queue(), ^{
		[self performSelector:@selector(start) withObject:nil afterDelay:4];
	});
}

- (void)onConnectionRepaired{
	[super onConnectionRepaired];
}

- (void)onRinging:(id<CMCall>)call{
	[super onRinging:call];
	[self.tester onRoundStarted];
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
//	[super resumeCall];
}

- (void)onCallFinished:(id<CMCall>)call{
	[super onCallFinished:call];
	[self.tester onRoundEnded];
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
	
}
@end
