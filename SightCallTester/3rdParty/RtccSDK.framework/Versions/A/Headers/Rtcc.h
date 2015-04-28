//
//  Weemo.h
//  iOS-SDK
//
//  Created by Salomon BRYS on 11/07/13.
//  Copyright (c) 2013 Weemo. All rights reserved.
//


#import "RtccData.h"
#import "RtccCall.h"
#import "RtccProtocols.h"

/**
 @brief Delegate for the Rtcc Singleton. Allows the Host Application to be notified upon connection events & call creation.
 @since 5.0
 */
@protocol RtccDelegate <NSObject>

/**
 @brief This function will be called after a call is created, either by calling a contact or receiving a call.

 To accept the call, use RtccCall::resume. To deny it, use RtccCall::hangup. The RtccCall object can possess a delegate of its own, RtccCallDelegate.
 In case of an incoming call, the RtccCall::contactUID will be `nil`, as only the display name is sent through the network.

 @param call The call created, can't be `nil`. Host App depends on the RtccCall::callStatus value (`callStatus_t` type value)

 @sa Rtcc::createCall:
 @sa The definition of the callStatus_t variables (found in RtccData.h).
 @since 5.0
 */
- (void)rtccCallCreated:(RtccCall*)call;



/**
 @brief Called when the call terminates, with an additional termination reason.
 
 This reason is either local, remote or error.
 
 @param call A pointer to the call that was terminated.
 @param reason The reason of the call termination.
 @sa RtccDelegate::rtccCallEnded:
 */
- (void)rtccCallEnded:(RtccCall*)call withReason:(callEndReason_t)reason;


/**
 @brief Called by the Rtcc singleton after the authentication step.
 @param error If authentication failed, error will be different from `nil`. The debugDescription field of the NSError returns a `NSString *` describing the error in human terms. Otherwise, it is `nil`.
 @sa Rtcc::authenticateWithToken:andType:
 @since 5.0
 */
- (void)rtccDidAuthenticate:(NSError*)error;


/**
 @brief Called when Rtcc singleton ended its initialization.
 
 If no error occured the Rtcc singleton is connected and users can proceed to the authentication step.
 @param error `nil` if no error occured. If different from `nil` then the connection did NOT succeed. The NSError::debugDescription field of the NSError returns a `NSString *` describing the error in human terms.
 @sa Rtcc::RtccWithAppID:andDelegate:error:
 @since 5.0
 */
- (void)rtccDidConnect:(NSError*)error;

@optional
/**
 @brief This function will be called after a call is stopped. 
 
 The object `call` will be released soon after this method returns.

 @param call The call that is stopped.
 @since 5.0 optional since 5.4
 */
- (void)rtccCallEnded:(RtccCall*)call;

/**
 @brief Called when Rtcc gets disconnected from the server. 


 If an error occured, the error debugDescription contains a human readable text and the error code can be found in RtccData.h. To reconnect using the same appID, use Rtcc::authenticateWithToken:andType:.
 To change the appID, please tear down the singleton by using Rtcc::reset, then recreate it using Rtcc::RtccWithAppID:andDelegate:error:

 @param error `nil` if the Rtcc singleton disconnected normally.
 @sa Rtcc::disconnect
 @since 5.0
 */
- (void)rtccDidDisconnect:(NSError*)error;

/**
 @brief Called after a contact is checked through the use of the Rtcc::getStatus:.

 This delegate function is only called when the user/host application specifically calls the Rtcc::getStatus: method.

 @param contactUID the contact checked.
 @param canBeCalled YES if the contact can be called, NO otherwise.
 @sa Rtcc::getStatus:
 @since 5.0
 @deprecated Since 5.4 - Please use RtccPresenceDelegate::rtccPresenceForContacts:
 */
- (void)rtccContact:(NSString*)contactUID canBeCalled:(BOOL)canBeCalled __attribute__((deprecated("Deprecated in 5.4. Please use RtccPresenceDelegate::rtccPresenceForContacts:.")));

