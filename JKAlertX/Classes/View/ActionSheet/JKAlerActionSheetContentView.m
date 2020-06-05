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

/** topPiercedBackgroundView */
@property (nonatomic, weak) UIView *topPiercedBackgroundView;

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
    [super calculateUI];
    
    self.backgroundEffectView.hidden = self.isPierced;
    self.topPiercedBackgroundView.hidden = !self.isPierced || self.customBackgroundView != nil;
    
    self.textContentView.contentWidth = self.contentWidth;
    
    [self.textContentView calculateUI];
    
    [self layoutTableView];
    
    [self layoutActionButton];
    
    [self adjustActionSheetFrame];
    
    if (self.isPierced) {
        
        self.topPiercedBackgroundView.layer.cornerRadius = self.piercedCornerRadius;
        self.topPiercedBackgroundView.layer.masksToBounds = YES;
        
        self.cancelButton.layer.cornerRadius = self.piercedCornerRadius;
        self.cancelButton.layer.masksToBounds = YES;
        
    } else {
        
        self.topPiercedBackgroundView.layer.cornerRadius = 0;
        self.cancelButton.layer.cornerRadius = 0;
    }
    
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
    
    self.textScrollView.contentSize = CGSizeMake(0, self.textScrollView.frame.size.height);
    
    CGFloat topHeight = self.textScrollView.frame.size.height;
    
    CGFloat bottomHeight = self.tableView.frame.size.height;
    
    self.actionScrollView.hidden = YES;
    
    if (self.cancelButtonPinned &&
        self.cancelAction.rowHeight >= 0.1) {
        
        bottomHeight += self.cancelMargin;
        
        bottomHeight += self.cancelAction.rowHeight;
        
        bottomHeight += JKAlertAdjustHomeIndicatorHeight;
        
        if (self.isPierced) {
            
            bottomHeight += self.piercedInsets.bottom;
        }
        
        self.actionScrollView.contentSize = CGSizeMake(0, self.actionScrollView.frame.size.height);
        
        self.actionScrollView.hidden = NO;
    }
    
    self.horizontalSeparatorLineView.hidden = (topHeight <= 0 || self.actionArray.count <= 0);
    
    self.horizontalSeparatorLineView.frame = CGRectMake(0, topHeight, self.contentWidth, JKAlertGlobalSeparatorLineThickness());
    
    frame = self.tableView.frame;
    frame.origin.y = CGRectGetMaxY(self.textScrollView.frame);
    self.tableView.frame = frame;
    
    CGFloat totalHeight = topHeight + bottomHeight;
    
    CGFloat halfHeight = self.maxHeight * 0.5;
    
    if (self.maxHeight <= 0 ||
        totalHeight <= self.maxHeight) {
        
        self.textScrollView.scrollEnabled = NO;
        self.tableView.scrollEnabled = NO;
        self.actionScrollView.scrollEnabled = NO;
        
    } else if (topHeight > halfHeight &&
               bottomHeight > halfHeight) {
        
        // 二者都超过最大高度的一半
        
        self.textScrollView.scrollEnabled = YES;
        
        if (self.cancelButtonPinned) {
            
            [self checkPiercedTableViewFrame];
            
        } else {
            
            self.tableView.scrollEnabled = YES;
        }
        
    } else if (topHeight > halfHeight) {
        
        // 上部分高度更高
        self.textScrollView.scrollEnabled = YES;
        self.tableView.scrollEnabled = NO;
        self.actionScrollView.scrollEnabled = NO;
        
    } else if (bottomHeight > halfHeight) {
        
        // 下部分高度更高
        self.textScrollView.scrollEnabled = NO;
        
        if (self.cancelButtonPinned) {
            
            [self checkPiercedTableViewFrame];
            
        } else {
            
            self.tableView.scrollEnabled = YES;
        }
    }
    
    if (!self.actionScrollView.hidden) {
        
        frame = self.actionScrollView.frame;
        
        frame.origin.y = CGRectGetMaxY(self.tableView.frame) + self.cancelMargin;
        
        self.actionScrollView.frame = frame;
    }
    
    frame = CGRectMake(0, 0, self.contentWidth, self.textScrollView.frame.size.height + self.tableView.frame.size.height);
    
    if (self.cancelButtonPinned &&
        self.cancelAction.rowHeight >= 0.1) {
            
        frame.size.height += self.cancelButton.frame.size.height;
        
        frame.size.height += self.cancelMargin;
        
        frame.size.height += JKAlertAdjustHomeIndicatorHeight;
        
        if (self.isPierced) {
            
            frame.size.height += self.piercedInsets.bottom;
        }
    }
    
    self.frame = frame;
    
    if (self.isPierced) {
        
        frame.size.height = CGRectGetMaxY(self.tableView.frame);
        
        self.topPiercedBackgroundView.frame = frame;
        
        [self.topPiercedBackgroundView addSubview:self.textScrollView];
        [self.topPiercedBackgroundView addSubview:self.tableView];
        
    } else {
        
        [self.contentView addSubview:self.textScrollView];
        [self.contentView addSubview:self.tableView];
    }
}

