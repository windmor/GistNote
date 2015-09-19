//
//  HMTableViewCtrl.m
//  GistNotes
//
//  Created on 26/02/15.
//  Copyright (c) 2015  . All rights reserved.
//

#import "HMTableViewCtrl.h"

@implementation HMTableViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.refreshControl addTarget:self
                            action:@selector(refreshData)
                  forControlEvents:UIControlEventValueChanged];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(update_list:)
                                                 name:NOTIFICATION_NEED_TO_UP
                                               object:nil];
    
    [self setCellId];
}

- (void)update_list:(NSNotification*)notification
{
    _needUpdate = true;
    _update_notification = notification;
}

//=======================
// refreshData
//=======================

- (void)refreshData
{
    
}

//================
// set cell id
//================

- (void)setCellId
{
    // exception
    @throw [[ingVirtualFunctionCallException alloc] initWithReason:EXCEPTION_NAMES[EXCEPTION_VIRT_FUNTION_CALLED]
                                                          userInfo:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//================
// load data
//================

- (void)loadData
{
    
}

//================
// fill with data
//================

- (void)fillViewWithData:(NSMutableArray*)tableData
{
    // exception
    @throw [[ingVirtualFunctionCallException alloc] initWithReason:EXCEPTION_NAMES[EXCEPTION_VIRT_FUNTION_CALLED]
                                                          userInfo:nil];
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
 

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (self.tableView.style == UITableViewStyleGrouped) {
        return _items.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.tableView.style == UITableViewStyleGrouped) {
        return [_items[section] count];
    }
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellId forIndexPath:indexPath];
    [self fillCell:cell atIndexPath:indexPath];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (void)fillCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath
{
    // exception
    @throw [[ingVirtualFunctionCallException alloc] initWithReason:EXCEPTION_NAMES[EXCEPTION_VIRT_FUNTION_CALLED]
                                                          userInfo:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TBL_CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_cellPrototype) {
        _cellPrototype = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:_cellId];
    }
    
    // configure the cell
    [self fillCell:_cellPrototype atIndexPath:indexPath];
    
    [_cellPrototype setNeedsUpdateConstraints];
    [_cellPrototype updateConstraintsIfNeeded];
    
    _cellPrototype.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(_cellPrototype.bounds));
    
    [_cellPrototype setNeedsLayout];
    [_cellPrototype layoutIfNeeded];
    
    CGFloat height = [_cellPrototype.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    
    if (height == 0) height = TBL_CELL_HEIGHT;
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    return 0;
}

@end
