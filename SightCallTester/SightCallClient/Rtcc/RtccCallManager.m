//
//  RtccCallManager.m
//  PacifyProvider
//
//  Created by Ihawk on 4/19/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "RtccCallManager.h"
#import "Log.h"
#import "Auth.h"

@interface RtccCallManager()
@property (nonatomic) NSString *appID;
@property (nonatomic) NSString *authServerURL;

@property (nonatomic) NSString *userID; //The UID we are trying to connect as
@property (nonatomic) NSString *userDisplayName; //the display name to be set after authent

@property (nonatomic) BOOL reconnecting;

@property (nonatomic, weak) id<CMCallDelegate> callDelegate;

@property (nonatomic) NSString * logFilePath;

@end

@implementation RtccCallManager

+(NSString*)infoMessage{
	return @"";
}

#pragma mark CallManager

-(id)initWithAppID:(NSString*)appID
	 authServerURL:(NSString*)authServerURL
			userID:(NSString *)userID
			userDisplayName:(NSString *)userDisplayName{
	NSParameterAssert(appID);
	NSParameterAssert(authServerURL);
	NSParameterAssert(userID);
	NSParameterAssert(userDisplayName);

	self = [super init];
	if(self){
		_appID = appID;
		_authServerURL = authServerURL;
		self.userID = userID;
		self.userDisplayName = userDisplayName;
	}
	return self;
}

