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

@interface ConfEndpoint : NSObject
@property (nonatomic, readonly) NSString *userId;
@property (nonatomic, readonly) NSString *mediaType;
@property (nonatomic, readonly) NSString *providerUserId;
@property (nonatomic, readonly) NSString *confUserId;
@property (nonatomic, readonly) NSString *providerType;
@property (nonatomic, readonly) NSString *id;
@property (nonatomic, readonly) NSString *providerConfId;
@property (nonatomic, readonly) NSString *companyId;

@end
