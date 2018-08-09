//
//  ConferenceParticipantsTable.h
//  Rainbow
//
//  Created by Vladimir Vyskocil on 30/05/2017.
//  Copyright © 2017 ALE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConferenceParticipant.h"

@interface ConferenceParticipantsTable : NSObject<NSFastEnumeration>
@property (nonatomic, readonly) NSDictionary<ConferenceParticipantId *, ConferenceParticipant *> *participants;
@property(readonly, copy) NSArray<ConferenceParticipant *> *allValues;
@property(readonly) NSUInteger count;

- (ConferenceParticipant *)objectForKey:(ConferenceParticipantId *)aKey;

/**
 * Add or update a conference participant
 *
 * @param participant the conference participant to add if not already in the conference or to update
 *
 * @return YES if the participant was already in the conference
 */
-(BOOL) addOrUpdateParticipant:(ConferenceParticipant *)participant;

/**
 * Remove a participant
 *
 * @param participantId the id of the participant to remove
 *
 * @return YES if the participant was in the conference and has been removed
 */
-(BOOL) removeParticipant:(ConferenceParticipantId *)participantId;
@end
