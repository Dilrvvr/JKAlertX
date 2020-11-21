//
//  JKAlertCollectionSheetContentView.m
//  JKAlertX
//
//  Created by albert on 2020/6/4.
//

#import "JKAlertCollectionSheetContentView.h"
#import "JKAlertCollectionViewCell.h"
#import "JKAlertAction.h"
#import "JKAlertView.h"
#import "JKAlertActionButton.h"
#import "JKAlertPanGestureRecognizer.h"
#import "UIView+JKAlertX.h"
#import "JKAlertTheme.h"

@interface JKAlertCollectionSheetContentView () <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>
{
    __weak UIPageControl *_pageControl;
}

/** flowlayout */
@property (nonatomic, strong) UICollectionViewFlowLayout *flowlayout;

/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;

/** flowlayout2 */
@property (nonatomic, strong) UICollectionViewFlowLayout *flowlayout2;

/** collectionView2 */
@property (nonatomic, weak) UICollectionView *collectionView2;

/** titleSeparatorLineView */
@property (nonatomic, weak) UIView *titleSeparatorLineView;

/** collectionSeparatorLineView */
@property (nonatomic, weak) UIView *collectionSeparatorLineView;

/** cornerMaskLayer */
@property (nonatomic, weak) CALayer *cornerMaskLayer;
@end

@implementation JKAlertCollectionSheetContentView

#pragma mark
#pragma mark - Public Methods

- (void)setCellClassName:(NSString *)cellClassName {
    
    if (![NSClassFromString(cellClassName) isKindOfClass:[JKAlertCollectionViewCell class]]) { return; }
    
    _cellClassName = cellClassName;
    
    [self registerCellClass];
}

- (void)setIsPierced:(BOOL)isPierced {
    [super setIsPierced:isPierced];
    
    self.backgroundEffectView.hidden = self.isPierced;
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
        
        self.collectionButton.layer.cornerRadius = self.cornerRadius;
        
        self.cancelButton.layer.cornerRadius = self.cornerRadius;
        
    } else {
        
        self.topContentView.layer.cornerRadius = 0;
        self.collectionButton.layer.cornerRadius = 0;
        self.cancelButton.layer.cornerRadius = 0;
    }
    
    [self.collectionView reloadData];
    [self.collectionView2 reloadData];
    
    if (!self.isPierced &&
        self.cornerRadius > 0) {
        
        self.cornerMaskLayer = [self JKAlertX_clipRoundWithRadius:self.cornerRadius corner:(UIRectCornerTopLeft | UIRectCornerTopRight)];
    }
}

#pragma mark
#pragma mark - Override

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGPoint center = self.pageControl.center;
    center.x = self.alertWidth * 0.5;
    self.pageControl.center = center;
}

#pragma mark
#pragma mark - Private Methods

