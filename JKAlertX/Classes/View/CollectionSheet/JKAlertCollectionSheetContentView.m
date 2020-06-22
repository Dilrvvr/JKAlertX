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

@interface JKAlertCollectionSheetContentView () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    __weak UIPageControl *_pageControl;
}

/** topContainerView */
@property (nonatomic, weak) UIView *topContainerView;

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

/** cancelButton */
@property (nonatomic, weak) JKAlertActionButton *cancelButton;

/** collectionButton */
@property (nonatomic, weak) JKAlertActionButton *collectionButton;
@end

@implementation JKAlertCollectionSheetContentView

#pragma mark
#pragma mark - Public Methods

- (void)calculateUI {
    [super calculateUI];
    
    self.backgroundEffectView.hidden = self.isPierced;
    
    self.textContentView.screenSafeInsets = self.screenSafeInsets;
    self.textContentView.contentWidth = self.contentWidth;
    
    [self.textContentView calculateUI];
    
    [self layoutCollectionView];
    
    [self layoutActionButton];
    
    [self adjustCollectionSheetFrame];
    
    [self adjustPinActionButtonCollectionSheetFrame];
    
    if (self.isPierced) {
        
        self.topContentView.layer.cornerRadius = self.piercedCornerRadius;
        
        self.collectionButton.layer.cornerRadius = self.piercedCornerRadius;
        
        self.cancelButton.layer.cornerRadius = self.piercedCornerRadius;
        
    } else {
        
        self.topContentView.layer.cornerRadius = 0;
        self.collectionButton.layer.cornerRadius = 0;
        self.cancelButton.layer.cornerRadius = 0;
    }
    
    [self.collectionView reloadData];
    [self.collectionView2 reloadData];
}

- (void)setCellClassName:(NSString *)cellClassName {
    
    if (![NSClassFromString(cellClassName) isKindOfClass:[JKAlertCollectionViewCell class]]) { return; }
    
    _cellClassName = cellClassName;
    
    [self registerCellClass];
}

#pragma mark
#pragma mark - Override

- (void)dealloc {
    
    // TODO: JKTODO delete
    
    NSLog(@"[ClassName: %@], %d, %s", NSStringFromClass([self class]), __LINE__, __func__);
}

#pragma mark
#pragma mark - Private Methods

- (void)adjustPinActionButtonCollectionSheetFrame {
    
    if (!self.actionButtonPinned) {
        
        [self.topContentView.scrollView addSubview:self.bottomContentView];
        
        return;
    }
    
    self.topContentView.scrollView.scrollEnabled = NO;
    self.bottomContentView.scrollView.scrollEnabled = NO;
    
    [self.contentView addSubview:self.bottomContentView];
    
    CGRect frame = self.topContentView.frame;
    frame.size.height = self.topContainerView.frame.size.height;
    self.topContentView.frame = frame;
    
    [self.topContentView updateContentSize];
    
    frame = self.bottomContentView.frame;
    frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
    self.bottomContentView.frame = frame;
    
    [self.bottomContentView updateContentSize];
    
    if (self.topContainerView.frame.size.height + self.bottomContentView.frame.size.height <= self.maxHeight) {
        
        frame = self.bottomContentView.frame;
        frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
        self.bottomContentView.frame = frame;
        
        self.frame = CGRectMake(0, 0, self.contentWidth, self.topContentView.frame.size.height + self.bottomContentView.frame.size.height);
        
        return;
    }
    
    CGFloat halfHeight = self.maxHeight * 0.5;
    
    if (self.topContainerView.frame.size.height > halfHeight &&
        self.bottomContentView.frame.size.height > halfHeight) {
        
        // 二者都超过最大高度的一半
        
        self.topContentView.scrollView.scrollEnabled = YES;
        self.bottomContentView.scrollView.scrollEnabled = YES;
        
        frame = self.topContentView.frame;
        frame.size.height = halfHeight;
        self.topContentView.frame = frame;
        
        frame = self.bottomContentView.frame;
        frame.size.height = halfHeight;
        self.bottomContentView.frame = frame;
        
    } else if (self.topContainerView.frame.size.height > halfHeight) {
        
        self.topContentView.scrollView.scrollEnabled = YES;
        
        frame = self.topContentView.frame;
        frame.size.height = self.maxHeight - self.bottomContentView.frame.size.height;
        self.topContentView.frame = frame;
        
    } else if (self.bottomContentView.frame.size.height > halfHeight) {
        
        self.bottomContentView.scrollView.scrollEnabled = YES;
        
        frame = self.bottomContentView.frame;
        frame.size.height = self.maxHeight - self.topContentView.frame.size.height;
        self.bottomContentView.frame = frame;
    }
    
    frame = self.bottomContentView.frame;
    frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
    self.bottomContentView.frame = frame;
    
    self.frame = CGRectMake(0, 0, self.contentWidth, self.topContentView.frame.size.height + self.bottomContentView.frame.size.height);
}

