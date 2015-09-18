//
//  serverAPI.h
//  GistNotes
//
//  Created
//  Copyright (c) 2015  . All rights reserved.
//
//


#import <Foundation/Foundation.h>

#define SERVER_URL @"https://api.github.com"

typedef void (^completionBlockArr)      (NSMutableArray* response);
typedef void (^completionBlockBool)     (bool response);
typedef void (^completionBlockError)    (NSError *error);

@class Note, Gist;

@interface HMServerAPI : NSObject
{
    HMStorageAPI* _storageAPI;
}

// Get api singleton
+ (HMServerAPI *)getInstance;

//====================
// get gists
//====================

- (void)getGistsWithCallback:(completionBlockArr)callback
            andCallbackError:(completionBlockError)callbackError;

- (void)getSavedGistsWithCallback:(completionBlockArr)callback
                 andCallbackError:(completionBlockError)callbackError;


//====================
// save notes
//====================

- (void)saveNote:(Note*)newNote
    withCallback:(completionBlockBool)callback
andCallbackError:(completionBlockError)callbackError;

//====================
// get notes
//====================

- (void)getSavedNotesWithCallback:(completionBlockArr)callback
                 andCallbackError:(completionBlockError)callbackError;

@end






















