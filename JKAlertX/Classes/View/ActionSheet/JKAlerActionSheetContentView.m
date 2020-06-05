//
//  JKAlerActionSheetContentView.m
//  JKAlertX
//
//  Created by albert on 2020/6/4.
//

#import "JKAlerActionSheetContentView.h"
#import "JKAlertAction.h"
#import "JKAlertTableViewCell.h"
#import "JKAlertPiercedTableViewCell.h"
#import "JKAlertConst.h"
#import "JKAlertView.h"
#import "JKAlertActionButton.h"

@interface JKAlerActionSheetContentView () <UITableViewDataSource, UITableViewDelegate>

/** horizontalSeparatorLineView */
@property (nonatomic, weak) UIView *horizontalSeparatorLineView;

/** tableView */
@property (nonatomic, weak) UITableView *tableView;

/** cancelButton */
@property (nonatomic, weak) JKAlertActionButton *cancelButton;
@end

@implementation JKAlerActionSheetContentView

#pragma mark
#pragma mark - Public Methods

- (void)calculateUI {
    
    self.textContentView.contentWidth = self.contentWidth;
    
    [self.textContentView calculateUI];
    
    [self layoutTableView];
    
    [self layoutActionButton];
    
    [self adjustActionSheetFrame];
    
    [self.tableView reloadData];
}

#pragma mark
#pragma mark - Override

- (void)dealloc {
    
    // TODO: JKTODO delete
    
    NSLog(@"[ClassName: %@], %d, %s", NSStringFromClass([self class]), __LINE__, __func__);
}

#pragma mark
#pragma mark - Private Methods

- (void)adjustActionSheetFrame {
    
    CGRect frame = CGRectZero;
    
    frame = self.textContentView.frame;
    self.textScrollView.frame = frame;
    
    CGFloat topHeight = self.textScrollView.frame.size.height;
    
    CGFloat bottomHeight = self.tableView.frame.size.height;
    
    self.actionScrollView.hidden = YES;
    
    if (self.pinCancelButton) {
        
        bottomHeight += self.cancelMargin;
        
        bottomHeight += self.cancelAction.rowHeight;
        
        self.actionScrollView.hidden = NO;
    }
    
    bottomHeight += JKAlertAdjustHomeIndicatorHeight;
    
    self.horizontalSeparatorLineView.frame = CGRectMake(0, topHeight, self.contentWidth - JKAlertGlobalSeparatorLineThickness() * 0.5, JKAlertGlobalSeparatorLineThickness());
    
    CGFloat totalHeight = topHeight + bottomHeight;
    
    CGFloat halfHeight = self.maxHeight * 0.5;
    
    if (self.maxHeight <= 0 ||
        totalHeight <= self.maxHeight) {
        
        self.textScrollView.scrollEnabled = NO;
        self.actionScrollView.scrollEnabled = NO;
        self.tableView.scrollEnabled = NO;
        
    } else if (topHeight > halfHeight &&
               bottomHeight > halfHeight) {
        
        // 二者都超过最大高度的一半
        
        self.textScrollView.scrollEnabled = YES;
        
    } else if (topHeight > halfHeight) {
        
        // 上部分高度更高
        self.textScrollView.scrollEnabled = YES;
        
    } else if (bottomHeight > halfHeight) {
        
        // 下部分高度更高
    }
    
    
    
}

- (void)checkPiercedTableViewFrame {
    
    if (!self.isPierced ||
        self.actionScrollView.hidden) {
        
        self.tableView.scrollEnabled = YES;
        
        return;
    }
    
    CGRect frame = CGRectZero;
    
    //CGFloat totalHeight = self.tableView.frame.size.height + self.actionScrollView.frame.size.height;
    
    CGFloat maxHeight = self.maxHeight * 0.5;
    
    CGFloat halfHeight = maxHeight * 0.5;
    
    if (self.tableView.frame.size.height > maxHeight &&
        self.actionScrollView.frame.size.height > maxHeight) {
        
        // 二者都超过最大高度的一半
        
        self.tableView.scrollEnabled = YES;
        self.actionScrollView.scrollEnabled = YES;
        
        frame = self.tableView.frame;
        frame.size.height = halfHeight;
        self.tableView.frame = frame;
        
        frame = self.actionScrollView.frame;
        frame.size.height = halfHeight;
        self.actionScrollView.frame = frame;
        
    } else if (self.tableView.frame.size.height > maxHeight) {
        
    } else if (self.actionScrollView.frame.size.height > maxHeight) {
        
    }
}

- (void)layoutTableView {
    
    CGRect rect = CGRectZero;
    
    if (self.actionArray.count <= 0) {
        
        self.tableView.hidden = YES;
        
        self.tableView.frame = rect;
        
        return;
    }
    
    self.tableView.hidden = NO;
    
    for (JKAlertAction *action in self.actionArray) {
        
        rect.size.height += action.rowHeight;
    }
    
    if (self.pinCancelButton) {
        
        self.tableView.frame = rect;
        
        return;
    }
    
    if (self.cancelAction) {
        
        rect.size.height += self.cancelAction.rowHeight;
    }
    
    rect.size.height += JKAlertAdjustHomeIndicatorHeight;
    
    self.tableView.frame = rect;
}

