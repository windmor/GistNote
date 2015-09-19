//
//  HMStrings.h
//  GistNotes
//
//  Created on 26/02/15.
//  Copyright (c) 2015  . All rights reserved.
//

#import <Foundation/Foundation.h>

//================================
// Segue IDs
//================================
extern NSString * SEGUE_SHOW_ALL;
extern NSString * SEGUE_SHOW_GISTS;
extern NSString * SEGUE_SHOW_NOTES;

extern NSString * SEGUE_GIST_DETAIL;

//=====================
// Storyboard ID's
//=====================
extern NSString * STORYBOARD_ID_GIST_DETAIL;

//=========================
// Notifications
//=========================
extern NSString * NOTIFICATION_NEED_TO_UP;

//=====================
// modules names
//=====================
extern __unsafe_unretained NSString* MODULE_NAMES[];

//=====================
// Log level names
//=====================
extern __unsafe_unretained NSString* LOG_LEVEL[];

//=====================
// exceptions
//=====================
extern __unsafe_unretained NSString* EXCEPTION_NAMES[];








@interface HMStrings : NSObject

//====================================
// Format Log level to string
//====================================
+ (NSString*)formatLogLevelToString:(kLogLevel)formatType;

@end