- (void)start{
	
	[Log log:[[self class] infoMessage]];
	
	self.callDelegate = nil;
	
	_reconnecting = NO;

	//Reset the SDK everytime to be sure we are disconnected.
	//	[self cleanup];

	[self onWillStart];
	
	//Logs all in in Xcode's debug console
	[Rtcc setLogLevel:logLevel_Info];

	[Log log:@"+[Rtcc RtccWithAppID:andDelegate:error:]" params:@"appID: %@", self.appID];

	//Init the Rtcc layer
	NSError *error = nil;
	[Rtcc RtccWithAppID:_appID andDelegate:self error:&error];
	if (error) {
		[self onError:error
			   reason:CMFailureInitialization];
		return;
	}	
	
	[[Rtcc instance] addObserver:self forKeyPath:@"currentStatus" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	//handles the SDK status changes
	if ([keyPath isEqualToString:@"currentStatus"]) {
		[Log log:@"" params:@"[[Rtcc instance] currentStatus] changed:%@", [Log rtccStatusName:[[Rtcc instance] currentStatus]]];
		[self onStatusChanged:[[Rtcc instance] currentStatus]];
	}
}
//Returns false if call cannot be made due to Rtcc not ready
- (BOOL)call:(NSString *)contactID contactDisplayName:displayName
{
	NSParameterAssert(contactID);
	NSParameterAssert(displayName);
	
	[Log log:@"-[Rtcc createCall:andSetDisplayName:withVideo:]" params:@"contactID: %@, name: %@, withVideo:%@",  contactID, displayName, @(YES)];

	[[Rtcc instance] createCall:contactID
			  andSetDisplayName:displayName
					  withVideo:true];
	return YES;
}

// Returns no if there is no active call
- (void)hangupCall{
	[Log log:@"-[RtccCall hangup]"];
	
	//hangup the call
	[[[Rtcc instance] activeCall] hangup];
	[self onHangupCall:[[Rtcc instance] activeCall]];
}

- (void)resumeCall{
	[Log log:@"-[RtccCall resume]"];
	
	//pickup the call
	[[[Rtcc instance] activeCall] resume];
}

- (RtccCall*)activeCall{
	return [[Rtcc instance] activeCall];
}

- (void)reset {
	[Log log:@"+[Rtcc reset]"];
	[Rtcc reset];
}

- (void)disconnect{	
	if([[Rtcc instance] currentStatus] == sdkStatus_connecting ||
	   [[Rtcc instance] currentStatus] == sdkStatus_connected ||
	   [[Rtcc instance] currentStatus] == sdkStatus_authenticating ||
	   [[Rtcc instance] currentStatus] == sdkStatus_authenticated){
		[Log log:@"-[Rtcc disconnect]"];
		[[Rtcc instance] disconnect];
	}
	
}

#pragma mark - RtccDelegate
- (void)rtccDidConnect:(NSError *)error {
	[Log logCString:__FUNCTION__ params:@"error:%@", error];

	if(error){
		[self onError:error
			   reason:CMFailureCloudConnectionFailed];
		return;
	}
	
	[Auth requestTokenFromServer:[self authServerURL]
						  userID:_userID
						 handler:^(NSString *token, NSError *error, CMFailureReason reason) {
							 if(error){
								 [self onError:error reason:reason];
							 }
							 else{
								 [Log log:@"-[Rtcc authenticateWithUserType:]" params:@"token:%@", token];
								 [[Rtcc instance] authenticateWithUserType:[UserType UserTypeInternalWithToken:token]];
							 }

						 }];

	
}

- (void)rtccDidAuthenticate:(NSError *)error {
	[Log logCString:__FUNCTION__ params:@"error:%@", error];

	if (error) {
		[self onError:error
			   reason:CMFailureCloudAuthFailed];
		return;
	}
	
	[[Rtcc instance] setDisplayName:self.userDisplayName];
	
	if(_reconnecting){
		_reconnecting = NO;
		[self onConnectionRepaired];
	}
	else{
		[self onStarted];
	}
}

- (void)rtccDidDisconnect:(NSError *)error {
	[Log logCString:__FUNCTION__ params:@"error:%@", error];

	if (error) {
		[self onError:error
			reason:CMFailureCloudDisconnectFailed];
		return;
	}
	
	if ([[Rtcc instance] currentStatus] == sdkStatus_networkLoss){
		_reconnecting = YES;
		[self onConnectionLost];
	}
	else if ([[Rtcc instance] currentStatus] == sdkStatus_notConnected){
		[self onStopped];
//		[Rtcc reset];
	}
}

/*This function will be called after a call is created, either by calling a contact or receiving a call.*/
- (void)rtccCallCreated:(RtccCall *)call {
	[Log logCString:__FUNCTION__ params:@"call:%@", call];

	call.audioRoute = route_loudspeaker;
	call.delegate = self;
	[self onCallCreated:call];
}

- (void)rtccCallEnded:(RtccCall*)call withReason:(callEndReason_t)reason{
	[Log logCString:__FUNCTION__ params:@"reason:%ld", (long)reason];
	
	//the call ended (either termination or local hangup), remove the link between the callviews and the RtccCall and clear the UIView layer
	[self onCallFinished:call];
}

- (void)rtccCall:(RtccCall *)call callStatus:(callStatus_t)status {
	[Log logCString:__FUNCTION__ params:@"status:%@(%ld)", [Log rtccCallStatusName:status], (long)status];

	switch (status) {
		case callStatus_proceeding:
			[self onCallProceeding:call];
//			[call resume]; //automatically pick up the call
			break;
		case callStatus_active:
			[self onCallStarted:call];
			break;
		case callStatus_ringing:
			[self onRinging:call];
			break;
		case callStatus_ended:
			//[self onCallFinished:call];
			break;
		default:
			break;
	}
}

- (void)setCallDelegate:(id<CMCallDelegate>)callDelegate
			videoInView:(UIView*)inView
		   videoOutView:(UIView*)outView{
	self.callDelegate = callDelegate;
	
	[Log log:@"-[Rtcc setViewVideoIn:]" params:@"view:%@", inView];
	[[self activeCall] setViewVideoIn:inView];
	[Log log:@"-[Rtcc setViewVideoOut:]" params:@"view:%@", outView];
	[[self activeCall] setViewVideoOut:outView];
}

- (void)resetCallDelegate{
	
	self.callDelegate = nil;
	
	[Log log:@"-[Rtcc setViewVideoIn:]" params:@"view:nil"];
	[[self activeCall] setViewVideoIn:nil];
	[Log log:@"-[Rtcc setViewVideoOut:]" params:@"view:nil"];
	[[self activeCall] setViewVideoOut:nil];
	
}

#pragma mark Protected method for overriding

-(void)onWillStart{
	[Log logCString:__FUNCTION__];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		if([[self delegate] respondsToSelector:@selector(onCallManagerWillStart:)]){
			[[self delegate] onCallManagerWillStart:self];
		}
	});
}

//Connection to Rtcc cloud establihed, as well as after network loss state
- (void)onStarted{
	[Log logCString:__FUNCTION__];

	dispatch_async(dispatch_get_main_queue(), ^{
		if([[self delegate] respondsToSelector:@selector(onCallManagerStarted:)]){
			[[self delegate] onCallManagerStarted:self];
		}
	});
}

