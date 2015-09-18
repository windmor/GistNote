 //
//  serverAPI.m
//  GistNotes
//
//  Created
//  Copyright (c) 2015  . All rights reserved.
//

#import "HMServerAPI.h"

#import "HMRequest.h"
#import "JSONKit.h"
#import "Reachability.h"

#import "Gist.h"
#import "User.h"

#import "CCDataController.h"
#import "NSString+URLEncoding.h"

#define sortDescriptorDistance [NSSortDescriptor sortDescriptorWithKey:@"object_distance" ascending:YES]

@implementation HMServerAPI

static HMServerAPI *_default = nil;
static dispatch_once_t safer;

//==============================
// Init
//==============================

- (instancetype)init
{
    if (self = [super init]) {
        _storageAPI = [HMStorageAPI getInstance];
    }
    return self;
}

//==============================
// Get api singleton
//==============================

+ (HMServerAPI *)getInstance
{
    if (_default != nil)
    {
        return _default;
    }
    
    dispatch_once(&safer, ^(void)
                  {
                      _default = [[HMServerAPI alloc] init];
                  });
    return _default;
}

//==============================
// is_internet_access
//==============================

- (BOOL)is_internet_access
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}



//==============================
//
//==============================

//====================
// get gists
//====================

- (void)getGistsWithCallback:(completionBlockArr)callback
            andCallbackError:(completionBlockError)callbackError
{
    if(![self is_internet_access]) {
        FUNCT_EXC(kErrorNetwork, kLogLevelAlert, kModuleServerAPI, MSG_ErrorNetwork);
        return;
    }
    
    HMRequest* req = [[HMRequest alloc] init];
    [req GET_RequestWithURL:[NSString stringWithFormat:@"%@/gists/public", SERVER_URL]
               withCallback:^(NSData *response) {
                   [self fillGistsWithData:response
                              withCallback:callback];
               }
           andCallbackError:^(NSError *error) {
               callbackError(error);
           }];
}

//==============================
// fill Gists
//==============================

- (void)fillGistsWithData:(NSData*)data
             withCallback:(completionBlockArr)callback
{
    NSDictionary *data_dict = [data objectFromJSONData];
    
    NSEntityDescription *entityGist = [NSEntityDescription entityForName:@"Gist"
                                                  inManagedObjectContext:[[CCDataController getInstance] managedObjectContext]];
    NSEntityDescription *entityUser = [NSEntityDescription entityForName:@"User"
                                                  inManagedObjectContext:[[CCDataController getInstance] managedObjectContext]];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (NSDictionary* data_item in data_dict) {
        @autoreleasepool {
            Gist* gist = nil;
            gist = [_storageAPI isGistIsSaved:[self getStringFromValue:data_item[@"id"]]];
            if (!gist)  {
                gist = [[Gist alloc] initWithEntity:entityGist
                           insertIntoManagedObjectContext:[[CCDataController getInstance] managedObjectContext]];
                gist.gist_id    = [self getStringFromValue:data_item[@"id"]];
                gist.desc       = [self getStringFromValue:data_item[@"description"]];
                
                if (data_item[@"owner"]) {
                    User* user = [[User alloc] initWithEntity:entityUser
                               insertIntoManagedObjectContext:[[CCDataController getInstance] managedObjectContext]];
                    user.name       = [self getStringFromValue:data_item[@"owner"][@"login"]];
                    user.avatar_url = [self getStringFromValue:data_item[@"owner"][@"avatar_url"]];
                    gist.owner = user;
                } else {
                    gist.owner = nil;
                }
            }
            [arr addObject:gist];
        }
    }
    if (arr.count > 0) {
        [_storageAPI saveContext];
    }
    
    callback(arr);
}

- (void)saveNote:(Note*)newNote
    withCallback:(completionBlockBool)callback
andCallbackError:(completionBlockError)callbackError
{
    [_storageAPI saveContext];
    callback(true);
}

//==============================
// get saved gists
//==============================

- (void)getSavedGistsWithCallback:(completionBlockArr)callback
                 andCallbackError:(completionBlockError)callbackError
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    arr = [_storageAPI getSavedGists];
    
    if (!arr) callbackError([[NSError alloc] init]);
    
    callback(arr);
}

//==============================
// get saved nodes
//==============================

- (void)getSavedNotesWithCallback:(completionBlockArr)callback
                 andCallbackError:(completionBlockError)callbackError
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    arr = [_storageAPI getSavedNotes];
    
    if (!arr) callbackError([[NSError alloc] init]);
    
    callback(arr);
}















//==============================
// set html
//==============================

- (NSString *)styledHTMLwithHTML:(NSString *)HTML
{
    NSString *style = @"<meta charset=\"UTF-8\"><style> body { font-family: 'HelveticaNeue'; font-size: 14px; } * {text-align: left !important;} </style>";
    
    return [NSString stringWithFormat:@"%@%@", style, HTML];
}

//==============================
// Get attributed str
//==============================

- (NSAttributedString*)getAttrStringFromStr:(NSString*)str
{
    if (!str || str.length == 0) return [[NSAttributedString alloc] initWithString:@""];
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[[self styledHTMLwithHTML:str] dataUsingEncoding:NSUnicodeStringEncoding]
                                                                    options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                         documentAttributes:nil
                                                                      error:nil];
    
    return attrStr;

}

//==============================
// Get string from value
//==============================

- (NSString*)getStringFromValue:(id)value
{
    if (!value || [[value class] isSubclassOfClass:[NSNull class]]) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%@", value];
}

//==============================
// Get int from value
//==============================

- (int)getIntFromValue:(id)value
{
    if ([[value class] isSubclassOfClass:[NSNull class]]) {
        return 0;
    }
    
    return (int)[value integerValue];
}

//==============================
// Get float from value
//==============================

- (float)getFloatFromValue:(id)value
{
    if ([[value class] isSubclassOfClass:[NSNull class]]) {
        return 0;
    }
    
    return (float)[value floatValue];
}

//==============================
// Get float from value
//==============================

- (int)getDoubleFromValue:(id)value
{
    if ([[value class] isSubclassOfClass:[NSNull class]]) {
        return 0;
    }
    
    return (double)[value doubleValue];
}

//==============================
// Get ull from value
//==============================

- (long)getLongFromValue:(id)value
{
    if ([[value class] isSubclassOfClass:[NSNull class]]) {
        return 0;
    }
    
    return (long)[value longValue];
}

//==============================
// Get bool from value
//==============================

- (bool)getBoolFromValue:(id)value
{
    if ([[value class] isSubclassOfClass:[NSNull class]]) {
        return 0;
    }
    
    return (bool)[value boolValue];
}

@end


























