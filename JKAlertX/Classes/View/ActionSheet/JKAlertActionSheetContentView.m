//
//  JKAlertActionSheetContentView.m
//  JKAlertX
//
//  Created by albert on 2020/6/4.
//

#import "JKAlertActionSheetContentView.h"
#import "JKAlertAction.h"
#import "JKAlertTableViewCell.h"
#import "JKAlertUtility.h"
#import "JKAlertView.h"
#import "JKAlertActionButton.h"
#import "UIView+JKAlertX.h"
#import "JKAlertTheme.h"
#import "JKAlertUITableView.h"
#import "JKAlertClearHeaderFooterView.h"

@interface JKAlertActionSheetContentView () <UITableViewDataSource, UITableViewDelegate>

/** horizontalSeparatorLineView */
@property (nonatomic, weak) UIView *horizontalSeparatorLineView;

/** cornerMaskLayer */
@property (nonatomic, weak) CALayer *cornerMaskLayer;
@end

@implementation JKAlertActionSheetContentView

#pragma mark
#pragma mark - Public Methods

- (void)setTableViewDataSource:(id <UITableViewDataSource>)tableViewDataSource {
    _tableViewDataSource = tableViewDataSource ? tableViewDataSource : self;
    
    self.tableView.dataSource = _tableViewDataSource;
}

- (void)setTableViewDelegate:(id <UITableViewDelegate>)tableViewDelegate {
    _tableViewDelegate = tableViewDelegate ? tableViewDelegate : self;
    
    self.tableView.delegate = _tableViewDelegate;
}

- (void)setCellClassName:(NSString *)cellClassName {
    
    if (![NSClassFromString(cellClassName) isKindOfClass:[JKAlertTableViewCell class]]) { return; }
    
    _cellClassName = cellClassName;
    
    [self registerCellClass];
}

- (void)setIsPierced:(BOOL)isPierced {
    [super setIsPierced:isPierced];
    
    [self updateIsPierced];
}

- (void)calculateUI {
    [super calculateUI];
    
    if (self.layer.mask == self.cornerMaskLayer) {
        
        self.layer.mask = nil;
    }
    
    if (self.bottomButtonPinned) {
        
        [self calculatePinnedUI];
        
    } else {
        
        [self calculateNormalUI];
    }
    
    if (self.isPierced) {
        
        self.topContentView.layer.cornerRadius = self.cornerRadius;
        
        self.cancelButton.layer.cornerRadius = self.cornerRadius;
        
    } else {
        
        self.topContentView.layer.cornerRadius = 0;
        self.cancelButton.layer.cornerRadius = 0;
    }
    
    [self.tableView reloadData];
    
    if (!self.isPierced &&
        self.cornerRadius > 0) {
        
        self.cornerMaskLayer = [self JKAlertX_clipRoundWithRadius:self.cornerRadius corner:(UIRectCornerTopLeft | UIRectCornerTopRight)];
    }
}

#pragma mark
#pragma mark - Override



#pragma mark
#pragma mark - Private Methods

- (void)calculateTextContentViewUI {
    
    self.textContentView.screenSafeInsets = self.isPierced ? UIEdgeInsetsZero : self.screenSafeInsets;
    self.textContentView.contentWidth = self.alertWidth;
    
    [self.textContentView calculateUI];
}

- (void)calculateTopGestureIndicatorUI {
    
    CGRect frame = CGRectMake(0, 0, self.alertWidth, 0);
    
    if (self.gestureIndicatorHidden ||
        !self.verticalGestureDismissEnabled) {
        
        self.topGestureIndicatorView.hidden = YES;
        self.topGestureIndicatorView.frame = frame;
        
        return;
    }
    
    self.topGestureIndicatorView.hidden = NO;
    
    frame.size.height = JKAlertTopGestureIndicatorHeight;
    self.topGestureIndicatorView.frame = frame;
    
    if (!self.topGestureIndicatorView.hidden) {
        
        self.topGestureLineView.frame = CGRectMake((self.topGestureIndicatorView.frame.size.width - JKAlertTopGestureIndicatorLineWidth) * 0.5, (JKAlertTopGestureIndicatorHeight - JKAlertTopGestureIndicatorLineHeight) * 0.5, JKAlertTopGestureIndicatorLineWidth, JKAlertTopGestureIndicatorLineHeight);
    }
}