/**
 @brief This function is called between the app's call to Rtcc::authenticateWithToken:andType: and the RtccDelegate::rtccDidAuthenticate: call.
 @param error If an error occured during authentication, this function may be called with an error param different from `nil`.
 @since 5.0
 */
- (void)rtccWillAuthenticate:(NSError *)error;

/**
 This callback is called upon data reception. 
 
 This data packet size is less than 1536B.
 @param data The data received.
 @param contactUID The name of the contact who sent the message.
 @param contactID Used to reply to the message, as second argument to the Rtcc::replyData:toContactID:.
 @sa Rtcc::sendData:toContact:
 @since 5.2
 @deprecated Since 5.4 - Please use RtccDataDelegate::rtccReceivedData:from:withID:
 */
- (void)rtccReceivedData:(NSData *)data from:(NSString *)contactUID withID:(uint8_t)contactID __attribute__((unavailable("Deprecated in 5.4. Please use RtccDataDelegate::rtccReceivedData:from:withID:.")));


@end

/**
 @brief Rtcc singleton. 
 
 This is the main object of the SDK, and allows for call creation and connection handling.

 Remarks:
 This singleton is instancianted in the host application by using the Rtcc::RtccWithAppID:andDelegate:error: class function.
 After initiating the singleton, authentication can happen, upon RtccDelegate::rtccDidAuthenticate: call.

 The singleton can be invoked anytime after instantiation through Rtcc::instance. If the instantiation isn't completed
 by the time Rtcc::instance is called, `nil` is returned.
 */
@interface Rtcc : NSObject



/**
 @brief Delegate for the SDK instance. Implements `RtccDelegate`'s protocol.
 @since 5.0
 */
@property(nonatomic, readonly, weak)  id<RtccDelegate> delegate;

/**
 @brief YES if the RTCC instance is connected.
 
 Once connected using Rtcc::RtccWithAppID:andDelegate:error:, the user can authenticate using Rtcc::authenticateWithUserType:
 @since 5.0
 @sa Rtcc::RtccWithAppID:andDelegate:error:
 @sa Rtcc::connected
 */
@property(nonatomic, getter = isConnected, readonly)BOOL connected;

/**
 @brief YES if the RTCC instance is authenticated.
 
 The user is authenticated after calling Rtcc::authenticateWithUserType: with a valid parameter.
 @since 5.0
 @sa Rtcc::authenticateWithUserType:
 @sa Rtcc::connected
 */
@property(nonatomic, getter = isAuthenticated, readonly)BOOL authenticated;

/**
 @brief The current active call, if any.
 
 Currently, only one call at a time is supported.
 @since 5.0
 */
@property(nonatomic, readonly) RtccCall *activeCall;

/**
 @brief Allows the app to fetch the current SDK status.
 
 KVO compliant.
 @since 5.4
 */
@property (nonatomic, readonly)sdkStatus_t currentStatus;

/**
 @brief The display name used by the application.
 
 Set this before placing a call to ensure the call can be created.
 @since 5.0
 */
@property(nonatomic, strong) NSString *displayName;


/**
 @brief The presence Delegate, implements `RtccPresenceDelegate`'s protocol. It will be called for every presence or roster events.
 
 Upon logon, the user is registered to a presence system. This allows users to set their presence, Create, Update, Fetch and Delete a contact roster and be notified of a registered Contact's Presence change.
 The Registration happens automatically upon authentication. The Delegate is notified of the event through RtccPresenceDelegate::rtccPresenceRegistrationUpdate:
 
 Setting one's presence is done through a call to Rtcc::setPresence:. A presence value is merely a `uint8_t`, its interpretation is left to the host app, beside `0`, which is the value returned when fetching the Presence of a non registered Contact.
 
 Registering a roster (a.k.a. a list of contacts) is done using Rtcc::addContactsToRoster:.
 */
@property (nonatomic, weak) id <RtccPresenceDelegate> presenceDelegate;