- (void)adjustCollectionSheetFrame {
    
    self.topContentView.scrollView.scrollEnabled = NO;
    self.bottomContentView.scrollView.scrollEnabled = NO;
    
    CGRect rect = CGRectMake(0, 0, self.contentWidth, 0);
    
    CGRect frame = CGRectZero;
    
    CGFloat topInitialHeight = 0;
    
    self.titleSeparatorLineView.hidden = self.titleSeparatorLineHidden;
    
    if (self.textContentView.hidden) {
        
        self.titleSeparatorLineView.hidden = YES;
        
    } else {

        frame = self.textContentView.frame;
        frame.origin.y = rect.size.height;
        self.textContentView.frame = frame;
        
        rect.size.height += self.textContentView.frame.size.height;
    }
    
    if (!self.titleSeparatorLineView.hidden) {
        
        frame = CGRectMake(0, rect.size.height, self.contentWidth, JKAlertGlobalSeparatorLineThickness());
        self.titleSeparatorLineView.frame = frame;
    }
    
    self.collectionSeparatorLineView.hidden = self.collectionSeparatorLineHidden;
    
    if (self.collectionView.hidden ||
        self.collectionView2.hidden) {
        
        self.collectionSeparatorLineView.hidden = YES;
    }
    
    CGFloat collectionMargin = MAX(self.collectionViewMargin, 0);
    
    CGFloat insetLeft = self.screenSafeInsets.left + self.sectionInset.left;
    CGFloat insetRight = self.screenSafeInsets.right + self.sectionInset.right;
    
    if (!self.collectionView.hidden) {
        
        self.flowlayout.itemSize = self.itemSize;
        self.flowlayout.minimumLineSpacing = self.minimumLineSpacing;
        
        UIEdgeInsets sectionInset = UIEdgeInsetsMake(0, insetLeft, 0, insetRight);
        self.flowlayout.sectionInset = sectionInset;

        frame = self.collectionView.frame;
        frame.origin.y = rect.size.height;
        self.collectionView.frame = frame;
        
        rect.size.height += self.collectionView.frame.size.height;
        
        if (!self.collectionView2.hidden) {
            
            if (!self.collectionSeparatorLineHidden) {

                frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame) + collectionMargin * 0.5, self.contentWidth, JKAlertGlobalSeparatorLineThickness());
                self.collectionSeparatorLineView.frame = frame;
                
                sectionInset.bottom = collectionMargin;
                self.flowlayout.sectionInset = sectionInset;
            }
        }
    }
    
    if (!self.collectionView2.hidden) {
        
        self.flowlayout2.itemSize = self.itemSize;
        self.flowlayout2.minimumLineSpacing = self.minimumLineSpacing;
        
        UIEdgeInsets sectionInset = UIEdgeInsetsMake(0, insetLeft, 0, insetRight);
        self.flowlayout2.sectionInset = sectionInset;

        frame = self.collectionView2.frame;
        frame.origin.y = rect.size.height;
        self.collectionView2.frame = frame;
        
        rect.size.height += self.collectionView2.frame.size.height;
    }
    
    if (!self.pageControl.hidden) {

        frame = self.pageControl.frame;
        frame.origin.y = rect.size.height;
        self.pageControl.frame = frame;
        
        rect.size.height += self.pageControl.frame.size.height;
    }
    
    self.topContainerView.frame = rect;
    
    CGRect actionRect = CGRectMake(0, 0, self.contentWidth, 0);
    
    if (!self.collectionButton.hidden) {
        
        if (self.topContainerView.frame.size.height > topInitialHeight + 0.1) {
            
            actionRect.size.height += self.cancelMargin;
        }

        frame = self.collectionButton.frame;
        frame.origin.y = actionRect.size.height;
        self.collectionButton.frame = frame;
        
        actionRect.size.height += self.collectionButton.frame.size.height;
    }
    
    BOOL shouldAdjustContentInset = NO;
    
    if (self.cancelButton.hidden) {
        
        if (!self.collectionButton.hidden ||
            self.topContainerView.frame.size.height > topInitialHeight + 0.1) {
            
            if (self.autoAdjustHomeIndicator ||
                self.isPierced) {
                
                actionRect.size.height += JKAlertAdjustHomeIndicatorHeight;
                
                shouldAdjustContentInset = YES;
            }
        }
        
    } else {
        
        if (!self.collectionButton.hidden ||
            self.topContainerView.frame.size.height > topInitialHeight + 0.1) {
            
            actionRect.size.height += self.cancelMargin;
        }

        frame = self.cancelButton.frame;
        frame.origin.y = actionRect.size.height;
        self.cancelButton.frame = frame;
        
        actionRect.size.height += self.cancelButton.frame.size.height;
        
        if ((self.autoAdjustHomeIndicator &&
             !self.fillHomeIndicator) ||
            self.isPierced) {
                
            actionRect.size.height += JKAlertAdjustHomeIndicatorHeight;
            
            shouldAdjustContentInset = YES;
        }
    }
    
    actionRect.origin.y = CGRectGetMaxY(self.topContainerView.frame);
    self.bottomContentView.frame = actionRect;
    
    [self.bottomContentView updateContentSize];
    
    rect.size.height += actionRect.size.height;
    
    [self.topContentView updateContentSize];
    
    self.topContentView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, (shouldAdjustContentInset ? JKAlertCurrentHomeIndicatorHeight() : 0), 0);
    self.topContentView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, JKAlertAdjustHomeIndicatorHeight, self.isPierced ? 0 : self.screenSafeInsets.right);
    
    self.topContentView.scrollView.scrollEnabled = NO;
    
    if (self.maxHeight > 0 &&
        rect.size.height > self.maxHeight) {
        
        rect.size.height = self.maxHeight;
        
        self.topContentView.scrollView.scrollEnabled = YES;
    }
    
    self.topContentView.frame = rect;
    
    self.frame = rect;
}