- (void)resetScrollViewUI {
    
    UIEdgeInsets contentInset = UIEdgeInsetsZero;
    
    UIEdgeInsets scrollIndicatorInsets = UIEdgeInsetsZero;
    scrollIndicatorInsets.right = self.isPierced ? 0 : self.screenSafeInsets.right;
    
    self.topContentView.scrollView.scrollEnabled = NO;
    self.tableView.scrollEnabled = NO;
    self.bottomContentView.scrollView.scrollEnabled = NO;
    
    self.topContentView.scrollView.contentInset = contentInset;
    self.topContentView.scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
    
    self.tableView.contentInset = contentInset;
    self.tableView.scrollIndicatorInsets = scrollIndicatorInsets;
    
    self.bottomContentView.scrollView.contentInset = contentInset;
    self.bottomContentView.scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
}

#pragma mark
#pragma mark - 计算普通样式

- (void)calculateNormalUI {
    
    [self calculateNormalTableViewUI];
    
    [self calculateTextContentViewUI];
    
    [self calculateTopGestureIndicatorUI];
    
    [self adjustNormalActionSheetFrame];
    
    [self calculateNormalTotalFrame];
}

- (void)calculateNormalTotalFrame {
    
    CGRect frame = CGRectMake(0, 0, self.alertWidth, 0);
    
    frame.size.height += self.topContentView.frame.size.height;
    frame.size.height += self.tableView.frame.size.height;
    
    self.frame = frame;
}

- (void)adjustNormalActionSheetFrame {
    
    [self.contentView addSubview:self.tableView];
    self.topContentView.scrollViewBottomConstraint.constant = 0;
    
    [self resetScrollViewUI];
    
    UIEdgeInsets contentInset = UIEdgeInsetsZero;
    contentInset.bottom = JKAlertAdjustHomeIndicatorHeight;
    
    UIEdgeInsets scrollIndicatorInsets = UIEdgeInsetsZero;
    scrollIndicatorInsets.right = self.isPierced ? 0 : self.screenSafeInsets.right;
    scrollIndicatorInsets.bottom = JKAlertAdjustHomeIndicatorHeight;
    
    self.bottomContentView.hidden = YES;
    
    CGRect frame = self.topGestureIndicatorView.frame;
    frame.origin.y = 0;
    self.topGestureIndicatorView.frame = frame;
    
    frame = self.textContentView.frame;
    frame.origin.y = CGRectGetMaxY(self.topGestureIndicatorView.frame);
    self.textContentView.frame = frame;
    
    frame = CGRectMake(0, 0, self.alertWidth, 0);
    frame.size.height += self.topGestureIndicatorView.frame.size.height;
    frame.size.height += self.textContentView.frame.size.height;
    self.topContentView.frame = frame;
    
    if (self.tableView.hidden) {
        
        self.horizontalSeparatorLineView.hidden = YES;
        
        frame = self.topContentView.frame;
        frame.size.height += JKAlertAdjustHomeIndicatorHeight;
        self.topContentView.frame = frame;
        
        [self.topContentView updateContentSize];
        [self.topContentView updateScrollContentViewFrame];
        
        if (self.maxHeight <= 0) { return; }
        
        if (self.topContentView.frame.size.height > self.maxHeight) {
            
            frame = self.topContentView.frame;
            frame.origin.y = 0;
            frame.size.height = self.maxHeight;
            self.topContentView.frame = frame;
            
            self.topContentView.scrollView.scrollEnabled = YES;
            
            //self.topContentView.scrollView.contentInset = contentInset;
            self.topContentView.scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
        }
        
        return;
    }
    
    [self.topContentView updateContentSize];
    [self.topContentView updateScrollContentViewFrame];
    
    CGFloat topHeight = self.topContentView.frame.size.height;
    
    CGFloat bottomHeight = self.tableView.frame.size.height;
    
    CGFloat totalHeight = topHeight + bottomHeight;
    
    CGFloat halfHeight = self.maxHeight * 0.5;
    
    if (self.maxHeight <= 0 ||
        totalHeight <= self.maxHeight) {
        
        frame = self.tableView.frame;
        frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
        self.tableView.frame = frame;
        
    } else if (topHeight > halfHeight &&
               bottomHeight > halfHeight) {
        
        // 二者都超过最大高度的一半
        
        frame = self.topContentView.frame;
        frame.size.height = halfHeight;
        self.topContentView.frame = frame;
        
        frame = self.tableView.frame;
        frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
        frame.size.height = halfHeight;
        self.tableView.frame = frame;
        
        self.topContentView.scrollView.scrollEnabled = YES;
        self.tableView.scrollEnabled = YES;
        
        self.tableView.scrollIndicatorInsets = scrollIndicatorInsets;
        
        if (self.cancelAction.rowHeight < 0.1 ||
            !self.fillHomeIndicator) {
            
            self.tableView.contentInset = contentInset;
        }
        
    } else if (topHeight > halfHeight) {
        
        // 上部分高度更高
        
        frame = self.topContentView.frame;
        frame.size.height = self.maxHeight - self.tableView.frame.size.height;
        self.topContentView.frame = frame;
        
        frame = self.tableView.frame;
        frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
        self.tableView.frame = frame;
        
        self.topContentView.scrollView.scrollEnabled = YES;
        
    } else if (bottomHeight > halfHeight) {
        
        // 下部分高度更高
        self.topContentView.scrollView.scrollEnabled = NO;
        
        frame = self.topContentView.frame;
        self.topContentView.frame = frame;
        
        frame = self.tableView.frame;
        frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
        frame.size.height = self.maxHeight - self.topContentView.frame.size.height;
        self.tableView.frame = frame;
        
        self.tableView.scrollEnabled = YES;
        
        self.tableView.scrollIndicatorInsets = scrollIndicatorInsets;
        
        if (self.cancelAction.rowHeight < 0.1 ||
            !self.fillHomeIndicator) {
            
            self.tableView.contentInset = contentInset;
        }
    }
    
    frame = self.tableView.frame;
    frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
    self.tableView.frame = frame;
    
    if (!self.bottomContentView.hidden) {
        
        frame = self.bottomContentView.frame;
        
        frame.origin.y = CGRectGetMaxY(self.tableView.frame);
        
        self.bottomContentView.frame = frame;
    }
    
    if (self.separatorLineAlwaysHidden) {
        
        self.horizontalSeparatorLineView.hidden = YES;
        
    } else {
        
        self.horizontalSeparatorLineView.hidden = (self.textContentView.hidden || self.actionArray.count <= 0);
    }
    
    self.horizontalSeparatorLineView.frame = CGRectMake(0, CGRectGetMaxY(self.topContentView.frame), self.alertWidth, JKAlertUtility.separatorLineThickness);
}

