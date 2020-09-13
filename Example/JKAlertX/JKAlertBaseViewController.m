//
//  JKAlertBaseViewController.m
//  JKAlertX_Example
//
//  Created by albert on 2020/9/13.
//  Copyright © 2020 jkayb123cool@gmail.com. All rights reserved.
//

#import "JKAlertBaseViewController.h"
#import "JKAlertX.h"
#import "JKAlertHeaderFooterView.h"
#import "JKAlertTableViewCell.h"
#import "JKAlertTableModel.h"
#import "JKAlertTableGroupModel.h"

@interface JKAlertBaseViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_dataArray;
}
@end

@implementation JKAlertBaseViewController

- (void)dealloc {
    
    NSLog(@"[ClassName: %@], %d, %s", NSStringFromClass([self class]), __LINE__, __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildUI];
    
    [self loadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView setContentOffset:CGPointMake(0, -self.tableView.contentInset.top) animated:NO];
    });
}

- (void)buildUI {
    
    UITableView *tableView = [self createTableViewWithStyle:(UITableViewStyleGrouped)];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [tableView registerClass:[JKAlertTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JKAlertTableViewCell class])];
    [tableView registerClass:[JKAlertHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([JKAlertHeaderFooterView class])];
}

- (void)loadData {
    
}

#pragma mark
#pragma mark - Override

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    self.tableView.contentInset = UIEdgeInsetsMake(JKAlertUtility.navigationBarHeight, 0, JKAlertUtility.currentHomeIndicatorHeight, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(JKAlertUtility.navigationBarHeight, 0, JKAlertUtility.currentHomeIndicatorHeight, 0);
}

#pragma mark
#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    JKAlertTableGroupModel *group = [self.dataArray objectAtIndex:section];
    
    return group.sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JKAlertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JKAlertTableViewCell class])];
    
    if (cell == nil) {
        
        cell = [[JKAlertTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([JKAlertTableViewCell class])];
    }
    
    JKAlertTableGroupModel *group = [self.dataArray objectAtIndex:indexPath.section];
    
    cell.model = [group.sectionArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static CGFloat rowHeight_ = 0;
    
    if (rowHeight_ <= 0) {

        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        
        rowHeight_ = (MIN(screenSize.width, screenSize.height) > 321) ? 53 : 46;
    }
    
    return rowHeight_;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JKAlertTableGroupModel *group = [self.dataArray objectAtIndex:indexPath.section];
    
    JKAlertTableModel *model = [group.sectionArray objectAtIndex:indexPath.row];
    
    !model.executeHandler ? : model.executeHandler(model);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    JKAlertHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([JKAlertHeaderFooterView class])];
    
    if (!header) {
        
        header = [[JKAlertHeaderFooterView alloc] initWithReuseIdentifier:NSStringFromClass([JKAlertHeaderFooterView class])];
    }
    
    JKAlertTableGroupModel *group = [self.dataArray objectAtIndex:section];
    
    header.textLabel.text = group.title;
    
    return header;
}

#pragma mark
#pragma mark - Property

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)createTableViewWithStyle:(UITableViewStyle)style {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:style];
    
    if (@available(iOS 13.0, *)) {
        tableView.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        tableView.backgroundColor = [UIColor whiteColor];
    }
    
    tableView.scrollsToTop = YES;
    
    tableView.rowHeight = 44;
    tableView.sectionFooterHeight = 0;
    tableView.sectionHeaderHeight = 0;
    
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, JKAlertUtility.currentHomeIndicatorHeight, 0);
    
    if (@available(iOS 11.0, *)) {
        
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    if (@available(iOS 13.0, *)) {
        
        tableView.automaticallyAdjustsScrollIndicatorInsets = NO;
    }
    
    return tableView;
}
@end
