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
    [super calculateUI];
    
    self.backgroundEffectView.hidden = self.isPierced;
    
    self.textContentView.safeInsets = self.isPierced ? UIEdgeInsetsZero : self.safeInsets;
    self.textContentView.contentWidth = self.contentWidth;
    
    [self.textContentView calculateUI];
    
    [self layoutTableView];
    
    [self layoutCancelActionButton];
    
    [self adjustActionSheetFrame];
    
    if (self.isPierced) {
        
        self.topContentView.layer.cornerRadius = self.piercedCornerRadius;
        self.topContentView.layer.masksToBounds = YES;
        
        self.cancelButton.layer.cornerRadius = self.piercedCornerRadius;
        self.cancelButton.layer.masksToBounds = YES;
        
    } else {
        
        self.topContentView.layer.cornerRadius = 0;
        self.cancelButton.layer.cornerRadius = 0;
    }
    
    [self updateTableViewInsets];
    
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
    self.topContentView.frame = frame;
    
    self.topContentView.scrollView.contentSize = CGSizeMake(0, self.topContentView.frame.size.height);
    
    CGFloat topHeight = self.topContentView.frame.size.height;
    
    CGFloat bottomHeight = self.tableView.frame.size.height;
    
    self.bottomContentView.hidden = YES;
    
    // 固定取消按钮且取消按钮的高度大于等0.1
    if (self.cancelButtonPinned &&
        self.cancelAction.rowHeight >= 0.1) {
        
        bottomHeight += self.cancelMargin;
        
        bottomHeight += self.cancelAction.rowHeight;
        
        bottomHeight += JKAlertAdjustHomeIndicatorHeight;
        
        if (self.isPierced) {
            
            bottomHeight += self.piercedInsets.bottom;
        }
        
        self.bottomContentView.scrollView.contentSize = CGSizeMake(0, self.bottomContentView.frame.size.height);
        
        self.bottomContentView.hidden = NO;
    }
    
    frame = self.tableView.frame;
    frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
    self.tableView.frame = frame;
    
    CGFloat totalHeight = topHeight + bottomHeight;
    
    CGFloat halfHeight = self.maxHeight * 0.5;
    
    if (self.maxHeight <= 0 ||
        totalHeight <= self.maxHeight) {
        
        self.topContentView.scrollView.scrollEnabled = NO;
        self.tableView.scrollEnabled = NO;
        self.bottomContentView.scrollView.scrollEnabled = NO;
        
    } else if (topHeight > halfHeight &&
               bottomHeight > halfHeight) {
        
        // 二者都超过最大高度的一半
        
        self.topContentView.scrollView.scrollEnabled = YES;
        
        frame = self.topContentView.frame;
        frame.size.height = halfHeight;
        self.topContentView.frame = frame;
        
        if (self.cancelButtonPinned) {
            
            [self checkCancelButtonPinnedBottomFrameWithMaxHeight:halfHeight];
            
        } else {
            
            self.tableView.scrollEnabled = YES;
            
            frame = self.tableView.frame;
            frame.size.height = halfHeight;
            self.tableView.frame = frame;
        }
        
    } else if (topHeight > halfHeight) {
        
        // 上部分高度更高
        self.topContentView.scrollView.scrollEnabled = YES;
        self.tableView.scrollEnabled = NO;
        self.bottomContentView.scrollView.scrollEnabled = NO;
        
        frame = self.topContentView.frame;
        frame.size.height = self.maxHeight - self.tableView.frame.size.height;
        self.topContentView.frame = frame;
        
    } else if (bottomHeight > halfHeight) {
        
        // 下部分高度更高
        self.topContentView.scrollView.scrollEnabled = NO;
        
        if (self.cancelButtonPinned) {
            
            [self checkCancelButtonPinnedBottomFrameWithMaxHeight:self.maxHeight - self.topContentView.frame.size.height];
            
        } else {
            
            self.tableView.scrollEnabled = YES;
            
            frame = self.tableView.frame;
            frame.size.height = self.maxHeight - self.topContentView.frame.size.height;
            self.tableView.frame = frame;
        }
    }
    
    frame = self.tableView.frame;
    frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
    self.tableView.frame = frame;
    
    if (!self.bottomContentView.hidden) {
        
        frame = self.bottomContentView.frame;
        
        frame.origin.y = CGRectGetMaxY(self.tableView.frame) + self.cancelMargin;
        
        self.bottomContentView.frame = frame;
    }
    
    frame = CGRectMake(0, 0, self.contentWidth, self.topContentView.frame.size.height + self.tableView.frame.size.height);
    
    if (self.cancelButtonPinned &&
        self.cancelAction.rowHeight >= 0.1) {
            
        frame.size.height += self.cancelButton.frame.size.height;
        
        frame.size.height += self.cancelMargin;
        
        if (self.isPierced) {
            
            frame.size.height += self.piercedInsets.bottom;
            
        } else {
            
            if (self.fillHomeIndicator) {
                
            } else {
                
                frame.size.height += JKAlertAdjustHomeIndicatorHeight;
            }
        }
    }
    
    self.frame = frame;
    
    self.horizontalSeparatorLineView.hidden = (topHeight <= 0 || self.actionArray.count <= 0);
    
    self.horizontalSeparatorLineView.frame = CGRectMake(0, CGRectGetMaxY(self.topContentView.frame), self.contentWidth, JKAlertGlobalSeparatorLineThickness());
    
    if (self.isPierced) {
        
        frame.size.height = CGRectGetMaxY(self.tableView.frame);
        
        self.topContentView.frame = frame;
        
        [self.topContentView addSubview:self.tableView];
        
    } else {
        
        [self.contentView addSubview:self.tableView];
    }
}

