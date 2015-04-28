//
//  RtccCallManager.h
//  PacifyProvider
//
//  Created by Ihawk on 4/19/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "Imports.h"
#import "CallManager.h"

@class CallsTester;

@interface RtccCallManager : NSObject<CallManager, RtccDelegate, RtccCallDelegate>
@property (nonatomic, weak) id<CMDelegate> delegate;
@property (nonatomic, weak) CallsTester * tester;
- (void)stopCurrentRound:(CallsTester*)tester;
- (void)startNextRound:(CallsTester*)tester;
@end

@interface RtccCall(CallManager) <CMCall>
@end