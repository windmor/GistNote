//
//  HMExceptions.m
//  GistNotes
//
//  Created on 26/02/15.
//  Copyright (c) 2015  . All rights reserved.
//

#import "HMExceptions.h"

//======================
// INTERNAL exceptions
//======================

@implementation ingInternalException
- (instancetype)initWithReason:(NSString *)aReason
                      userInfo:(NSDictionary *)aUserInfo
{
    self = [super initWithName:EXCEPTION_NAMES[EXCEPTION_INTERNAL]
                        reason:aReason
                      userInfo:aUserInfo];
    return self;
}
@end

@implementation ingVirtualFunctionCallException
- (instancetype)initWithReason:(NSString *)aReason
                      userInfo:(NSDictionary *)aUserInfo
{
    self = [super initWithName:EXCEPTION_NAMES[EXCEPTION_VIRT_FUNTION_CALLED]
                        reason:aReason
                      userInfo:aUserInfo];
    return self;
}
@end

//======================
// GUI exceptions
//======================

@implementation ingGUIException
- (instancetype)initWithReason:(NSString *)aReason
                      userInfo:(NSDictionary *)aUserInfo
{
    self = [super initWithName:EXCEPTION_NAMES[EXCEPTION_GUI]
                        reason:aReason
                      userInfo:aUserInfo];
    return self;
}
@end

//=====================
// NETWORK exceptions
//=====================

@implementation ingNetworkException
- (instancetype)initWithReason:(NSString *)aReason
                      userInfo:(NSDictionary *)aUserInfo
{
    self = [super initWithName:EXCEPTION_NAMES[EXCEPTION_NETWORK]
                        reason:aReason
                      userInfo:aUserInfo];
    return self;
}
@end

//=========================
// BAD RESPONSE exceptions
//=========================

@implementation ingBadResponseException : NSException
- (instancetype)initWithReason:(NSString *)aReason
                      userInfo:(NSDictionary *)aUserInfo
{
    self = [super initWithName:EXCEPTION_NAMES[EXCEPTION_BAD_RESPONSE]
                        reason:aReason
                      userInfo:aUserInfo];
    return self;
}
@end
