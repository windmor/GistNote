//
//  HMErrors.h
//  GistNotes
//
//  Created on 26/02/15.
//  Copyright (c) 2015  . All rights reserved.
//

#import <Foundation/Foundation.h>

//=====================
// Errors
//=====================
extern NSString * ERROR_IN_ARRAY;
extern NSString * SERVER_ERROR;

//=================================
// Error messages for user
//=================================

typedef struct _errorMessageForUserFormat {
    int msg_id;
    __unsafe_unretained NSString* msg_text;
} errorMessageForUserFormat;
extern const struct errorMessageForUserFormat errorMsgForUserFormat;

extern errorMessageForUserFormat errorMessagesForUser[];

//=================================
// Error messages
//=================================

typedef struct _errorMessageFormat {
    int msg_id;
    __unsafe_unretained NSString* msg_text;
    __unsafe_unretained NSString* mnemonic_text;
    kErrorUMsgCode msg_for_user;
} errorMessageFormat;
extern const struct errorMessageFormat errorMsgFormat;

extern errorMessageFormat errorMessages[];








@interface HMErrors : NSError
{
    // Error code
    kErrorCode _error_code;
    // Message code
    kErrorMsgCode _msg_code;
    // Log level
    kLogLevel _log_level;
    // Module code
    kModuleCode _module_code;
}

// Error code
@property (nonatomic) kErrorCode error_code;
// Message code
@property (nonatomic) kErrorMsgCode msg_code;
// Log level
@property (nonatomic) kLogLevel log_level;
// Module code
@property (nonatomic) kModuleCode module_code;

- (instancetype)initWithCode:(kErrorCode)errorCode
                 messageCode:(kErrorMsgCode)messageCode
                       level:(kLogLevel)logLevel
                      module:(kModuleCode)moduleCode;


@end
