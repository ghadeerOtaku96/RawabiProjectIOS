/*
 * Rainbow
 *
 * Copyright (c) 2016-2017, ALE International
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
#import "Contact.h"


/**
 *  RTCCall type
 */
typedef NS_ENUM(NSInteger, RTCCallFeatureFlags) {
    /**
     *  Audio feature
     */
    RTCCallFeatureAudio = 1 << 0,
    /**
     *  Remote Video available
     */
    RTCCallFeatureRemoteVideo = 1 << 1,
    /**
     * Local video available
     */
    RTCCallFeatureLocalVideo = 1 << 2
};

/**
 *  RTCCall status
 */
typedef NS_ENUM(NSInteger, RTCCallStatus) {
    /**
     *  Call is ringing
     */
    RTCCallStatusRinging = 0,
    /**
     *  Call is accepted, we can proceed and establish
     */
    RTCCallStatusConnecting,
    /**
     *  Call is declined.
     */
    RTCCallStatusDeclined,
    /**
     *  Call has not been accepted/decline in time.
     */
    RTCCallStatusTimeout,
    /**
     *  Call has been canceled
     */
    RTCCallStatusCanceled,
    /**
     *  Call has been established
     */
    RTCCallStatusEstablished,
    /**
     *  Call has been hangup
     */
    RTCCallStatusHangup,
};


@interface RTCCall : NSObject

@property(nonatomic, readonly) NSUUID *callID;

@property(nonatomic, readonly) NSString *jingleSessionID;

@property(nonatomic, readonly) Contact *contact;

@property(nonatomic, readonly) BOOL isIncoming;

@property(nonatomic, readonly) RTCCallStatus status;

@property(nonatomic, readonly) RTCCallFeatureFlags features;

@property (nonatomic, readonly) NSDate *connectionDate;

-(BOOL) isAudioEnabled;

-(BOOL) isVideoEnabled;

-(BOOL) isLocalVideoEnabled;

-(BOOL) isRemoteVideoEnabled;

@property (nonatomic, readonly) BOOL isSharingEnabled;
@end
