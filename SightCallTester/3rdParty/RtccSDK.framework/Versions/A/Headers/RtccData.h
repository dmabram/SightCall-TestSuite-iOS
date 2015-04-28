//
//  WeemoData.h
//  iOS-SDK
//
//  Created by Charles Thierry on 7/16/13.
//  Copyright (c) 2013 Weemo. All rights reserved.
//
#include <stdint.h>
#import <AvailabilityMacros.h>

#pragma mark - Call status
/**
 The call possible statuses.
 @since 5.0
 */
typedef NS_ENUM(NSInteger, callStatus_t)
{
	/** The SDK is emitting a call that is not yet picked up.*/
	callStatus_proceeding = 0,
	/** The SDK is receiving a call.*/
	callStatus_ringing,
	/** The call is active.*/
	callStatus_active,
	/** The call ended.*/
	callStatus_ended,
	/** The call is currently paused (not used).*/
	callStatus_paused
};


/**
 The possible states of the SDK.
 @since 5.4
 */
typedef NS_ENUM(NSInteger, sdkStatus_t)
{
	/** The original State. You can try to connect*/
	sdkStatus_notConnected = 0,
	/** The SDK is attempting to connect*/
	sdkStatus_connecting,
	/** The SDK is connected. You can try to authenticate*/
	sdkStatus_connected,
	/** The SDK is attempting an authentication*/
	sdkStatus_authenticating,
	/** The SDK is authenticated*/
	sdkStatus_authenticated,
	/** The SDK is disconnecting*/
	sdkStatus_disconnecting,
	/** The SDK lost its connection. Will attempt to reconnect.*/
	sdkStatus_networkLoss,
};

/**
 The call terminaison reasons.
 @since 5.3
 */
typedef NS_ENUM(NSInteger, callEndReason_t)
{
	/** The call was locally hung up*/
	callEndReason_local = 0,
	/** The call was terminated by the remote*/
	callEndReason_remote,
	/** Reason unknown, most likely an error occured*/
	callEndReason_unknown
};

#pragma mark - Error codes
/**
 Errors returned by the SDK.
 @since 5.0
 */
typedef NS_ENUM(NSInteger, errorCode_t)
{
	/** Generic error code.*/
	errInit_general = 0x100,
	/** An error occured during network verification.*/
	errInit_network,
	/** You tried to register with a suffix account, but the uid did not contain both uid and suffix.*/
	errInit_provision,
	/** The appID you try to use is not availble on the platform.*/
	errInit_badAppID,
	/** You are trying to generate a Rtcc singleton w/o having rested it. Call Rtcc::reset.*/
	errInit_alreadyCreated,
	/** An error occured while you were disconnecting.*/
	errConn_closed = 0x200,
	/** You tried to authenticate without being connected.*/
	errAuth_notConnected = 0x300,
	/** You tried to authenticate while already authenticated.*/
	errAuth_alreadyAuthenticated,
	/** The token you provided is not valid in regard to your appID and uid.*/
	errAuth_badToken,
	/** An error occured while authenticating.*/
	errAuth_sip,
	
	/** Generic meeting point error, admin side. Sent to host delegate. */
	errMP_general = 0x400,
	/** An error occured upon Meeting Point creation. Received by the host and MP delegates. */
	errMP_creation,
	/** An error occured upon Meeting Point deletion. Received by the host delegate. */
	errMP_deletion,
	/** An error occured upon Meeting Point update. Received by the host delegate. */
	errMP_update,
	/** An error occured upon Meeting Point details fetch. Received by the host delegate. */
	errMP_getDetails,
	/** An error occured related to acceptance. If host, setting the MP acceptance failed. If attendee, an error occured when the host accepted or denied your request to enter the waiting room. Sent to host or attendee delegate.*/
	errMP_acceptance,
	/** An error occured where the attendee was invited to an unexisting meeting point. Sent to meeting point delegate.*/
	errMP_invite,
	
	/** An error occured while trying to host the meeting point. Received by the host delegate. */
	errMP_hosting,
	/** Meeting Point: An error occured with your request. Can be received by meeting point, attendee and host delegates. */
	errMP_request
};