/**
 @brief The delegate to whom the answers to the Data method will be sent.
 
 Implements `RtccDataDelegate`'s protocol.
 @since 5.4
 */
@property (nonatomic, weak)id<RtccDataDelegate> dataDelegate;

/**
 @brief Delegate that implements the meeting point callbacks.
 
 Implements `RtccMeetingPointDelegate`'s protocol.
 @since 5.3
 */
@property(nonatomic, weak) id<RtccMeetingPointDelegate> meetingDelegate;

/**
 @brief Delegate that implements the host delegate.
 
 Implements `RtccHostDelegate`'s protocol. Will be notified of Meeting point creation, destruction, user trying to join, etc
 
 @since 5.3
 */
@property(nonatomic, weak) id<RtccHostDelegate> hostDelegate;

/**
 @brief Delegate that implements the attendee delegate. 
 
 Implements `RtccAttendeeDelegate`'s protocol. Implement it to be notified of invitation and acceptance status.
 @since 5.3
 */
@property(nonatomic, weak) id<RtccAttendeeDelegate> attendeeDelegate;

/** @name Getting and initializing */

/**
 @brief Creates a Rtcc singleton Object.
 
 The initialization is asynchronous, the RtccDelegate::rtccDidConnect: will be called upon singleton connection.

 @param appID The Application Identifier. Must not be `nil`.
 @param delegate The delegate object that implements the RtccDelegate protocol.
 @param error When initialization fails and this is not `nil`, a message explaining the failure is available in `[error debugDescription]`.
 @sa RtccDelegate::rtccDidConnect:
 @since 5.0
 */
+ (Rtcc *)RtccWithAppID:(NSString *)appID
			  andDelegate:(id<RtccDelegate>)delegate
					error:(NSError *__autoreleasing *)error __attribute__((nonnull (1)));

/**
 @brief Returns the Rtcc singleton instance, if instantiated.
 @return The Rtcc singleton or `nil` if the SDK was not instantiated.
 @since 5.0
 */
+ (Rtcc*)instance;

/**
 Used for identification purpose.
 @return The version of the Rtcc SDK.
 @since 5.0
 */
+ (NSString *)getVersion;

/**
 Reset the whole thing. Connection is dropped and data forgotten.
 @since 5.0
 */
+ (void)reset;


/** @name Log files.*/
/**
 Set the log level currently used.
 @param logLevel The logLevel to set.
 @sa logLevel_t in RtccData.h
 @sa Rtcc::getLogLevel
 @since 5.1
 */
+ (void)setLogLevel:(logLevel_t)logLevel;

/**
 Returns the current log level.
 @sa logLevel_t int RtccData.h
 @sa Rtcc::setLogLevel:
 @since 5.1
 */
+ (logLevel_t)getLogLevel;

/**
 Copy the logfile of the app to a temporary location (in the NSTemporaryDirectory() application folder.)
 @return The URI of the logfile.
 @since 5.3
 */
- (NSString*)createLogfile;

#pragma mark - Connection relevant
/** @name Connection and status */
/**
 @brief Connects to servers with the given token.
 
 The connection is asynchronous, RtccDelegate::rtccDidAuthenticate: will be called upon user token validation.
 @param token The token to be used for authentication. Must not be `nil`. In case of `type` being `userExternal`, set it to the parent's UID to authentify as a children.
 @param type The user type.
 @sa RtccDelegate::rtccDidAuthenticate:
 @sa RtccData::userProfile_t
 @since 5.0
 @deprecated Use Rtcc::authenticateWithUserType:
 */
- (BOOL)authenticateWithToken:(NSString *)token andType:(userProfile_t)type __attribute__((nonnull (1))) __attribute__((deprecated("Use Rtcc::authenticateWithUserType:")));


/**
 @brief Authenticate a user defined by a UserType object.
 
 @param usertype Depending on the usertype, the logging process differs.
 @since 5.5
 */
- (BOOL)authenticateWithUserType:(UserType *)usertype;

