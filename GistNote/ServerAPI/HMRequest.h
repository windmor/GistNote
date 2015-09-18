//
//  request.h
//  GistNotes
//
//  Created
//  Copyright (c) 2015  . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completionBlockData)     (NSData* response);
typedef void (^completionBlockError)    (NSError *error);

@interface HMRequest : NSObject <NSURLSessionDelegate>

// GET request
- (void)GET_RequestWithURL:(NSString*)reqURL
              withCallback:(completionBlockData)callback
          andCallbackError:(completionBlockError)callbackError;

// POST request
- (void)POST_RequestWithURL:(NSString*)reqURL
              andParameters:(NSDictionary*)parametersDict
               withCallback:(completionBlockData)callback
           andCallbackError:(completionBlockError)callbackError;

@end
