//
//  CCGistDetail.m
//  GistNote
//
//  Created by Liliya Sayfutdinova on 18/09/15.
//  Copyright © 2015 Liliya. All rights reserved.
//

#import "CCGistDetail.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "CCDataController.h"
#import "Gist.h"
#import "Note.h"
#import "User.h"

@implementation CCGistDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_gist) {
        [self fillViewWithGist:_gist];
    } else if (_note) {
        [self fillViewWithNote:_note];
    }
}

- (void)fillViewWithGist:(Gist*)obj
{
    [_imgAvatar sd_setImageWithURL:[NSURL URLWithString:obj.owner.avatar_url]];
    _lblOwnerName.text = obj.owner.name;
    _txtDesc.text = obj.desc;
}

- (void)fillViewWithNote:(Note*)obj
{
    [_imgAvatar sd_setImageWithURL:[NSURL URLWithString:obj.initial_gist.owner.avatar_url]];
    _lblOwnerName.text = obj.initial_gist.owner.name;
    _txtDesc.text = obj.desc;
    _txtNote.text = obj.note;
    _btnOpenGist.hidden = NO;
}

- (IBAction)onSaveNote:(id)sender
{
    if (_gist && (![_txtDesc.text isEqualToString:_gist.desc] || _txtNote.text.length > 0)) {
        [self saveNewNote];
    } else if (_note && (![_txtDesc.text isEqualToString:_note.desc] ||
                         (_txtNote.text.length > 0 && ![_txtNote.text isEqualToString:_note.note]))) {
        [self editNote];
    }
}

//============

- (void)saveNewNote
{
    __weak CCGistDetail *weakSelf = self;
    
    NSEntityDescription *entityGist = [NSEntityDescription entityForName:@"Note"
                                                  inManagedObjectContext:[[CCDataController getInstance] managedObjectContext]];
    Note* note = nil;
    note = [_storageAPI isNoteIsSaved:_gist.gist_id];
    if (!note)  {
        note = [[Note alloc] initWithEntity:entityGist
             insertIntoManagedObjectContext:[[CCDataController getInstance] managedObjectContext]];
        note.initial_gist = _gist;
    }
    NSString* desc = [_txtDesc.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (desc.length > 0) note.desc = desc;
    else note.desc = _gist.desc;
    note.note = [_txtNote.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_serverAPI saveNote:note
                withCallback:^(bool response)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                        [HMMethods showAlertWithTitle:NSLocalizedString(@"APP_NAME", nil)
                                               andMsg:NSLocalizedString(@"NOTE_SAVED", nil)
                                              forCtrl:self];
                     });
                 } andCallbackError:^(NSError *error)
                 {
                     [weakSelf serverAPIError];
                 }];
    });
}

- (void)editNote
{
    __weak CCGistDetail *weakSelf = self;
    
    NSString* desc = [_txtDesc.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (desc.length > 0) _note.desc = desc;
    else _note.desc = _gist.desc;
    _note.note = [_txtNote.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_serverAPI saveNote:_note
                withCallback:^(bool response)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [HMMethods showAlertWithTitle:NSLocalizedString(@"APP_NAME", nil)
                                        andMsg:NSLocalizedString(@"NOTE_SAVED", nil)
                                       forCtrl:self];
             });
         } andCallbackError:^(NSError *error)
         {
             [weakSelf serverAPIError];
         }];
    });
}

//==================
//
//==================

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.topItem.title = @"";
    
    if (_gist) {
        self.navigationItem.title = _gist.desc;
    } else if (_note) {
        self.navigationItem.title = _note.desc;
    }
}

- (IBAction)onOpenInitialGist:(id)sender
{
    CCGistDetail* initialGistCtrl = [self.storyboard instantiateViewControllerWithIdentifier:STORYBOARD_ID_GIST_DETAIL];
    initialGistCtrl.gist = _note.initial_gist;
    [self.navigationController pushViewController:initialGistCtrl animated:YES];
}


@end