- (void)layoutCollectionView {
    
    NSInteger count = self.actionArray.count;
    NSInteger count2 = self.actionArray2.count;
    
    if (count <= 0 && count2 <= 0) {
        
        self.collectionView.hidden = YES;
        self.collectionView2.hidden = YES;
        self.pageControl.hidden = YES;
        
        self.collectionView.frame = CGRectZero;
        self.collectionView2.frame = CGRectZero;
        self.pageControl.frame = CGRectZero;
        
        return;
    }
    
    // TODO: JKTODO <#注释#>
    CGFloat collectionHeight = self.itemSize.height;
    
    CGRect frame = CGRectMake(0, 0, self.contentWidth, collectionHeight);
    
    self.collectionView.hidden = (count <= 0);
    self.collectionView2.hidden = (count2 <= 0);
    
    if (self.collectionView.hidden) {
        
        self.collectionView.frame = CGRectZero;
        
    } else {
        
        if (!self.collectionView2.hidden) {
        
            frame.size.height += MAX(self.collectionViewMargin, 0);
        }
        
        self.collectionView.frame = frame;
    }
    
    if (self.collectionView2.hidden) {
        
        self.collectionView2.frame = CGRectZero;
        
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

- (void)layoutActionButton {
    
    self.cancelAction.isPierced = self.isPierced;
    self.cancelAction.multiPiercedBackgroundColor = self.piercedBackgroundColor;
    
    self.collectionAction.isPierced = self.isPierced;
    self.collectionAction.multiPiercedBackgroundColor = self.piercedBackgroundColor;
    
    self.cancelButton.action = self.cancelAction;
    
    self.collectionButton.action = self.collectionAction;
    
    if (self.cancelAction.rowHeight < 0.1) {
        
        self.cancelButton.hidden = YES;
        self.cancelButton.frame = CGRectZero;
    }
    
    if (!self.collectionAction ||
        self.collectionAction.rowHeight < 0.1) {
        
        self.collectionButton.hidden = YES;
        self.collectionButton.frame = CGRectZero;
    }
    
    if (self.cancelButton.hidden &&
        self.collectionButton.hidden) {
        
        return;
    }
    
    // 固定取消按钮且取消按钮的高度大于等于0.1
    
    CGRect frame = CGRectMake(0, 0, self.contentWidth, 0);
    
    if (!self.cancelButton.hidden) {
        
        frame.size.height = self.cancelAction.rowHeight;
        
        // 非镂空效果 且 自动适配X设备底部 且 填充X设备底部
        if (!self.isPierced &&
            self.autoAdjustHomeIndicator &&
            self.fillHomeIndicator) {
            
            // 加上底部间距
            frame.size.height += JKAlertAdjustHomeIndicatorHeight;
        }
        
        self.cancelButton.frame = frame;
        
        if (self.cancelAction.customView) {
            
            self.cancelAction.customView.frame = self.cancelButton.bounds;
        }
    }
    
    if (!self.collectionButton.hidden) {
        
        frame.size.height = self.collectionAction.rowHeight;
        
        self.collectionButton.frame = frame;
        
        if (self.collectionAction.customView) {
            
            self.collectionAction.customView.frame = self.collectionButton.bounds;
        }
    }
}

- (void)updateLightModetUI {
    [super updateLightModetUI];
    
    self.titleSeparatorLineView.backgroundColor = JKAlertGlobalSeparatorLineMultiColor().lightColor;
    
    self.collectionSeparatorLineView.backgroundColor = JKAlertGlobalSeparatorLineMultiColor().lightColor;
    
    self.topContainerView.backgroundColor = self.isPierced ? nil: self.textContentBackgroundColor.lightColor;
    
    self.topContentView.backgroundView.backgroundColor = self.isPierced ? self.piercedBackgroundColor.lightColor: nil;
}

- (void)updateDarkModeUI {
    [super updateDarkModeUI];
    
    self.titleSeparatorLineView.backgroundColor = JKAlertGlobalSeparatorLineMultiColor().darkColor;
    
    self.collectionSeparatorLineView.backgroundColor = JKAlertGlobalSeparatorLineMultiColor().darkColor;
    
    self.topContainerView.backgroundColor = self.isPierced ? nil: self.textContentBackgroundColor.darkColor;
    
    self.topContentView.backgroundView.backgroundColor = self.isPierced ? self.piercedBackgroundColor.darkColor: nil;
}

#pragma mark
#pragma mark - Private Selector

- (void)actionButtonClick:(JKAlertActionButton *)button {
    
    JKAlertAction *action = button.action;
    
    if (action.autoDismiss && ![action isEmpty]) { [self.alertView dismiss]; }
    
    !action.handler ? : action.handler(action);
}

#pragma mark
#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return collectionView == self.collectionView ? self.actionArray.count : self.actionArray2.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JKAlertCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(self.cellClassName) forIndexPath:indexPath];
    
    cell.action = collectionView == self.collectionView ? self.actionArray[indexPath.item] : self.actionArray2[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    JKAlertAction *action = collectionView == self.collectionView ? self.actionArray[indexPath.item] : self.actionArray2[indexPath.item];
    
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
    
    _pageControlHeight = 30;
    
    _minimumLineSpacing = 10;
    
    _sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    _itemSize = CGSizeMake(76, 70);
    
    _collectionViewMargin = 10;
    
    _autoAdjustHomeIndicator = YES;
    
    _fillHomeIndicator = YES;
    
    _pageControlHidden = YES;
    
    _titleSeparatorLineHidden = YES;
    
    _collectionSeparatorLineHidden = YES;
    
    _cancelMargin = ((JKAlertScreenWidth > 321) ? 7 : 5);
    
    _cellClassName = NSStringFromClass([JKAlertCollectionViewCell class]);
    
    _textContentBackgroundColor = JKAlertGlobalMultiBackgroundColor();
    
    // TODO: JKTODO <#注释#>
    _actionButtonPinned = YES;
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
    [self.topContentView.scrollView insertSubview:topContainerView atIndex:0];
    _topContainerView = topContainerView;
    
    JKAlertCollectionSheetTextContentView *textContentView = [[JKAlertCollectionSheetTextContentView alloc] init];
    [self.topContainerView addSubview:textContentView];
    _textContentView = textContentView;
    
    UIView *titleSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentWidth, JKAlertGlobalSeparatorLineThickness())];
    titleSeparatorLineView.hidden = YES;
    [self.topContainerView addSubview:titleSeparatorLineView];
    _titleSeparatorLineView = titleSeparatorLineView;
    
    UIView *collectionSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentWidth, JKAlertGlobalSeparatorLineThickness())];
    collectionSeparatorLineView.hidden = YES;
    [self.topContainerView addSubview:collectionSeparatorLineView];
    _collectionSeparatorLineView = collectionSeparatorLineView;
    
    [self.topContentView.scrollView addSubview:self.bottomContentView];
    
    JKAlertActionButton *cancelButton = [JKAlertActionButton buttonWithType:(UIButtonTypeCustom)];
    [self.bottomContentView.scrollView addSubview:cancelButton];
    _cancelButton = cancelButton;
    
    [cancelButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    JKAlertActionButton *collectionButton = [JKAlertActionButton buttonWithType:(UIButtonTypeCustom)];
    [self.bottomContentView.scrollView addSubview:collectionButton];
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
    
    // TODO: JKTODO delete
    
//    self.collectionView.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
//    self.collectionView2.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
}

