//
//  HMStrings.m
//  GistNotes
//
//  Created on 26/02/15.
//  Copyright (c) 2015  . All rights reserved.
//

#import "HMStrings.h"

//================================
// Segue IDs
//================================

NSString * SEGUE_SHOW_ALL   = @"show_all";
NSString * SEGUE_SHOW_GISTS = @"show_gists";
NSString * SEGUE_SHOW_NOTES = @"show_notes";

NSString * SEGUE_GIST_DETAIL = @"show_gist_detail";

//=====================
// Storyboard ID's
//=====================
NSString * STORYBOARD_ID_GIST_DETAIL  = @"CCGistDetail";

//=========================
// Notifications
//=========================
NSString * NOTIFICATION_NEED_TO_UP = @"need_to_update_ctrl";;


//=====================
// modules names
//=====================
__unsafe_unretained NSString* MODULE_NAMES[] =
{
    @"ServerAPI",
    @"StorageAPI",
    @"App",
};

//=====================
// Log level names
//=====================
__unsafe_unretained NSString* LOG_LEVEL[] =
{
    @"EMERGENCY",
    @"ALERT",
    @"CRITICAL",
    @"ERROR",
    @"WARNING",
    @"NOTICE",
    @"INFO",
    @"DEBUG",
    @"EXCEPTION",
    @"UNEXPECTED LOG LEVEL"
};

//=====================
// exceptions
//=====================
__unsafe_unretained NSString* EXCEPTION_NAMES[] =
{
    @"EXCEPTION_AUTH",
    @"EXCEPTION_INTERNAL",
    @"EXCEPTION_VIRT_FUNTION_CALLED",
    @"EXCEPTION_GUI",
    @"EXCEPTION_NETWORK",
    @"EXCEPTION_BAD_RESPONSE"
};


@implementation HMStrings


//====================================
// Format Log level to string
//====================================

+ (NSString*)formatLogLevelToString:(kLogLevel)logType
{
    NSString *result = nil;
    
    int logLevelCount = (sizeof LOG_LEVEL) / (sizeof LOG_LEVEL[0]);
    
    if (logType < logLevelCount) {
        result = LOG_LEVEL[logType];
    } else {
        [NSException raise:NSGenericException format:@"%@", NSLocalizedString(@"UNEXPECTED_LOG_LEVEL", nil)];
    }
    
    return result;
}

@end
