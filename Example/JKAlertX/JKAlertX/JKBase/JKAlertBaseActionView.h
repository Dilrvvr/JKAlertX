//
//  JKAlertBaseActionView.h
//  JKAlertX
//
//  Created by albertcc on 2020/5/10.
//  Copyright © 2020 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JKAlertAction;

@interface JKAlertBaseActionView : UIView

/** action */
@property (nonatomic, strong) JKAlertAction *action;

/** iconImageView */
@property (nonatomic, weak, readonly) UIImageView *iconImageView;

/** titleLabel */
@property (nonatomic, weak, readonly) UILabel *titleLabel;

/** isFullContentWidth */
@property (nonatomic, assign) BOOL isFullContentWidth;

/** seleted */
@property (nonatomic, assign) BOOL seleted;

/** highlighted */
@property (nonatomic, assign) BOOL highlighted;

#pragma mark
#pragma mark - Private

/** backgroundView */
@property (nonatomic, weak, readonly) UIView *backgroundView;

/** selectedBackgroundView */
@property (nonatomic, weak, readonly) UIView *selectedBackgroundView;

/** contentView */
@property (nonatomic, weak, readonly) UIView *contentView;

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
@end
