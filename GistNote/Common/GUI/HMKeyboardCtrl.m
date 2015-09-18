//
//  HMKeyboardViewController.m
//  GistNotes
//
//  Created
//  Copyright (c) 2015  . All rights reserved.
//

#import "HMKeyboardCtrl.h"

@interface HMKeyboardCtrl ()

@end

@implementation HMKeyboardCtrl

@synthesize activeField;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sView = (UIScrollView*)[self.view viewWithTag:1];
    
    _serverAPI = [HMServerAPI getInstance];
    _storageAPI = [HMStorageAPI getInstance];
    

    if (_endView)
        _endView.backgroundColor = [UIColor clearColor];
    
    [self addObservers];
    [self updateScrollViewHeight];
}

//==================
//
//==================

- (void)updateScrollViewHeight
{
    if (!_sView) return;
    
    [_sView setNeedsLayout];
    [_sView layoutIfNeeded];

    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    contentInsets.top = 0;
    
    _sView.contentInset = contentInsets;
    _sView.contentSize = CGSizeMake(self.view.frame.size.width, _endView.frame.origin.y);
    
    _scrollViewContentHeight = _sView.contentSize.height;
}


#pragma Text field

//================
//
//================

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}


//======================
// keyboard
//======================

- (void)keyboardDidShow:(NSNotification *)notification
{
    if (![[self class] isSubclassOfClass:[self.navigationController.childViewControllers.lastObject class]])
        return;
    
    UIEdgeInsets contentInsets;
    CGRect aRect = _sView.frame;
    [_sView setContentSize:CGSizeMake(_sView.frame.size.width, _scrollViewContentHeight)];
    
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [info[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    contentInsets = _sView.contentInset;
    contentInsets.bottom = kbRect.size.height;
    
    if (_sView.frame.origin.y > 0)
        contentInsets.bottom -= NAV_BAR_HEIGHT + STATUS_BAR_HEIGHT;
    
    _sView.contentInset = contentInsets;
    _sView.scrollIndicatorInsets = contentInsets;

    aRect.size.height -= kbRect.size.height;
    if (self.activeField) {
        if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
            [_sView scrollRectToVisible:self.activeField.frame animated:YES];
        }
    }
    if (self.activeView) {
        if (!CGRectContainsPoint(aRect, self.activeView.frame.origin) ) {
            [_sView scrollRectToVisible:self.activeView.frame animated:YES];
        }
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    if (![[self class] isSubclassOfClass:[self.navigationController.childViewControllers.lastObject class]])
        return;
    
    [_sView setContentSize:CGSizeMake(_sView.frame.size.width, _scrollViewContentHeight)];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    contentInsets.top = NAV_BAR_HEIGHT + STATUS_BAR_HEIGHT;
    if (_sView.frame.origin.y > 0)
        contentInsets.bottom = 0;
    
    _sView.contentInset = contentInsets;
    _sView.scrollIndicatorInsets = contentInsets;
}

//======================
// Text field's events
//======================

- (IBAction)textFieldDidBeginEditing:(UITextField *)sender
{
    self.activeField = sender;
}

- (IBAction)textFieldDidEndEditing:(UITextField *)sender
{
    self.activeField = nil;
}

- (void)disableActiveField
{
    [self.activeField resignFirstResponder];
    self.activeField = nil;
}

//======================
// Text view's events
//======================

- (IBAction)textViewDidBeginEditing:(UITextView *)textView
{
    self.activeView = textView;
}

- (IBAction)textViewDidEndEditing:(UITextView *)textView
{
    self.activeView = nil;
}

//======================
// View was tapped
//======================

- (IBAction)onTap:(id)sender
{
    if (self.activeField) {
        [self.activeField resignFirstResponder];
    }
    if (self.activeView) {
        [self.activeView resignFirstResponder];
    }
}






@end









