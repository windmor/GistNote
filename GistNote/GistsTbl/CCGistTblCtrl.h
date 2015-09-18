//
//  CCGistTblCtrl.h
//  GistNote
//
//  Created by Liliya Sayfutdinova on 18/09/15.
//  Copyright © 2015 Liliya. All rights reserved.
//

#import "HMTableViewCtrl.h"

@interface CCGistTblCtrl : HMTableViewCtrl
{
    UISegmentedControl* _sgm;
    
    UIView* _headerView;
}

@property (nonatomic) kGistTblType tblType;

@end
