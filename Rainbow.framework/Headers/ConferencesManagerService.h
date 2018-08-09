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

#import "ConfEndpoint.h"
#import "ConferenceInfo.h"
#import "ConferenceState.h"
#import "ConferenceParticipant.h"
#import "ConferenceParticipantsTable.h"

static NSString *kConferenceStartedNotification = @"ConferenceStartedNotification";
static NSString *kConferenceTerminatedNotification = @"ConferenceTerminatedNotification";
static NSString *kConferenceParticipantAddedNotification = @"ConferenceParticipantAddedNotification";
static NSString *kConferenceParticipantRemovedNotification = @"ConferenceParticipantRemovedNotification";
static NSString *kConferenceTalkersChangedNotification = @"ConferenceTalkersChangedNotification";

@interface ConferencesManagerService : NSObject

typedef void (^ConferenceManagerSnapshotCompletionHandler) (NSDictionary *snapshot, NSError *error);
typedef void (^ConferenceManagerInitiateAudioConferenceCompletionHandler) (NSError *error);
typedef void (^ConferenceManagerJoinAudioConferenceCompletionHandler) (NSError *error);
typedef void (^ConferenceManagerTerminateAudioConferenceCompletionHandler) (NSError *error);

/** List of all Conference endpoints */
@property (nonatomic, readonly) NSArray<ConfEndpoint *> *confEndpoints;

/** List of active conference */
@property (nonatomic, readonly) NSDictionary<NSString *, ConferenceState *> *activeConferences;

/** Conference participants in the active conferences */
@property (nonatomic, readonly) NSDictionary<NSString *, ConferenceParticipantsTable *> *conferencesParticipants;

/** Conference talkers */
@property (nonatomic, readonly) NSDictionary<NSString *, NSArray<ConferenceParticipantId *> *> *conferencesTalkers;

/**
 * Initiate a audio conference 
 *
 * @param confId            the conference id to join
 * @param completionHandler the block called at the completion
 */
-(void) initiateAudioConferenceWithId:(NSString *)confId completionBlock:(ConferenceManagerInitiateAudioConferenceCompletionHandler) completionHandler;

/**
 * Terminate a audio conference
 *
 * @param confId            the conference id to terminate
 * @param completionHandler the block called at the completion
 */
-(void) terminateAudioConferenceWithId:(NSString *)confId completionBlock:(ConferenceManagerTerminateAudioConferenceCompletionHandler) completionHandler;

/** 
 * join a audio conference 
 *
 * @param confId            the conference id to join
 * @param phoneNumber       phone number in E.164 format
 * @param role              the role in the conference : member or moderator
 * @param muted             the state of the participant : muted or unmuted
 * @param country           country where the called number is from. If nil, the user's country is taken
 * @param completionHandler the block called at the completion
 */
-(void) joinAudioConferenceWithId:(NSString *)confId phoneNumber:(NSString *)phoneNumber role:(ParticipantRole)role muted:(BOOL)muted country:(NSString *)country completionBlock:(ConferenceManagerJoinAudioConferenceCompletionHandler) completionHandler;

/**
 * get a conference snapshot
 *
 * @param confId            the conference id
 * @param completionHandler the block called at the completion
 */
-(void) conferenceSnapshot:(NSString *)confId completionBlock:(ConferenceManagerSnapshotCompletionHandler) completionHandler;

/**
 * disconnect the conference participant using its participant id
 *
 * @param confId            the conference id
 * @param participantId     the id of the participant in the conference
 */
-(void) disconnectParticipant: (ConferenceParticipantId *)participantId InConference:(NSString *)confId;

/**
 * set the mute state of a conference participant
 *
 * @param mute              YES to mute, NO to unmute
 * @param confId            the conference id
 * @param participantId     the id of the participant to update
 */
-(void) updateMuteState:(BOOL)mute inConference:(NSString *)confId forParticipant:(ConferenceParticipantId *)participantId;

/**
 * set the mute state for all conference participants
 *
 * @param mute              YES to mute, NO to unmute
 * @param confId            the conference id
 */
-(void) updateMuteState:(BOOL)mute forConference:(NSString *)confId;

/**
 * return the conference participant using its participant id
 *
 * @param confId            the conference id
 * @param participantId     the id of the participant in the conference
 */
-(ConferenceParticipant *)participantFromConference: (NSString *)confId withParticipantId:(ConferenceParticipantId *)participantId;

/**
 * return the conference participant id using its jid
 *
 * @param confId            the conference id
 * @param jid               the jid of the user
 */
-(ConferenceParticipantId *)participantIdFromConference :(NSString *)confId withJid:(NSString *)jid;
@end
