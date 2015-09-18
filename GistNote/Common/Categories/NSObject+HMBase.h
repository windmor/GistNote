//
//  NSObject+HMBase.h
//  GistNotes
//
//  Created on 26/02/15.
//  Copyright (c) 2015  . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HMBase)

// error handler
- (void)errorHandlingWithCode:(kErrorCode)errorCode
                 withLogLevel:(kLogLevel)logLevel
                     inModule:(kModuleCode)moduleID
                withMessageID:(kErrorMsgCode)errorMessageID
                   methodData:(NSString*)methodData;

// error handler
- (void)errorHandlingWithCode:(kErrorCode)errorCode
                 withLogLevel:(kLogLevel)logLevel
                     inModule:(kModuleCode)moduleID
                  withMessage:(NSString*)errorMessage
                   methodData:(NSString*)methodData;

// error handler for appdelegate
- (void)errorHandlingWithCode:(kErrorCode)errorCode
                     inModule:(kModuleCode)moduleID
                withMessageID:(kErrorMsgCode)errorMessageID
                   stackTrace:(NSString*)stackTrace;

// begin log
- (void)beginLog;

// serverAPIError
- (void)serverAPIError;


@end
