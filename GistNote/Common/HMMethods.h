//
//  HMMethods.h
//  GistNotes
//
//  Created on 26/02/15.
//  Copyright (c) 2015  . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completionBlockStr)  (NSString* response);
typedef void (^completionBlockBool) (bool response);

@interface HMMethods : NSObject 

// Get UI element from storyboard
+ (id)getUIElementFromStoryboardView:(UIView*)parentView
                             withTag:(int)tag;

// Show alert with msg
+ (void)showAlertWithTitle:(NSString*)title
                    andMsg:(NSString*)msg
                   forCtrl:(id)ctrl;


@end