- (void)checkPiercedTableViewFrame {
    
    if (!self.cancelButtonPinned ||
        self.actionScrollView.hidden) {
        
        self.tableView.scrollEnabled = YES;
        
        return;
    }
    
    CGRect frame = CGRectZero;
    
    //CGFloat totalHeight = self.tableView.frame.size.height + self.actionScrollView.frame.size.height;
    
    CGFloat maxHeight = self.maxHeight * 0.5;
    
    CGFloat halfHeight = maxHeight * 0.5;
    
    CGFloat actionTotalHeight = self.actionScrollView.frame.size.height + self.cancelMargin;
    
    CGFloat extraHeight = 0;
    
    if (self.isPierced) {
        
        extraHeight += self.piercedInsets.bottom;
        extraHeight += JKAlertAdjustHomeIndicatorHeight;
        
    } else {
        
        if (AutoAdjustHomeIndicator) {
            
            if (self.fillHomeIndicator) {
                
                extraHeight += JKAlertAdjustHomeIndicatorHeight;
                
            } else {
                
            }
            
        } else {
            
        }
    }
    
    actionTotalHeight += extraHeight;
    
    if (self.tableView.frame.size.height > halfHeight &&
        actionTotalHeight > halfHeight) {
        
        // 二者都超过最大高度的一半
        
        self.tableView.scrollEnabled = YES;
        self.actionScrollView.scrollEnabled = YES;
        
        frame = self.tableView.frame;
        frame.size.height = halfHeight;
        self.tableView.frame = frame;
        
        frame = self.actionScrollView.frame;
        frame.size.height = halfHeight - extraHeight;
        self.actionScrollView.frame = frame;
        
    } else if (self.tableView.frame.size.height > maxHeight) {
        
        frame = self.tableView.frame;
        frame.size.height = halfHeight;
        self.tableView.frame = frame;
        
        self.tableView.scrollEnabled = YES;
        self.actionScrollView.scrollEnabled = NO;
        
    } else if (self.actionScrollView.frame.size.height > maxHeight) {
        
        self.tableView.scrollEnabled = NO;
        
        self.actionScrollView.scrollEnabled = YES;
        
        frame = self.actionScrollView.frame;
        frame.size.height = halfHeight - extraHeight;
        self.actionScrollView.frame = frame;
    }
}

- (void)layoutTableView {
    
    CGRect rect = CGRectMake(0, 0, self.contentWidth, 0);
    
    if (self.actionArray.count <= 0) {
        
        self.tableView.hidden = YES;
        
        self.tableView.frame = rect;
        
        return;
    }
    
    self.tableView.hidden = NO;
    
    for (JKAlertAction *action in self.actionArray) {
        
        rect.size.height += action.rowHeight;
    }
    
    if (self.cancelButtonPinned) {
        
        self.tableView.frame = rect;
        
        return;
    }
    
    if (self.cancelAction.rowHeight > 0.1) {
        
        rect.size.height += self.cancelMargin;
        
        rect.size.height += self.cancelAction.rowHeight;
        
        rect.size.height += JKAlertAdjustHomeIndicatorHeight;
    }
    
    self.tableView.frame = rect;
}