/// 固定底部取消按钮时计算tableView和取消按钮的frame
- (void)checkCancelButtonPinnedBottomFrameWithMaxHeight:(CGFloat)maxHeight {
    
    CGRect frame = CGRectZero;
    
    if (!self.cancelButtonPinned ||
        self.cancelAction.rowHeight < 0.1) {
            
        frame = self.tableView.frame;
        frame.size.height = maxHeight;
        self.tableView.frame = frame;
        
        self.tableView.scrollEnabled = YES;
        
        return;
    }
    
    //CGFloat totalHeight = self.tableView.frame.size.height + self.bottomContentView.frame.size.height;
    
    CGFloat halfHeight = maxHeight * 0.5;
    
    CGFloat actionTotalHeight = self.bottomContentView.frame.size.height + self.cancelMargin;
    
    CGFloat extraHeight = 0;
    
    if (self.isPierced) {
        
        extraHeight += self.piercedInsets.bottom;
        //extraHeight += JKAlertAdjustHomeIndicatorHeight;
        
    }
    
    if (self.autoAdjustHomeIndicator) {
        
        if (self.fillHomeIndicator) {
            
            
        } else {
            
            extraHeight += JKAlertAdjustHomeIndicatorHeight;
        }
    }
    
    actionTotalHeight += extraHeight;
    
    if (self.tableView.frame.size.height > halfHeight &&
        actionTotalHeight > halfHeight) {
        
        // 二者都超过最大高度的一半
        
        self.tableView.scrollEnabled = YES;
        self.bottomContentView.scrollView.scrollEnabled = YES;
        
        frame = self.tableView.frame;
        frame.size.height = halfHeight;
        self.tableView.frame = frame;
        
        frame = self.bottomContentView.frame;
        frame.size.height = halfHeight - extraHeight;
        self.bottomContentView.frame = frame;
        
    } else if (self.tableView.frame.size.height > halfHeight) {
        
        frame = self.tableView.frame;
        frame.size.height = maxHeight - self.bottomContentView.frame.size.height - self.cancelMargin - extraHeight;
        self.tableView.frame = frame;
        
        self.tableView.scrollEnabled = YES;
        self.bottomContentView.scrollView.scrollEnabled = NO;
        
    } else if (self.bottomContentView.frame.size.height > halfHeight) {
        
        self.tableView.scrollEnabled = NO;
        
        self.bottomContentView.scrollView.scrollEnabled = YES;
        
        frame = self.bottomContentView.frame;
        frame.size.height = maxHeight - self.tableView.frame.size.height - extraHeight - self.cancelMargin;
        self.bottomContentView.frame = frame;
    }
}

