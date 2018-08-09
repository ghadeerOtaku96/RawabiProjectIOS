/*
 * Rainbow
 *
 * Copyright (c) 2016, ALE International
 * All rights reserved.
 *
 * ALE International Proprietary Information
 *
 * Contains proprietary/trade secret information which is the property of
 * ALE International and must not be made available to, or copied or used by
 * anyone outside ALE International without its written authorization
 *
 * Not to be disclosed or used except in accordance with applicable agreements.
 */

#import <Foundation/Foundation.h>
#import "RTCCall.h"
#import <WebRTC/WebRTC.h>


FOUNDATION_EXPORT NSString *const kRTCServiceDidAddCallNotification;
FOUNDATION_EXPORT NSString *const kRTCServiceDidUpdateCallNotification;
FOUNDATION_EXPORT NSString *const kRTCServiceDidRemoveCallNotification;

// The notification emmited when we have new stats available
FOUNDATION_EXPORT NSString *const kRTCServiceCallStatsNotification;

FOUNDATION_EXPORT NSString *const kRTCServiceDidAllowMicrophoneNotification;
FOUNDATION_EXPORT NSString *const kRTCServiceDidRefuseMicrophoneNotification;

FOUNDATION_EXPORT NSString *const kRTCServiceDidAddLocalVideoTrackNotification;
FOUNDATION_EXPORT NSString *const kRTCServiceDidRemoveLocalVideoTrackNotification;
FOUNDATION_EXPORT NSString *const kRTCServiceDidAddRemoteVideoTrackNotification;
FOUNDATION_EXPORT NSString *const kRTCServiceDidRemoveRemoteVideoTrackNotification;

/**
 *  Manage WebRTC calls (audio/video) made through Rainbow
 *  This allow to receive incoming RTC calls and also to start an outgoing call with somebody.
 *
 *  ### RTC service available notifications ###
 *   - kRTCServiceCallStatsNotification: `notification sent when new statistics are available`
 */
@interface RTCService : NSObject

// Provide your application icon name, this icon must be a 40 point icon that will be used as a mask for callkit screens
@property (nonatomic, strong) NSString *appIconName;
@property (readonly) NSArray<RTCCall *> *calls;
@property (nonatomic, readonly) BOOL hasActiveCalls;

/**
 *  Emit a new outgoing RTC call
 *
 *  @param contact The Rainbow contact to call, only an *online* *Rainbow* contact can be called
 *  @param features The features you want to enabled for this call (audio, video, audio+video, ..)
 *
 *  @return Return the newly create RTCCall, or `nil` on error
 *  @see RTCCall
 */
-(RTCCall *) beginNewOutgoingCallWithContact:(Contact *)contact withFeatures:(RTCCallFeatureFlags)features;

/**
 *  Cancel the given outgoing call
 *
 *  @param rtcCall the RTCCall to cancel
 *
 *  @see RTCCall
 */
-(void) cancelOutgoingCall:(RTCCall *)rtcCall;

/**
 *  Accept an incoming RTC call
 *
 *  @param rtcCall The incoming call to answer
 *  @param features The features you want to enabled for this call (audio, video, audio+video, ..)
 *
 *  @see RTCCall
 */
-(void) acceptIncomingCall:(RTCCall *)rtcCall withFeatures:(RTCCallFeatureFlags)features;

/**
 *  Decline an incoming RTC call
 *
 *  @param rtcCall The incoming call to answer
 *
 *  @see RTCCall
 */
-(void) declineIncomingCall:(RTCCall *)rtcCall;

/**
 *  Hang an ongoing RTC call
 *
 *  @param rtcCall the RTCCall to hangup
 *
 *  @see RTCCall
 */
-(void) hangupCall:(RTCCall *)rtcCall;

/**
 *  Check if a call is muted
 *  @param rtcCall the RTCCall to check
 *  @return `YES` if this call is muted, otherwise `NO`
 *  @see RTCCAll
 */
-(BOOL) isCallMuted:(RTCCall *) rtcCall;

/**
 *  Mute the local audio tracks of the given call
 *
 *  @param rtcCall the RTCCall to mute
 *
 *  @see RTCCall
 */
-(void) muteLocalAudioForCall:(RTCCall *)rtcCall;

/**
 *  Check if the speaker is enabled
 *  @return `YES` if speaker is enabled, otherwise return `NO`
 */
-(BOOL) isSpeakerEnabled;

/**
 *  Un-mute the local audio tracks of the given call
 *
 *  @param rtcCall the RTCCall to un-mute
 *
 *  @see RTCCall
 */
-(void) unMuteLocalAudioForCall:(RTCCall *)rtcCall;

/**
 *  Force audio to be played on speaker
 */
-(void) forceAudioOnSpeaker;

/**
 *  Un-force audio to be played on speaker
 */
-(void) unForceAudioOnSpeaker;

/** @name ContactsManager methods */

/**
 *  Ask to unlock the microphone
 */
-(void) requestMicrophoneAccess;

/**
 *
 * @return `YES` if the microphone access has been determined by the user otherwise @return `NO`
 */
@property (nonatomic, readonly) BOOL microphoneAccessAlreadyDetermined;

/**
 *
 * @return `YES` if the microphone access has been granted by the user otherwise @return `NO`
 */
@property (nonatomic, readonly) BOOL microphoneAccessGranted;

-(BOOL) handleContinueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^_Nullable)(NSArray * _Nullable))restorationHandler;

/**
 *  Get the remote video stream for the given call if exist.
 *  @return RTCMediaStream object if this call have one.
 */
-(RTCMediaStream *_Nullable) remoteVideoStreamForCall:(RTCCall* _Nonnull) call;

/**
 *  Get the local video stream for the given call if exist.
 *  @return RTCMediaStream object if this call have one.
 */
-(RTCMediaStream *_Nullable) localVideoStreamForCall:(RTCCall *_Nonnull) call;

-(void) addVideoMediaToCall:(RTCCall *_Nonnull) call;

-(void) removeVideoMediaFromCall:(RTCCall *_Nonnull) call;
@end
