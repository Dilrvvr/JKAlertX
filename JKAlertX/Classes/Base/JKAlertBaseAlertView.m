//
//  JKAlertBaseAlertView.m
//  JKAlertX
//
//  Created by albert on 2019/1/14.
//  Copyright © 2019 安永博. All rights reserved.
//

#import "JKAlertBaseAlertView.h"
#import "JKAlertConst.h"
#import "JKAlertVisualFormatConstraintManager.h"

@interface JKAlertBaseAlertView ()

@end

@implementation JKAlertBaseAlertView

#pragma mark
#pragma mark - Public Methods



#pragma mark
#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
    }
    return self;
}

#pragma mark
#pragma mark - Private Methods

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

- (void)adjustScrollView:(UIScrollView *)scrollView {
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    
    if (@available(iOS 11.0, *)) {
        
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    if (@available(iOS 13.0, *)) {
        
        scrollView.automaticallyAdjustsScrollIndicatorInsets = NO;
    }
}

#pragma mark
#pragma mark - Private Selector

- (void)dismissButtonClick:(UIButton *)button {
    
}

#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 交给子类重写 super自动调用该方法 */
- (void)initializeProperty{
    
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    
    [self initializeProperty];
    [self createUI];
    [self layoutUI];
    [self initializeUIData];
}

/** 创建UI 交给子类重写 super自动调用该方法 */
- (void)createUI {
    
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.userInteractionEnabled = NO;
    backgroundView.backgroundColor = JKAlertAdaptColor([[UIColor blackColor] colorWithAlphaComponent:0], [[UIColor whiteColor] colorWithAlphaComponent:0]);
    [self insertSubview:backgroundView atIndex:0];
    _backgroundView = backgroundView;
    
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    _contentView = contentView;
    
    UIButton *dismissButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    dismissButton.backgroundColor = nil;
    [self.contentView insertSubview:dismissButton atIndex:0];
    _dismissButton = dismissButton;
    
    [dismissButton addTarget:self action:@selector(dismissButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    /*
    UIView *alertContainerView = [[UIView alloc] init];
    [self.contentView addSubview:alertContainerView];
    _alertContainerView = alertContainerView; //*/
}

/** 布局UI 交给子类重写 super自动调用该方法 */
- (void)layoutUI {
    
    [JKAlertVisualFormatConstraintManager addZeroEdgeConstraintsWithTargetView:self.backgroundView constraintsView:self];
    
    [JKAlertVisualFormatConstraintManager addZeroEdgeConstraintsWithTargetView:self.contentView constraintsView:self];
    
    [JKAlertVisualFormatConstraintManager addZeroEdgeConstraintsWithTargetView:self.dismissButton constraintsView:self.contentView];
}

/** 初始化UI数据 交给子类重写 super自动调用该方法 */
- (void)initializeUIData {
    
}

#pragma mark
#pragma mark - Private Property





@end