- (void)resetScrollViewUI {
    
    UIEdgeInsets contentInset = UIEdgeInsetsZero;
    
    UIEdgeInsets scrollIndicatorInsets = UIEdgeInsetsZero;
    scrollIndicatorInsets.right = self.isPierced ? 0 : self.screenSafeInsets.right;
    
    self.topContentView.scrollView.scrollEnabled = NO;
    self.bottomContentView.scrollView.scrollEnabled = NO;
    
    self.topContentView.scrollView.contentInset = contentInset;
    self.topContentView.scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
    
    self.bottomContentView.scrollView.contentInset = contentInset;
    self.bottomContentView.scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
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

- (void)calculateTextContentViewUI {
    
    self.textContentView.screenSafeInsets = self.isPierced ? UIEdgeInsetsZero : self.screenSafeInsets;
    self.textContentView.contentWidth = self.alertWidth;
    
    [self.textContentView calculateUI];
}

- (void)calculateActionButtonUI {
    
    self.cancelButton.action = self.cancelAction;
    self.collectionButton.action = self.collectionAction;
    
    self.bottomContentView.scrollViewTopConstraint.constant = 0;
    self.bottomContentView.scrollViewBottomConstraint.constant = self.isPierced ? -JKAlertAdjustHomeIndicatorHeight - self.piercedInsets.bottom : 0;
    
    if (self.cancelAction.rowHeight < 0.1) {
        
        self.cancelButton.hidden = YES;
        self.cancelButton.frame = CGRectZero;
    }
    
    if (!self.collectionAction ||
        self.collectionAction.rowHeight < 0.1) {
        
        self.collectionButton.hidden = YES;
        self.collectionButton.frame = CGRectZero;
    }
    
    /*
    if (self.cancelButton.hidden &&
        self.collectionButton.hidden) {
        
        self.bottomContentView.hidden = YES;
        self.bottomContentView.frame = CGRectMake(0.0, 0.0, self.alertWidth, 0.0);
        
        return;
    } //*/
    
    self.bottomContentView.hidden = NO;
    
    // 固定取消按钮且取消按钮的高度大于等于0.1
    
    CGRect frame = CGRectMake(0, 0, self.alertWidth, 0);
    
    CGRect rect = CGRectMake(0, 0, self.alertWidth, 0);

    rect.size.height += self.piercedInsets.bottom;
    rect.size.height += JKAlertAdjustHomeIndicatorHeight;
    
    if (!self.collectionButton.hidden) {
        
        self.bottomContentView.scrollViewTopConstraint.constant = self.cancelMargin;
        
        frame.size.height = self.collectionAction.rowHeight;
        
        self.collectionButton.frame = frame;
        
        if (self.collectionAction.customView) {
            
            self.collectionAction.customView.frame = self.collectionButton.bounds;
        }
        
        rect.size.height += self.cancelMargin;
        rect.size.height += self.collectionButton.frame.size.height;
    }
    
    if (!self.cancelButton.hidden) {
        
        self.bottomContentView.scrollViewTopConstraint.constant = self.cancelMargin;
        
        frame.size.height = self.cancelAction.rowHeight;
        
        // 非镂空效果 且 自动适配X设备底部 且 填充X设备底部
        if (!self.isPierced &&
            self.autoAdjustHomeIndicator &&
            self.fillHomeIndicator) {
            
            // 加上底部间距
            frame.size.height += JKAlertAdjustHomeIndicatorHeight;
            
            rect.size.height -= JKAlertAdjustHomeIndicatorHeight;
            
            //self.bottomContentView.scrollViewBottomConstraint.constant = 0;
        }
        
        frame.origin.y = self.collectionButton.hidden ? 0 : CGRectGetMaxY(self.collectionButton.frame) + self.cancelMargin;
        
        self.cancelButton.frame = frame;
        
        if (self.cancelAction.customView) {
            
            self.cancelAction.customView.frame = self.cancelButton.bounds;
        }
        
        rect.size.height += self.cancelMargin;
        rect.size.height += self.cancelButton.frame.size.height;
    }
    
    self.bottomContentView.frame = rect;
    
    [self.bottomContentView updateContentSize];
    [self.bottomContentView updateScrollContentViewFrame];
}

- (void)calculateCollectionViewUI {
    
    NSInteger count = self.actionArray.count;
    NSInteger count2 = self.secondActionArray.count;
    
    if (count <= 0 && count2 <= 0) {
        
        self.collectionView.hidden = YES;
        self.collectionView2.hidden = YES;
        self.pageControl.hidden = YES;
        
        self.collectionView.frame = CGRectMake(0.0, 0.0, self.alertWidth, 0.0);
        self.collectionView2.frame = CGRectMake(0.0, 0.0, self.alertWidth, 0.0);
        self.pageControl.frame = CGRectZero;
        
        return;
    }
    
    self.collectionView.pagingEnabled = self.collectionPagingEnabled;
    self.collectionView2.pagingEnabled = self.collectionPagingEnabled;
    
    self.pageControl.numberOfPages = ceil(((self.minimumLineSpacing + self.itemSize.width) * MAX(count, count2) - 5) / self.alertWidth);
    
    CGFloat collectionHeight = self.itemSize.height;
    
    CGRect frame = CGRectMake(0, 0, self.alertWidth, collectionHeight);
    
    self.collectionView.hidden = (count <= 0);
    self.collectionView2.hidden = (count2 <= 0);
    
    if (self.collectionView.hidden) {
        
        self.collectionView.frame = CGRectMake(0.0, 0.0, self.alertWidth, 0.0);
        
    } else {
        
        if (!self.collectionView2.hidden) {
            
            frame.size.height += MAX(self.collectionViewMargin, 0);
        }
        
        self.collectionView.frame = frame;
    }
    
    if (self.collectionView2.hidden) {
        
        self.collectionView2.frame = CGRectMake(0.0, 0.0, self.alertWidth, 0.0);
        
    } else {
        
        frame.size.height = collectionHeight;
        
        self.collectionView2.frame = frame;
    }
    
    self.pageControl.hidden = self.pageControlHidden;
    
    if (!self.pageControl.hidden) {
        
        frame.size.height = self.pageControlHeight;
        
        self.pageControl.frame = frame;
    }
}

- (void)calculateTopContainerViewUI {
    
    CGRect frame = self.topGestureIndicatorView.frame;
    frame.origin.y = 0;
    self.topGestureIndicatorView.frame = frame;
    
    frame = self.textContentView.frame;
    frame.origin.y = CGRectGetMaxY(self.topGestureIndicatorView.frame);
    self.textContentView.frame = frame;
    
    frame = self.titleSeparatorLineView.frame;
    frame.origin.y = CGRectGetMaxY(self.topGestureIndicatorView.frame);
    self.titleSeparatorLineView.frame = frame;
    
    self.titleSeparatorLineView.hidden = self.titleSeparatorLineHidden || self.textContentView.hidden || (self.collectionView.hidden && self.collectionView2.hidden);
    
    frame = self.collectionView.frame;
    frame.origin.y = CGRectGetMaxY(self.textContentView.frame);
    self.collectionView.frame = frame;
    
    CGFloat collectionMargin = MAX(self.collectionViewMargin, 0);
    
    frame = self.collectionSeparatorLineView.frame;
    frame.origin.y = CGRectGetMaxY(self.collectionView.frame) - collectionMargin * 0.5;
    self.collectionSeparatorLineView.frame = frame;
    
    self.collectionSeparatorLineView.hidden = (self.collectionSeparatorLineHidden || self.collectionView.hidden || self.collectionView2.hidden);
    
    frame = self.collectionView2.frame;
    frame.origin.y = CGRectGetMaxY(self.collectionView.frame);
    self.collectionView2.frame = frame;
    
    CGFloat insetLeft = self.screenSafeInsets.left + self.sectionInset.left;
    CGFloat insetRight = self.screenSafeInsets.right + self.sectionInset.right;
    
    
    self.flowlayout.itemSize = self.itemSize;
    self.flowlayout.minimumLineSpacing = self.minimumLineSpacing;
    
    UIEdgeInsets sectionInset = UIEdgeInsetsMake(self.flowlayout.itemSize.height - self.collectionView.frame.size.height, insetLeft, 0, insetRight);
    self.flowlayout.sectionInset = sectionInset;
    
    self.flowlayout2.itemSize = self.itemSize;
    self.flowlayout2.minimumLineSpacing = self.minimumLineSpacing;
    
    sectionInset = UIEdgeInsetsMake(self.flowlayout2.itemSize.height - self.collectionView2.frame.size.height, insetLeft, 0, insetRight);
    self.flowlayout2.sectionInset = sectionInset;
    
    
    if (!self.collectionView.hidden &&
        !self.collectionView2.hidden) {
        
        sectionInset.bottom = collectionMargin;
        self.flowlayout.sectionInset = sectionInset;
    }
    
    frame = self.pageControl.frame;
    frame.origin.y = CGRectGetMaxY(self.collectionView2.frame);
    self.pageControl.frame = frame;
    
    frame = CGRectMake(0, 0, self.alertWidth, 0);
    frame.size.height += self.topGestureIndicatorView.frame.size.height;
    frame.size.height += self.textContentView.frame.size.height;
    frame.size.height += self.collectionView.frame.size.height;
    frame.size.height += self.collectionView2.frame.size.height;
    frame.size.height += self.pageControl.frame.size.height;
    self.topContainerView.frame = frame;
}

#pragma mark
#pragma mark - 计算普通样式

- (void)calculateNormalUI {
    
    [self calculateActionButtonUI];
    
    [self calculateCollectionViewUI];
    
    [self calculateTextContentViewUI];
    
    [self calculateTopGestureIndicatorUI];
    
    [self calculateTopContainerViewUI];
    
    [self adjustNormalCollectionSheetFrame];
    
    [self calculateNormalTotalFrame];
}

- (void)calculateNormalTotalFrame {
    
    self.frame = self.topContentView.frame;
}

- (void)adjustNormalCollectionSheetFrame {
    
    [self.topContentView.scrollContentView addSubview:self.bottomContentView];
    
    [self resetScrollViewUI];
    
    UIEdgeInsets contentInset = UIEdgeInsetsZero;
    contentInset.bottom = JKAlertAdjustHomeIndicatorHeight;
    
    UIEdgeInsets scrollIndicatorInsets = UIEdgeInsetsZero;
    scrollIndicatorInsets.right = self.isPierced ? 0 : self.screenSafeInsets.right;
    scrollIndicatorInsets.bottom = JKAlertAdjustHomeIndicatorHeight;
    
    CGRect frame = self.topContainerView.frame;
    frame.origin.y = 0;
    self.topContainerView.frame = frame;
    
    frame = self.bottomContentView.frame;
    frame.origin.y = CGRectGetMaxY(self.topContainerView.frame);
    self.bottomContentView.frame = frame;
    
    frame = CGRectMake(0, 0, self.alertWidth, 0);
    frame.size.height += self.topContainerView.frame.size.height;
    frame.size.height += self.bottomContentView.frame.size.height;
    if (self.bottomContentView.hidden) {
        frame.size.height += JKAlertAdjustHomeIndicatorHeight;
    }
    self.topContentView.frame = frame;
    
    [self.topContentView updateContentSize];
    [self.topContentView updateScrollContentViewFrame];
    
    if (self.maxHeight <= 0 || self.topContentView.frame.size.height < self.maxHeight) { return; }
    
    frame = self.topContentView.frame;
    frame.size.height = self.maxHeight;
    self.topContentView.frame = frame;
    
    self.topContentView.scrollView.scrollEnabled = YES;
    
    self.topContentView.scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
    //self.topContentView.scrollView.contentInset = contentInset;
}

#pragma mark
#pragma mark - 计算固定底部按钮样式

- (void)calculatePinnedUI {
    
    [self calculateActionButtonUI];
    
    [self calculateCollectionViewUI];
    
    [self calculateTextContentViewUI];
    
    [self calculateTopGestureIndicatorUI];
    
    [self calculateTopContainerViewUI];
    
    [self adjustPinnedCollectionSheetFrame];
    
    [self calculatePinnedTotalFrame];
}

- (void)calculatePinnedTotalFrame {
    
    CGRect frame = CGRectMake(0, 0, self.alertWidth, 0);
    
    frame.size.height += self.topContentView.frame.size.height;
    
    frame.size.height += self.bottomContentView.frame.size.height;
    
    self.frame = frame;
}

- (void)adjustPinnedCollectionSheetFrame {
    
    [self.contentView addSubview:self.bottomContentView];
    
    [self resetScrollViewUI];
    
    //UIEdgeInsets contentInset = UIEdgeInsetsZero;
    //contentInset.bottom = JKAlertAdjustHomeIndicatorHeight;
    
    UIEdgeInsets scrollIndicatorInsets = UIEdgeInsetsZero;
    scrollIndicatorInsets.right = self.isPierced ? 0 : self.screenSafeInsets.right;
    scrollIndicatorInsets.bottom = JKAlertAdjustHomeIndicatorHeight;
    
    CGRect frame = self.topContainerView.frame;
    frame.origin.y = 0;
    self.topContainerView.frame = frame;
    
    frame = CGRectMake(0, 0, self.alertWidth, 0);
    frame.size.height += self.topContainerView.frame.size.height;
    self.topContentView.frame = frame;
    
    [self.topContentView updateContentSize];
    [self.topContentView updateScrollContentViewFrame];
    
    frame = self.bottomContentView.frame;
    frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
    self.bottomContentView.frame = frame;
    
    CGFloat topHeight = self.topContentView.frame.size.height;
    
    CGFloat bottomHeight = self.bottomContentView.frame.size.height;
    
    CGFloat totalHeight = topHeight + bottomHeight;
    
    if (self.maxHeight <= 0 || totalHeight < self.maxHeight) { return; }
    
    CGFloat halfHeight = self.maxHeight * 0.5;
    
    if (topHeight > halfHeight &&
        bottomHeight > halfHeight) {
        
        frame = self.topContentView.frame;
        frame.size.height = halfHeight;
        self.topContentView.frame = frame;
        
        frame = self.bottomContentView.frame;
        frame.size.height = halfHeight;
        self.bottomContentView.frame = frame;
        
        self.topContentView.scrollView.scrollEnabled = YES;
        self.bottomContentView.scrollView.scrollEnabled = YES;
        
        if (!self.isPierced &&
            self.autoAdjustHomeIndicator) {
            
            self.bottomContentView.scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
            
            //if (!self.fillHomeIndicator) {
            
            //self.bottomContentView.scrollView.contentInset = contentInset;
            //}
        }
        
    } else if (topHeight > halfHeight) {
        
        frame = self.topContentView.frame;
        frame.size.height = self.maxHeight - self.bottomContentView.frame.size.height;
        self.topContentView.frame = frame;
        
        frame = self.bottomContentView.frame;
        frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
        self.bottomContentView.frame = frame;
        
        self.topContentView.scrollView.scrollEnabled = YES;
        
    } else if (bottomHeight > halfHeight) {
        
        frame = self.bottomContentView.frame;
        frame.size.height = self.maxHeight - self.topContentView.frame.size.height;
        self.bottomContentView.frame = frame;
        
        self.bottomContentView.scrollView.scrollEnabled = YES;
        
        if (!self.isPierced &&
            self.autoAdjustHomeIndicator) {
            
            self.bottomContentView.scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
            
            //if (!self.fillHomeIndicator) {
            
            //self.bottomContentView.scrollView.contentInset = contentInset;
            //}
        }
    }
}

#pragma mark
#pragma mark - Private Selector

- (void)actionButtonClick:(JKAlertActionButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertContentView:executeHandlerOfAction:)]) {

        [self.delegate alertContentView:self executeHandlerOfAction:button.action];
    }
}

