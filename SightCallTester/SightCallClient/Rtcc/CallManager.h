//
//  CallManager.h
//  PacifyProvider
//
//  Created by Ihawk on 4/19/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "Imports.h"

typedef enum : NSUInteger {
	CMFailureNone,
	CMFailureInitialization,
	CMFailureCloudConnectionFailed,
	CMFailureAuthServerUnavailable,
	CMFailureAuthServerInvalidResponse,
	CMFailureCloudAuthFailed,
	CMFailureCloudDisconnectFailed
} CMFailureReason;

@protocol CallManager;

@protocol CMCall
@property(readonly) NSString *contactUID;
@end

@protocol CMDelegate<NSObject>
@optional

- (void)onCallManagerWillStart:(id<CallManager>)cm;
/**
 Called when connection to Call Cloud established and authenticated
 */
- (void)onCallManagerStarted:(id<CallManager>)cm;
/**
 Called when call manager disconnected from Call Cloud
 */
- (void)onCallManagerStopped:(id<CallManager>)cm;
/**
 Called when connection to Call Cloud is lost, and in progress of reconnection. Reconnect happens automatically
 */
- (void)onCallManagerLostConnection:(id<CallManager>)cm;
/**
 Called on conection reestablished after network loss
 */
- (void)onCallManagerRepairedConnection:(id<CallManager>)cm;
/**
 Called when error encountered
 @param error Error itself.
 @param reason Reason of error
 @param callInProgress Indicates that error happened after call was picked up but before call completed
 */
- (void)onCallManager:(id<CallManager>)cm
				error:(NSError*)error
			   reason:(CMFailureReason)failure;
/**
 Called when someone calls you. Hangup or Pickup expected as a reaction to Ring
 @param call Information about incoming call
 */
- (void)onCallManager:(id<CallManager>)cm
			  ringing:(id<CMCall>)call;

- (void)onCallManager:(id<CallManager>)cm
		  createdCall:(id<CMCall>)call;

/**
 Called when call was successfully pickedup and we are about video/audio exchange
 @param call Information about incoming call
 */
- (void)onCallManager:(id<CallManager>)cm
		  startedCall:(id<CMCall>)call;
/**
 Call was completed due to hangup on one of sides
 @param call Information about incoming call
 */
- (void)onCallManager:(id<CallManager>)cm
		 finishedCall:(id<CMCall>)call;

- (void)onCallManager:(id<CallManager>)cm
		 proceedingCall:(id<CMCall>)call;

/**
 Call completion was initiated by one of sides
 @param call Information about incoming call
 */
-(void)onCallManager:(id<CallManager>)cm
		  hangupCall:(id<CMCall>)call;

-(void)onCallManager:(id<CallManager>)cm
		  statusChanged:(sdkStatus_t)status;

@end

@protocol CMCallDelegate<NSObject>
@optional
- (void)callVideoInSizeDidChange:(CGSize)profile;
- (void)callVideoOutSizeDidChange:(CGSize)size;
- (void)callVideoReceivingDidChange:(BOOL)isReceiving;
- (void)callVideoSendingDidChange:(BOOL)isSending;
- (void)callVideoSourceDidChange:(int)source;
- (void)callAudioSendingDidChange:(BOOL)isSending;
- (void)callStatusDidChange:(int)status;
//- (void)callShareOutbound:(BOOL)isOutbound;
//- (void)callShareInbound:(BOOL)isInbound;
@end

@protocol CallManager <NSObject>
@property (nonatomic, weak) id<CMDelegate> delegate;
//@property (nonatomic, weak) id<CMCallDelegate> callDelegate;
@end

inline static
NSString * stringForReason(CMFailureReason reason){
	switch (reason) {
		case CMFailureInitialization:
			return @"Initialization failed";
		case CMFailureCloudConnectionFailed:
			return @"Cloud connection failed";
		case CMFailureAuthServerUnavailable:
			return @"Auth server unavailable";
		case CMFailureAuthServerInvalidResponse:
			return @"Invalid Auth server response";
		case CMFailureCloudAuthFailed:
			return @"Cloud authentication failed";
		case CMFailureCloudDisconnectFailed:
			return @"Rtcc disconnection failed";
		default:
			return @"None";
	}
}
