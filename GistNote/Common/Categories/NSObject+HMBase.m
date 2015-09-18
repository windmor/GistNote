//
//  NSObject+HMBase.m
//  GistNotes
//
//  Created on 26/02/15.
//  Copyright (c) 2015  . All rights reserved.
//

#import "NSObject+HMBase.h"

#include <pthread.h>

@implementation NSObject (HMBase)

//================================
// error handler
//================================

- (void)errorHandlingWithCode:(kErrorCode)errorCode
                 withLogLevel:(kLogLevel)logLevel
                     inModule:(kModuleCode)moduleID
                withMessageID:(kErrorMsgCode)errorMessageID
                   methodData:(NSString*)methodData
{
    // log
    NSString* logString = [NSString stringWithFormat:@"Module: %@\nMnemonic: %@\nMessage: %@\nMethod: %@",
                           MODULE_NAMES[moduleID], errorMessages[errorMessageID].mnemonic_text,
                           NSLocalizedString(errorMessages[errorMessageID].msg_text, nil), methodData];
    [self addLog:logLevel logString:logString];
    
    
    //action
    switch(logLevel) {
        case kLogLevelEmergency:
            [self showAlertWithTitle:NSLocalizedString(@"APP_NAME", nil)
                    andUserErrorCode:errorMessages[errorMessageID].msg_for_user
                    withTargetMethod:@"closeAppWithException"];
            break;
        case kLogLevelAlert:
            [self showAlertWithTitle:NSLocalizedString(@"APP_NAME", nil)
                    andUserErrorCode:errorMessages[errorMessageID].msg_for_user
                    withTargetMethod:nil];
            break;
        case kLogLevelCritical:
            
            break;
        case kLogLevelError:
            
            break;
        case kLogLevelWarning:
            
            break;
        case kLogLevelNotice:
            
            break;
        case kLogLevelInfo:
            
            break;
        case kLogLevelDebug:
            
            break;
        default:
            [NSException raise:NSGenericException format:@"%@", NSLocalizedString(errorMessages[MSG_ErrorUnexpected].msg_text, nil)];
    }
}

//================================
// error handler
//================================

- (void)errorHandlingWithCode:(kErrorCode)errorCode
                 withLogLevel:(kLogLevel)logLevel
                     inModule:(kModuleCode)moduleID
                  withMessage:(NSString*)errorMessage
                   methodData:(NSString*)methodData
{
    // log
    NSString* logString = [NSString stringWithFormat:@"Module: %@\nMnemonic: %@\nMessage: %@\nStack: %@",
                           MODULE_NAMES[moduleID], errorMessage,
                           errorMessage, methodData];
    [self addLog:logLevel logString:logString];
    [self showAlertWithTitle:NSLocalizedString(@"APP_NAME", nil)
             andUserErrorMsg:errorMessage
            withTargetMethod:nil];
}

//================================
// error handler for appdelegate
//================================

- (void)errorHandlingWithCode:(kErrorCode)errorCode
                     inModule:(kModuleCode)moduleID
                withMessageID:(kErrorMsgCode)errorMessageID
                   stackTrace:(NSString*)stackTrace
{
    // log
    NSString* logString = [NSString stringWithFormat:@"Module: %@\nMnemonic: %@\nMessage: %@\nStack: %@",
                           MODULE_NAMES[moduleID], errorMessages[errorMessageID].mnemonic_text,
                           NSLocalizedString(errorMessages[errorMessageID].msg_text, nil), stackTrace];
    [self addLog:kLogLevelEmergency logString:logString];
}

//===========================
// close app with exception
//===========================

- (void)closeAppWithException
{
    [NSException raise:NSLocalizedString(@"APP_NAME", nil) format:@"exit"];
}

//================
// Log
//================

- (void)addLog:(kLogLevel)logLevel
     logString:(NSString*)logStr
{
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *timestamp = [formatter stringFromDate:time];
    
    mach_port_t machTID = pthread_mach_thread_np(pthread_self());
    
    NSMutableString* logString = [NSMutableString new];
    [logString setString:@"(\n"];
    [logString appendString:@"===========================================\n"];
    [logString appendString:[NSString stringWithFormat:@"*** %@  (%@)\n", [HMStrings formatLogLevelToString:logLevel], timestamp]];
    [logString appendString:@"===========================================\n"];
    [logString appendString:[NSString stringWithFormat:@"Thread: ID: %x, data: %@\n", machTID, [NSThread currentThread]]];
    [logString appendString:logStr];
    [logString appendString:@"\n===========================================\n"];
    [logString appendString:@")"];
    
    NSLog(@"%@", logString);
    
    //ingFileRw* fileRW = [ingFileRw getInstance];
    //[fileRW writeData:logString toFile:LOG_FILE_NAME];
}

//================
// Begin log
//================

- (void)beginLog
{
    NSArray *keys = @[ @"environment", @"arguments", @"hostName",
                       @"processName", @"processIdentifier",
                       @"operatingSystem", @"operatingSystemName",
                       @"operatingSystemVersionString", @"processorCount",
                       @"activeProcessorCount",
                       @"physicalMemory", @"systemUptime" ];
    
    NSMutableDictionary *info = [[[NSProcessInfo processInfo] dictionaryWithValuesForKeys: keys] mutableCopy];
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *timestamp = [formatter stringFromDate:time];
    
    NSMutableString* logString = [NSMutableString new];
    [logString setString:@"(\n"];
    [logString appendString:@"===========================================\n"];
    [logString appendString:[NSString stringWithFormat:@"*** APP START LOG  (%@)\n", timestamp]];
    [logString appendString:@"===========================================\n"];
    [logString appendString:[NSString stringWithFormat:@"%@", info]];
    [logString appendString:@"===========================================\n"];
    [logString appendString:@"(\n"];
    
    NSLog(@"%@", logString);
    
    //ingFileRw* fileRW = [ingFileRw getInstance];
    //[fileRW writeData:logString toFile:LOG_FILE_NAME];
}

//================================
// serverAPIError
//================================

- (void)serverAPIError
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
}

//================================
// alert
//================================

- (void)showAlertWithTitle:(NSString*)msgTitle
           andUserErrorMsg:(NSString*)userMsg
          withTargetMethod:(NSString*)callMethod
{
    // iOS7
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:msgTitle
                                                      message:userMsg
                                                     delegate:nil//self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles: nil];
    [alert show];
    
    //iOS8 - UIAlertController
}

- (void)showAlertWithTitle:(NSString*)msgTitle
          andUserErrorCode:(kErrorUMsgCode)userMsgID
          withTargetMethod:(NSString*)callMethod
{
    // iOS7
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:msgTitle
                                                      message:NSLocalizedString(errorMessagesForUser[userMsgID].msg_text, nil)
                                                     delegate:nil//self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles: nil];
    [alert show];
    
    //iOS8 - UIAlertController
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) { // OK btn
        
    }
}

@end
