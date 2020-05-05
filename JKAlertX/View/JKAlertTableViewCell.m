//
//  JKAlertTableViewCell.m
//  TestVideoAndPicture
//
//  Created by albert on 2017/4/19.
//  Copyright © 2017年 安永博. All rights reserved.
//

#import "JKAlertTableViewCell.h"
#import "JKAlertAction.h"

@interface JKAlertTableViewCell ()

@end

@implementation JKAlertTableViewCell

#pragma mark
#pragma mark - 初始化

/** 初始化自身属性 交给子类重写 super自动调用该方法 */
- (void)initializeProperty{
    [super initializeProperty];
    
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization{
    [super initialization];
    
}

/** 创建UI 交给子类重写 super自动调用该方法 */
- (void)createUI{
    [super createUI];
    
}

/** 布局UI 交给子类重写 super自动调用该方法 */
- (void)layoutUI{
    [super layoutUI];
    
}

/** 初始化UI数据 交给子类重写 super自动调用该方法 */
- (void)initializeUIData{
    [super initializeUIData];
    
}

#pragma mark
#pragma mark - Override

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    
    if (@available(iOS 11.0, *)) {
        
        safeAreaInsets = self.alertSuperView.safeAreaInsets;
    }
    
    self.contentView.frame = self.bounds;
    
    self.selectedBackgroundView.frame = self.contentView.frame;

    self.titleButton.frame = CGRectMake(safeAreaInsets.left, 0, self.frame.size.width - (safeAreaInsets.left + safeAreaInsets.right), self.action.rowHeight);
    
    self.customView.frame = self.contentView.bounds;
}

#pragma mark
#pragma mark - 点击事件



#pragma mark
#pragma mark - 赋值



#pragma mark
#pragma mark - Property



@end
