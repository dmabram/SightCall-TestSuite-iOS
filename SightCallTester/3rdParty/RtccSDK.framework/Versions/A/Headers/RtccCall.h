//
//  WeemoCall.h
//  iOS-SDK
//
//  Created by Charles Thierry on 7/16/13.
//  Copyright (c) 2013 Weemo. All rights reserved.
//
#include "RtccData.h"

@class RtccContact;

/**
 @brief Delegate for the RtccCall Singleton.
 
 Allows the Host Application to be notified upon events. All functions are optionals.
 @since 5.0
 */
@protocol RtccCallDelegate <NSObject>
@optional
/**
 @brief Called when the call starts or stops receiving video.
 @param sender The RtccCall which property changed.
 @param isReceiving Answers "Are we receing video?".
 @sa RtccCall::receivingVideo
 @since 5.0
 */
- (void)rtccCall:(id)sender videoReceiving:(BOOL)isReceiving;

/**
 @brief Called when the SDK receives cursor coordinates in the share view.
 
 This location is in percent, between 0 and 99 (width%, height%). If the cursor is out of the view, location is -1x-1.
 @param sender The RtccCall which property changed.
 @param location The inbound video cursor location. If -1x-1, the remote's cursor is not over the share view.
 @since 5.3
 */
- (void)rtccCall:(id)sender cursorLocationInShare:(CGPoint)location;

/**
 @brief Called when the SDK receives a cursor click event.
 
 This location is in percent, between 0 and 99 (width%, height%). If the cursor is out of the view, location is -1x-1.
 
 @param sender The RtccCall which property changed.
 @param action The type of action sent by the remote. 0 is cursor location, 1 is drawing (a.k.a. connects the dots) and 2 is drop (a predefined form is to be drawn at the coordinates).
 @param location The inbound cursor location. If -1x-1, the remote's cursor is not over the share view.
 @since 5.3
 */
- (void)rtccCall:(id)sender cursorClick:(int)action onShareInAt:(CGPoint)location;

/**
 @brief Fired when the SDK starts or stops receiving share data.
 @param sender The RtccCall which property changed.
 @param isReceiving Answers "Are we receiving share data?".
 @since 5.1
 */
- (void)rtccCall:(id)sender shareReceiving:(BOOL)isReceiving;

/**
 @brief Called when the call starts or stops sending video.
 @param sender The RtccCall which property changed.
 @param isSending Answers "Are we sending video?".
 @sa RtccCall::sendingVideo
 @since 5.0
 */
- (void)rtccCall:(id)sender videoSending:(BOOL)isSending;

/**
 @brief Fired when the SDK starts or stops sending share data.
 @param sender The RtccCall which property changed.
 @param isSending Answers "Are we sending share data?".
 @sa RtccCall::sendingShare
 @since 5.1
 */
- (void)rtccCall:(id)sender shareSending:(BOOL)isSending;


/**
 @brief Fired when the video capture is paused or resumed.
 @param sender The RtccCall which property changed.
 @param pauseDidStart Answers "Is the video output paused?".
 @sa RtccCall::videoPaused
 */
- (void)rtccCall:(id)sender videoPause:(BOOL)pauseDidStart;

/**
 @brief Called when the incoming video profile changes.
 
 Use this method to know when the video incoming size/profile changes.
 @param sender The RtccCall which property changed.
 @param profile The new profile used by the incoming video. Can be `profile_unknown`.
 @sa RtccCall::videoInProfile
 @sa RtccCall::getVideoInSize
 @since 5.0
 @deprecated Since 5.3 - Replaced by the RtccCallDelegate::rtccCall:videoInSizeChange:. Names sanitization effort.
 */
- (void)rtccCall:(id)sender videoProfile:(video_profile_t)profile __attribute__ ((unavailable("Please use rtccCall:videoInSizeChange:")));


