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
#import "Contact.h"

typedef NSString ConferenceParticipantId;

#define kParticipantRoleModerator    @"moderator"
#define kParticipantRoleMember       @"member"
typedef NS_ENUM(NSInteger, ParticipantRole) {
    /**
     *  Moderator role
     */
    ParticipantRoleModerator = 0,

    /**
     *  Attendee role
     */
    ParticipantRoleMember
};

#define kParticipantTypeUnmuted      @"unmuted"
#define kParticipantTypeMuted        @"muted"

#define kParticipantStateRinging    @"ringing"
#define kParticipantStateConnected  @"connected"
#define kParticipantStateDisconnected  @"disconnected"
typedef NS_ENUM(NSInteger, ParticipantState) {
    ParticipantStateUnknown = -1,
    /**
     *  Call is ringing
     */
    ParticipantStateRinging = 0,
    
    /**
     *  The participant is connected
     */
    ParticipantStateConnected,
    
    /**
     *  The participant is disconnected
     */
    ParticipantStateDisconnected
};


@interface ConferenceParticipant : NSObject

@property (nonatomic, readonly) Contact *contact;
@property (nonatomic, readonly) ConferenceParticipantId *participantId;
@property (nonatomic, readonly) NSString *jidIM;
@property (nonatomic, readonly) NSString *phoneNumber;
@property (nonatomic, readonly) ParticipantRole role;
@property (nonatomic, readonly) BOOL muted;
@property (nonatomic, readonly) BOOL hold;
@property (nonatomic, readonly) ParticipantState state;

+(ParticipantRole) participantRoleFromNSString:(NSString *)roleStr;
+(ParticipantState) participantStateFromNSString:(NSString *)stateStr;

-(instancetype) initWithParticipantId:(NSString *)id jidIM:(NSString *)jidIM phoneNumber:(NSString *)phoneNumber role:(ParticipantRole)role state:(ParticipantState)state muted:(BOOL) muted hold:(BOOL) hold;

@end
