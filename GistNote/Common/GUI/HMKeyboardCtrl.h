//
//  HMKeyboardViewController.h
//  GistNotes
//
//  Created
//  Copyright (c) 2015  . All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>

@interface HMKeyboardCtrl : UIViewController <UIScrollViewDelegate>
{
    UIScrollView* _sView;
    
    float _scrollViewContentHeight;
    
    HMServerAPI * _serverAPI;
    HMStorageAPI * _storageAPI;
    
}

@property (weak, nonatomic) UITextField *activeField;
@property (weak, nonatomic) UITextView *activeView;

@property (weak, nonatomic) IBOutlet UIView *endView;
@property (weak, nonatomic) IBOutlet UIButton *btnBottom;

- (void)disableActiveField;
- (void)updateScrollViewHeight;

@end