- (void)calculateNormalTableViewUI {
    
    CGRect rect = CGRectMake(0, 0, self.alertWidth, 0);
    
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
    
    // 如果取消按钮高度大于等于0.1，则加上相应高度
    if (self.cancelAction.rowHeight >= 0.1) {
        
        rect.size.height += self.cancelMargin;
        
        rect.size.height += self.cancelAction.rowHeight;
    }
    
    // 自动适配X设备底部间距时，加上X设备底部间距
    rect.size.height += JKAlertAdjustHomeIndicatorHeight;
    
    self.tableView.frame = rect;
}

#pragma mark
#pragma mark - 计算固定底部按钮样式

- (void)calculatePinnedUI {
    
    [self calculatePinnedCancelButtonUI];
    
    [self calculatePinnedTableViewUI];
    
    [self calculateTextContentViewUI];
    
    [self calculateTopGestureIndicatorUI];
    
    [self adjustPinnedActionSheetFrame];
    
    [self calculatePinnedTotalFrame];
}

- (void)calculatePinnedTotalFrame {
    
    CGRect frame = CGRectMake(0, 0, self.alertWidth, 0);
    
    if (self.isPierced) {
        
        frame.size.height += self.topContentView.frame.size.height;
        
    } else {
        
        frame.size.height += self.topContentView.frame.size.height;
        frame.size.height += self.tableView.frame.size.height;
    }
    
    frame.size.height += self.bottomContentView.frame.size.height;
    
    self.frame = frame;
}