#pragma mark
#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return collectionView == self.collectionView ? self.actionArray.count : self.secondActionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JKAlertCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(self.cellClassName) forIndexPath:indexPath];
    
    JKAlertAction *action = nil;
    
    if (collectionView == self.collectionView) {
        
        action = self.actionArray.count > indexPath.item ? self.actionArray[indexPath.item] : nil;
        
    } else {
        
        action = self.secondActionArray.count > indexPath.item ? self.secondActionArray[indexPath.item] : nil;
    }
    
    cell.action = action;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    JKAlertAction *action = nil;
    
    if (collectionView == self.collectionView) {
        
        action = self.actionArray.count > indexPath.item ? self.actionArray[indexPath.item] : nil;
        
    } else {
        
        action = self.secondActionArray.count > indexPath.item ? self.secondActionArray[indexPath.item] : nil;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertContentView:executeHandlerOfAction:)]) {

        [self.delegate alertContentView:self executeHandlerOfAction:action];
    }
}


#pragma mark
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.topContentView.scrollView ||
        scrollView == self.bottomContentView.scrollView) {
        
        if (scrollView.isDecelerating) { return; }
        
        [self solveVerticalScroll:scrollView];
        
    } else {
        
        [self solveHorizontalScroll:scrollView];
        
        if (self.combined) {
            
            self.collectionView.contentOffset = scrollView.contentOffset;
            self.collectionView2.contentOffset = scrollView.contentOffset;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (scrollView == self.topContentView.scrollView ||
        scrollView == self.bottomContentView.scrollView) {
        
        if (!self.verticalGestureDismissEnabled) { return; }
        
        beginScrollDirection = JKAlertScrollDirectionNone;
        endScrollDirection = JKAlertScrollDirectionNone;
        
        lastContainerY = self.frame.origin.y;
        
        if (scrollView.contentOffset.y + scrollView.contentInset.top < 0) {
            
            disableScrollToDismiss = YES;
        }
        
    } else {
        
        if (!self.horizontalGestureDismissEnabled) { return; }
        
        beginScrollDirection = JKAlertScrollDirectionNone;
        endScrollDirection = JKAlertScrollDirectionNone;
        
        lastContainerX = self.frame.origin.x;
        
        if (scrollView.contentOffset.x + scrollView.contentInset.left < 0 &&
            fabs(self.frame.origin.x - self.correctFrame.origin.x) < 0.1) {
            
            disableScrollToDismiss = YES;
        }
        
        if (scrollView.contentOffset.x + scrollView.frame.size.width - scrollView.contentInset.right > scrollView.contentSize.width &&
            fabs(self.frame.origin.x - self.correctFrame.origin.x) < 0.1) {
            
            disableScrollToDismiss = YES;
        }
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if (scrollView == self.topContentView.scrollView ||
        scrollView == self.bottomContentView.scrollView) {
        
        [self solveWillEndDraggingVertically:scrollView withVelocity:velocity];
        
    } else {
        
        [self solveWillEndDraggingHorizontally:scrollView withVelocity:velocity];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        
        self.pageControl.currentPage = ceil((scrollView.contentOffset.x - 5) / self.alertWidth);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        
        self.pageControl.currentPage = ceil((scrollView.contentOffset.x - 5) / self.alertWidth);
    }
    
    if (scrollView == self.topContentView.scrollView ||
        scrollView == self.bottomContentView.scrollView) {
        
        if (!self.verticalGestureDismissEnabled) { return; }
        
        disableScrollToDismiss = NO;
        
        //[self checkVerticalSlideShouldDismiss];
        
    } else {
        
        if (!self.horizontalGestureDismissEnabled) { return; }
        
        if (self.collectionView.isDecelerating ||
            self.collectionView2.isDecelerating) {
            return;
        }
        
        disableScrollToDismiss = NO;
    }
}

- (void)solveVerticalScroll:(UIScrollView *)scrollView{
    
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

- (void)solveHorizontalScroll:(UIScrollView *)scrollView{
    
    if (!self.horizontalGestureDismissEnabled || !self.tapBlankDismiss) { return; }
    
    if ((scrollView == self.collectionView &&
         self.collectionView2.isDecelerating) ||
        (scrollView == self.collectionView2 &&
         self.collectionView.isDecelerating)) {
        return;
    }
    
    if (!scrollView.isDragging || disableScrollToDismiss) { return; }
    
    if (scrollView.contentOffset.x + scrollView.contentInset.left < 0) {
        
        if (JKAlertSheetHorizontalGestureDismissDirectionToLeft == self.horizontalGestureDismissDirection) {
            
            return;
        }
        
        CGRect frame = self.frame;
        
        frame.origin.x -= (scrollView.contentOffset.x + scrollView.contentInset.left);
        
        self.frame = frame;
        
        scrollView.contentOffset = CGPointMake(-scrollView.contentInset.left, scrollView.contentOffset.y);
        
    } else if (self.frame.origin.x > self.correctFrame.origin.x + 0.1) {
        
        if (JKAlertSheetHorizontalGestureDismissDirectionToLeft == self.horizontalGestureDismissDirection) {
            
            return;
        }
        
        CGRect frame = self.frame;
        
        frame.origin.x -= (scrollView.contentOffset.x + scrollView.contentInset.left);
        
        frame.origin.x = (frame.origin.x < self.correctFrame.origin.x) ? self.correctFrame.origin.x : frame.origin.x;
        
        self.frame = frame;
        
        scrollView.contentOffset = CGPointMake(-scrollView.contentInset.left, scrollView.contentOffset.y);
        
    } else if (scrollView.contentOffset.x + scrollView.frame.size.width - scrollView.contentInset.right > scrollView.contentSize.width) {
        
        if (JKAlertSheetHorizontalGestureDismissDirectionToRight == self.horizontalGestureDismissDirection) {
            
            return;
        }
        
        CGRect frame = self.frame;
        
        frame.origin.x -= (scrollView.contentOffset.x + scrollView.frame.size.width - scrollView.contentInset.right - scrollView.contentSize.width);
        
        self.frame = frame;
        
        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width - scrollView.frame.size.width + scrollView.contentInset.right, scrollView.contentOffset.y);
        
    } else if (self.frame.origin.x < self.correctFrame.origin.x - 0.1) {
        
        if (JKAlertSheetHorizontalGestureDismissDirectionToRight == self.horizontalGestureDismissDirection) {
            
            return;
        }
        
        CGRect frame = self.frame;
        
        frame.origin.x -= (scrollView.contentOffset.x + scrollView.frame.size.width - scrollView.contentInset.right - scrollView.contentSize.width);
        
        frame.origin.x = (frame.origin.x > self.correctFrame.origin.x) ? self.correctFrame.origin.x : frame.origin.x;
        
        self.frame = frame;
        
        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width - scrollView.frame.size.width + scrollView.contentInset.right, scrollView.contentOffset.y);
    }
    
    if (scrollView.isDragging) {
        
        [self checkHorizontalSlideDirection];
    }
}

- (void)solveWillEndDraggingVertically:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity{
    
    if (!self.verticalGestureDismissEnabled || !self.tapBlankDismiss || disableScrollToDismiss) { return; }
    
    if (scrollView.contentOffset.y + scrollView.contentInset.top > 0 ||
        scrollView.contentOffset.x + scrollView.contentInset.left > 0) {
        
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

- (void)solveWillEndDraggingHorizontally:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity{
    
    if (!self.horizontalGestureDismissEnabled || !self.tapBlankDismiss || disableScrollToDismiss) { return; }
    
    if (fabs(self.frame.origin.x - self.correctFrame.origin.x) < 0.1) {
        
        disableScrollToDismiss = YES;
        
        return;
    }
    
    if (velocity.x < -1.5 && beginScrollDirection == endScrollDirection) {
        
        if (JKAlertSheetHorizontalGestureDismissDirectionToLeft == self.horizontalGestureDismissDirection) {
            
            return;
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(alertContentViewExecuteGestureDismiss:dismissType:)]) {
            
            [self.delegate alertContentViewExecuteGestureDismiss:self dismissType:JKAlertSheetDismissAnimationTypeToRight];
        }
        
    } else if (velocity.x > 1.5 && beginScrollDirection == endScrollDirection) {
        
        if (JKAlertSheetHorizontalGestureDismissDirectionToRight == self.horizontalGestureDismissDirection) {
            
            return;
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(alertContentViewExecuteGestureDismiss:dismissType:)]) {
            
            [self.delegate alertContentViewExecuteGestureDismiss:self dismissType:JKAlertSheetDismissAnimationTypeToLeft];
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
    
    _pageControlHeight = 30;
    
    _minimumLineSpacing = 10;
    
    _sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    _itemSize = CGSizeMake(76, 70);
    
    _collectionViewMargin = 10;
    
    _pageControlHidden = YES;
    
    _titleSeparatorLineHidden = YES;
    
    _collectionSeparatorLineHidden = YES;
    
    _cellClassName = NSStringFromClass([JKAlertCollectionViewCell class]);
    
    self.cancelMargin = 10;
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
    [self registerCellClass];
}

/** 创建UI */
- (void)createUI {
    [super createUI];
    
    UIView *topContainerView = [[UIView alloc] init];
    [self.topContentView.scrollContentView insertSubview:topContainerView atIndex:0];
    _topContainerView = topContainerView;
    
    JKAlertCollectionSheetTextContentView *textContentView = [[JKAlertCollectionSheetTextContentView alloc] init];
    [self.topContainerView addSubview:textContentView];
    _textContentView = textContentView;
    
    UIView *titleSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.alertWidth, JKAlertUtility.separatorLineThickness)];
    titleSeparatorLineView.userInteractionEnabled = NO;
    titleSeparatorLineView.hidden = YES;
    [self.topContainerView addSubview:titleSeparatorLineView];
    _titleSeparatorLineView = titleSeparatorLineView;
    
    UIView *collectionSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.alertWidth, JKAlertUtility.separatorLineThickness)];
    collectionSeparatorLineView.userInteractionEnabled = NO;
    collectionSeparatorLineView.hidden = YES;
    [self.topContainerView addSubview:collectionSeparatorLineView];
    _collectionSeparatorLineView = collectionSeparatorLineView;
    
    [self.topContentView.scrollContentView addSubview:self.bottomContentView];
    
    JKAlertActionButton *cancelButton = [JKAlertActionButton buttonWithType:(UIButtonTypeCustom)];
    [self.bottomContentView.scrollContentView addSubview:cancelButton];
    _cancelButton = cancelButton;
    
    [cancelButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    JKAlertActionButton *collectionButton = [JKAlertActionButton buttonWithType:(UIButtonTypeCustom)];
    [self.bottomContentView.scrollContentView addSubview:collectionButton];
    _collectionButton = collectionButton;
    
    [collectionButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
}

/** 布局UI */
- (void)layoutUI {
    [super layoutUI];
    
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
    self.bottomContentView.scrollView.scrollEnabled = NO;
    
    self.topContentView.layer.masksToBounds = YES;
    self.collectionButton.layer.masksToBounds = YES;
    self.cancelButton.layer.masksToBounds = YES;
    
    [JKAlertThemeProvider providerBackgroundColorWithOwner:self.titleSeparatorLineView provideHandler:^(JKAlertThemeProvider *provider, JKAlertCollectionSheetContentView *providerOwner) {
        
        providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertUtility.separatorLineLightColor, JKAlertUtility.separatorLineDarkColor);
    }];
    
    [JKAlertThemeProvider providerBackgroundColorWithOwner:self.collectionSeparatorLineView provideHandler:^(JKAlertThemeProvider *provider, JKAlertCollectionSheetContentView *providerOwner) {
        
        providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertUtility.separatorLineLightColor, JKAlertUtility.separatorLineDarkColor);
    }];
    
    [JKAlertThemeProvider providerBackgroundColorWithOwner:self.topContainerView provideHandler:^(JKAlertThemeProvider *provider, UIView *providerOwner) {
        
        providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertUtility.lightBackgroundColor, JKAlertUtility.darkBackgroundColor);
    }];
}

