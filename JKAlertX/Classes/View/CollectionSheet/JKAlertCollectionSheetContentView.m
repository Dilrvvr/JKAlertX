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

/** flowlayout */
@property (nonatomic, strong) UICollectionViewFlowLayout *flowlayout;

/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;

/** flowlayout2 */
@property (nonatomic, strong) UICollectionViewFlowLayout *flowlayout2;

/** collectionView2 */
@property (nonatomic, weak) UICollectionView *collectionView2;

/** horizontalSeparatorLineView */
@property (nonatomic, weak) UIView *horizontalSeparatorLineView;

/** pageControl */
@property (nonatomic, weak) UIPageControl *pageControl;

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
    
    self.textContentView.safeInsets = self.safeInsets;
    self.textContentView.contentWidth = self.contentWidth;
    
    [self.textContentView calculateUI];
}

#pragma mark
#pragma mark - Override

- (void)dealloc {
    
    // TODO: JKTODO delete
    
    NSLog(@"[ClassName: %@], %d, %s", NSStringFromClass([self class]), __LINE__, __func__);
}

#pragma mark
#pragma mark - Private Methods



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
    
    JKAlertCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JKAlertCollectionViewCell class]) forIndexPath:indexPath];
    
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
    
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
}

/** 创建UI */
- (void)createUI {
    [super createUI];
    
    JKAlertCollectionSheetTextContentView *textContentView = [[JKAlertCollectionSheetTextContentView alloc] init];
    [self.contentView addSubview:textContentView];
    _textContentView = textContentView;
    
    UIView *horizontalSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentWidth, JKAlertGlobalSeparatorLineThickness())];
    horizontalSeparatorLineView.hidden = YES;
    [self addSubview:horizontalSeparatorLineView];
    _horizontalSeparatorLineView = horizontalSeparatorLineView;
    
    JKAlertActionButton *cancelButton = [JKAlertActionButton buttonWithType:(UIButtonTypeCustom)];
    [self.actionScrollView addSubview:cancelButton];
    _cancelButton = cancelButton;
    
    [cancelButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    JKAlertActionButton *collectionButton = [JKAlertActionButton buttonWithType:(UIButtonTypeCustom)];
    [self.actionScrollView addSubview:collectionButton];
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
    
}

#pragma mark
#pragma mark - Private Property

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowlayout = flowlayout;
        
        UICollectionView *collectionView = [self createCollectionViewWithFlowLayout:flowlayout];
        [self.textScrollView addSubview:collectionView];
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
        [self.textScrollView addSubview:collectionView];
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
        [self.textScrollView addSubview:pageControl];
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
    
    [collectionView registerClass:[JKAlertCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JKAlertCollectionViewCell class])];
    
    if (@available(iOS 11.0, *)) {
        
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    if (@available(iOS 13.0, *)) {
        
        collectionView.automaticallyAdjustsScrollIndicatorInsets = NO;
    }
    
    return collectionView;
}

@end
