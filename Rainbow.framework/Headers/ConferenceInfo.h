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
#import "ConferenceState.h"
#import "ConferenceParticipantsTable.h"

@class ConferenceParticipant;

/**
 *  The different conference event types
 */
typedef NS_ENUM(NSInteger, ConferenceEventType) {
    /**
     *  Type unknown
     */
    ConferenceEventTypeUnknown = 0,
    /**
     *  Type conference state
     */
    ConferenceEventTypeState = 1,
    /**
     *  Type participants update
     */
    ConferenceEventTypeParticipantsUpdate = 2,
    /**
     *  Type participants removed
     */
    ConferenceEventTypeParticipantsRemoved = 3,
    /**
     *  Type conference talkers
     */
    ConferenceEventTypeTalkers = 4
};


@interface ConferenceInfo : NSObject
@property (nonatomic, readonly) NSString *confId;
@property (nonatomic, readonly) ConferenceEventType eventType;
@property (nonatomic, readonly) ConferenceState *state;
@property (nonatomic, readonly) ConferenceParticipantsTable *participants;
@property (nonatomic, readonly) NSArray<ConferenceParticipantId *> *removedParticipants;
@property (nonatomic, readonly) NSArray<ConferenceParticipantId *> *talkers;

-(void) addOrUpdateParticipant:(ConferenceParticipant *)participant;
-(void) addRemovedParticipant:(ConferenceParticipantId *)id;
-(void) addTalker:(ConferenceParticipantId *)id;
@end