- (void)registerCellClass {
    
    [self.collectionView registerClass:NSClassFromString(self.cellClassName) forCellWithReuseIdentifier:self.cellClassName];
    [self.collectionView2 registerClass:NSClassFromString(self.cellClassName) forCellWithReuseIdentifier:self.cellClassName];
}

#pragma mark
#pragma mark - Private Property

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowlayout = flowlayout;
        
        UICollectionView *collectionView = [self createCollectionViewWithFlowLayout:flowlayout];
        [self.topContentView.scrollView addSubview:collectionView];
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
        [self.topContentView.scrollView addSubview:collectionView];
        _collectionView2 = collectionView;
    }
    return _collectionView2;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.backgroundColor = nil;
        pageControl.pageIndicatorTintColor = JKAlertAdaptColor(JKAlertSameRGBColor(217), JKAlertSameRGBColor(38));
        pageControl.currentPageIndicatorTintColor = JKAlertAdaptColor(JKAlertSameRGBColor(102), JKAlertSameRGBColor(153));
        pageControl.userInteractionEnabled = NO;
        [self.topContentView.scrollView addSubview:pageControl];
        _pageControl = pageControl;
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

- (BOOL)actionButtonPinned {
    
    if (self.isPierced) { return YES; }
    
    return _actionButtonPinned;
}

@end