/**
 Registration status. A contact already registered may already have a roster.
 @since 5.4
 */

typedef NS_ENUM(NSInteger, registrationUpdate_t)
{
	/** You don't have access to the presence functionality.*/
	registration_notRegistered,
	/** You have access to the presence functionality.*/
	registration_registered,
	/** You have access to the presence functionality, and you are already registered somewhere else.*/
	registration_alreadyRegistered,
};

#pragma mark - log levels

/**
 @brief Log levels used by the Rtcc::setLogLevel:. 
 
 Using Rtcc::setLogLevel: with `logLevel_Warn` will prevent every message whose priority is lower than Warn(ing) to be displayed. This only impacts the logs printed in the Xcode console.
 @since 5.1.49
 */
typedef NS_ENUM(NSInteger, logLevel_t)
{
	/** Will not print a thing in Xcode's debug console.*/
	logLevel_Fatal = 0,
	/** Will print all errors met by the SDK in Xcode's debug console.*/
	logLevel_Error,
	/** Will print the SDK's warning in Xcode's debug console.*/
	logLevel_Warn,
	/** Prints the important things in Xcode's debug console.*/
	logLevel_Notice,
	/** Logs all in in Xcode's debug console.*/
	logLevel_Info
};

/**
 This is used to describe the video Profile returned by the SDK throught the RtccCallDelegate::rtccCall:videoProfile: callback.
 @since 5.1
 */
typedef NS_ENUM(NSInteger,video_profile_t)
{
	/** The video in profile is unknown*/
	profile_unknown = -1,
	/** landscape dimensions lower than 352*288*/
	profile_lowest,
	/** landscape dimensions between 352*280 included and 640*360 excluded*/
	profile_low,
	/** High video profile lanscape dimensions greater or equal to 640*360*/
	profile_high
};

/**
 @brief This is used with Rtcc::createCallWithOptions: as `k_WithAudio` value.
 
 @since 5.3
 */
typedef NS_ENUM(NSInteger,audioMode_t)
{
	/** The call will start as muted (i.e. no audio will be sent) */
	audio_mute,
	/** The call will start as active (i.e. audio will be sent). This is the default mode. */
	audio_active
};


/** 
 Used to set the audio out route you want the incoming audio to take.
 */
typedef NS_ENUM(NSInteger, audioRoute_t)
{
	/** This is the default builtin speaker, or the headset if any is connected.
	 RtccCall::audioRoute returning this value means the SDK is using the builtin ear speaker to play the sound.*/
	route_default,
	/** Set the route to the builtin loudspeaker, overriding any connected headset.
	 RtccCall::audioRoute returning this value means the SDK is using the built in loudpseaker to play the sound.*/
	route_loudspeaker,
	/** Using this value make the sound go through the connected headset or fallbacking to loudspeaker.
	 RtccCall::audioRoute returning this value means the SDK is using the headset to play the sound.*/
	route_headsetOrLoudspeaker
};


/**@brief The type of Meeting point we are creating.
 
 One of mpType_t. value is a NSNumber.*/
#define k_MPType		@"MeetingPointType"
/**@brief Where the meeting will take place.
 
 Value is a NSString, max 128 long.*/
#define k_MPLocation	@"MeetingPointLocation"		
/**@brief The meeting's "human" name. 
 
 Value is a NSString, max 128 long.*/
#define k_MPTitle		@"MeetingPointTitle"
/**@brief The meeting's "system" name.
 Value is a NSString, max 128 long.*/
#define	k_MPID			@"MeetingPointID"
/**@brief Time at which the meeting will start.
 
 Value is a NSDate.*/
#define k_MPStart		@"MeetingPointStartTime"
/**@brief Time at which the meeting will end.
 
 Value is a NSDate.*/
