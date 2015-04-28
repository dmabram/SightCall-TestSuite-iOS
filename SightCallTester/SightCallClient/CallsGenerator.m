//
//  CallsGenerator.m
//  SightCallClient
//
//  Created by Ihawk on 4/24/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "CallsGenerator.h"
#import "RtccCallManager_Protected.h"
#import "CallManager.h"
#import "Log.h"

@interface CallsGenerator()
@property(nonatomic) NSTimeInterval callDuration;
@property(nonatomic) NSTimeInterval delayBeforeNextCall;
@property(nonatomic) NSTimeInterval testDuration;

@end

@implementation CallsGenerator

-(id)initWithManager:(RtccCallManager*)cm
		callDuration:(NSTimeInterval)callDuration
 delayBeforeNextCall:(NSTimeInterval)delayBeforeNextCall
		testDuration:(NSTimeInterval)testDuration
		   contactID:(NSString*)contactID{
	self = [super initWithManager:cm];
	if(self){
		_callDuration = callDuration;
		_delayBeforeNextCall = delayBeforeNextCall;
		_testDuration = testDuration;
		_contactID = contactID;
	}
	return self;
}

-(void)onCallTimeElapsed{
	[self.cm stopCurrentRound:self];
}

-(void)onDelayBeforeNextRoundElapsed{
	[self.cm startNextRound:self];
}

-(void)onRoundEnded{
	[super onRoundEnded];
	NSTimeInterval duration = [[NSDate date] timeIntervalSinceDate:self.startDate];
	if(_testDuration <= duration){
		[Log logStats:@"<<< Test END. Params: Duration = %@, Call Duration = %@, ContactID =%@, CallManager = %@", @(self.testDuration), @(self.callDuration), self.contactID, NSStringFromClass([self.cm class])];
		[Log logStats:@"%@", [self statString]];
	}
	else{
		dispatch_async(dispatch_get_main_queue(), ^{
			[self performSelector:@selector(onDelayBeforeNextRoundElapsed) withObject:nil afterDelay:_delayBeforeNextCall];
		});
	}

}

-(void)resetRound{
	[super resetRound];
	dispatch_async(dispatch_get_main_queue(), ^{
		[NSObject cancelPreviousPerformRequestsWithTarget:self];
	});
}

#pragma mark CMDelegate

- (void)onCallManager:(id<CallManager>)cm startedCall:(id<CMCall>)call{
	[super onCallManager:cm startedCall:call];
	dispatch_async(dispatch_get_main_queue(), ^{
		[self performSelector:@selector(onCallTimeElapsed) withObject:nil afterDelay:_callDuration];
	});
}

@end
