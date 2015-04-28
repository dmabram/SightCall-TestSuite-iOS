//
//  WeemoContact.h
//  WeemoSDK
//
//  Created by Charles Thierry on 6/16/14.
//  Copyright (c) 2014 Weemo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Pre declaration to avoid include looping
 */
@class RtccCall;

/**
 *  @brief Represents the data available on any contact present in the related call.
 
	All calls should have at least two RtccContact. One is RtccCall::myself, the other is the remote contact.
 */
@interface RtccContact : NSObject

/**
 The call in which this contact exists.
 */
@property (nonatomic, readonly, weak) RtccCall *relatedCall;

/**
 The contact display name.
 */
@property (nonatomic, readonly) NSString *displayName;

/**
 The contact UID. This value is immutable during call.
 */
@property (nonatomic, readonly) NSString *UID;

/**
 The contact number in the call. This value is immutable during a call.
 */
@property (nonatomic, readonly) NSNumber *contactID;

#pragma mark - Video in
/** @name Video Parameters */
/**
 The view in which the call is rendered.
 */
@property (nonatomic, weak) UIView *renderView;

/**
 The video profile
 */
@property (nonatomic) video_profile_t videoInProfile;

/**
 The incoming video size for this contact. Each contact have their own video.
 @sa RtccCall::getVideoInSize is used as a proxy when only one remote contact.
 */
- (CGSize)getVideoInSize;

/** @name Conference Parameters */
/**
 Conference status, can only be set if the user is the conference admin.
 */
@property (nonatomic, getter = isMuted) BOOL muted;

/**
 Conference status, can only be set if the user is the conference admin.
 */
@property (nonatomic, getter = isDeaf) BOOL deaf;

/**
 Conference status.
 */
@property (nonatomic, readonly) BOOL isEmittingVideo;

/**
 Conference status. Any user can set their own.
 */
@property (nonatomic, getter = isHandUp) BOOL handUp;

/**
 Conference status. Set by the conference bridge.
 */
@property (nonatomic, readonly) BOOL isAdmin;

/**
 Conference status. Is the contact on hold.
 */
@property (nonatomic, getter = isOnHold) BOOL onHold;

/**
 Conference status.
 */
@property (nonatomic, readonly) BOOL isTalking;

@end