#define	k_MPEnd			@"MeetingPointEndTime"

/**@brief The Attendee wall URL.
 
 Value is a NSString.*/
#define k_MPURLAttendee	@"MeetingPointURLAttendee"
/**@brief The Host wall URL.
 
 Value is a NSString. */
#define k_MPURLHost		@"MeetingPointURLHost"

/**@brief The display name of the contact related to the action.*/
#define k_MPDisplayName	@"MeetingPointDisplayName"
/**@brief The "system" name of the contact related to the action.*/
#define k_MPContactName	@"MeetingPointContactName"


//call creation options
/**@brief Used in conjonction with Rtcc::createCallWithOptions:.
 
 The UID of the contact to call. Expects a NSString. Mandatory.*/
#define k_ContactID		@"contactID"
/**@brief Used in conjonction with Rtcc::createCallWithOptions:.
 
 The display name of the contact to call. Expects a NSString. Mandatory.*/
#define k_ContactDN		@"contactDisplayName"
/**@brief Used in conjonction with Rtcc::createCallWithOptions:.
 
 Should the call start with video enabled? To set, use [NSNumber numberWithBool:]. (Default: YES) */
#define k_WithVideo		@"withVideo"
/**@brief Used in conjonction with Rtcc::createCallWithOptions:.
 
 \@"md" to start in MD, \@"sd" to start in a lower definition (default \@"sd") */
#define k_VideoStartProfile	@"videoStartProfile"
/**@brief Used in conjonction with Rtcc::createCallWithOptions:.
 
 Should the call start with audio enabled? To set, use [NSNumber numberWithInt:] and a audioMode_t value. (Default: audio_active) */
#define k_WithAudio		@"withAudio"
/**@brief Used in conjonction with Rtcc::createCallWithOptions:.
 
 Set the video source. To set, use [NSNumber numberWithInt:]. 1 for rear camera, 0 for front. (Default: 0)*/
#define k_VideoSource	@"videoSource"
/**@brief Used in conjonction with Rtcc::createCallWithOptions:.
 
 Set the audio route. To set, use [NSNumber numberWithInt:]. 1 to start with the loudspeaker. 0 otherwise. (Default: 1)*/
#define k_AudioRoute	@"audioRoute"

/**
 The possible types of meeting points, to be used as `Type` in Rtcc::meetingPointCreateWithTitle:atLocation:startDate:endDate:withType:
 @since 5.3
 */
typedef NS_ENUM(NSInteger,mpType_t)
{
	/** Used to create a meeting point. This creates a permanent MP.*/
	mpType_permanent = 0,
	/** Used to create a meeting point. This creates a scheduled MP.*/
	mpType_scheduled,
	/** Used to create a meeting point. Not supported yet.*/
	mpType_adHoc

};

/**
 The authorization you set for a meeting point you created.
 @since 5.3
 */
typedef  NS_ENUM(NSInteger,mpAuthorizationMode_t)
{
	/** The default authorization mode. You will be notifed and will have to accept/deny every contact trying to join.*/
	mpSta_default = 0,
	/** Autoaccept authorization mode. Everyone will be able to enter your meeting room without you being notified by callback.*/
	mpSta_autoaccept,
	/** Autodeny everyone. No one will be allowed to join the meeting point, and you will not be notified of someone trying.*/
	mpSta_autodeny
};


/**
 You asked to join a conference, this is the answer you'll get.
 @since 5.3
 */
typedef  NS_ENUM(NSInteger, mpAttendeeStatus_t)
{
	/** Your request is still pending.*/
	mpAtt_pending,
	/** Your request was granted.*/
	mpAtt_accepted,
	/** Your request was denied.*/
	mpAtt_denied
};


#pragma mark - User type

/**
 User profiles. Used during authentication.
 @since 5.3
 */