- (void)registerCellClass {
    
    [self.collectionView registerClass:NSClassFromString(self.cellClassName) forCellWithReuseIdentifier:self.cellClassName];
    [self.collectionView2 registerClass:NSClassFromString(self.cellClassName) forCellWithReuseIdentifier:self.cellClassName];
}

#pragma mark
#pragma mark - Private Property

- (NSMutableArray *)secondActionArray {
    if (!_secondActionArray) {
        _secondActionArray = [NSMutableArray array];
    }
    return _secondActionArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowlayout = flowlayout;
        
        UICollectionView *collectionView = [self createCollectionViewWithFlowLayout:flowlayout];
        [self.topContentView.scrollContentView addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UICollectionView *)collectionView2 {
    if (!_collectionView2) {
        
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowlayout2 = flowlayout;
        
        UICollectionView *collectionView = [self createCollectionViewWithFlowLayout:flowlayout];
        [self.topContentView.scrollContentView addSubview:collectionView];
        _collectionView2 = collectionView;
    }
    return _collectionView2;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.backgroundColor = nil;
        pageControl.userInteractionEnabled = NO;
        [self.topContentView.scrollContentView addSubview:pageControl];
        _pageControl = pageControl;
        
        [JKAlertThemeProvider providerWithOwner:pageControl handlerKey:NSStringFromSelector(@selector(pageIndicatorTintColor)) provideHandler:^(JKAlertThemeProvider *provider, UIPageControl *providerOwner) {
            
            providerOwner.pageIndicatorTintColor = JKAlertCheckDarkMode(JKAlertSameRGBColor(217), JKAlertSameRGBColor(38));
        }];
        
        [JKAlertThemeProvider providerWithOwner:pageControl handlerKey:NSStringFromSelector(@selector(currentPageIndicatorTintColor)) provideHandler:^(JKAlertThemeProvider *provider, UIPageControl *providerOwner) {
            
            providerOwner.currentPageIndicatorTintColor = JKAlertCheckDarkMode(JKAlertSameRGBColor(102), JKAlertSameRGBColor(153));
        }];
    }
    return _pageControl;
}

- (UICollectionView *)createCollectionViewWithFlowLayout:(UICollectionViewFlowLayout *)flowLayout {
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.backgroundColor = nil;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    collectionView.scrollsToTop = NO;
    
    if (@available(iOS 11.0, *)) {
        
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    if (@available(iOS 13.0, *)) {
        
        collectionView.automaticallyAdjustsScrollIndicatorInsets = NO;
    }
    
    return collectionView;
}

@end