/**
 @brief Called when the incoming video profile changes.
 
 Use this method to know when the video incoming size/profile changes.
 @param sender The RtccCall which property changed.
 @param size The new profile used by the incoming video. Can be CGSizeZero.
 @sa RtccCall::videoInProfile
 @sa RtccCall::getVideoInSize
 @since 5.1
 */
- (void)rtccCall:(id)sender videoInSizeChange:(CGSize)size;


/**
 @brief Called when the incoming video profile changes.
 
 Use this method to know when the video incoming size/profile changes.
 @param sender The RtccCall which property changed.
 @param profile The new profile used by the incoming video. Can be CGSizeZero.
 @param contact The contact whose video in changed.
 @sa RtccCall::videoInProfile
 @sa RtccCall::getVideoInSize
 @since 5.1
 */
- (void)rtccCall:(id)sender videoInSizeChange:(CGSize)profile forContact:(RtccContact *)contact;


/**
 @brief Called when the incoming share frame size changes.
 
 @param sender	The RtccCall which property changed.
 @param size	The new size of the share frame. Can be CGSizeZero.
 @since 5.1
 */
- (void)rtccCall:(id)sender shareInSizeChange:(CGSize)size;

/**
 @brief Called when the outgoing video size changes (that is, even if the device rotates).
 @param sender The RtccCall which property changed.
 @param size The new size of the monitoring video. Can be CGSizeZero.
 @sa RtccCall::videoProfile
 @sa RtccCall::getVideoOutSize
 @since 5.1
 */
- (void)rtccCall:(id)sender videoOutSizeChange:(CGSize)size;

/**
 @brief Called when the video source changes.
 @param sender The RtccCall which property changed.
 @param source The new source. 0 if front (on the screen side of the device) camera, back camera otherwise.
 @sa RtccCall::videoSource
 @since 5.0
 */
- (void)rtccCall:(id)sender videoSource:(int)source;

/**
 @brief Called when the microphone is muted.
 @param sender The RtccCall which property changed.
 @param isSending sending captured audio stream if true, sending empty packets otherwise.
 @sa RtccCall::audioStart
 @sa RtccCall::audioStop
 @since 5.0
 */
- (void)rtccCall:(id)sender audioSending:(BOOL)isSending;

/**
 @brief Called when the audio route changes.
 @param sender The RtccCall which property changed.
 @param route The new route used.
 @sa RtccCall::audioRoute
 @since 5.0 - modified 5.5
 */
- (void)rtccCall:(id)sender audioRoute:(audioRoute_t)route;

/**
 @brief Called when the status of the call changes.
 @param sender The RtccCall which property changed.
 @param status The new status of the call (i.e. callStatus_ringing).
 @sa RtccCall::callStatus
 @since 5.0
 */
- (void)rtccCall:(id)sender callStatus:(callStatus_t)status;

/**
 @brief The call unique SIP identifier as been received. This occurs *after* the call goes active. After this delegate method is fired, the RtccCall::getSipID message can be fired anytime to retrieve this ID.
 @param sender The RtccCall which sipID was received.
 @param sipID The sipID.
 @sa RtccCall::getSipID
 @since 5.2
 */
- (void)rtccCall:(id)sender sipID:(NSString *)sipID;

/**
 @brief You received raw data from the contact you are talking to.
 @param sender The call related to the data.
 @param data The data received.
 @since 5.3
 */
- (void)rtccCall:(id)sender receivedData:(NSData *)data;

#pragma mark - Conference delegation
/**
 @brief Fired when a participant's status changes.
 @param sender the Call which participant changed.
 @param contact A reference to the contact that changed. The changes is one of the following:

	* RtccContact::isMuted
	* RtccContact::isDeaf
	* RtccContact::isEmittingVideo
	* RtccContact::isHandUp
	* RtccContact::isAdmin
	* RtccContact::isOnHold
	* RtccContact::isTalking

 @since 5.3
 */