- (void)adjustPinnedActionSheetFrame {
    
    if (self.isPierced) {
        
        [self.topContentView addSubview:self.tableView];
        
    } else {
        
        [self.contentView addSubview:self.tableView];
    }
    
    self.topContentView.scrollViewBottomConstraint.constant = 0;
    
    [self resetScrollViewUI];
    
    UIEdgeInsets contentInset = UIEdgeInsetsZero;
    contentInset.bottom = JKAlertAdjustHomeIndicatorHeight;
    
    UIEdgeInsets scrollIndicatorInsets = UIEdgeInsetsZero;
    scrollIndicatorInsets.right = self.isPierced ? 0 : self.screenSafeInsets.right;
    scrollIndicatorInsets.bottom = JKAlertAdjustHomeIndicatorHeight;
    
    CGRect frame = self.topGestureIndicatorView.frame;
    frame.origin.y = 0;
    self.topGestureIndicatorView.frame = frame;
    
    frame = self.textContentView.frame;
    frame.origin.y = CGRectGetMaxY(self.topGestureIndicatorView.frame);
    self.textContentView.frame = frame;
    
    frame = CGRectMake(0, 0, self.alertWidth, 0);
    frame.size.height += self.topGestureIndicatorView.frame.size.height;
    frame.size.height += self.textContentView.frame.size.height;
    self.topContentView.frame = frame;
    
    if (self.tableView.hidden &&
        self.bottomContentView.hidden) {
        
        self.horizontalSeparatorLineView.hidden = YES;
        
        frame = self.topContentView.frame;
        frame.size.height += JKAlertAdjustHomeIndicatorHeight;
        self.topContentView.frame = frame;
        
        [self.topContentView updateContentSize];
        [self.topContentView updateScrollContentViewFrame];
        
        if (self.maxHeight <= 0) { return; }
        
        if (self.topContentView.frame.size.height > self.maxHeight) {
            
            frame = self.topContentView.frame;
            frame.origin.y = 0;
            frame.size.height = self.maxHeight;
            self.topContentView.frame = frame;
            
            self.topContentView.scrollView.scrollEnabled = YES;
            
            self.topContentView.scrollView.contentInset = contentInset;
            self.topContentView.scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
        }
        
        return;
    }
    
    [self.topContentView updateContentSize];
    [self.topContentView updateScrollContentViewFrame];
    
    CGFloat topHeight = self.topContentView.frame.size.height;
    
    CGFloat bottomHeight = self.tableView.frame.size.height + self.bottomContentView.frame.size.height;
    
    CGFloat totalHeight = topHeight + bottomHeight;
    
    CGFloat halfHeight = self.maxHeight * 0.5;
    
    
    if (self.maxHeight <= 0 ||
        totalHeight <= self.maxHeight) {
        
        frame = self.tableView.frame;
        frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
        self.tableView.frame = frame;
        
        if (self.isPierced) {
            
            frame = self.topContentView.frame;
            frame.size.height += self.tableView.frame.size.height;
            self.topContentView.scrollViewBottomConstraint.constant = -self.tableView.frame.size.height;
            self.topContentView.frame = frame;
            
            frame = self.bottomContentView.frame;
            frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
            self.bottomContentView.frame = frame;
            
        } else {
            
            frame = self.bottomContentView.frame;
            frame.origin.y = CGRectGetMaxY(self.tableView.frame);
            self.bottomContentView.frame = frame;
        }
        
    } else if (topHeight > halfHeight &&
               bottomHeight > halfHeight) {
        
        // 二者都超过最大高度的一半
        
        frame = self.topContentView.frame;
        frame.size.height = halfHeight;
        self.topContentView.frame = frame;
        
        [self checkBottomButtonPinnedBottomFrameWithMaxHeight:halfHeight];
        
        self.topContentView.scrollView.scrollEnabled = YES;
        
    } else if (topHeight > halfHeight) {
        
        // 上部分高度更高
        
        frame = self.topContentView.frame;
        frame.size.height = self.maxHeight - bottomHeight;
        self.topContentView.frame = frame;
        
        frame = self.tableView.frame;
        frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
        self.tableView.frame = frame;
        
        if (self.isPierced) {
            
            frame = self.topContentView.frame;
            frame.size.height += self.tableView.frame.size.height;
            self.topContentView.scrollViewBottomConstraint.constant = -self.tableView.frame.size.height;
            self.topContentView.frame = frame;
            
            frame = self.bottomContentView.frame;
            frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
            self.bottomContentView.frame = frame;
            
        } else {
            
            frame = self.bottomContentView.frame;
            frame.origin.y = CGRectGetMaxY(self.tableView.frame);
            self.bottomContentView.frame = frame;
        }
        
        self.topContentView.scrollView.scrollEnabled = YES;
        
    } else if (bottomHeight > halfHeight) {
        
        // 下部分高度更高
        
        frame = self.tableView.frame;
        frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
        self.tableView.frame = frame;
        
        [self checkBottomButtonPinnedBottomFrameWithMaxHeight:self.maxHeight - topHeight];
    }
    
    if (self.separatorLineAlwaysHidden) {
        
        self.horizontalSeparatorLineView.hidden = YES;
        
    } else {
        
        self.horizontalSeparatorLineView.hidden = (self.textContentView.hidden || self.actionArray.count <= 0);
    }
    
    self.horizontalSeparatorLineView.frame = CGRectMake(0, self.isPierced ? self.tableView.frame.origin.y : CGRectGetMaxY(self.topContentView.frame), self.alertWidth, JKAlertUtility.separatorLineThickness);
}

