//
//  Auth.h
//  SightCallClient
//
//  Created by Ihawk on 4/24/15.
//  Copyright (c) 2015 Masslight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallManager.h"

@interface Auth : NSObject
+ (void)requestTokenFromServer:(NSString*)serverURL userID:(NSString*)userID handler:(void (^)(NSString* token, NSError* error, CMFailureReason reason)) handler ;
@end
