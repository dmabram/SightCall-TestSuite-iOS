//
//  CallManager3.m
//  SightCallClient
//
//  Created by Ihawk on 4/27/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "CallManager3.h"
#import "RtccCallManager_Protected.h"
#import "CallsGenerator.h"


//Result:
/*
[;[fg0,0,255;I:  UCL 28/04-12:19:50:389 +0300: I/NETWORK_MUCL NET_SendVideoPLI: Asking for video KF
	[;[fg255,0,0;[bg220,220,220;E:  UCL 28/04-12:19:58:980 +0300: E/NETWORK_MUCL WARN: recv_atomic len 0, end of readStream
					 [;2015-04-28 12:19:58.983 SightCallClient[844:102413] >>> >>> Rtcc status: NetworkLoss, Active Call: <RtccCall: 0x15038400>, Call status: Active
					   2015-04-28 12:19:58.986 SightCallClient[844:102413] >>>  [[Rtcc instance] currentStatus] changed:NetworkLoss
					   2015-04-28 12:19:58.993 SightCallClient[844:102413] >>> >>> Rtcc status: NetworkLoss, Active Call: <RtccCall: 0x15038400>, Call status: Active
					   2015-04-28 12:19:58.994 SightCallClient[844:102413] >>> -[RtccCallManager onStatusChanged:] status:NetworkLoss
					   [fg255,127,0;[bg220,220,220;W:  UCL 28/04-12:19:58:980 +0300: W/NETWORK_MUCL Network_Read : network disconnected.
									   [;2015-04-28 12:19:59.005 SightCallClient[844:102666] >>> >>> Rtcc status: NetworkLoss, Active Call: <RtccCall: 0x15038400>, Call status: Active
										 2015-04-28 12:19:59.007 SightCallClient[844:102666] >>> -[RtccCallManager rtccDidDisconnect:] error:(null)
										 [fg255,0,0;[bg220,220,220;E:  UCL 28/04-12:19:58:981 +0300: E/NETWORK_MUCL NetworkThread : Can't get frameheader
													   [;2015-04-28 12:19:59.012 SightCallClient[844:102666] >>> >>> Rtcc status: NetworkLoss, Active Call: <RtccCall: 0x15038400>, Call status: Active
														 2015-04-28 12:19:59.020 SightCallClient[844:102666] >>> -[RtccCallManager onConnectionLost]
														 2015-04-28 12:19:59.023 SightCallClient[844:102666] >>> >>> Rtcc status: NetworkLoss, Active Call: <RtccCall: 0x15038400>, Call status: Active
														 2015-04-28 12:19:59.026 SightCallClient[844:102666] >>> -[RtccCall hangup]
														 [fg0,0,255;I:  UCL 28/04-12:19:58:981 +0300: I/NETWORK_MUCL Step CONSTATE_NETWORK_ERROR
														   [;2015-04-28 12:19:59.031 SightCallClient[844:102666] >>> >>> Rtcc status: NetworkLoss, Active Call: <RtccCall: 0x15038400>, Call status: Active
															 2015-04-28 12:19:59.034 SightCallClient[844:102666] >>> -[RtccCallManager onHangupCall:]
															 2015-04-28 12:19:59.038 SightCallClient[844:102666] >>> >>> Rtcc status: NetworkLoss, Active Call: <RtccCall: 0x15038400>, Call status: Active
															 [fg0,0,255;I:  UCL 28/04-12:19:58:981 +0300: I/SM_MUCL ProcessMessage 0x3005
															   [;2015-04-28 12:19:59.042 SightCallClient[844:102666] >>> +[Rtcc reset]
																 [fg0,0,255;I:  UCL 28/04-12:19:58:981 +0300: I/SM_MUCL Msg : MUCL_NETWORKERROR
																   [;[fg0,0,255;I:  UCL 28/04-12:19:58:981 +0300: I/NETWORK_MUCL NET_UpdateConnectionStatus : 0 [2]
																		[;[fg0,0,255;I:  UCL 28/04-12:19:58:982 +0300: I/NETWORK_MUCL NET_UpdateShowtimeNetworkStatus :0 (old showtime:3)
																			 [;[fg0,0,255;I:  UCL 28/04-12:19:58:983 +0300: I/SM_MUCL CBEvent :  1100
																				  [;[fg255,127,0;[bg220,220,220;W:  SDK 28/04-12:19:58:983 +0300: CORE: Disconnected!
																									 [;[fg0,0,255;I:  SDK 28/04-12:19:58:983 +0300: RTCC: Authenticated: NO
																										  [;[fg0,0,255;I:  SDK 28/04-12:19:58:996 +0300: -[AudioStream holdAudio]
																											   [;[fg0,0,255;I:  SDK 28/04-12:19:58:996 +0300: RTCC: Disconnected
																													[;[fg0,0,255;I:  UCL 28/04-12:19:59:031 +0300: I/SM_MUCL ProcessMessage 0x303
																														 [;[fg0,0,255;I:  UCL 28/04-12:19:59:031 +0300: I/SM_MUCL SMSDK_callstatus status: 0x14
																															  [;[fg0,0,255;I:  UCL 28/04-12:19:59:031 +0300: I/SM_MUCL Msg : local emission CALLSTATUS_ENDED
																																   [;[fg0,0,255;I:  SDK 28/04-12:19:59:031 +0300: CORE: AudioCallback: cmd: 0x9104, param: 0
																																		[;[fg0,0,255;I:  SDK 28/04-12:19:59:031 +0300: AUDIO: Stopping the graph.
																																			 [;[fg0,0,255;I:  SDK 28/04-12:19:59:031 +0300: AUDIO: Audio Unit Graph stopped.
																																				  [;[fg0,0,255;I:  UCL 28/04-12:19:59:031 +0300: I/NETWORK_MUCL NET_SendCommandCallControl 2 0 0
																																					   [;[fg255,0,0;[bg220,220,220;E:  UCL 28/04-12:19:59:031 +0300: E/NETWORK_MUCL Network_Write : not connected.
																																										[;[fg0,0,255;I:  UCL 28/04-12:19:59:046 +0300: I/NETWORK_MUCL NET_SendCommandCallControl 2 0 0
																																											 [;[fg255,0,0;[bg220,220,220;E:  UCL 28/04-12:19:59:046 +0300: E/NETWORK_MUCL Network_Write : not connected.
																																															  [;[fg0,0,255;I:  SDK 28/04-12:19:59:046 +0300: Changing the video state from state_stopped to state_stopped
																																																   [;[fg0,0,255;I:  SDK 28/04-12:19:59:047 +0300: RTCC: Authenticated: NO
																																																		[;[fg0,0,255;I:  UCL 28/04-12:19:59:048 +0300: I/AUDIO_MUCL AudioThread stopped
																																																			 [;[fg0,0,255;I:  UCL 28/04-12:19:59:058 +0300: I/MUCL_MUCL MUCL_Destroy : Closing Event CB
																																																				  [;[fg0,0,255;I:  UCL 28/04-12:19:59:059 +0300: I/MUCL_MUCL MUCL_Destroy : Closing Call CB
																																																					   [;[fg0,0,255;I:  UCL 28/04-12:19:59:083 +0300: I/MUCL_MUCL MUCL_Destroy : Closing RPDC CB
																																																							[;[fg0,0,255;I:  UCL 28/04-12:19:59:083 +0300: I/MUCL_MUCL MUCL_Destroy : Stopping Network thread
																																																								 [;[fg0,0,255;I:  UCL 28/04-12:19:59:083 +0300: I/NETWORK_MUCL NetworkThread : Not Connected Manual Unlock
																																																									  [;[fg0,0,255;I:  UCL 28/04-12:19:59:083 +0300: I/NETWORK_MUCL NetworkThread ending
																																																										   [;[fg0,0,255;I:  UCL 28/04-12:19:59:084 +0300: I/MUCL_MUCL MUCL_Destroy : Stopping SM thread
																																																												[;[fg0,0,255;I:  UCL 28/04-12:19:59:084 +0300: I/NETWORK_MUCL NET_UpdateShowtimeMediaStatus :0 (old showtime:2)
																																																													 [;[fg0,0,255;I:  UCL 28/04-12:19:59:084 +0300: I/MUCL_MUCL MUCL_Destroy : Closing SM thread
 */
@implementation CallManager3

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
	[[self cg] resetRound];
	[self hangupCall];
	[self reset];
	dispatch_async(dispatch_get_main_queue(), ^{
		[self performSelector:@selector(start) withObject:nil afterDelay:4];
	});
	
//	[self start];
	
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
//	[super resumeCall];
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
