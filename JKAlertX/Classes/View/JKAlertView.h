//
//  JKAlertView.h
//  TestVideoAndPicture
//
//  Created by albert on 2017/4/18.
//  Copyright © 2017年 Albert. All rights reserved.
//

#import "JKAlertBaseAlertView.h"
#import "JKAlertAction.h"

@interface JKAlertView : JKAlertBaseAlertView

#pragma mark
#pragma mark - 基本方法

/** 实例化 */
+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                             style:(JKAlertStyle)style;

/** 富文本实例化 */
+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)attributedTitle
                           attributedMessage:(NSAttributedString *)attributedMessage
                                       style:(JKAlertStyle)style;

/** 添加action */
- (void)addAction:(JKAlertAction *)action;

/**
 * 添加textField 默认高度30
 * textField之间的间距是1，和其superView的上下左右间距也是1
 * textField可以直接对其superView进行一些属性修改，如背景色
 * block中的参数view用于调用dismiss()来移除当前弹框
 */
- (void)addTextFieldWithConfigurationHandler:(void (^)(JKAlertView *innerAlertView, UITextField *textField))configurationHandler;

/** 显示 */
@property (nonatomic, copy, readonly) JKAlertView *(^show)(void);

/** 显示并监听JKAlertView消失动画完成 */
@property (nonatomic, copy, readonly) void (^showWithDidDismissHandler)(void (^handler)(void));

/** 退出 */
@property (nonatomic, copy, readonly) void (^dismiss)(void);


#pragma mark
#pragma mark - 类方法

/** 函数式类方法 */
@property (class, nonatomic, readonly) JKAlertView *(^show)(NSString *title, NSString *message, JKAlertStyle style, void(^configuration)(JKAlertView *alertView));

/** 链式实例化 */
@property (class, nonatomic, readonly) JKAlertView *(^alertView)(NSString *title, NSString *message, JKAlertStyle style);

/** 富文本链式实例化 */
@property (class, nonatomic, readonly) JKAlertView *(^alertViewAttributed)(NSAttributedString *attributedTitle, NSAttributedString *attributedMessage, JKAlertStyle style);

/** 显示文字HUD */
@property (class, nonatomic, readonly) void (^showHUDWithTitle)(NSString *title, void(^configuration)(JKAlertView *alertView));

/** 显示富文本HUD */
@property (class, nonatomic, readonly) void (^showHUDWithAttributedTitle)(NSAttributedString *attributedTitle, void(^configuration)(JKAlertView *alertView));

/**
 * 显示自定义HUD
 * 注意使用点语法调用，否则莫名报错 JKAlertView.showCustomHUD
 * customHUD尺寸将完全由自定义控制，默认显示在屏幕中间
 * 注意自己计算好自定义HUD的size，以避免横竖屏出现问题
 */
@property (class, nonatomic, readonly) void (^showCustomHUD)(UIView *(^customHUD)(void), void(^configuration)(JKAlertView *alertView));


#pragma mark
#pragma mark - 添加action

/** 添加action */
- (void)insertAction:(JKAlertAction *)action atIndex:(NSUInteger)index;

/** 链式添加action */
@property (nonatomic, copy, readonly) JKAlertView *(^addAction)(JKAlertAction *action);

/** 链式添加action */
@property (nonatomic, copy, readonly) JKAlertView *(^insertAction)(JKAlertAction *action, NSUInteger atIndex);


#pragma mark
#pragma mark - action数组操作

/** 添加action */
- (void)addAction:(JKAlertAction *)action isSecondCollection:(BOOL)isSecondCollection;

/** 移除action */
- (void)removeAction:(JKAlertAction *)action isSecondCollection:(BOOL)isSecondCollection;

/** 添加action */
- (void)insertAction:(JKAlertAction *)action atIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection;

/** 移除action */
- (void)removeActionAtIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection;

/** 获取action */
- (JKAlertAction *)getActionAtIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection;

/** 获取cancelAction */
- (JKAlertAction *)getCancelAction;

/** 获取collectionAction */
- (JKAlertAction *)getCollectionAction;

/** 获取action数组 */
- (NSArray *)getActionArrayIsSecondCollection:(BOOL)isSecondCollection;

/** 清空action数组 */
- (void)clearActionArrayIsSecondCollection:(BOOL)isSecondCollection;

/** 链式添加action */
@property (nonatomic, copy, readonly) JKAlertView *(^addActionTo)(JKAlertAction *action, BOOL isSecondCollection);

/** 链式移除action */
@property (nonatomic, copy, readonly) JKAlertView *(^removeActionFrom)(JKAlertAction *action, BOOL isSecondCollection);

/** 链式添加action */
@property (nonatomic, copy, readonly) JKAlertView *(^insertActionTo)(JKAlertAction *action, NSUInteger atIndex, BOOL isSecondCollection);

/** 链式移除action */
@property (nonatomic, copy, readonly) JKAlertView *(^removeActionAtIndexFrom)(NSUInteger index, BOOL isSecondCollection);

/** 链式获取action */
@property (nonatomic, copy, readonly) JKAlertView *(^getActionAtIndexFrom)(NSUInteger index, BOOL isSecondCollection, void (^)(JKAlertAction *action));

/** 链式获取cancelAction或collectionAction */
@property (nonatomic, copy, readonly) JKAlertView *(^getCancelOrCollectionAction)(BOOL isCancelAction, void (^)(JKAlertAction *action));

/** 链式获取action数组 */
@property (nonatomic, copy, readonly) JKAlertView *(^getActionArrayFrom)(BOOL isSecondCollection, void (^)(NSArray *actionArray));

/** 链式清空action数组 */
@property (nonatomic, copy, readonly) JKAlertView *(^clearActionArrayFrom)(BOOL isSecondCollection);


#pragma mark
#pragma mark - 添加textField

/**
 * 链式添加textField 默认高度30
 * textField之间的间距是1，和其superView的上下左右间距也是1
 * textField可以直接对其superView进行一些属性修改，如背景色
 * block中的参数view用于调用dismiss()来移除当前弹框
 */
@property (nonatomic, copy, readonly) JKAlertView *(^addTextFieldWithConfigurationHandler)(void (^)(JKAlertView *view, UITextField *textField));
@end
