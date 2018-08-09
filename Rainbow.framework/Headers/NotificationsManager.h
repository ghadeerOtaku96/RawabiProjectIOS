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

FOUNDATION_EXPORT NSString *const kNotificationsManagerHandleNotification;

/**
 *  Purpose of this class is to deal with all push notifications
 */
@interface NotificationsManager : NSObject
-(void) handleNotificationWithIdentifier:(NSString *)identifier withUserInfo:(NSDictionary *)userInfo withResponseInformation:(NSDictionary *) responseInfo;
-(void) didReceiveNotificationWithUserInfo:(NSDictionary *) userInfo;
@end