/**
 @brief Disconnects from rtcc servers.
 
 A call to RtccDelegate::rtccDidDisconnect: is to be expected upon disconnection.
 @sa RtccDelegate::rtccDidDisconnect:
 @since 5.0
 */
- (BOOL)disconnect;



#pragma mark - One-to-One Call
/** @name Create a call*/

/**
 @brief Creates a call using a dictionary of parameters.
 
 This method is eventually called by all the others of the Rtcc `createCall:` family.
 Note that certain key/values of the dictionary are mandatory. The others falls back to default values presented in the following list.
 All keys are defined in RtccData.h .
 
 @param options The parameters to use to create the call. Possible keys are defined in RtccData.h:
 - `k_ContactID`: the ID of the contact to call. NSString. Mandatory.
 - `k_ContactDN`: the display name of the person you are calling. NSString. Mandatory.
 - `k_WithVideo`: YES (as a NSNumber) will see the app send a video stream on call start. Default is YES.
 - `k_WithAudio`: A NSNumber from an int, based on the rawValue of the wanted `audioMode_t`.
 - `k_VideoStartProfile`: @"md" will see the app start in VGA outgoing stream or CIF profile otherwise. Default is @"sd".
 - `k_VideoSource`: 1 for the rear camera, 0 for the front (above-screen) camera. Default is 0.
 - `k_AudioRoute`: A NSNumber from an int, based on the rawValue of the wanted `audioRoute_t`.
 
 @sa RtccDelegate::rtccCallCreated:
 @since 5.3
 */
- (void)createCallWithOptions:(NSDictionary *)options __attribute__((nonnull (1)));;

/**
 @brief Creates a call whose recipient is `contactUID`.
 
 The call is immediately created. If the callee is not available, the call is ended almost immediately. The call is returned to the application throught the use of the RtccDelegate::rtccCallCreated: method. Similar to call Rtcc::createCallWithOptions: with `@{k_ContactID:contactUID, k_ContactDN:contactUID}` as argument.
 
 @param contactUID The UID of the contact or the conference to call. Must not be `nil`.
 @sa Rtcc::createCallWithOptions:
 @sa RtccDelegate::rtccCallCreated:
 @sa RtccCall::contactUID
 @sa Rtcc::createCall:andSetDisplayName:
 @since 5.0
 */
- (void)createCall:(NSString*)contactUID __attribute__((nonnull (1)));

/**
 @brief Creates a call whose recipient is `contactUID` and set the contact's display name to `displayName`.
 
 The call is immediately created. If the callee is not available, the call is ended almost immediately. The call is returned to the application throught the use of the RtccDelegate::rtccCallCreated: method. Similar to call Rtcc::createCallWithOptions: with `@{k_ContactID:contactUID, k_ContactDN:displayName}` as argument.
 
 @param contactUID The ID of the contact or the conference to call. Must not be `nil`.
 @param displayName The contact display name to be used. Must not be `nil`.
 
 @sa Rtcc::createCallWithOptions:
 @sa RtccDelegate::rtccCallCreated:
 @sa RtccCall::contactUID
 @sa RtccCall::contactDisplayName
 @sa Rtcc::createCall:
 @since 5.0
 */
- (void)createCall:(NSString *)contactUID andSetDisplayName:(NSString *)displayName __attribute__((nonnull (1, 2)));


/**
 @brief Creates a call whose recipient is `contactUID` and set the contact's display name to `displayName`.
 
 The call is immediately created. If the callee is not available, the call is ended almost immediately. The call is returned to the application throught the use of RtccDelegate::rtccCallCreated: method. Similar to call Rtcc::createCallWithOptions: with `@{k_ContactID:contactUID, k_ContactDN:displayName, k_WithVideo:@1}` as argument.
 
 @param contactUID The ID of the contact or the conference to call. Must not be `nil`.
 @param displayName The contact display name to be used. Must not be `nil`.
 @param videoEnabled YES if the call should have videoOut enable by the time the remote picks up.
 
 @sa Rtcc::createCallWithOptions:
 @sa RtccDelegate::rtccCallCreated:
 @sa RtccCall::contactUID
 @sa RtccCall::contactDisplayName
 @sa Rtcc::createCall:
 @since 5.2
 */