- (void)rtccConference:(id)sender participantChange:(RtccContact *)contact;

/**
 Fired when the list of contacts changes. The whole list (of RtccContact) is dropped and rebuilt.
 @param sender The Call which participant list changed.
 @since 5.3
 */
- (void)rtccParticipantListChangeForConference:(id)sender;


/**
 Indicates that recording for this call started.
 @param sender The related RtccCall.
 @sa RtccCall::recordingStop
 @sa RtccCall::recordingPause
 @since 5.3
 */
- (void)rtccCallRecordStopped:(id)sender;


/**
 Indicates that recording for this call ended.
 @param sender The related RtccCall.
 @since 5.3
 @sa RtccCall::recordingStart:
 */
- (void)rtccCallRecordStarted:(id)sender;

@end

/**
 @brief Represents a call to a contact or a conference. Such an object is created on Rtcc::createCall:.
 
 Remarks:
 When the device is held in a non supported rotation, the monitoring view of the outgoing video is rotated to indicate that the rotation is not supported, though the outgoing video is sent correctly rotated.
 @since 5.0
 */
@interface RtccCall : NSObject
/** @name Call parameters*/

/**
 @brief The host app should set this value if it wants to be notified about call changes.
 @since 5.0
 */
@property(nonatomic, strong) id<RtccCallDelegate>delegate;

/**
 @brief The ID of the call. 
 
 Not really used for now since only one call can be held at a time.
 @since 5.0
 */
@property(readonly) int callid;

/**
 @brief This is the duration of this call, in seconds. 
 
 Not KVO, as it is updated only when the value is requested.
 @since 5.1
 */
@property(nonatomic, readonly)NSTimeInterval callDuration;

/**
 @brief Date of call start.
 @since 5.1
 */
@property(nonatomic, readonly)NSDate *startDate;

/**
 @brief ID of the contact or the conference being called.
 @sa RtccCall::contactDisplayName
 @since 5.0
 */
@property(readonly) NSString *contactUID;

/**
 @brief Display name of the contact or conference being called. 
 
 If this name is not set, a call to this variable returns the same value as RtccCall::contactUID. The only way to set this variable is on call creation through Rtcc::createCall:andSetDisplayName:
 @sa RtccCall::contactUID
 @since 5.0
 */
@property(nonatomic, readonly) NSString *contactDisplayName;


/**
 @brief The sip ID of the call.
 This property is only available after the call is set to active.
 
 Fetching it before the RtccCallDelegate::rtccCall:sipID: callback is fired will return `nil`. Fetching it with a callstatus different from `callStatus_active`, `callStatus_paused` or `callStatus_ended` will return `nil`.
 @sa RtccCall::callStatus
 @sa RtccCallDelegate::rtccCall:sipID:
 @since 5.2
 */
@property(nonatomic, readonly, getter = getSipID) NSString *sipID;


#pragma mark - Call status
/** @name Call Status*/
/**
 @brief Status of the call
 
 Upon change, RtccCallDelegate::rtccCall:callStatus: is called.
 @sa RtccCallDelegate::rtccCall:callStatus:
 @since 5.0
 */
@property(nonatomic, readonly) callStatus_t callStatus;

/**
 @brief Value changes after a RtccCall::toggleAudioRoute.
 
 Upon change, RtccCallDelegate::rtccCall:audioRoute: is called.
 @sa RtccCallDelegate::rtccCall:audioRoute:
 @sa RtccCall::toggleAudioRoute
 @since 5.0 - modified 5.5
 */
@property (nonatomic) audioRoute_t audioRoute;

/**
 @brief Value changes after a RtccCall::toggleVideoSource. 0 is front camera, 1 is back camera.
 
 Upon change, RtccCallDelegate::rtccCall:videoSource: is called.
 @sa RtccCallDelegate::rtccCall:videoSource:
 @since 5.0
 */
@property (nonatomic, readonly) int videoSource;