/// 固定底部取消按钮时计算tableView和取消按钮的frame
- (void)checkBottomButtonPinnedBottomFrameWithMaxHeight:(CGFloat)maxHeight {
    
    UIEdgeInsets contentInset = UIEdgeInsetsZero;
    contentInset.bottom = JKAlertAdjustHomeIndicatorHeight;
    
    UIEdgeInsets scrollIndicatorInsets = UIEdgeInsetsZero;
    scrollIndicatorInsets.right = self.isPierced ? 0 : self.screenSafeInsets.right;
    scrollIndicatorInsets.bottom = JKAlertAdjustHomeIndicatorHeight;
    
    CGRect frame = CGRectMake(0.0, 0.0, self.alertWidth, 0.0);
    
    if (self.bottomContentView.hidden &&
        !self.tableView.hidden) {
        
        frame = self.tableView.frame;
        frame.size.height = maxHeight;
        self.tableView.frame = frame;
        
        self.tableView.scrollEnabled = YES;
        
        if (!self.isPierced) {
            
            self.tableView.scrollIndicatorInsets = scrollIndicatorInsets;
            self.tableView.contentInset = contentInset;
        }
        
        return;
    }
    
    if (self.tableView.hidden &&
        !self.bottomContentView.hidden) {
        
        frame = self.bottomContentView.frame;
        frame.size.height = maxHeight;
        self.bottomContentView.frame = frame;
        
        self.bottomContentView.scrollView.scrollEnabled = YES;
        
        if (!self.isPierced) {
            
            self.bottomContentView.scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
            
            //self.bottomContentView.scrollView.contentInset = contentInset;
        }
        
        return;
    }
    
    CGFloat halfHeight = maxHeight * 0.5;
    
    CGFloat tableHeight = self.tableView.frame.size.height;
    
    CGFloat bottomHeight = self.bottomContentView.frame.size.height;
    
    if (tableHeight > halfHeight &&
        bottomHeight > halfHeight) {
        
        // 二者都超过最大高度的一半
        
        frame = self.tableView.frame;
        frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
        frame.size.height = halfHeight;
        self.tableView.frame = frame;
        
        if (self.isPierced) {
            
            frame = self.topContentView.frame;
            frame.size.height += self.tableView.frame.size.height;
            self.topContentView.scrollViewBottomConstraint.constant = -self.tableView.frame.size.height;
            self.topContentView.frame = frame;
            
            frame = self.bottomContentView.frame;
            frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
            frame.size.height = halfHeight;
            self.bottomContentView.frame = frame;
            
        } else {
            
            frame = self.bottomContentView.frame;
            frame.origin.y = CGRectGetMaxY(self.tableView.frame);
            frame.size.height = halfHeight;
            self.bottomContentView.frame = frame;
            
            //self.bottomContentView.scrollView.contentInset = contentInset;
            self.bottomContentView.scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
        }
        
        self.tableView.scrollEnabled = YES;
        self.bottomContentView.scrollView.scrollEnabled = YES;
        
    } else if (tableHeight > halfHeight) {
        
        frame = self.tableView.frame;
        frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
        frame.size.height = maxHeight - bottomHeight;
        self.tableView.frame = frame;
        
        if (self.isPierced) {
            
            frame = self.topContentView.frame;
            frame.size.height += self.tableView.frame.size.height;
            self.topContentView.scrollViewBottomConstraint.constant = -self.tableView.frame.size.height;
            self.topContentView.frame = frame;
            
            frame = self.bottomContentView.frame;
            frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
            self.bottomContentView.frame = frame;
            
        } else {
            
            frame = self.bottomContentView.frame;
            frame.origin.y = CGRectGetMaxY(self.tableView.frame);
            self.bottomContentView.frame = frame;
        }
        
        self.tableView.scrollEnabled = YES;
        
    } else if (bottomHeight > halfHeight) {
        
        frame = self.tableView.frame;
        frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
        self.tableView.frame = frame;
        
        if (self.isPierced) {
            
            frame = self.topContentView.frame;
            frame.size.height += self.tableView.frame.size.height;
            self.topContentView.scrollViewBottomConstraint.constant = -self.tableView.frame.size.height;
            self.topContentView.frame = frame;
            
            frame = self.bottomContentView.frame;
            frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
            frame.size.height = maxHeight - tableHeight;
            self.bottomContentView.frame = frame;
            
        } else {
            
            frame = self.bottomContentView.frame;
            frame.origin.y = CGRectGetMaxY(self.tableView.frame);
            frame.size.height = maxHeight - tableHeight;
            self.bottomContentView.frame = frame;
            
            //self.bottomContentView.scrollView.contentInset = contentInset;
            self.bottomContentView.scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
        }
        
        self.bottomContentView.scrollView.scrollEnabled = YES;
    }
}