- (void)createCall:(NSString *)contactUID andSetDisplayName:(NSString *)displayName withVideo:(BOOL)videoEnabled
__attribute__((nonnull (1, 2)));


#pragma mark - Media Overrides
/** @name Media rate overrides */
/**
 @brief Overrides internals values. 
 
 Overrides the default bandwidth parameters by changing the max video FPS and bandwith, and adding a resolution divider. Settings any of this value to 0 will reset the setting to default values.
 
 @param maxfps The max FPS wanted from the encoder. valid values are 1-30. Set to 0 to get back to defaults.
 @param maxBitrate Max bitrate for the video encding. 1-1000000, unit is bps.
 @param resolutionDiv Values are 1 or 2. Setting 2 will divide the video frame dimension by 2 (i.e. 352*288 becomes 176*144).
 
 @since 5.1
 */
- (void)overrideVideoFPS:(int)maxfps andVideoMaxBitrate:(int)maxBitrate andResolutionDivider:(int)resolutionDiv;

/**
 @brief Overrides two audio encoding parameters and the CPU usage of the video encoder.
 @param complexity The complexity used for the audio encoding. 0-10, 10 is better quality, more cpu consuming. Default is 4.
 @param bitrate The audio bitrate in bps. 16000 - 64000. default is 24000.
 @param cpuusage The cpu usage of the video encoder. 0-16, 0 being the most intensive. default is 8.
 @since 5.2
 */
- (void)overrideAudioComplexity:(int)complexity andAudioBitrate:(int)bitrate andVideoCPUUsage:(int)cpuusage;

/**
 @brief Restore defaults bandwidth parameters.
 
 Equivalent to call Rtcc::overrideVideoFPS:andVideoMaxBitrate:andResolutionDivider: with 0 as parameters.
 @since 5.1
 */
- (void)resetBandwidthDefaults;


#pragma mark - Presence calls
/** @name Handle the presence */


/**
 @brief Check if a user can be called.
 
 RtccDelegate::rtccContact:canBeCalled: is called upon callback from the network.
 
 @param contactUID The ID of the contact to check. Must not be `nil`.
 @sa RtccDelegate::rtccContact:canBeCalled:
 @since 5.0
 @deprecated Since 5.4 - Please use Rtcc::getPresenceForContacts: with `contactUID` as a parameter.
 */
- (void)getStatus:(NSString *)contactUID
__attribute__((nonnull (1)))
__attribute__((deprecated("Please use the new Presence system (see Rtcc::getPresenceForContacts:)")));


/**
 @brief Fetches the status for the contacts UID in the array.
 
 If `contactsUID` is `nil`, the whole roster is returned throught RtccPresenceDelegate::rtccRosterUpdate:.
 @param contactsUID An array of UIDs. All components of the array must be of type `NSString *`. If `nil`, fetches the whole roster.
 @since 5.4
 */
- (void)getPresenceForContacts:(NSArray *)contactsUID;

/**
 @brief This allows users to change their presence status.
 
 This calls in return the RtccPresenceDelegate::rtccPresenceContact:changedPresence: with your current presence.
 @param presence The significance of the value is left to the host App.
 @sa RtccPresenceDelegate::rtccPresenceContact:changedPresence:
 @since 5.4
 */
- (void)setPresence:(uint8_t)presence;

/**
 @brief Adding contacts to the roster.
 @param contactsUID Contact UIDs to add to the roster. All components of the array must be of type `NSString *`. If `nil`, nothing is done.
 @sa RtccPresenceDelegate::rtccRosterUpdate:
 @since 5.4
 */
- (void)addContactsToRoster:(NSArray *)contactsUID __attribute__((nonnull (1)));