/**
 @brief Whether or not the call is receiving video.
 
 This property changes when the video stream is started/ended on the other end. Upon change, RtccCallDelegate::rtccCall:videoReceiving: is called.
 @sa RtccCallDelegate::rtccCall:videoReceiving:
 @since 5.0
 */
@property(nonatomic, readonly, getter = isReceivingVideo) BOOL receivingVideo;

/**
 @brief Whether or not the call is sending video.
 
 This property changes when the network acknowledge the video status change on this end. Upon change, RtccCallDelegate::rtccCall:videoSending: is called.
 @sa RtccCallDelegate::rtccCall:videoSending:
 @since 5.0
 */
@property(nonatomic, readonly, getter = isSendingVideo) BOOL sendingVideo;

/**
 @brief YES if the video capture is suspended.
 
 Upon change, RtccCallDelegate::rtccCall:videoPause: is called.
 @sa RtccCall::toggleVideoPause
 @sa RtccCallDelegate::rtccCall:videoPause:
 @since 5.3
 */
@property(nonatomic, readonly, getter = isVideoPaused) BOOL videoPaused;

/**
 @brief Whether or not the call has an outbound view share ongoing.
 
 This property changes when the share starts. Upon change, RtccCallDelegate::rtccCall:shareReceiving: is called.
 @sa RtccCallDelegate::rtccCall:shareReceiving:
 @since 5.1
 */
@property(nonatomic, readonly, getter = isReceivingShare) BOOL receivingShare;

/**
 @brief Whether or not the call has an outbound view share ongoing.
 
 This property changes when the network acknowledge the share is ongoing.
 Upon change, RtccCallDelegate::rtccCall:shareSending: is called.
 @sa RtccCallDelegate::rtccCall:shareSending:
 @since 5.1
 */
@property(nonatomic, readonly, getter = isSendingShare) BOOL sendingShare;

/**
 @brief Whether or not the call is sending captured audio packet.
 
 This property changes when the network acknowledge the microphone status change on this end.
 Upon change, RtccCallDelegate::rtccCall:audioSending: is called.
 @sa RtccCallDelegate::rtccCall:audioSending:
 @since 5.0
 */
@property(nonatomic, readonly, getter = isSendingAudio) BOOL sendingAudio;

/** @name Videos & Share Screens*/
/**
 @brief The view in wich the call should display the incoming share.
 
 Set by the host application.
 @sa RtccCall::viewShareOut
 @since 5.1
 */
@property(nonatomic, weak) UIView *viewShareIn;

/**
 @brief The view in wich the call should display the outgoing share.
 
 Set by the host application.
 @sa RtccCall::viewShareIn
 @since 5.3
 */
@property(nonatomic, weak) UIView *viewShareOut;

/**
 @brief The view in wich the call should display the incoming video.
 
 Set by the host application.
 @sa RtccCall::viewVideoOut
 @since 5.0
 */
@property(nonatomic, weak) UIView *viewVideoIn;

/**
 @brief The view in wich the call should display the outgoing video.
 
 Set by the host application.
 @since 5.0
 */
@property(nonatomic, weak) UIView *viewVideoOut;

/**
 @brief Set this value to ask for a change in the incoming video resolution.
 
 Valid values are `profile_low` and `profile_high`.
 Upon change, RtccCallDelegate::rtccCall:videoProfile: is called.
 @sa RtccCallDelegate::rtccCall:videoProfile:
 @since 5.1
 @deprecated Since 5.3 - Replaced by RtccCall::videoInProfile. Names sanitization effort.
 */
@property (nonatomic) video_profile_t videoProfile __attribute__ ((unavailable("Removed in 5.3. Please use RtccCall::videoInProfile.")));

/**
 @brief Set this value to ask for a change in the incoming video resolution.
 
 Valid values are `profile_low` and `profile_high`.
 @sa RtccCallDelegate::rtccCall:videoInSizeChange:
 @since 5.2
 */