- (void)calculatePinnedTableViewUI {
    
    CGRect rect = CGRectMake(0, 0, self.alertWidth, 0);
    
    // 没有action且cancelAction的高度小于0.1
    if (self.actionArray.count <= 0) {
        
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
    
    if (self.cancelButton.hidden &&
        !self.isPierced) {
        
        rect.size.height += JKAlertAdjustHomeIndicatorHeight;
    }
    
    self.tableView.frame = rect;
}

- (void)calculatePinnedCancelButtonUI {
    
    self.bottomContentView.scrollViewTopConstraint.constant = 0;
    
    self.bottomContentView.scrollViewBottomConstraint.constant = self.isPierced ? -JKAlertAdjustHomeIndicatorHeight - self.piercedInsets.bottom : 0;
    
    self.cancelButton.action = self.cancelAction;
    
    CGRect rect = CGRectMake(0, 0, self.alertWidth, 0);
    
    rect.size.height += self.piercedInsets.bottom;
    
    // 取消按钮的高度小于0.1
    if (self.cancelAction.rowHeight < 0.1) {
        
        self.cancelButton.hidden = YES;
        
        if (self.isPierced &&
            self.autoAdjustHomeIndicator) {
            
            self.bottomContentView.hidden = NO;
            
            self.bottomContentView.frame = rect;
            
            [self.bottomContentView updateContentSize];
            [self.bottomContentView updateScrollContentViewFrame];
            
            rect.size.height += JKAlertAdjustHomeIndicatorHeight;
            self.bottomContentView.frame = rect;
            
            return;
        }
        
        self.bottomContentView.hidden = YES;
        self.bottomContentView.frame = CGRectMake(0.0, 0.0, self.alertWidth, 0.0);
        
        return;
    }
    
    // 固定取消按钮且取消按钮的高度大于等于0.1
    
    self.bottomContentView.hidden = NO;
    
    self.cancelButton.hidden = NO;
    
    CGRect frame = CGRectMake(0, 0, self.alertWidth, self.cancelAction.rowHeight);
    
    rect.size.height += self.cancelMargin + JKAlertAdjustHomeIndicatorHeight;
    
    // 非镂空效果 且 自动适配X设备底部 且 填充X设备底部
    if (!self.isPierced &&
        self.autoAdjustHomeIndicator &&
        self.fillHomeIndicator) {
        
        // 加上底部间距
        frame.size.height += JKAlertAdjustHomeIndicatorHeight;
        
        rect.size.height -= JKAlertAdjustHomeIndicatorHeight;
    }
    
    self.cancelButton.frame = frame;
    
    rect.size.height += self.cancelButton.frame.size.height;
    
    self.bottomContentView.scrollViewTopConstraint.constant = self.cancelMargin;
    
    self.bottomContentView.frame = rect;
    
    [self.bottomContentView updateContentSize];
    [self.bottomContentView updateScrollContentViewFrame];
    
    if (self.cancelAction.customView) {
        
        self.cancelAction.customView.frame = self.cancelButton.bounds;
    }
}

#pragma mark
#pragma mark - Private Selector

- (void)cancelButtonClick:(JKAlertActionButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertContentView:executeHandlerOfAction:)]) {

        [self.delegate alertContentView:self executeHandlerOfAction:button.action];
    }
}