/**
 @brief Removes the UID contained in `contactsUID` from the roster. 
 
 Use `nil` to clear the roster.
 @param contactsUID The list of contacts to be removed from the roster. All components of the array must be of type `NSString *`. If `nil`, the roster is cleared.
 @since 5.4
 */
- (void)removeContactsFromRoster:(NSArray *)contactsUID;

#pragma mark - Data Channel

/** @name Send and Receive Data*/


/**
 @brief Sends data using the data channel.
 
 Data should not be bigger than 1536B. The `data` is transfered as it is to the remote client authenticated as `contactID`. The contact is notified of the message's sender's name.
 @param data The data to send to the user. Must not be `nil`.
 @param contactUID The recipient. Must not be `nil`.
 @sa RtccDelegate::rtccReceivedData:from:withID:
 @since 5.2
 @deprecated Since 5.4 - Please use Rtcc::dataSend:toContactUIDs:withID:
 */
- (void)sendData:(NSData *)data toContact:(NSString *)contactUID
__attribute__((nonnull (1, 2)))
__attribute__ ((unavailable("Please use the new Chat system (i.e. Rtcc::dataSend:toContactUIDs:withID:)")));


/**
 @brief Reply to a specified contact.
 
 To be used with the ID in the callback RtccDelegate::rtccReceivedData:from:withID:
 @param data The data to send. Must not be `nil`.
 @param contactID The ID of the contact to reply to. Value received in RtccDelegate::rtccReceivedData:from:withID:
 @sa RtccDelegate::rtccReceivedData:from:withID:
 @sa Rtcc::sendData:toContact:
 @since 5.2
 @deprecated Since 5.4 - No replacement in place, since the old RtccDelegate::rtccReceivedData:from:withID: will never be called.
 */
- (void)replyData:(NSData *)data toContactID:(uint8_t)contactID __attribute__((nonnull (1))) __attribute__ ((unavailable("Please use the new Chat system (i.e. Rtcc::dataAcknowledge:ofContact:withFlag:")));

/**
 @brief Used to acknowledge a message received through RtccDataDelegate::rtccReceivedData:from:withID:.
 @param messageID The ID of the message to acknowledge
 @param contactUID The UID of the sender. Must not be `nil`.
 @param flag A host application defined value, send to the remote contact who first sent the message.
 @sa RtccDataDelegate::rtccReceivedData:from:withID:
 */
- (void)dataAcknowledge:(uint8_t)messageID ofContact:(NSString *)contactUID withFlag:(uint8_t)flag __attribute__ ((nonnull (2)));

/**
 @brief Sends data to a contact.
 
 This data is received by the contact through RtccDataDelegate::rtccReceivedData:from:withID:
 @param data The data to send. Must not be `nil`.
 @param contactUIDs The UID of the contacts to which the message will be sent. Must not be `nil`.
 @param messageID The ID of the message
 @sa RtccDataDelegate::rtccReceivedData:from:withID:
 */
- (void)dataSend:(NSData *)data toContactUIDs:(NSArray *)contactUIDs withID:(uint8_t)messageID __attribute__((nonnull (1, 2)));



#pragma mark - MeetingPoints Host
/** @name Meeting Point: Host controls*/


/**
 @brief Creates a MeetingPoint based on values.
 
 Asynchronous call. Host only.
 @param title			The title of the meeting point. 128 char. max
 @param location		The location of the meeting. 128 char. max.
 @param startDate	The date at which the call will start.
 @param endDate			The date at which the call will end.
 @param mpType			The meeting type.
 @warning 5.3: For the key `mpType`, the value `mpType_adHoc` is not yet supported
 @since 5.3
 */
- (void)meetingPointCreateWithTitle:(NSString *)title
						 atLocation:(NSString *)location
						  startDate:(NSDate *)startDate
							endDate:(NSDate *)endDate
						   withType:(mpType_t)mpType;