- (void)layoutActionButton {
    
    self.cancelAction.isPierced = self.isPierced;
    
    self.cancelButton.action = self.cancelAction;
    
    if (!self.cancelButtonPinned ||
        self.cancelAction.rowHeight < 0.1) {
        
        self.actionScrollView.hidden = YES;
        self.actionScrollView.frame = CGRectZero;
        
        return;
    }
    
    self.actionScrollView.hidden = NO;
    
    CGRect frame = CGRectMake(0, 0, self.contentWidth, self.cancelAction.rowHeight);
    
    if (self.isPierced) {
        
        
    } else {
        
        if (AutoAdjustHomeIndicator) {
            
            if (self.fillHomeIndicator) {
                
                frame.size.height += JKAlertAdjustHomeIndicatorHeight;
            }
            
        } else {
            
        }
    }
    
    self.cancelButton.frame = frame;
    
    self.actionScrollView.frame = self.cancelButton.frame;
    
    if (self.cancelAction.customView) {
        
        self.cancelAction.customView.frame = self.cancelButton.bounds;
    }
}

- (void)updateLightModetUI {
    [super updateLightModetUI];
    
    self.horizontalSeparatorLineView.backgroundColor = JKAlertGlobalSeparatorLineMultiColor().lightColor;
    
    self.topPiercedBackgroundView.backgroundColor = self.piercedBackgroundColor.lightColor;
    
    self.textScrollView.backgroundColor = self.isPierced ? nil : self.textContentBackgroundColor.lightColor;
}

- (void)updateDarkModeUI {
    [super updateDarkModeUI];
    
    self.horizontalSeparatorLineView.backgroundColor = JKAlertGlobalSeparatorLineMultiColor().darkColor;
    
    self.topPiercedBackgroundView.backgroundColor = self.piercedBackgroundColor.darkColor;
    
    self.textScrollView.backgroundColor = self.isPierced ? nil : self.textContentBackgroundColor.darkColor;
}

#pragma mark
#pragma mark - Private Selector

- (void)cancelButtonClick:(JKAlertActionButton *)button {
    
    JKAlertAction *action = button.action;
    
    if (action.autoDismiss && ![action isEmpty]) { [self.alertView dismiss]; }
    
    !action.handler ? : action.handler(action);
}

#pragma mark
#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return (self.cancelButtonPinned || self.cancelAction.rowHeight < 0.1) ? 1 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? self.actionArray.count : (self.cancelButtonPinned ? 0 : 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JKAlertBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.isPierced ? [JKAlertPiercedTableViewCell class] : [JKAlertTableViewCell class])];
    
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
    
    switch (indexPath.section) {
        case 0:
            return action.rowHeight;
            break;
        case 1:
            return action.rowHeight + JKAlertAdjustHomeIndicatorHeight;
            break;
            
        default:
            break;
    }
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return CGFLOAT_MIN;
            break;
        case 1:
            return self.cancelAction.rowHeight > 0.1 ? self.cancelMargin : CGFLOAT_MIN;
            break;
            
        default:
            break;
    }
    
    return CGFLOAT_MIN;
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
    
    AutoAdjustHomeIndicator = YES;
    
    _fillHomeIndicator = YES;
    
    _cancelMargin = ((JKAlertScreenWidth > 321) ? 7 : 5);
    
    _textContentBackgroundColor = JKAlertGlobalMultiBackgroundColor();
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
}

/** 创建UI */
- (void)createUI {
    [super createUI];
    
    UIView *topPiercedBackgroundView = [[UIView alloc] init];
    [self.contentView insertSubview:topPiercedBackgroundView atIndex:0];
    _topPiercedBackgroundView = topPiercedBackgroundView;
    
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

- (BOOL)cancelButtonPinned {
    
    if (self.isPierced) { return YES; }
    
    return _cancelButtonPinned;
}

@end
