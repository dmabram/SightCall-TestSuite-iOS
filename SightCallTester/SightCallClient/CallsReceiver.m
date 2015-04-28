//
//  CallsReceiver.m
//  SightCallClient
//
//  Created by Ihawk on 4/24/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "CallsReceiver.h"
#import "RtccCallManager_Protected.h"
#import "CallManager.h"

@implementation CallsReceiver
- (void)onCallManagerStopped:(id<CallManager>)cm{
	[super onCallManagerStopped:cm];	
//	[self.cm start];
}

@end
