//
//  FlurryUtility.m
//  PacifyPatient
//
//  Created by Ihawk Masslight. All rights reserved.
//

#import "Log.h"

static NSString * logString = @"";
static NSString * rtccLogString = @"";
static NSString * statsLogString = @"";

@implementation Log

+ (NSURL *)applicationDocumentsDirectory {
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
												   inDomains:NSUserDomainMask] lastObject];
}

+(NSString*)reportFileName{
	return @"report.txt";
}

+(NSString*)reportFilePath{
	return [[self applicationDocumentsDirectory].path
			stringByAppendingPathComponent:[self reportFileName]];
	
}

+(NSString*)fullLog{
	return logString;
}

+(NSString*)rtccLog{
	return rtccLogString;
}

+(void)initialize{
	if([[NSFileManager defaultManager] fileExistsAtPath:[self reportFilePath]]){
		NSError * error;
		logString = @"Crash Report\n";
		logString = [NSString stringWithContentsOfFile:[self reportFilePath]
								  encoding:NSUTF8StringEncoding
									 error:&error];
		logString = [NSString stringWithFormat:@"%@\n---------------------------\n---------------------------\n", logString];
		if(error){
			NSString * message = [NSString stringWithFormat:@"Failed to read crash report file: %@", error];

			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
		}
		
		[[NSFileManager defaultManager] removeItemAtPath:[self reportFilePath] error:&error];
		if(error){
			NSString * message = [NSString stringWithFormat:@"Failed to delete crash report file: %@", error];
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
		}
		
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Crash report" message:@"App crashed at previous run. Look at Logs page for details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];

	}
}

+(void)saveReport{
	NSString *path = [[self applicationDocumentsDirectory].path
					  stringByAppendingPathComponent:[self reportFileName]];
	NSError * error;
	NSString * message = [NSString stringWithFormat:@"%@ \n --------------Rtcc Log--------\n %@", logString, rtccLogString];
	[message writeToFile:path atomically:YES
				   encoding:NSUTF8StringEncoding error:&error];
	if(error){
		NSLog(@"Failed to save rash report: %@", error);
	}

}

+(void)logMessage:(NSString*)message{
	
	NSString * msg = [self rtccStateMessage];
	NSLog(@">>> %@", msg);
	logString = [NSString stringWithFormat:@"%@\n%@", logString, msg];
	[[NSNotificationCenter defaultCenter] postNotificationName:[self onMessageNotificationName] object:msg];
	
	NSLog(@">>> %@", message);
	logString = [NSString stringWithFormat:@"%@\n%@", logString, message];
	[[NSNotificationCenter defaultCenter] postNotificationName:[self onMessageNotificationName] object:message];
}

+(void)logCString:(const char*)eventNameCString params:(NSString*)format, ...{
	
	NSString * eventName = [NSString stringWithCString:eventNameCString encoding:NSUTF8StringEncoding];
	
	va_list args;
	va_start(args, format);
	NSString *argsString = [[NSString alloc] initWithFormat: format
												  arguments: args];
	va_end(args);

	NSString * message = [NSString stringWithFormat:@"%@ %@", eventName, argsString];
	[self logMessage:message];
}

+(void)logCString:(const char*)eventNameCString{
	
	NSString * eventName = [NSString stringWithCString:eventNameCString encoding:NSUTF8StringEncoding];
	
	[self logMessage:eventName];
}


+(void)log:(NSString*)eventName params:(NSString*)format, ...{
	
	va_list args;
	va_start(args, format);
	NSString *argsString = [[NSString alloc] initWithFormat: format
												  arguments: args];
	va_end(args);
	
	NSString * message = [NSString stringWithFormat:@"%@ %@", eventName, argsString];
	[self logMessage:message];
}

+(void)log:(NSString*)eventName{
	[self logMessage:eventName];
}

+(void)logException:(NSException*)exception{
	NSString * msg = [NSString stringWithFormat:@"!!!! UNHANDLED EXCEPTION: %@\n Reason:%@\nUserInfo: %@\nCall Stack:\n%@\nReturn Addresses:\n%@\n", [exception description], [exception reason], [exception userInfo], [exception callStackSymbols], [exception callStackReturnAddresses]];
	[self logMessage:msg];
	
	[self saveReport];
}

+(void)logSignal:(int)sig info:(siginfo_t *)info context:(void *)context stackFrames:(NSArray*)stackFrames returnAddresses:(NSArray*)returnAddress{
	NSString * msg = [NSString stringWithFormat:@"!!!! SIGNAL: %@\nCall Stack:\n%@\nReturn Addresses:\n%@\n", @(sig),  stackFrames, returnAddress];
	[self logMessage:msg];
	
	[self saveReport];

}

+(void)errorCString:(const char*)errorNameCString error:(NSError*)error message:(NSString*)format, ...{
	NSString * errorName = [NSString stringWithCString:errorNameCString encoding:NSUTF8StringEncoding];
	
	va_list args;
	va_start(args, format);
	NSString *argsString = [[NSString alloc] initWithFormat: format
												  arguments: args];
	va_end(args);

	NSString * msg = [NSString stringWithFormat:@"Error %@ %@", errorName, argsString];
	[self logMessage:msg];
}

+(void)logRtccLog:(NSString*)message{
	rtccLogString = [NSString stringWithFormat:@"%@\n%@", rtccLogString, message];
	[[NSNotificationCenter defaultCenter] postNotificationName:[self onRtccLogUpdatedNotificationName] object:message];
}

+(void)logStats:(NSString*)format, ...{
	
	va_list args;
	va_start(args, format);
	NSString *statsString = [[NSString alloc] initWithFormat: format
												  arguments: args];
	va_end(args);
	
	statsLogString = [NSString stringWithFormat:@"%@\n%@", statsLogString, statsString];
	[[NSNotificationCenter defaultCenter] postNotificationName:[self onStatsMessageNotificationName] object:statsString];
	NSLog(@"%@", statsString);
}

+(NSString*)onStatsMessageNotificationName{
	return @"onStatsMessageNotification";
}

+(NSString*)statsLog{
	return statsLogString;
}

+(NSString*)rtccStateMessage{
	return
	[NSString stringWithFormat:@">>> Rtcc status: %@, Active Call: %@, Call status: %@",
		  [self rtccStatusName:[[Rtcc instance] currentStatus]],
		  [[Rtcc instance] activeCall],
		  [self rtccCallStatusName:[[[Rtcc instance] activeCall] callStatus]]];
}

+ (NSString*)rtccStatusName:(sdkStatus_t)currentStatus{
	switch(currentStatus){
		case sdkStatus_notConnected:
			return @"notConnected";
		case sdkStatus_connecting:
			return @"Connecting";
		case sdkStatus_connected:
			return @"Connected";
		case sdkStatus_authenticating:
			return @"Authenticating";
		case sdkStatus_authenticated:
			return @"Authenticated";
		case sdkStatus_disconnecting:
			return @"Disconnecting";
		case sdkStatus_networkLoss:
			return @"NetworkLoss";
	}
}

+ (NSString*)rtccCallStatusName:(callStatus_t)currentStatus{
	switch(currentStatus){
		case callStatus_proceeding:
			return @"Proceeding";
		case callStatus_ringing:
			return @"Ring";
		case callStatus_active:
			return @"Active";
		case callStatus_ended:
			return @"Ended";
		case callStatus_paused:
			return @"Paused";
	}
}

+(NSString*)onMessageNotificationName{
	return @"onLogMessageNotification";
}

+(NSString*)onRtccLogUpdatedNotificationName{
	return @"onRtccLogUpdatedNotification";
}

@end