- (void)layoutActionButton {
    
    self.cancelAction.isPierced = self.isPierced;
    
    if (!self.isPierced ||
        !self.cancelAction) {
        
        self.actionScrollView.hidden = YES;
        self.actionScrollView.frame = CGRectZero;
        
        return;
    }
    
    CGRect frame = CGRectMake(0, 0, self.contentWidth, self.cancelAction.rowHeight + JKAlertAdjustHomeIndicatorHeight);
    
    self.cancelButton.frame = frame;
    
    self.actionScrollView.frame = self.cancelButton.frame;
    
    if (self.cancelAction.customView) {
        
        self.cancelAction.customView.frame = self.cancelButton.bounds;
    }
    
    self.actionScrollView.hidden = (self.actionScrollView.frame.size.height <= 0);
}

#pragma mark
#pragma mark - Private Selector

- (void)cancelButtonClick:(JKAlertActionButton *)button {
    
    // TODO: JKTODO <#注释#>
}

#pragma mark
#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return (self.cancelAction.rowHeight > 0 && !self.pinCancelButton) ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? self.actionArray.count : (self.pinCancelButton ? 0 : 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JKAlertBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.isActionSheetPierced ? [JKAlertPiercedTableViewCell class] : [JKAlertTableViewCell class])];
    
    if (cell == nil) {
        
        cell = [[JKAlertTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([JKAlertTableViewCell class])];
    }
    
    cell.alertSuperView = self.customSuperView;
    
    if (indexPath.section == 0) {
        
        cell.action = self.actionArray[indexPath.row];
        
    } else {
        
        cell.action = self.cancelAction;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JKAlertAction *action = indexPath.section == 0 ? self.actionArray[indexPath.row] : self.cancelAction;
    
    if (!self.fillHomeIndicator) { return action.rowHeight; }
    
    return indexPath.section == 0 ? action.rowHeight : action.rowHeight + JKAlertAdjustHomeIndicatorHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (section == 0) ? CGFLOAT_MIN : self.cancelMargin;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    JKAlertAction *action = indexPath.section == 0 ? self.actionArray[indexPath.row] : self.cancelAction;
    
    if (action.autoDismiss && ![action isEmpty]) { [self.alertView dismiss]; }
    
    !action.handler ? : action.handler(action);
}

#pragma mark
#pragma mark - Custom Delegates



#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 */
- (void)initializeProperty {
    [super initializeProperty];
    
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
}

/** 创建UI */
- (void)createUI {
    [super createUI];
    
    JKAlertActionSheetTextContentView *textContentView = [[JKAlertActionSheetTextContentView alloc] init];
    [self.textScrollView addSubview:textContentView];
    _textContentView = textContentView;
    
    UITableView *tableView = [self createTableViewWithStyle:(UITableViewStyleGrouped)];
    tableView.dataSource = self.tableViewDataSource ? self.tableViewDataSource : self;
    tableView.delegate = self.tableViewDelegate ? self.tableViewDelegate : self;
    [tableView registerClass:[JKAlertTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JKAlertTableViewCell class])];
    [tableView registerClass:[JKAlertPiercedTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JKAlertPiercedTableViewCell class])];
    //tableView.rowHeight = JKAlertRowHeight;
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, CGFLOAT_MIN)];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, CGFLOAT_MIN)];
    tableView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:tableView];
    _tableView = tableView;
    
    JKAlertActionButton *cancelButton = [JKAlertActionButton buttonWithType:(UIButtonTypeCustom)];
    [self.actionScrollView addSubview:cancelButton];
    _cancelButton = cancelButton;
    
    [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIView *horizontalSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentWidth, JKAlertGlobalSeparatorLineThickness())];
    horizontalSeparatorLineView.hidden = YES;
    [self.contentView addSubview:horizontalSeparatorLineView];
    _horizontalSeparatorLineView = horizontalSeparatorLineView;
}

/** 布局UI */
- (void)layoutUI {
    [super layoutUI];
    
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
}

#pragma mark
#pragma mark - Private Property




- (UITableView *)createTableViewWithStyle:(UITableViewStyle)style {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    
    tableView.backgroundColor = nil;
    
    tableView.scrollsToTop = NO;
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.rowHeight = 44;
    tableView.sectionFooterHeight = 0;
    tableView.sectionHeaderHeight = 0;
    
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, JKAlertCurrentHomeIndicatorHeight(), 0);
    
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft) {
        
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, -34, JKAlertCurrentHomeIndicatorHeight(), 34);
    }
    
    if (@available(iOS 11.0, *)) {
        
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    if (@available(iOS 13.0, *)) {
        
        tableView.automaticallyAdjustsScrollIndicatorInsets = NO;
    }
    
    return tableView;
}

@end
