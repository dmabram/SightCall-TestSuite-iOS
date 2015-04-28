//
//  Auth.m
//  SightCallClient
//
//  Created by Ihawk on 4/24/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import "Auth.h"



@implementation Auth
//Request to auth server for token which may be used to access Rtcc cloud
+ (NSURLRequest*)tokenRequestFrom:(NSString*)serverURL userID:(NSString*)userID{
	NSString * urlString = [serverURL stringByAppendingFormat:@"gettoken?uid=%@",userID];
	NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL: [[NSURL alloc] initWithString:urlString]];
	[request setValue:@"Basic bGFiOndpbW8yMDEw" forHTTPHeaderField:@"Authorization"];
	return request;
}

+ (void)requestTokenFromServer:(NSString*)serverURL userID:(NSString*)userID handler:(void (^)(NSString* token, NSError* error, CMFailureReason reason)) handler {
	[NSURLConnection sendAsynchronousRequest:[self tokenRequestFrom: serverURL userID:userID] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
		if (connectionError){
			handler(nil, connectionError, CMFailureAuthServerUnavailable);
		}
		else{
			NSError * parseError;
			NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data
																		  options:NSJSONReadingMutableContainers
																			error:&parseError];
			if (parseError){
				handler(nil, parseError, CMFailureAuthServerInvalidResponse);
			}
			else{
				NSString * token = [result objectForKey:@"token"];//KEY_TOKEN
				handler(token, nil, CMFailureNone);
			}
		}
	}];
}

@end
