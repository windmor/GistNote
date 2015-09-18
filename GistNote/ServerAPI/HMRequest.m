//
//  request.m
//  GistNotes
//
//  Created
//  Copyright (c) 2015  . All rights reserved.
//

#import "HMRequest.h"

#import "JSONKit.h"

@implementation HMRequest

//==============================
// GET request
//==============================

- (void)GET_RequestWithURL:(NSString*)reqURL
              withCallback:(completionBlockData)callback
          andCallbackError:(completionBlockError)callbackError
{
    
    NSLog(@"Url = %@", reqURL);
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                 delegate: self
                                                            delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:reqURL]];
    
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest
                                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                            [self forUrl:reqURL
                                                                    data:data
                                                            receivedWith:response
                                                               withError:error
                                                            withCallback:callback
                                                        andCallbackError:callbackError];
                                                        }];
    
    [dataTask resume];
}

//==============================
// POST request
//==============================

- (void)POST_RequestWithURL:(NSString*)reqURL
              andParameters:(NSDictionary*)parametersDict
               withCallback:(completionBlockData)callback
           andCallbackError:(completionBlockError)callbackError
{
    NSLog(@"*** =========================");
    NSLog(@"POST parameters: %@", parametersDict);
    NSLog(@"*** =========================");
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                 delegate: nil
                                                            delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:reqURL]];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString* parameters = @"";
    for (NSString* key in parametersDict) {
        if (parameters.length > 0) parameters = [NSString stringWithFormat:@"%@&", parameters];
        parameters = [NSString stringWithFormat:@"%@%@=%@", parameters, key, parametersDict[key]];
    }
    
    [urlRequest setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           [self forUrl:reqURL
                                                                   data:data
                                                           receivedWith:response
                                                              withError:error
                                                           withCallback:callback
                                                       andCallbackError:callbackError];
                                                       }];
    [dataTask resume];
}

//==============================
// data receiver
//==============================

- (void)forUrl:(NSString*)reqURL
          data:(NSData*)data
  receivedWith:(NSURLResponse*)response
     withError:(NSError*)error
  withCallback:(completionBlockData)callback
andCallbackError:(completionBlockError)callbackError
{
    if(error == nil)
    {
        NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
        NSLog(@"*** =========================");
        NSLog(@"Url = %@", reqURL);
        NSLog(@"Req = %@", text);
        NSLog(@"*** =========================");
        
        //=====
        
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
        if (HTTPResponse.statusCode >= 200 &&
            HTTPResponse.statusCode < 300)
        {
            callback(data);
        } else {
            FUNCT_EXC_SERV(kErrorBadResponse, kLogLevelAlert, kModuleServerAPI, NSLocalizedString(@"SERVER_ERROR", nil));
            callbackError(error);
        }

    } else callbackError(error);
}

@end