- (void)layoutTableView {
    
    CGRect rect = CGRectMake(0, 0, self.contentWidth, 0);
    
    // 没有action且cancelAction的高度小于0.1
    if (self.actionArray.count <= 0 &&
        self.cancelAction.rowHeight < 0.1) {
        
        self.tableView.hidden = YES;
        
        self.tableView.frame = rect;
        
        return;
    }
    
    // 有action或cancelAction的高度大于等于0.1
    
    self.tableView.hidden = NO;
    
    // 加上action的高度
    for (JKAlertAction *action in self.actionArray) {
        
        rect.size.height += action.rowHeight;
    }
    
    // 自动适配X设备底部间距时，加上X设备底部间距
    rect.size.height += JKAlertAdjustHomeIndicatorHeight;
    
    // 固定取消按钮在底部，则tableView高度计算完毕
    if (self.cancelButtonPinned) {
        
        self.tableView.frame = rect;
        
        return;
    }
    
    // 不固定取消按钮，如果取消按钮高度大于等于0.1，则加上相应高度
    if (self.cancelAction.rowHeight >= 0.1) {
        
        rect.size.height += self.cancelMargin;
        
        rect.size.height += self.cancelAction.rowHeight;
    }
    
    self.tableView.frame = rect;
}

- (void)layoutCancelActionButton {
    
    self.cancelAction.isPierced = self.isPierced;
    
    self.cancelButton.action = self.cancelAction;
    
    // 没有固定取消按钮或取消按钮的高度小于0.1
    if (!self.cancelButtonPinned ||
        self.cancelAction.rowHeight < 0.1) {
        
        self.bottomContentView.hidden = YES;
        self.bottomContentView.frame = CGRectZero;
        
        return;
    }
    
    // 固定取消按钮且取消按钮的高度大于等于0.1
    
    self.bottomContentView.hidden = NO;
    
    CGRect frame = CGRectMake(0, 0, self.contentWidth, self.cancelAction.rowHeight);
    
    // 非镂空效果 且 自动适配X设备底部 且 填充X设备底部
    if (!self.isPierced &&
        self.autoAdjustHomeIndicator &&
        self.fillHomeIndicator) {
        
        // 加上底部间距
        frame.size.height += JKAlertAdjustHomeIndicatorHeight;
    }
    
    self.cancelButton.frame = frame;
    
    self.bottomContentView.frame = self.cancelButton.frame;
    
    if (self.cancelAction.customView) {
        
        self.cancelAction.customView.frame = self.cancelButton.bounds;
    }
}

- (void)updateTableViewInsets {
    
    CGFloat bottomInset = 0;
    
    // 没有固定取消按钮或取消按钮的高度小于0.1
    if (!self.cancelButtonPinned ||
        self.cancelAction.rowHeight < 0.1) {
        
        bottomInset = JKAlertAdjustHomeIndicatorHeight;
    }
    
    self.topContentView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, (self.isPierced ? 0 : self.safeInsets.right));
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, bottomInset, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, bottomInset, (self.isPierced ? 0 : self.safeInsets.right));
    
    self.bottomContentView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, JKAlertAdjustHomeIndicatorHeight, 0);
    self.bottomContentView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, JKAlertAdjustHomeIndicatorHeight, (self.isPierced ? 0 : self.safeInsets.right));
}

- (void)updateLightModetUI {
    [super updateLightModetUI];
    
    self.horizontalSeparatorLineView.backgroundColor = JKAlertGlobalSeparatorLineMultiColor().lightColor;
    
    self.topContentView.backgroundColor = self.isPierced ? self.piercedBackgroundColor.lightColor : self.textContentBackgroundColor.lightColor;
}

- (void)updateDarkModeUI {
    [super updateDarkModeUI];
    
    self.horizontalSeparatorLineView.backgroundColor = JKAlertGlobalSeparatorLineMultiColor().darkColor;
    
    self.topContentView.backgroundColor = self.isPierced ? self.piercedBackgroundColor.darkColor : self.textContentBackgroundColor.darkColor;
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
            return self.cancelAction.rowHeight >= 0.1 ? self.cancelMargin : CGFLOAT_MIN;
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
    
    _autoAdjustHomeIndicator = YES;
    
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
    
    JKAlertActionSheetTextContentView *textContentView = [[JKAlertActionSheetTextContentView alloc] init];
    [self.topContentView.scrollView addSubview:textContentView];
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
    [self.bottomContentView.scrollView addSubview:cancelButton];
    _cancelButton = cancelButton;
    
    [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIView *horizontalSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentWidth, JKAlertGlobalSeparatorLineThickness())];
    horizontalSeparatorLineView.hidden = YES;
    [self addSubview:horizontalSeparatorLineView];
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
