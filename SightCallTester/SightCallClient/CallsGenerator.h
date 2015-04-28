//
//  CallsGenerator.h
//  SightCallClient
//
//  Created by Ihawk on 4/24/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RtccCallManager.h"
#import "CallsTester.h"

@interface CallsGenerator : CallsTester
@property(nonatomic) NSString * contactID;
-(id)initWithManager:(RtccCallManager*)cm
		callDuration:(NSTimeInterval)callDuration
 delayBeforeNextCall:(NSTimeInterval)delayBeforeNextCall
		testDuration:(NSTimeInterval)testDuration
		   contactID:(NSString*)contactID;

@end
