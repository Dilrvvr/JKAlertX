//
//  JKAlertView+LifeCycle.m
//  JKAlertX
//
//  Created by albert on 2020/6/4.
//

#import "JKAlertView+LifeCycle.h"
#import "JKAlertView+PrivateProperty.h"

@implementation JKAlertView (LifeCycle)

/**
 * 监听即将开始显示动画
 */
- (JKAlertView *(^)(void (^handler)(JKAlertView *innerAlertView)))makeWillShowHandler {
    
    return ^(void(^handler)(JKAlertView *innerAlertView)) {
        
        self.willShowHandler = handler;
        
        return self;
    };
}

/**
 * 监听显示动画完成
 */
- (JKAlertView *(^)(void (^handler)(JKAlertView *innerAlertView)))makeDidShowHandler {
    
    return ^(void(^handler)(JKAlertView *innerAlertView)) {
        
        self.didShowHandler = handler;
        
        return self;
    };
}

/**
 * 监听JKAlertView即将开始消失动画
 */
- (JKAlertView *(^)(void (^handler)(void)))makeWillDismissHandler {
    
    return ^JKAlertView *(void(^handler)(void)) {
        
        self.willDismissHandler = handler;
        
        return self;
    };
}

/**
 * 监听JKAlertView消失动画完成
 */
- (JKAlertView *(^)(void (^handler)(void)))makeDidDismissHandler {
    
    return ^(void(^handler)(void)) {
        
        self.didDismissHandler = handler;
        
        return self;
    };
}

/**
 * 是否允许dealloc打印，用于检查循环引用
 * 默认NO
 */
- (JKAlertView *(^)(BOOL enabled))makeDeallocLogEnabled {
    
    return ^(BOOL enabled) {
        
        self.deallocLogEnabled = enabled;
        
        return self;
    };
}

/**
 * dealloc时会调用的block
 */
- (void (^)(void (^handler)(void)))makeDeallocHandler {
    
    return ^(void(^handler)(void)) {
        
        self.deallocHandler = handler;
    };
}

/**
 * 用于通知消失的key
 * 设置该值后可以使用类方法 JKAlertView.dismissForKey(keyName); 来手动消失
 */
- (JKAlertView *(^)(NSString *key))makeDismissKey {
    
    return ^(NSString *key) {
        
        self.dismissKey = key;
        
        return self;
    };
}

/**
 * 移除设置了某一dismissKey的JKAlertView
 * 本质是发送一个通知，让dismissKey为该值的JKAlertView对象执行消失操作
 */
+ (void (^)(NSString *key))dismissForKey {
    
    return ^(NSString *key) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:JKAlertDismissForKeyNotification object:key];
    };
}

/**
 * 是否使JKAlertView.dismissAll(); 对当前JKAlertView无效
 * 请谨慎使用，若设置为YES 调用JKAlertView.dismissAll(); 将对当前JKAlertView无效
 */
- (JKAlertView *(^)(BOOL isNoneffective))makeDismissAllNoneffective {
    
    return ^(BOOL isNoneffective) {
        
        self.isDismissAllNoneffective = isNoneffective;
        
        return self;
    };
}

/**
 * 移除当前所有的JKAlertView
 * 本质是发送一个通知，让所有的JKAlertView对象执行消失操作
 * 注意如果某个对象setDismissAllNoneffective为YES时，该对象将不会响应通知
 * ***谨慎使用该方法***
 */
+ (void (^)(void))dismissAll {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:JKAlertDismissAllNotification object:nil];
    
    return ^{};
}

/**
 * 用于通知消失的类别
 * 可以将多个弹框设置同一类别，方便移除同一类别的弹框
 * 设置该值后可以使用类方法 JKAlertView.dismissForCategory(dismissCategory); 来手动消失
 */
- (JKAlertView *(^)(NSString *dismissCategory))makeDismissCategory {
    
    return ^(NSString *dismissCategory) {
        
        self.dismissCategory = dismissCategory;
        
        return self;
    };
}

/**
 * 移除设置了同一dismissCategory的多个JKAlertView
 * 本质是发送一个通知，让dismissCategory为该值的JKAlertView对象执行消失操作
 */
+ (void (^)(NSString *dismissCategory))dismissForCategory {
    
    return ^(NSString *dismissCategory) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:JKAlertDismissForCategoryNotification object:dismissCategory];
    };
}

/**
 * 清空当前所有的JKAlertView
 * 本质是发送一个通知，让所有的JKAlertView对象执行消失操作
 * 执行该操作会清空所有的JKAlertView，即使setDismissAllNoneffective为YES亦然，请谨慎操作
 * ***谨慎使用该方法***
 */
+ (void (^)(void))clearAll {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:JKAlertClearAllNotification object:nil];
    
    return ^{};
}
@end