/**
 @brief Changes the writable informations of the meeting point.
 
 Asychronous call. Host only.
 @param mpID		The internal name of the meeting point that was returned after a creation callback. Must not be `nil`.
 @param title		The title of the meeting point. 128 char. max
 @param location	The location of the meeting. 128 char. max.
 @param startDate	The date at which the call will start.
 @param endDate		The date at which the call will end.
 @since 5.3
 @sa Rtcc::meetingPointCreateWithTitle:atLocation:startDate:endDate:withType:
 */
- (void)meetingPointUpdate:(NSString *)mpID
				  newTitle:(NSString *)title
			   newLocation:(NSString *)location
			  newStartDate:(NSDate *)startDate
				newEndDate:(NSDate *)endDate
				__attribute__((nonnull (1)));

/**
 @brief Locks the meeting point.
 
 Equivalent to Rtcc::meetingPoint:setAuthorizationStatus: with `mpSta_autodeny` as status.
 @param mpID The ID of the meeting point we want to lock. Must not be `nil`.
 @since 5.3
 */
- (void)meetingPointLock:(NSString *)mpID __attribute__((nonnull (1)));

/**
 @brief Changes the meeting point automatic authorization behaviour.
 
 Attendees-to-be will be answered to automatically if `status` is `mpSta_autoaccept` or `mpSta_autodeny`.
 @param mpID The ID of the meeting point we want to lock. Must not be `nil`.
 @param status One of mpAuthorizationMode_t;
 @since 5.3
 */
- (void)meetingPoint:(NSString *)mpID setAuthorizationStatus:(mpAuthorizationMode_t)status __attribute__((nonnull (1)));


/**
 @brief Returns details about the meeting point.
 
 Asynchronous call.
 @param mpID The meeting point id. Must not be `nil`.
 @since 5.3
 */
- (void)meetingPointGetDetails:(NSString *)mpID __attribute__((nonnull (1)));

/**
 @brief Returns the list of contacts in the meeting point. 
 
 Asynchronous call.
 @param mpID The meeting point id. Must not be `nil`.
 @since 5.3
 */
- (void)meetingPointContactList:(NSString *)mpID  __attribute__((nonnull (1)));

/**
 @brief Deletes the meeting point from the system. 
 
 Host only.
 @param mpID The ID of the meeting point we want to delete. Must not be `nil`.
 @sa Rtcc::meetingPointCreateWithTitle:atLocation:startDate:endDate:withType:
 @since 5.3
 */
- (void)meetingPointDelete:(NSString *)mpID __attribute__((nonnull (1)));


/**
 @brief Starts the meeting point. 
 
 To be called only the host after this MP was created.
 @param mpID The ID of the meeting point. Must not be `nil`.
 @sa Rtcc::meetingPointCreateWithTitle:atLocation:startDate:endDate:withType:
 @sa Rtcc::meetingPointStop:
 @since 5.3
 */
- (void)meetingPointStart:(NSString *)mpID __attribute__((nonnull (1)));


/**
 @brief Stops the meeting point.
 
 Host only.
 @param mpID The ID of the meeting point. Must not be `nil`.
 @sa Rtcc::meetingPointStart:
 @since 5.3
 */
- (void)meetingPointStop:(NSString *)mpID __attribute__((nonnull (1)));

/**
 @brief Create the conference call related to the meeting point.
 
 It is only after this call is created and started that the Host can accept or deny attendees. This method can only be called after the meeting point is started through Rtcc::meetingPointStart:.
 @param mpID The ID of the meeting point. Must not be `nil`.
 @sa Rtcc::meetingPointStart:
 @sa Rtcc::meetingPointJoinConferenceAttendee:
 @since 5.3
 */
- (void)meetingPointJoinConferenceHost:(NSString *)mpID __attribute__((nonnull (1)));


/**
 @brief Accept an attendee in the conference.
 
 The related call must have been created. Host only.
 @param mpID The ID of the meeting point. Must not be `nil`.
 @param contactUID The ID of the user to be accepted. Must not be `nil`.
 @sa RtccHostDelegate::rtccHostNewAttendee:
 @since 5.3
 */
