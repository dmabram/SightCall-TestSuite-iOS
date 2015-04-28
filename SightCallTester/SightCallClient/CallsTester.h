//
//  CallsTester.h
//  SightCallClient
//
//  Created by Ihawk on 4/25/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallManager.h"
#import "RtccCallManager.h"

@interface CallsTester : NSObject<CMDelegate, CMCallDelegate>
@property(nonatomic, strong) RtccCallManager * cm;
@property(nonatomic) NSUInteger callsCount;
@property(nonatomic) NSMutableArray * errors; //array of arrays;
@property(nonatomic) NSMutableArray * reasons; //array of arrays;
@property(nonatomic) NSDate * startDate;
@property(nonatomic) NSMutableArray * callErrors;
@property(nonatomic) NSMutableArray * callReasons;
@property(nonatomic) NSUInteger callNetLostsCount;
@property(nonatomic) NSMutableArray * netLosts; //array of NSUInteger;

@property (nonatomic) UIView * inView;
@property (nonatomic) UIView * outView;


-(id)initWithManager:(RtccCallManager*)cm;
-(void)start;
-(NSString*)statString;

-(void)onRoundStarted;
-(void)onRoundEnded;
-(void)resetRound;
@end
