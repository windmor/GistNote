//
//  HMErrors.m
//  GistNotes
//
//  Created on 26/02/15.
//  Copyright (c) 2015  . All rights reserved.
//

#import "HMErrors.h"

NSString * ERROR_IN_ARRAY = @"ERROR_IN_ARRAY";
NSString * SERVER_ERROR = @"SERVER_ERROR";

//=================================
// Error messages
//=================================

errorMessageFormat errorMessages[] = {
    {MSG_UIElementWasNotFound,      @"MSG_UIElementWasNotFound",        @"UIELNOTFND",  UMSG_EmergencyError},
    {MSG_ErrorVirtualFunctionCall,  @"MSG_ErrorVirtualFunctionCall",    @"VRTFNCCALL",  UMSG_EmergencyError},
    {MSG_ErrorUnexpected,           @"MSG_ErrorUnexpected",             @"UNEXPEXTYPE", UMSG_Warning},
    {MSG_ErrorNetwork,              @"MSG_ErrorNetwork",                @"NETERR",      UMSG_NetworkError},
    {MSG_ErrorBadResponse,          @"MSG_ErrorBadResponse",            @"BADRESP",     UMSG_BadResponse}
};

//=================================
// Error messages for user
//=================================

errorMessageForUserFormat errorMessagesForUser[] = {
    {UMSG_EmergencyError,   @"UMSG_EmergencyError"},
    {UMSG_Warning,          @"UMSG_Warning"},
    {UMSG_NetworkError,     @"UMSG_NetworkError"},
    {UMSG_BadResponse,      @"UMSG_BadResponse"}
};











@implementation HMErrors

- (instancetype)initWithCode:(kErrorCode)errorCode
                 messageCode:(kErrorMsgCode)messageCode
                       level:(kLogLevel)logLevel
                      module:(kModuleCode)moduleCode
{
    NSString* errorDomain = @"appErrorDomain";
    
    self.error_code = errorCode;
    self.msg_code = messageCode;
    self.log_level = logLevel;
    self.module_code = moduleCode;
    
    self = [super initWithDomain:errorDomain code:errorCode userInfo:nil];
    
    return self;
}

@end
