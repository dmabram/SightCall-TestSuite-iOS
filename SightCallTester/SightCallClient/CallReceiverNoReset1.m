//
//  CallReceiverNoReset1.m
//  SightCallClient
//
//  Created by Alexander Willingham on 4/27/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "CallReceiverNoReset1.h"
#import "RtccCallManager_Protected.h"

@implementation CallReceiverNoReset1

+(NSString*)infoMessage{
    return @"onRinging: pickup. onCallFinished: disconnect. onStopped: reset";
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
