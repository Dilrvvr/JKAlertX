//
//  JKAlertBaseAlertView.m
//  JKAlertX
//
//  Created by albert on 2019/1/14.
//  Copyright © 2019 Albert. All rights reserved.
//

#import "JKAlertBaseAlertView.h"
#import "JKAlertUtility.h"
#import "JKAlertConstraintManager.h"
#import "JKAlertTheme.h"

@interface JKAlertBaseAlertView ()

@end

@implementation JKAlertBaseAlertView

#pragma mark
#pragma mark - Public Methods

- (void)setFullBackgroundView:(UIView *)fullBackgroundView {
    
    if (_fullBackgroundView) {
        
        [_fullBackgroundView removeFromSuperview];
    }
    
    _fullBackgroundView = fullBackgroundView;
    
    if (_fullBackgroundView) {
        
        [self.backgroundView addSubview:_fullBackgroundView];
        
        [JKAlertConstraintManager addZeroEdgeConstraintsWithTargetView:_fullBackgroundView constraintsView:self.backgroundView];
    }
}

#pragma mark
#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame {
    
    CGRect rect = frame;
    
    if (CGRectEqualToRect(CGRectZero, rect)) {
        
        rect = JKAlertUtility.keyWindow.bounds;
    }
    
    self = [super initWithFrame:rect];
    
    return self;
}

#pragma mark
#pragma mark - Private Methods

- (void)restoreFullBackgroundColor {
    
    self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
}

#pragma mark
#pragma mark - Private Selector

- (void)dismissButtonClick:(UIButton *)button {
    
}

#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 交给子类重写 super自动调用该方法 */
- (void)initializeProperty{
    [super initializeProperty];
    
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
}

/** 创建UI 交给子类重写 super自动调用该方法 */
- (void)createUI {
    [super createUI];
    
    UIButton *dismissButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    dismissButton.backgroundColor = nil;
    [self.contentView insertSubview:dismissButton atIndex:0];
    _dismissButton = dismissButton;
    
    [dismissButton addTarget:self action:@selector(dismissButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
}

/** 布局UI 交给子类重写 super自动调用该方法 */
- (void)layoutUI {
    [super layoutUI];
    
    [JKAlertConstraintManager addZeroEdgeConstraintsWithTargetView:self.dismissButton constraintsView:self.contentView];
}

/** 初始化UI数据 交给子类重写 super自动调用该方法 */
- (void)initializeUIData {
    [super initializeUIData];
    
    [self restoreFullBackgroundColor];
}

#pragma mark
#pragma mark - Private Property



@end
