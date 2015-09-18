//
//  HMTableViewCtrl.h
//  GistNotes
//
//  Created on 26/02/15.
//  Copyright (c) 2015  . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMTableViewCtrl : UITableViewController <UISearchBarDelegate>
{
    NSMutableArray * _items;
    NSMutableArray * _savedItems;
    
    NSString * _cellId;
    
    HMServerAPI * _serverAPI;
    
    UITableViewCell * _cellPrototype;
}

// fill with data
- (void)fillViewWithData:(NSMutableArray*)tableData;

// load data
- (void)loadData;

@end
