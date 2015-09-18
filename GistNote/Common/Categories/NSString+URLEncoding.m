//
//  NSString+URLEncoding.m
//  GistNotes
//
//  Created on 25/02/15.
//  Copyright (c) 2015  . All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                               (CFStringRef)self,
                                                               NULL,
                                                               (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% {}<>,",
                                                               CFStringConvertNSStringEncodingToEncoding(encoding)));
}

@end
