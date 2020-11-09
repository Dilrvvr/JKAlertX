//
//  JKAlertBaseView.h
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import <UIKit/UIKit.h>
#import "JKAlertUtility.h"

@interface JKAlertBaseView : UIView

#pragma mark
#pragma mark - Private

/**
 * 是否自动添加基本的view
 * 包括backgroundView & contentView
 * 默认YES，子类重写getter
 */
@property (nonatomic, assign, readonly) BOOL autoAddBasicViews;

/** backgroundView */
@property (nonatomic, weak, readonly) UIView *backgroundView;

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
