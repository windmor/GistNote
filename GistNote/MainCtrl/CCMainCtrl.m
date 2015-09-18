//
//  CCMainCtrl.m
//  GistNote
//
//  Created by Liliya Sayfutdinova on 18/09/15.
//  Copyright © 2015 Liliya. All rights reserved.
//

#import "CCMainCtrl.h"

#import "CCGistTblCtrl.h"

@implementation CCMainCtrl

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destViewController = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:SEGUE_SHOW_ALL])
    {
        ((CCGistTblCtrl*)destViewController).tblType = kGistTblTypeAll;
    } else if ([segue.identifier isEqualToString:SEGUE_SHOW_GISTS])
    {
        ((CCGistTblCtrl*)destViewController).tblType = kGistTblTypeGists;
    } else if ([segue.identifier isEqualToString:SEGUE_SHOW_NOTES])
    {
        ((CCGistTblCtrl*)destViewController).tblType = kGistTblTypeNotes;
    }
}

//==================
//
//==================

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.topItem.title = @"";
    
    self.navigationItem.title = NSLocalizedString(@"MAIN_TITLE", nil);
}

@end
