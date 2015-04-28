//
//  CallsTester.m
//  SightCallClient
//
//  Created by Ihawk on 4/25/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "CallsTester.h"
#import "RtccCallManager_Protected.h"
#import "CallManager.h"
#import "Log.h"

@implementation CallsTester

-(id)initWithManager:(RtccCallManager*)cm{
	self = [super init];
	if(self){
		_cm = cm;
		_cm.tester = self;
	}
	return self;
}

-(void)start{
	NSLog(@"<<< START Test with manager %@", NSStringFromClass([_cm class]));
	_startDate = [NSDate date];
	_callsCount = 0;
	_errors = [NSMutableArray array];
	_reasons = [NSMutableArray array];
	_netLosts = [NSMutableArray array];
	_callErrors = [NSMutableArray array];
	_callReasons = [NSMutableArray array];
	_callNetLostsCount = 0;
	
	_cm.delegate = self;
	[_cm start];
}

-(NSString*)statString{
	NSString * statString = @"";
	statString = [NSString stringWithFormat:@"%@ Start Date: %@\n", statString, _startDate];
	statString = [NSString stringWithFormat:@"%@ Calls: %@\n", statString, @(_callsCount)];
	for(int i = 0; i < _callsCount; i++){
		NSArray * callErrors = [_errors objectAtIndex:i];
		NSArray * callReasons = [_reasons objectAtIndex:i];
		NSNumber * callNetLostsNumber = [_netLosts objectAtIndex:i];
		statString = [NSString stringWithFormat:@"%@ %@) errors: %@, losts: %@\n", statString, @(i), @([callErrors count]), callNetLostsNumber];
		for(int k = 0; k < [callErrors count]; k++){
			NSError * error = [callErrors objectAtIndex:k];
			CMFailureReason reason = [(NSNumber*)[callReasons objectAtIndex:k] unsignedIntegerValue];
			statString = [NSString stringWithFormat:@"%@        %@: %@\n", statString, stringForReason(reason), error];
		}
	}
	return statString;
}

-(void)onRoundStarted{
	NSLog(@"<<< Round #%@", @(_callsCount));
	_callErrors = [NSMutableArray array];
	_callReasons = [NSMutableArray array];
	_callNetLostsCount = 0;
}

-(void)onRoundEnded{
	
	NSLog(@"<<< Round #%@ STAT: ", @(_callsCount));
	[Log logStats:@"Errors: %@, losts: %@", @([_callErrors count]), @(_callNetLostsCount)];
	for(int k = 0; k < [_callErrors count]; k++){
		NSError * error = [_callErrors objectAtIndex:k];
		CMFailureReason reason = [(NSNumber*)[_callReasons objectAtIndex:k] unsignedIntegerValue];
		[Log logStats:@"       %@: %@", stringForReason(reason), error];
	}
	
	[_reasons addObject:_callReasons];
	[_errors addObject:_callErrors];
	[_netLosts addObject:@(_callNetLostsCount)];
	
	_callsCount++;
}

-(void)resetRound{
	
}

#pragma mark CMDelegate

- (void)onCallManagerStarted:(id<CallManager>)cm{
//	NSLog(@"<<< #%@: Round Manager Started ", @(_callsCount));
}

- (void)onCallManagerStopped:(id<CallManager>)cm{
	
}

- (void)onCallManager:(id<CallManager>)cm
		  createdCall:(id<CMCall>)call{
//	NSLog(@"<<< #%@: Round  CREATED", @(_callsCount));
}

- (void)onCallManager:(id<CallManager>)cm startedCall:(id<CMCall>)call{
//	NSLog(@"<<< #%@: CALL  ACTIVE", @(_callsCount));
	[_cm setCallDelegate:nil videoInView:_inView videoOutView:_outView];
}

- (void)onCallManager:(id<CallManager>)cm finishedCall:(id<CMCall>)call{
//	NSLog(@"<<< #%@: CALL  FINISHED: ", @(_callsCount));
}
//
//- (void)onCallManagerStopped:(id<CallManager>)cm{
//}

- (void)onCallManagerLostConnection:(id<CallManager>)cm{
	_callNetLostsCount++;
}

- (void)onCallManager:(id<CallManager>)cm error:(NSError *)error reason:(CMFailureReason)failure{
	[_callErrors addObject:error];
	[_callReasons addObject:@(failure)];
}

@end