typedef NS_ENUM(NSInteger, userProfile_t)
{
	/** The data set doesn't define a specific user type.*/
	userInvalid = -1,
	/** The user is internal - the "normal" user profile that allow the user to call someone from their contact list.*/
	userInternal = 0,
	/** The user is external - a profile in which the user can only log in when its parent is already logged in (i.e. a client contacting an agent).*/
	userExternal,
	/** The call is using the suffix handling.*/
	userSuffix,
	/** The user tries to log in to place a 6 digits calls*/
	user6Digits = 6
};

/**
 UserType is used to authenticate a user based on the provided data.
 @since 5.5
 */
@interface UserType: NSObject
/**
 *  Generate a UserType set for external authentication.
 *
 *  @param parentUID The UID of the parent. The parent must be logged in when the external user is trying to log in.
 *
 *  @return A UserType to be used in Rtcc::authenticateWithUserType:
 */
+ (instancetype)UserTypeExternalWithParentID:(NSString *)parentUID;
/**
 *  Generate a UserType set for internal authentication.
 *
 *  @param token The token generated to authenticate the user.
 *
 *  @return A UserType to be used in Rtcc::authenticateWithUserType:
 */
+ (instancetype)UserTypeInternalWithToken:(NSString *)token;
/**
 *  Generate a UserType set for six digits authentication.
 *
 *  @param sixDigits The sixdigit code generated by the parent.
 *
 *  @return A UserType to be used in Rtcc::authenticateWithUserType:
 */
+ (instancetype)UserTypeSixDigitsWithPIN:(NSString *)sixDigits;

/**
 *  Generate a UserType set for attendee authentication.
 *
 *  @param suffix    This is the hash with which the system recognize an already authenticated user.
 *  @param userhash  This is the hash with which the system recognize an already authenticated user.
 *  @param uid       This is the UID of the host.
 *  @param mpid      This is the ID of the Meeting Point.
 *
 *  @return A UserType to be used in Rtcc::authenticateWithUserType:
 */
+ (instancetype)UserTypeAttendeeWithUID:(NSString *)uid suffix:(NSString *)suffix mpID:(NSString*)mpid andUserhash:(NSString *)userhash;



/**
 @brief This value is computed depending on the field sets.
 
 If it turns to be invalid, authentication will not take place.
 @since 5.5
 */
@property (nonatomic, readonly)userProfile_t currentProfile;

/**
 @brief External User. Set only this field.
 
 This is the parent UID of the external user. The parent must be logged in when the external user is trying to log in.
 @since 5.5
 */
@property (nonatomic) NSString *parentUID;
/**
 @brief Internal User. Set only this field.
 
 This is the token generated to authenticate the user.
 @since 5.5
 */
@property (nonatomic) NSString *token;

/**
 @brief SixDigits User. Set only this field.
 
 This is the sixdigit code generated by the parent.
 @since 5.5
 */
@property (nonatomic) NSString *sixDigits;

/**
 @brief Attendee User. This is one of the four fields to set.
 
 This is the suffix used by the system to recognized the user as attendee.
 @since 5.5
 @sa userType::userhash
 @sa userType::uid
 @sa userType::mpid
 */
@property (nonatomic) NSString *suffix;
/**
 @brief Attendee User. This is one of the four fields to set.

 This is the hash with which the system recognize an already authenticated user.
 @since 5.5
 @sa userType::suffix
 @sa userType::uid
 @sa userType::mpid
 */
@property (nonatomic) NSString *userHash;
/**
 @brief Attendee User. This is one of the four fields to set.
 
 This is the UID of the host.
 @since 5.5
 @sa userType::suffix
 @sa userType::userhash
 @sa userType::mpid
 */
@property (nonatomic) NSString *uid;
/**
 @brief Attendee User. This is one of the four fields to set.
 
 This is the ID of the Meeting Point.
 @since 5.5
 @sa userType::suffix
 @sa userType::userhash
 @sa userType::uid
 */
@property (nonatomic) NSString *mpid;



@end