@property (nonatomic) video_profile_t videoInProfile;

/**
 @brief Set this value to ask for a change in the outgoing video resolution.
 
 Valid values are `profile_low` and `profile_high`.
 @sa RtccCallDelegate::rtccCall:videoOutSizeChange:
 @since 5.2
 */
@property (nonatomic) video_profile_t videoOutProfile;

/** @name Conference Call*/
/**
 @brief Answers the question "Is this call a conference?".
 @since 5.3
 */
@property(nonatomic, readonly) BOOL isConference;

/**
 @brief The list of participants in the call, own user excluded.
 
 This dictionary is composed of couples <`NSNumber *`, `RtccContact *`>, where the `NSNumber *` indicates the contact's location in the floorlist.
 
 The logged user (a.k.a. `myself`) is not represented in this array.

 @sa RtccCall::myself
 @since 5.3
 */
@property (nonatomic, readonly) NSDictionary *participantsDictionary;

/**
 @brief Only used in case of conference. Not present in the participantsList.
 @since 5.3
 */
@property (nonatomic, readonly) RtccContact *myself;


/**
 YES if the app is hosting the conference. NO if attendee.
 @sa Rtcc::meetingPointCreateWithTitle:atLocation:startDate:endDate:withType:
 @since 5.3
 */
@property (nonatomic, readonly) BOOL isHost;
/**
 @brief Setting this mute/unmute all the conference participants. 
 
 YES if all contacts are muted. Same as iterating throught the contacts list and checking if everyone is muted.
 
 Setting this to YES sends a global command to the conference bridge.
 @since 5.3
 */
@property (nonatomic, getter = areAllMuted) BOOL muteAll;

/**
 @brief Setting this deafen/undeafen all the conference participants. 
 
 YES if all contacts are deaf. Same as iterating throught the contacts list and checking if everyone is deaf.
 
 Setting this to YES sends a global command to the conference bridge.
 @since 5.3
 */
@property (nonatomic, getter = areAllDeafen) BOOL deafenAll;


#pragma mark - Basic controls
/** @name Bsic Call Controls*/
/**
 @brief Hang up the call and stop it
 @since 5.0
 */
- (void)hangup;

/**
 @brief Pause the call so it can be later resumed.
 @warning Not Yet Available.
 @since 5.0
 */
- (void)pause;

/**
 @brief Resume the call if it was paused. Pick it up if it is ringing.
 @since 5.0
 */
- (void)resume;

/**
 @brief Pick up a call without activating the outgoing video.
 @since 5.2
 */
- (void)resumeWithoutVideo;

/**
 @brief Start the share view and set the view to be shared.
 
 @param view This view is *NOT* retained by the SDK (a.k.a. its reference is kept with a `weak` property).
 @warning Not available on iOS version earlier than the 7.0.
 @since 5.1
 */
- (void)screenShareStart:(UIView *)view;

/**
 @brief Stops the share. If the incoming video stream was active, it is resumed.
 @since 5.1
 */
- (void)screenShareStop;


/**
 @brief Start sending video from the camera.
 
 @since 5.0
 */
- (void)videoStart;

/**
 @brief Stop sending video from the camera.
 @since 5.0
 */
- (void)videoStop;

/**
 @brief Suspend sending and diplaying new frames from the camera. 
 
 The last captured buffer is send over and over to the remote and displayed in RtccCall::viewVideoOut.
 @sa RtccCall::videoPaused
 @sa RtccCallDelegate::rtccCall:videoPause:
 @since 5.3
 */
- (void)toggleVideoPause;

/**
 @brief Start sending audio from the microphone.

 While the outgoing audio stream starts automatically upon call start, it is possible to mute the microphone, thus sending only empty frames. This function starts the sending of captured audio packet.

 Upon change, RtccCallDelegate::rtccCall:audioSending: is called.
 @sa RtccCallDelegate::rtccCall:audioSending:
 @since 5.0
 */
