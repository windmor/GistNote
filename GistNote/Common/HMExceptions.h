//
//  HMExceptions.h
//  GistNotes
//
//  Created on 26/02/15.
//  Copyright (c) 2015  . All rights reserved.
//

#import <Foundation/Foundation.h>

//======================
// INTERNAL exceptions
//======================

@interface ingInternalException : NSException
- (instancetype)initWithReason:(NSString *)aReason
                      userInfo:(NSDictionary *)aUserInfo;
@end

@interface ingVirtualFunctionCallException : NSException
- (instancetype)initWithReason:(NSString *)aReason
                      userInfo:(NSDictionary *)aUserInfo;
@end

//======================
// GUI exceptions
//======================

@interface ingGUIException : NSException
- (instancetype)initWithReason:(NSString *)aReason
                      userInfo:(NSDictionary *)aUserInfo;
@end

//======================
// NETWORK exceptions
//======================

@interface ingNetworkException : NSException
- (instancetype)initWithReason:(NSString *)aReason
                      userInfo:(NSDictionary *)aUserInfo;
@end

//=========================
// BAD RESPONSE exceptions
//=========================

@interface ingBadResponseException : NSException
- (instancetype)initWithReason:(NSString *)aReason
                      userInfo:(NSDictionary *)aUserInfo;
@end