//
//  CCGistTblCtrl.m
//  GistNote
//
//  Created by Liliya Sayfutdinova on 18/09/15.
//  Copyright © 2015 Liliya. All rights reserved.
//

#import "CCGistTblCtrl.h"

#import "CCGistDetail.h"

#import "Note.h"
#import "Gist.h"
#import "User.h"

@implementation CCGistTblCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _serverAPI = [HMServerAPI getInstance];
    
    if (_tblType == kGistTblTypeAll) {
        _tblType = kGistTblTypeGists;
        [self addHeader];
    }
    
    [self loadData];
}

//=======================
// refreshData
//=======================

- (void)refreshData
{
    switch (_tblType) {
        case kGistTblTypeNotes:
            break;
        case kGistTblTypeGists:
            [self loadDataFromNet];
            break;
        default:
            break;
    }
}

//================
// set cell id
//================

- (void)setCellId
{
    switch (_tblType) {
        case kGistTblTypeNotes:
        case kGistTblTypeGists:
        case kGistTblTypeAll:
            _cellId = @"gist_cell";
            break;
            
        default:
            break;
    }
}

//====================
// load data from net
//====================

- (void)loadDataFromNet
{
    __weak CCGistTblCtrl *weakSelf = self;
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_serverAPI getGistsWithCallback:^(NSMutableArray *response)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakSelf fillViewWithData:response];
                        });
                    }
                        andCallbackError:^(NSError *error)
                        {
                            [weakSelf serverAPIError];
                        }];
    });
}

//================
// load data
//================

- (void)loadData
{
    __weak CCGistTblCtrl *weakSelf = self;
    if (_tblType == kGistTblTypeNotes) {
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [_serverAPI getSavedNotesWithCallback:^(NSMutableArray *response)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [weakSelf fillViewWithData:response];
                 });
             }
                                 andCallbackError:^(NSError *error)
             {
                 [weakSelf serverAPIError];
             }];
        });
    } else if (_tblType == kGistTblTypeGists) {
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [_serverAPI getSavedGistsWithCallback:^(NSMutableArray *response)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [weakSelf fillViewWithData:response];
                 });
             }
                                 andCallbackError:^(NSError *error)
             {
                 [weakSelf serverAPIError];
             }];
        });
    }
}

//================
// fill with data
//================

- (void)fillViewWithData:(NSMutableArray*)tableData
{
    _items = [tableData mutableCopy];
    
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellId forIndexPath:indexPath];
    
    switch (_tblType) {
        case kGistTblTypeNotes:
            [self fillNote:cell atIndexPath:indexPath];
            break;
        case kGistTblTypeGists:
            [self fillGist:cell atIndexPath:indexPath];
            break;
        default:
            break;
    }
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}


- (void)fillNote:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath
{
    Note * note = (Note*)_items[indexPath.row];
    
    if (note.desc.length != 0)  cell.textLabel.text = note.desc;
    else                        cell.textLabel.text = note.initial_gist.gist_id;
}

- (void)fillGist:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath
{
    Gist * gist = (Gist*)_items[indexPath.row];
    if (gist.desc.length != 0)  cell.textLabel.text = gist.desc;
    else                        cell.textLabel.text = gist.gist_id;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TBL_CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TBL_CELL_HEIGHT;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destViewController = segue.destinationViewController;
    UITableViewCell *cell = (UITableViewCell*)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if ([segue.identifier isEqualToString:SEGUE_GIST_DETAIL])
    {
        switch (_tblType) {
            case kGistTblTypeNotes:
                ((CCGistDetail*)destViewController).note = _items[indexPath.row];
                break;
            case kGistTblTypeGists:
                ((CCGistDetail*)destViewController).gist = _items[indexPath.row];
                break;
            default:
                break;
        }
    }
}

//==================
//
//==================

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.topItem.title = @"";
    [self setTitle];
    
    
    if (_needUpdate) {
        _needUpdate = false;
        if ([_update_notification.name isEqualToString:NOTIFICATION_NEED_TO_UP]) {
            [self loadData];
        }
    }
}

- (void)setTitle
{
    switch (_tblType) {
        case kGistTblTypeNotes:
            self.navigationItem.title = NSLocalizedString(@"NOTES_TITLE", nil);
            break;
        case kGistTblTypeGists:
            self.navigationItem.title = NSLocalizedString(@"GESTS_TITLE", nil);
            break;
        default:
            break;
    }
}

//================
// header view
//================

//===================================
// Add search bar to heared
//===================================

- (void)addHeader
{
    _headerView = [self createHeaderView];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [self getHeaderHeight])];
    
    [self.view addSubview:_headerView];
    [self.view bringSubviewToFront:_headerView];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Adjust the header's frame to keep it pinned to the top of the scroll view
    CGRect headerFrame = _headerView.frame;
    CGFloat yOffset = scrollView.contentOffset.y;
    headerFrame.origin.y = MAX(0, yOffset);
    _headerView.frame = headerFrame;
    
    // If the user is pulling down on the top of the scroll view, adjust the scroll indicator appropriately
    CGFloat height = CGRectGetHeight(headerFrame);
    if (yOffset< 0) {
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(ABS(yOffset) + height, 0, 0, 0);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

- (float)getHeaderHeight
{
    return TBL_SEGMENT_BAR_HEADER;
}

- (UIView*)createHeaderView
{
    float headerH = [self getHeaderHeight];
    
    self.tableView.sectionHeaderHeight = headerH;
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, headerH)];
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, headerH)];
    headerView.backgroundColor = [UIColor whiteColor];

    NSArray *itemArray = [NSArray arrayWithObjects:
                          NSLocalizedString(@"GESTS_TITLE", nil),
                          NSLocalizedString(@"NOTES_TITLE", nil),
                          nil];
    
    _sgm = [[UISegmentedControl alloc] initWithItems:itemArray];
    _sgm.frame = CGRectMake(5, 5, self.view.frame.size.width - 10, TBL_SEGMENT_BAR_HEADER - 10);
    [_sgm addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    [_sgm setSelectedSegmentIndex:0];
    [headerView addSubview:_sgm];
    
    return headerView;
}

- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:
            _tblType = kGistTblTypeGists;
            break;
        case 1:
            _tblType = kGistTblTypeNotes;
            break;
        default:
            break;
    }
    [self setTitle];
    
    [self setCellId];
    [self loadData];
}




@end
