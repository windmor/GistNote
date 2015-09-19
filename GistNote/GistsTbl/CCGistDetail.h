//
//  CCGistDetail.h
//  GistNote
//
//  Created by Liliya Sayfutdinova on 18/09/15.
//  Copyright © 2015 Liliya. All rights reserved.
//

#import "HMKeyboardCtrl.h"

@class Gist, Note;

@interface CCGistDetail : HMKeyboardCtrl
{
    // update
    NSNotification * _update_notification;
    BOOL _needUpdate;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblOwnerName;
@property (weak, nonatomic) IBOutlet UITextField *txtDesc;
@property (weak, nonatomic) IBOutlet UITextField *txtNote;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnOpenGist;

@property (nonatomic, strong) Gist* gist;
@property (nonatomic, strong) Note* note;

@end