#pragma mark
#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return (self.bottomButtonPinned || self.cancelAction.rowHeight < 0.1) ? 1 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? self.actionArray.count : (self.bottomButtonPinned ? 0 : 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JKAlertBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellClassName];
    
    if (cell == nil) {
        
        cell = [[JKAlertTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([JKAlertTableViewCell class])];
    }
    
    JKAlertAction *action = nil;
    
    if (indexPath.section == 0) {
        
        action = self.actionArray.count > indexPath.row ? self.actionArray[indexPath.row] : nil;
        
    } else {
        
        action = self.cancelAction;
    }
    
    cell.action = action;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (self.isPierced ||
        self.bottomButtonPinned) {
        
        return CGFLOAT_MIN;
    }
    
    switch (section) {
        case 0:
            return self.cancelAction.rowHeight >= 0.1 ? self.cancelMargin : CGFLOAT_MIN;
            break;
        case 1:
            return CGFLOAT_MIN;
            break;
            
        default:
            break;
    }
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (self.isPierced ||
        self.bottomButtonPinned) {
        
        return nil;
    }
    
    JKAlertClearHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([JKAlertClearHeaderFooterView class])];
    
    if (footer == nil) {
        
        footer = [[JKAlertClearHeaderFooterView alloc] initWithReuseIdentifier:NSStringFromClass([JKAlertClearHeaderFooterView class])];
    }
    
    footer.hidden = YES;
    
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    JKAlertAction *action = indexPath.section == 0 ? self.actionArray[indexPath.row] : self.cancelAction;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertContentView:executeHandlerOfAction:)]) {

        [self.delegate alertContentView:self executeHandlerOfAction:action];
    }
}

#pragma mark
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!self.verticalGestureDismissEnabled) { return; }
    
    if ((scrollView == self.topContentView.scrollView &&
         self.tableView.isDecelerating) ||
        (scrollView == self.tableView &&
         self.topContentView.scrollView.isDecelerating)) {
        
        return;
    }
    
    [self solveVerticalScroll:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (!self.verticalGestureDismissEnabled) { return; }
    
    beginScrollDirection = JKAlertScrollDirectionNone;
    endScrollDirection = JKAlertScrollDirectionNone;
    
    lastContainerY = self.frame.origin.y;
    
    if (scrollView.contentOffset.y + scrollView.contentInset.top < 0) {
        
        disableScrollToDismiss = YES;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    [self solveWillEndDraggingVertically:scrollView withVelocity:velocity];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (!self.verticalGestureDismissEnabled) { return; }
    
    if (self.topContentView.scrollView.isDecelerating ||
        _tableView.isDecelerating) {
        
        return;
    }
    
    disableScrollToDismiss = NO;
    
    //[self checkVerticalSlideShouldDismiss];
}

- (void)solveVerticalScroll:(UIScrollView *)scrollView {
    
    if (!self.verticalGestureDismissEnabled ||
        !self.tapBlankDismiss ||
        !scrollView.isDragging ||
        disableScrollToDismiss) { return; }
    
    if (scrollView.contentOffset.y + scrollView.contentInset.top < 0) {
        
        CGRect frame = self.frame;
        
        frame.origin.y -= (scrollView.contentOffset.y + scrollView.contentInset.top);
        
        frame.origin.y = (frame.origin.y < self.correctFrame.origin.y) ? self.correctFrame.origin.y : frame.origin.y;
        
        self.frame = frame;
        
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -scrollView.contentInset.top);
        
    } else if (self.frame.origin.y > self.correctFrame.origin.y + 0.1) {
        
        CGRect frame = self.frame;
        
        frame.origin.y -= (scrollView.contentOffset.y + scrollView.contentInset.top);
        
        frame.origin.y = (frame.origin.y < self.correctFrame.origin.y) ? self.correctFrame.origin.y : frame.origin.y;
        
        self.frame = frame;
        
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -scrollView.contentInset.top);
    }
    
    if (scrollView.isDragging) {
        
        [self checkVerticalSlideDirection];
    }
}

