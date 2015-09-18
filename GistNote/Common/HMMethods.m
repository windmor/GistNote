//
//  HMMethods.m
//  GistNotes
//
//  Created on 26/02/15.
//  Copyright (c) 2015  . All rights reserved.
//

#import "HMMethods.h"

@implementation HMMethods

//==================================
// Get UI element from storyboard
//==================================

+ (id)getUIElementFromStoryboardView:(UIView*)parentView
                             withTag:(int)tag
{
    id uiElement = [parentView viewWithTag:tag];
    
    if (!uiElement) {
        FUNCT_EXC(kErrorUIElementWasNotFound, kLogLevelEmergency, kModuleApp, MSG_UIElementWasNotFound);
    }
    
    return uiElement;
}

//=========================
// Show alert with msg
//=========================

+ (void)showAlertWithTitle:(NSString*)title
                    andMsg:(NSString*)msg
                   forCtrl:(id)ctrl
{
    if ([UIAlertController class])
    {
        // use UIAlertController
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:title
                                   message:msg
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"BTN_OK", nil)
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
        [alert addAction:ok];
    
        [ctrl presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        // use UIAlertView
        UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:title
                                                         message:msg
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"BTN_OK", nil)
                                               otherButtonTitles:nil];
        
        dialog.alertViewStyle = UIAlertViewStyleDefault;
        dialog.tag = 400;
        [dialog show];
    }
}

@end





















