//
//  RtccCallManager_Protected.h
//  PacifyProvider
//
//  Created by Ihawk on 4/19/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "RtccCallManager.h"

@interface RtccCallManager ()
-(NSString*)infoMessage;
- (id<CMCall>)activeCall;

-(id)initWithAppID:(NSString*)appID
	 authServerURL:(NSString*)authServerURL
			userID:(NSString *)userID
			userDisplayName:(NSString *)userDisplayName;

- (void)start;
- (void)reset;
- (void)disconnect;

- (BOOL)call:(NSString *)contactID contactDisplayName:displayName;
- (void)hangupCall;
- (void)resumeCall;
- (void)setCallDelegate:(id<CMCallDelegate>)callDelegate
			videoInView:(UIView*)inView
		   videoOutView:(UIView*)outView;
- (void)resetCallDelegate;

- (NSString*)logFilePath;

-(void)onWillStart;
- (void)onStarted;
- (void)onStopped;
- (void)onConnectionLost;
- (void)onConnectionRepaired;
- (void)onRinging:(id<CMCall>)call;
- (void)onCallCreated:(id<CMCall>)call;
- (void)onCallStarted:(id<CMCall>)call;
- (void)onCallProceeding:(id<CMCall>)call;
- (void)onCallFinished:(id<CMCall>)call;
- (void)onHangupCall:(id<CMCall>)call;
- (void)onError:(NSError*)error
		 reason:(CMFailureReason)reason;
- (void)onStatusChanged:(sdkStatus_t)status;
@end
