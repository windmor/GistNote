//
//  HMStorageAPI.m
//  GistNotes
//
//  Created
//  Copyright (c) 2015  . All rights reserved.
//

#import "HMStorageAPI.h"
#import "Gist.h"
#import "CCDataController.h"

//================
// Storage API
//================

@implementation HMStorageAPI

static HMStorageAPI *_default = nil;
static dispatch_once_t safer;

//==============================
// Init 
//==============================

- (instancetype)init
{
    if((self = [super init])) {
        defaultsDB = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

//==============================
// Get storage singleton
//==============================

+ (HMStorageAPI *)getInstance
{
    if (_default != nil)
    {
        return _default;
    }
    
    dispatch_once(&safer, ^(void)
                  {
                      _default = [[HMStorageAPI alloc] init];
                  });
    return _default;
}

//=================================================
// Save user's data to the User Default Database
//=================================================

- (void)saveData:(id)data
          forKey:(NSString*)key
{
    [defaultsDB setObject:data forKey:key];
    [defaultsDB synchronize];
}

//===================================================
// Remove user's data from the User Default Database
//===================================================

- (void)removeDataByKey:(NSString*)key
{
    [defaultsDB removeObjectForKey:key];
    [defaultsDB synchronize];
}

//=================================================
// Get user's data from the User Default Database
//=================================================

- (id)getDataByKey:(NSString*)key
{
    if ([defaultsDB stringForKey:key]) {
        return [defaultsDB stringForKey:key];
    }
    return nil;
}

//=================================================
// save gists
//=================================================

- (void)saveContext
{
    NSError *error = nil;
    
    [[[CCDataController getInstance] managedObjectContext] save:&error];
    // Save the object to persistent store
    if (![[[CCDataController getInstance] managedObjectContext] save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

- (NSMutableArray*)getSavedGists
{
    NSMutableArray* arrGists = [[NSMutableArray alloc] init];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Gist"];
    arrGists = [[[[CCDataController getInstance] managedObjectContext]
                        executeFetchRequest:fetchRequest
                        error:nil] mutableCopy];
    
    return arrGists;
}

- (NSMutableArray*)getSavedNotes
{
    NSMutableArray* arrNotes = [[NSMutableArray alloc] init];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Note"];
    arrNotes = [[[[CCDataController getInstance] managedObjectContext]
                 executeFetchRequest:fetchRequest
                 error:nil] mutableCopy];
    
    return arrNotes;
}


- (Gist*)isGistIsSaved:(NSString*)gistId
{
    NSError *error = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Gist"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"gist_id == %@", gistId]];
    [request setFetchLimit:1];
    NSArray *saved_gist = [[[CCDataController getInstance] managedObjectContext] executeFetchRequest:request
                                                                                               error:&error];
    if (saved_gist.count > 0)
        return saved_gist[0];
    
    return nil;
}

- (Note*)isNoteIsSaved:(NSString*)gistId
{
    NSError *error = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Note"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"initial_gist.gist_id == %@", gistId]];
    [request setFetchLimit:1];
    NSArray *saved_note = [[[CCDataController getInstance] managedObjectContext] executeFetchRequest:request
                                                                                               error:&error];
    if (saved_note.count > 0)
        return saved_note[0];
    
    return nil;
}

@end