- (void)meetingPoint:(NSString *)mpID acceptUser:(NSString *)contactUID __attribute__((nonnull (1, 2)));

/**
 @brief Denies an attendee access to the conference.
 
 The related call must have been created. Host only.
 @param mpID The ID of the meeting point. Must not be `nil`.
 @param contactUID The ID of the user. Must not be `nil`.
 @sa RtccHostDelegate::rtccHostNewAttendee:
 @since 5.3
 */
- (void)meetingPoint:(NSString *)mpID denyUser:(NSString *)contactUID __attribute__((nonnull (1, 2)));

/**
 @brief Invites a user to a meeting point. 
 
 The related call must have been created. Host only.
 @param mpID The ID of the meeting point. Must not be `nil`.
 @param contactUID The ID of the contact we want to invite. Must not be `nil`.
 @sa RtccHostDelegate::rtccHostNewAttendee:
 @since 5.3
 */
- (void)meetingPoint:(NSString *)mpID inviteUser:(NSString *)contactUID __attribute__((nonnull (1,2)));

/**
 @brief Cancels the invitation sent by Rtcc::meetingPoint:inviteUser:. 
 
 Host Only.
 @param mpID The ID of the meeting point. Must not be `nil`.
 @param contactUID The ID of the contact whose invitation will be revoked. Must not be `nil`.
 @since 5.3
 */
- (void)meetingPoint:(NSString *)mpID cancelInviteTo:(NSString *)contactUID __attribute__((nonnull (1,2)));

/** @name Meeting Point: Attendee controls*/


/**
 @brief Asks to join a meeting point as an attendee.
 @param mpID The ID of the meeting point we want to join. Must not be `nil`.
 @since 5.3
 */
- (void)meetingPointRequestJoin:(NSString *)mpID __attribute__((nonnull (1)));

/**
 @brief Cancels the join request.
 @param mpID The ID of the meeting point we wanted to join. Must not be `nil`.
 @since 5.3
 */
- (void)meetingPointCancelJoinRequest:(NSString *)mpID __attribute__((nonnull (1)));

/**
 @brief Call the meeting point as attendee.
 
 This should be called only if already accepted (i.e. in response to a RtccAttendeeDelegate::rtccAttendeeAuthorization:forMeeting: with `mpAtt_accepted` as first param).
 @param mpID The meeting point ID. Must not be `nil`.
 @sa RtccAttendeeDelegate::rtccAttendeeAuthorization:forMeeting:
 @sa Rtcc::meetingPointJoinConferenceHost: for the matching Host function.
 @warning To be called only after the host accepts the join request or the attendee receives an invite. Calling otherwise will lead to a call error.
 @since 5.3
 */
- (void)meetingPointJoinConferenceAttendee:(NSString *)mpID __attribute__((nonnull (1)));


/**
 @brief Used by an attendee to respond to an invitation to join a meeting point. 
 
 Attendee Only. Should be send in response to a RtccAttendeeDelegate::rtccAttendeeWasInvitedToMeeting:.
 @param mpID The meeting point ID. Must not be `nil`.
 @param accept YES if the attendee accepts to join the meeting point. NO if not.
 @sa Rtcc::meetingPoint:inviteUser:
 @sa RtccAttendeeDelegate::rtccAttendeeWasInvitedToMeeting:
 @since 5.3
 */
- (void)meetingPoint:(NSString *)mpID attendeeAnswersToInvite:(BOOL)accept __attribute__((nonnull (1)));


/**
 @brief Join a meeting point using its ID and a hash.
 
 The only way to have a hash is to be accepted beforehand.
 @param mpID The meeting point ID. Must not be `nil`.
 @param hash The hash for the Meeting Point. Provided by an implementation of JS in standalone mode.
 @since 5.4.1
 */
- (void)meetingPoint:(NSString *)mpID joinWithHash:(NSString *)hash __attribute__((nonnull (1,2)));

@end


