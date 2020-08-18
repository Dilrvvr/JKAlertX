//
//  JKAlertBaseTableViewCell.h
//  JKAlertX
//
//  Created by albert on 2020/5/5.
//  Copyright © 2020 Albert. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JKAlertAction, JKAlertTableActionView;

@interface JKAlertBaseTableViewCell : UITableViewCell

/** actionView */
@property (nonatomic, weak) JKAlertTableActionView *actionView;

/** 底部分隔线 */
@property (nonatomic, weak, readonly) UIView *bottomLineView;

/** action */
@property (nonatomic, strong) JKAlertAction *action;

#pragma mark
#pragma mark - Private

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
