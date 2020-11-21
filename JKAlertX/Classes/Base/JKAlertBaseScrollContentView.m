//
//  JKAlertBaseScrollContentView.m
//  JKAlertX
//
//  Created by albert on 2020/6/16.
//

#import "JKAlertBaseScrollContentView.h"
#import "JKAlertConstraintManager.h"

@interface JKAlertBaseScrollContentView ()
{
    __weak UIScrollView *_scrollView;
    __weak UIView *_scrollContentView;
}
@end

@implementation JKAlertBaseScrollContentView

#pragma mark
#pragma mark - Public Methods



#pragma mark
#pragma mark - Override



#pragma mark
#pragma mark - Private Methods



#pragma mark
#pragma mark - Private Selector



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
    
    [JKAlertConstraintManager addConstraintsWithHorizontalFormat:@"H:|-0-[view]-0-|" verticalFormat:nil viewKeyName:@"view" targetView:self.scrollView constraintsView:self];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeTop) multiplier:1 constant:0];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeBottom) multiplier:1 constant:0];
    
    [self addConstraint:topConstraint];
    [self addConstraint:bottomConstraint];
    
    _scrollViewTopConstraint = topConstraint;
    _scrollViewBottomConstraint = bottomConstraint;
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
}

#pragma mark
#pragma mark - Private Property

- (BOOL)autoAddBasicViews {
    
    return NO;
}

- (UIView *)backgroundView {
    
    return nil;
}

- (UIView *)contentView {
    
    return nil;
}

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
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIView *)scrollContentView {
    if (!_scrollContentView) {
        UIView *scrollContentView = [[UIView alloc] init];
        [self.scrollView addSubview:scrollContentView];
        _scrollContentView = scrollContentView;
    }
    return _scrollContentView;
}
@end
