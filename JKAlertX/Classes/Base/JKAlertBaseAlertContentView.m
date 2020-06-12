//
//  JKAlertBaseAlertContentView.m
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseAlertContentView.h"
#import "JKAlertVisualFormatConstraintManager.h"

@interface JKAlertBaseAlertContentView ()

@end

@implementation JKAlertBaseAlertContentView

#pragma mark
#pragma mark - Public Methods

- (void)calculateUI {
    
    [self updateUserInterfaceStyle];
}

- (void)setCustomBackgroundView:(UIView *)customBackgroundView {
    
    if (_customBackgroundView) {
        
        [_customBackgroundView removeFromSuperview];
    }
    
    _customBackgroundView = customBackgroundView;
    
    if (_customBackgroundView) {
        
        self.backgroundEffectView.hidden = YES;
        
        [self.backgroundView addSubview:_customBackgroundView];
        
        [JKAlertVisualFormatConstraintManager addZeroEdgeConstraintsWithTargetView:_customBackgroundView constraintsView:self.backgroundView];
        
        return;
    }
    
    self.backgroundEffectView.hidden = NO;
}

#pragma mark
#pragma mark - Override



#pragma mark
#pragma mark - Private Methods

- (void)updateLightModetUI {
    [super updateLightModetUI];
    
    if (!self.backgroundEffectView.hidden) {
        
        [self.backgroundEffectView setEffect:self.lightBlurEffect];
    }
}

- (void)updateDarkModeUI {
    [super updateDarkModeUI];
    
    if (!self.backgroundEffectView.hidden) {
        
        [self.backgroundEffectView setEffect:self.darkBlurEffect];
    }
}

#pragma mark
#pragma mark - Private Selector



#pragma mark
#pragma mark - Custom Delegates



#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 */
- (void)initializeProperty {
    [super initializeProperty];
    
    _darkBlurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    _lightBlurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
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
    
    [JKAlertVisualFormatConstraintManager addZeroEdgeConstraintsWithTargetView:self.backgroundEffectView constraintsView:self.backgroundView];
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
}

#pragma mark
#pragma mark - Private Property

- (UIScrollView *)topScrollView {
    if (!_topScrollView) {
        UIScrollView *topScrollView = [[UIScrollView alloc] init];
        topScrollView.showsHorizontalScrollIndicator = NO;
        topScrollView.scrollsToTop = NO;
        topScrollView.scrollEnabled = NO;
        if (@available(iOS 11.0, *)) {
            topScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if (@available(iOS 13.0, *)) {
            topScrollView.automaticallyAdjustsScrollIndicatorInsets = NO;
        }
        [self.contentView addSubview:topScrollView];
        _topScrollView = topScrollView;
    }
    return _topScrollView;
}

- (UIScrollView *)actionScrollView {
    if (!_actionScrollView) {
        UIScrollView *actionScrollView = [[UIScrollView alloc] init];
        actionScrollView.showsHorizontalScrollIndicator = NO;
        actionScrollView.scrollsToTop = NO;
        actionScrollView.scrollEnabled = NO;
        if (@available(iOS 11.0, *)) {
            actionScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if (@available(iOS 13.0, *)) {
            actionScrollView.automaticallyAdjustsScrollIndicatorInsets = NO;
        }
        [self.contentView addSubview:actionScrollView];
        _actionScrollView = actionScrollView;
    }
    return _actionScrollView;
}

- (UIVisualEffectView *)backgroundEffectView {
    if (!_backgroundEffectView) {
        UIVisualEffectView *backgroundEffectView = [[UIVisualEffectView alloc] initWithEffect:nil];
        backgroundEffectView.clipsToBounds = YES;
        [self.backgroundView addSubview:backgroundEffectView];
        _backgroundEffectView = backgroundEffectView;
    }
    return _backgroundEffectView;
}
@end
