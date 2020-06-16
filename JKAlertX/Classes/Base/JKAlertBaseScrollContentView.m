//
//  JKAlertBaseScrollContentView.m
//  JKAlertX
//
//  Created by albert on 2020/6/16.
//

#import "JKAlertBaseScrollContentView.h"
#import "JKAlertVisualFormatConstraintManager.h"

@interface JKAlertBaseScrollContentView ()
{
    __weak UIScrollView *_scrollView;
}
@end

@implementation JKAlertBaseScrollContentView

#pragma mark
#pragma mark - Public Methods



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



#pragma mark
#pragma mark - UITableViewDataSource & UITableViewDelegate



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
    
}

/** 布局UI */
- (void)layoutUI {
    [super layoutUI];
    
    //[JKAlertVisualFormatConstraintManager addZeroEdgeConstraintsWithTargetView:self.scrollView constraintsView:self.contentView];
    [JKAlertVisualFormatConstraintManager addConstraintsWithHorizontalFormat:@"H:|-0-[view]-0-|" verticalFormat:nil viewKeyName:@"view" targetView:self.scrollView constraintsView:self.contentView];
    ///*
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeTop) multiplier:1 constant:0];
    //NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeLeft) multiplier:1 constant:0];
    //NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeRight) multiplier:1 constant:0];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeBottom) multiplier:1 constant:0];
    
    [self.contentView addConstraint:topConstraint];
    //[self.contentView addConstraint:leftConstraint];
    //[self.contentView addConstraint:rightConstraint];
    [self.contentView addConstraint:bottomConstraint]; //*/
    
    _scrollViewBottomConstraint = bottomConstraint;
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
}

#pragma mark
#pragma mark - Private Property

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.scrollEnabled = NO;
        if (@available(iOS 11.0, *)) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if (@available(iOS 13.0, *)) {
            scrollView.automaticallyAdjustsScrollIndicatorInsets = NO;
        }
        [self.contentView addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

@end
