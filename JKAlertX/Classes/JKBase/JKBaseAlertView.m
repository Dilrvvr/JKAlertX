//
//  JKBaseAlertView.m
//  JKAlertX
//
//  Created by albert on 2019/1/14.
//  Copyright © 2019 安永博. All rights reserved.
//

#import "JKBaseAlertView.h"
#import "JKAlertConst.h"

@interface JKBaseAlertView ()

@end

@implementation JKBaseAlertView

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

#pragma mark
#pragma mark - 初始化

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
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = JKAlertAdaptColor([[UIColor blackColor] colorWithAlphaComponent:0], [[UIColor whiteColor] colorWithAlphaComponent:0]);
    [self insertSubview:contentView atIndex:0];
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
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *contentViewCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[contentView]-0-|" options:0 metrics:nil views:@{@"contentView" : self.contentView}];
    [self addConstraints:contentViewCons1];
    
    NSArray *contentViewCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[contentView]-0-|" options:0 metrics:nil views:@{@"contentView" : self.contentView}];
    [self addConstraints:contentViewCons2];
    
    self.dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *dismissButtonCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[dismissButton]-0-|" options:0 metrics:nil views:@{@"dismissButton" : self.dismissButton}];
    [self.contentView addConstraints:dismissButtonCons1];
    
    NSArray *dismissButtonCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[dismissButton]-0-|" options:0 metrics:nil views:@{@"dismissButton" : self.dismissButton}];
    [self.contentView addConstraints:dismissButtonCons2];
}

/** 初始化UI数据 交给子类重写 super自动调用该方法 */
- (void)initializeUIData {
    
}

#pragma mark
#pragma mark - 点击事件

- (void)dismissButtonClick:(UIButton *)button {
    
}

#pragma mark
#pragma mark - 发送请求


#pragma mark
#pragma mark - 处理数据


#pragma mark
#pragma mark - 赋值


#pragma mark
#pragma mark - Property





@end
