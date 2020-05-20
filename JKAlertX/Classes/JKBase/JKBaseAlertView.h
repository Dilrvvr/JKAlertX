//
//  JKBaseAlertView.h
//  JKAlertX
//
//  Created by albert on 2019/1/14.
//  Copyright © 2019 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKBaseAlertView : UIView

#pragma mark
#pragma mark - Private

/** contentView */
@property (nonatomic, weak, readonly) UIView *contentView;

/** 最底层背景按钮 */
@property (nonatomic, weak, readonly) UIButton *dismissButton;

/** alertContainerView */
//@property (nonatomic, weak, readonly) UIView *alertContainerView;

- (UITableView *)createTableViewWithStyle:(UITableViewStyle)style;

- (void)adjustScrollView:(UIScrollView *)scrollView;

/** 初始化自身属性 交给子类重写 super自动调用该方法 */
- (void)initializeProperty NS_REQUIRES_SUPER;

/** 构造函数初始化时调用 注意调用super */
- (void)initialization NS_REQUIRES_SUPER;

/** 创建UI 交给子类重写 super自动调用该方法 */
- (void)createUI NS_REQUIRES_SUPER;

/** 布局UI 交给子类重写 super自动调用该方法 */
- (void)layoutUI NS_REQUIRES_SUPER;

/** 初始化数据 交给子类重写 super自动调用该方法 */
- (void)initializeUIData NS_REQUIRES_SUPER;

- (void)dismissButtonClick:(UIButton *)button;
@end
