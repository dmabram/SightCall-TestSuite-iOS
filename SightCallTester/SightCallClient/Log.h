//
//  FlurryUtility.h
//  PacifyPatient
//
//  Created by Ihawk on 4/22/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Imports.h"

@interface Log : NSObject
+(void)logCString:(const char*)eventNameCString;
+(void)log:(NSString*)eventName params:(NSString*)format, ...;
+(void)logCString:(const char*)eventNameCString params:(NSString*)format, ...;
+(void)log:(NSString*)eventName;
+(void)errorCString:(const char*)errorNameCString error:(NSError*)error message:(NSString*)format, ...;
+ (NSString*)rtccStatusName:(sdkStatus_t)currentStatus;
+ (NSString*)rtccCallStatusName:(callStatus_t)currentStatus;
+(void)logException:(NSException*)exception;
+(void)logSignal:(int)sig info:(siginfo_t *)info context:(void *)context stackFrames:(NSArray*)stackFrames returnAddresses:(NSArray*)returnAddress;
+(void)logRtccLog:(NSString*)message;
+(NSString*)onMessageNotificationName;
+(NSString*)onRtccLogUpdatedNotificationName;
+(NSString*)fullLog;
+(NSString*)rtccLog;
+(void)logStats:(NSString*)format, ...;
+(NSString*)onStatsMessageNotificationName;
+(NSString*)statsLog;
@end