- (void)solveWillEndDraggingVertically:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity {
    
    if (!self.verticalGestureDismissEnabled || !self.tapBlankDismiss || disableScrollToDismiss) { return; }
    
    if (scrollView.contentOffset.y + scrollView.contentInset.top > 0) {
        
        disableScrollToDismiss = YES;
        
        return;
    }
    
    if (velocity.y < -1.5 && beginScrollDirection == endScrollDirection) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(alertContentViewExecuteGestureDismiss:dismissType:)]) {
            
            [self.delegate alertContentViewExecuteGestureDismiss:self dismissType:JKAlertSheetDismissAnimationTypeToBottom];
        }
        
    } else {
        
        [self checkVerticalSlideShouldDismiss];
    }
}

- (void)solveWillEndDraggingHorizontally:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity {
    
    if (!self.horizontalGestureDismissEnabled || !self.tapBlankDismiss || disableScrollToDismiss) { return; }
    
    if (scrollView.contentOffset.x + scrollView.contentInset.left > 0) {
        
        disableScrollToDismiss = YES;
        
        return;
    }
    
    if (velocity.x < -1.5 && beginScrollDirection == endScrollDirection) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(alertContentViewExecuteGestureDismiss:dismissType:)]) {
            
            [self.delegate alertContentViewExecuteGestureDismiss:self dismissType:JKAlertSheetDismissAnimationTypeToRight];
        }
        
    } else {
        
        [self checkHorizontalSlideShouldDismiss];
    }
}

#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 */
- (void)initializeProperty {
    [super initializeProperty];
    
    _cellClassName = NSStringFromClass([JKAlertTableViewCell class]);
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
    [self registerCellClass];
}

/** 创建UI */
- (void)createUI {
    [super createUI];
    
    JKAlertActionSheetTextContentView *textContentView = [[JKAlertActionSheetTextContentView alloc] init];
    [self.topContentView.scrollContentView addSubview:textContentView];
    _textContentView = textContentView;
    
    UITableView *tableView = [self createTableViewWithStyle:(UITableViewStylePlain)];
    [tableView registerClass:[JKAlertClearHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([JKAlertClearHeaderFooterView class])];
    tableView.dataSource = self.tableViewDataSource ? self.tableViewDataSource : self;
    tableView.delegate = self.tableViewDelegate ? self.tableViewDelegate : self;
    tableView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:tableView];
    _tableView = tableView;
    
    JKAlertActionButton *cancelButton = [JKAlertActionButton buttonWithType:(UIButtonTypeCustom)];
    [self.bottomContentView.scrollContentView addSubview:cancelButton];
    _cancelButton = cancelButton;
    
    [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIView *horizontalSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.alertWidth, JKAlertUtility.separatorLineThickness)];
    horizontalSeparatorLineView.userInteractionEnabled = NO;
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
    
    self.topContentView.layer.masksToBounds = YES;
    self.cancelButton.layer.masksToBounds = YES;
    
    [JKAlertThemeProvider providerBackgroundColorWithOwner:self.horizontalSeparatorLineView provideHandler:^(JKAlertThemeProvider *provider, JKAlertActionSheetContentView *providerOwner) {
        
        providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertUtility.separatorLineLightColor, JKAlertUtility.separatorLineDarkColor);
    }];
    
    [self restoreTopBackgroundColor];
}

- (void)restoreTopBackgroundColor {
    
    [JKAlertThemeProvider providerBackgroundColorWithOwner:self.topContentView provideHandler:^(JKAlertThemeProvider *provider, UIView *providerOwner) {
        
        providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertUtility.lightBackgroundColor, JKAlertUtility.darkBackgroundColor);
    }];
}

- (void)updateIsPierced {
    
    self.backgroundEffectView.hidden = self.isPierced;
}

- (void)registerCellClass {
    
    [self.tableView registerClass:NSClassFromString(self.cellClassName) forCellReuseIdentifier:self.cellClassName];
}

#pragma mark
#pragma mark - Private Property

- (UITableView *)createTableViewWithStyle:(UITableViewStyle)style {
    
    UITableView *tableView = [[JKAlertUITableView alloc] initWithFrame:CGRectZero style:style];
    
    tableView.backgroundColor = nil;
    
    tableView.scrollsToTop = NO;
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, JKAlertUtility.currentHomeIndicatorHeight, 0);
    
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft) {
        
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, -34, JKAlertUtility.currentHomeIndicatorHeight, 34);
    }
    
    return tableView;
}
@end