- (void)audioStart;

/**
 @brief Stop sending audio from the microphone.

 The function stops the sending of captured audio packet. Enpty audio frames are sent instead.

 Upon change, RtccCallDelegate::rtccCall:audioSending: is called.
 @sa RtccCallDelegate::rtccCall:audioSending:
 @since 5.0
 */
- (void)audioStop;

/**
 @brief Switches camera source between front and back.

 Upon change, RtccCallDelegate::rtccCall:videoSource: is called.
 @sa RtccCallDelegate::rtccCall:videoSource:
 @since 5.0
 */
- (void)toggleVideoSource;

/**
 @brief Changes the audio route used by the call.
 
 This toggle the speaker override, turns on the device's speaker or changes back to the default equipement of the device (or the headset if a compatible headset is connected.)

 Upon change, RtccCallDelegate::rtccCall:audioRoute: is called.
 @sa RtccCallDelegate::rtccCall:audioRoute:
 @sa RtccCall::audioRoute
 @since 5.0
 @deprecated Since 5.5. Set RtccCall::audioRoute to change the outgoing audio route.
 */
- (void)toggleAudioRoute __attribute__((deprecated("Use setAudioRoute:")));

#pragma mark - Views and Video

/** @name Video and Share Streams*/

/**
 @brief Returns the incoming video size. Use it to resize RtccCall::viewVideoIn .
 @return The size of the video.
 @since 5.2
 */
- (CGSize)getVideoInSize;

/**
 @brief Returns the outgoing video size. Use it to resize RtccCall::viewVideoOut.
 @return The size of the video, such as the video is correctly oriented.
 @since 5.2
 */
- (CGSize)getVideoOutSize;

/**
 @brief Returns the incoming share size. Use it to resize RtccCall::viewShareIn.
 @return The size of the video.
 @since 5.1
 */
- (CGSize)getShareInSize;

/**
 @brief Returns the incoming video size, used to resize the incoming video view (in case of ratio change and/or dimension change).
 @return The size of the video.
 @deprecated Since 5.3 - Replaced by RtccCall::getVideoInSize. Names sanitization effort.
 @since 5.1
 */
- (CGSize)getVideoInProfile __attribute__ ((unavailable("Removed in 5.3. Please use RtccCall::getVideoInSize.")));


/**
 @brief Returns the outgoing video size, to be used to resize the monitoring video.
 @return The size of the video, such as the video is correctly oriented.
 @deprecated Since 5.2 - Replaced by RtccCall::getVideoOutSize. Names sanitization effort.
 @since 5.1
 */
- (CGSize)getVideoOutProfile __attribute__ ((unavailable("Removed in 5.3. Please use RtccCall::getVideoOutSize.")));

#pragma mark - Pointers

/** @name Inband Messages*/
/**
 Send raw data to the call recipient. Could be anything. 
 @param data The data to send.
 @since 5.3
 */
- (void)sendData:(NSData *)data;

#pragma mark - Conference
/** @name Conference Controls*/

/**
 @brief Kicks a participant out of the call. Only an admin can call this method and be obeyed.
 @param participantID The ID of the participant to kick out.
 @since 5.3
 */
- (void)kickParticipant:(NSNumber *)participantID __attribute__((nonnull (1)));

/**
 @brief Start recording the video to the specified URL. Conference calls only.
 @param serverURL The server to which the MVS will send the video streams.
 @since 5.3
 */
- (void)recordingStart:(NSString *)serverURL;

/**
 @brief Pause the recording. Conference calls only.
 @since 5.3
 */
- (void)recordingPause;

/**
 @brief Stop the recording. Conference calls only.
 @since 5.3
 */
- (void)recordingStop;

/**
 @brief Create a bookmark in a recording. Conference calls only.
 @since 5.3
 */
- (void)recordingBookmark;


@end