- (void)onStopped{
	[Log logCString:__FUNCTION__];
	
	@try { [[Rtcc instance] removeObserver:self forKeyPath:@"currentStatus"]; }
	@catch (NSError *){}
	
	NSString * logFilePath = [[Rtcc instance] createLogfile];
	NSError * error;
	NSString * logString = [NSString stringWithContentsOfFile:logFilePath
										  encoding:NSUTF8StringEncoding
											 error:&error];

	[Log logRtccLog:logString];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		if([[self delegate] respondsToSelector:@selector(onCallManagerStopped:)]){
			[[self delegate] onCallManagerStopped:self];
		}

	});
}

//Connection to Rtcc cloud temporarily lost, waiting for automatic reconnection
- (void)onConnectionLost{
	[Log logCString:__FUNCTION__];

	dispatch_async(dispatch_get_main_queue(), ^{
		if([[self delegate] respondsToSelector:@selector(onCallManagerLostConnection:)]){
			[[self delegate] onCallManagerLostConnection:self];
		}
	});
}

- (void)onConnectionRepaired{
	[Log logCString:__FUNCTION__];

	dispatch_async(dispatch_get_main_queue(), ^{
		if([[self delegate] respondsToSelector:@selector(onCallManagerRepairedConnection:)]){
			[[self delegate] onCallManagerRepairedConnection:self];
		}
	});
}

//On incoming call
- (void)onRinging:(id<CMCall>)call{
	[Log logCString:__FUNCTION__];

	dispatch_async(dispatch_get_main_queue(), ^{
		if([[self delegate] respondsToSelector:@selector(onCallManager: ringing:)]){
			[[self delegate] onCallManager:self ringing:call];
		}
	});
}


- (void)onCallCreated:(id<CMCall>)call{
	[Log logCString:__FUNCTION__];
	dispatch_async(dispatch_get_main_queue(), ^{
		if([[self delegate] respondsToSelector:@selector(onCallManager: startedCall:)]){
			[[self delegate] onCallManager:self createdCall:call];
		}
		
	});

}

//On call established
- (void)onCallStarted:(id<CMCall>)call{
	[Log logCString:__FUNCTION__];

	dispatch_async(dispatch_get_main_queue(), ^{
		if([[self delegate] respondsToSelector:@selector(onCallManager: startedCall:)]){
			[[self delegate] onCallManager:self startedCall:call];
		}

	});
}

- (void)onCallProceeding:(id<CMCall>)call{
	[Log logCString:__FUNCTION__];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		if([[self delegate] respondsToSelector:@selector(onCallManager: proceedingCall:)]){
			[[self delegate] onCallManager:self proceedingCall:call];
		}
	});
}

//On call finished
- (void)onCallFinished:(id<CMCall>)call{
	[Log logCString:__FUNCTION__];

	dispatch_async(dispatch_get_main_queue(), ^{
		if([[self delegate] respondsToSelector:@selector(onCallManager: finishedCall:)]){
			[[self delegate] onCallManager:self finishedCall:call];
		}
	});
}

-(void)onHangupCall:(id<CMCall>)call{
	[Log logCString:__FUNCTION__];

	dispatch_async(dispatch_get_main_queue(), ^{
		if([[self delegate] respondsToSelector:@selector(onCallManager: hangupCall:)]){
			[[self delegate] onCallManager:self hangupCall:call];
		}

	});
}

- (void)onError:(NSError*)error
		 reason:(CMFailureReason)reason{
	[Log logCString:__FUNCTION__ params:@"error:%@, reason:%@", error, stringForReason(reason)];

	dispatch_async(dispatch_get_main_queue(), ^{
		if([[self delegate] respondsToSelector:@selector(onCallManager:error:reason:)]){
			[[self delegate] onCallManager:self
									 error:error
									reason:reason];
		}

	});
}

- (void)onStatusChanged:(sdkStatus_t)status{
	[Log logCString:__FUNCTION__ params:@"status:%@", [Log rtccStatusName:status]];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		if([[self delegate] respondsToSelector:@selector(onCallManager:statusChanged:)]){
			[[self delegate] onCallManager:self
							 statusChanged:status];
		}
		
	});
	
}

- (void)stopCurrentRound:(CallsTester*)tester{
	
}

- (void)startNextRound:(CallsTester*)tester{
	
}


@end


