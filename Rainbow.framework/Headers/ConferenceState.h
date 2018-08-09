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

/**
 *  The different conference state
 */
typedef NS_ENUM(NSInteger, ConferenceStateActive) {
    /**
     *  Unknown state
     */
    ConferenceStateActiveUnknown = 0,
    /**
     *  Active state
     */
    ConferenceStateActiveYes = 1,
    /**
     *  Not active state
     */
    ConferenceStateActiveNo = 2
};

/**
 *  The different conference state
 */
typedef NS_ENUM(NSInteger, ConferenceStateRecording) {
    /**
     *  Unknown state
     */
    ConferenceStateRecordingUnknown = 0,
    /**
     *  Active state
     */
    ConferenceStateRecordingYes = 1,
    /**
     *  Not active state
     */
    ConferenceStateRecordingNo = 2
};

/**
 *  The different conference talkers state
 */
typedef NS_ENUM(NSInteger, ConferenceStateTalkerActive) {
    /**
     *  Unknown state
     */
    ConferenceStateTalkerActiveUnknown = 0,
    /**
     *  Active state
     */
    ConferenceStateTalkerActiveYes = 1,
    /**
     *  Not active state
     */
    ConferenceStateTalkerActiveNo = 2
};

@interface ConferenceState : NSObject

@property (nonatomic, readonly) ConferenceStateActive state;
@property (nonatomic, readonly) ConferenceStateRecording recording;
@property (nonatomic, readonly) ConferenceStateTalkerActive talkerActive;

@end
