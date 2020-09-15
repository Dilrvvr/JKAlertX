//
//  JKAlertView+LifeCycle.h
//  JKAlertX
//
//  Created by albert on 2020/6/4.
//

#import "JKAlertView.h"

@interface JKAlertView (LifeCycle)

/**
 * 监听即将开始显示动画
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeWillShowHandler)(void (^handler)(JKAlertView *innerAlertView));

/**
 * 监听显示动画完成
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeDidShowHandler)(void (^handler)(JKAlertView *innerAlertView));

/**
 * 监听JKAlertView即将开始消失动画
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeWillDismissHandler)(void (^handler)(void));

/**
 * 监听JKAlertView消失动画完成
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeDidDismissHandler)(void (^handler)(void));

/**
 * 是否允许dealloc打印，用于检查循环引用
 * 默认NO
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeDeallocLogEnabled)(BOOL enabled);

/**
 * dealloc时会调用的block
 */
@property (nonatomic, copy, readonly) void (^makeDeallocHandler)(void (^handler)(void));

/**
 * 用于通知消失的key
 * 设置该值后可以使用类方法 JKAlertView.dismissForKey(keyName); 来手动消失
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeDismissKey)(NSString *key);

/**
 * 移除设置了某一dismissKey的JKAlertView
 * 本质是发送一个通知，让dismissKey为该值的JKAlertView对象执行消失操作
 */
@property (class, nonatomic, readonly) void (^dismissForKey)(NSString *key);

/**
 * 是否使JKAlertView.dismissAll(); 对当前JKAlertView无效
 * 请谨慎使用，若设置为YES 调用JKAlertView.dismissAll(); 将对当前JKAlertView无效
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeDismissAllNoneffective)(BOOL isNoneffective);

/**
 * 移除当前所有的JKAlertView
 * 本质是发送一个通知，让所有的JKAlertView对象执行消失操作
 * 注意如果某个对象setDismissAllNoneffective为YES时，该对象将不会响应通知
 * ***谨慎使用该方法***
 */
@property (class, nonatomic, readonly) void (^dismissAll)(void);

/**
 * 用于通知消失的类别
 * 可以将多个弹框设置同一类别，方便移除同一类别的弹框
 * 设置该值后可以使用类方法 JKAlertView.dismissForCategory(dismissCategory); 来手动消失
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeDismissCategory)(NSString *dismissCategory);

/**
 * 移除设置了同一dismissCategory的多个JKAlertView
 * 本质是发送一个通知，让dismissCategory为该值的JKAlertView对象执行消失操作
 */
@property (class, nonatomic, readonly) void (^dismissForCategory)(NSString *dismissCategory);

/**
 * 清空当前所有的JKAlertView
 * 本质是发送一个通知，让所有的JKAlertView对象执行消失操作
 * 执行该操作会清空所有的JKAlertView，即使setDismissAllNoneffective为YES亦然，请谨慎操作
 * ***谨慎使用该方法***
 */
@property (class, nonatomic, readonly) void (^clearAll)(void);
@end
