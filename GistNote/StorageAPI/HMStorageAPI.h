//
//  HMStorageAPI.h
//  GistNotes
//
//  Created
//  Copyright (c) 2015  . All rights reserved.
//

#import <Foundation/Foundation.h>

@class Gist, Note;

//================
// Storage API
//================

@interface HMStorageAPI : NSObject
{
    // User Default Database
    NSUserDefaults *defaultsDB;
}

// Get storage singleton 
+ (HMStorageAPI *)getInstance;

// Save user's data to the User Default Database
- (void)saveData:(id)data
          forKey:(NSString*)key;

// Remove user's data from the User Default Database
- (void)removeDataByKey:(NSString*)key;

// Get user's data from the User Default Database
- (id)getDataByKey:(NSString*)key;

- (void)saveContext;
- (NSMutableArray*)getSavedGists;
- (NSMutableArray*)getSavedNotes;
- (Gist*)isGistIsSaved:(NSString*)gistId;
- (Note*)isNoteIsSaved:(NSString*)gistId;

@end












