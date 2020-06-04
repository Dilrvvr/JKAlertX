//
//  JKAlertView+LifeCycle.m
//  JKAlertX
//
//  Created by albert on 2020/6/4.
//

#import "JKAlertView+LifeCycle.h"
#import "JKAlertView+PrivateProperty.h"

@implementation JKAlertView (LifeCycle)

/** 监听即将开始显示动画 */
- (JKAlertView *(^)(void(^willShowHandler)(JKAlertView *view)))setWillShowHandler {
    
    return ^(void(^willShowHandler)(JKAlertView *view)) {
        
        self.willShowHandler = willShowHandler;
        
        return self;
    };
}

/** 监听JKAlertView显示动画完成 */
- (JKAlertView *(^)(void(^didShowHandler)(JKAlertView *view)))setDidShowHandler {
    
    return ^(void(^didShowHandler)(JKAlertView *view)) {
        
        self.didShowHandler = didShowHandler;
        
        return self;
    };
}

/** 监听JKAlertView即将消失 */
- (JKAlertView *(^)(void(^willDismissHandler)(void)))setWillDismissHandler {
    
    return ^JKAlertView * (void(^willDismissHandler)(void)) {
        
        self.willDismissHandler = willDismissHandler;
        
        return self;
    };
}

/** 监听JKAlertView消失动画完成 */
- (JKAlertView *(^)(void(^didDismissHandler)(void)))setDidDismissHandler {
    
    return ^(void(^didDismissHandler)(void)) {
        
        self.didDismissHandler = didDismissHandler;
        
        return self;
    };
}

/** 允许dealloc打印，用于检查循环引用 */
- (JKAlertView *(^)(BOOL enable))enableDeallocLog {
    
    return ^(BOOL enable) {
        
        self->_enableDeallocLog = enable;
        
        return self;
    };
}

/** 设置dealloc时会调用的block */
- (void(^)(void(^deallocBlock)(void)))setDeallocBlock {
    
    return ^(void(^deallocBlock)(void)) {
        
        self.deallocBlock = deallocBlock;
    };
}

/**
 * 设置用于通知消失的key
 * 设置该值后可以使用类方法 JKAlertView.DismissForKey(dismissKey); 来手动消失
 */
- (JKAlertView *(^)(NSString *dismissKey))setDismissKey {
    
    return ^(NSString *dismissKey) {
        
        self.dismissKey = dismissKey;
        
        return self;
    };
}

/**
 * 设置是否使JKAlertView.dismissAll(); 对当前JKAlertView无效
 * 请谨慎使用，若设置为YES 调用JKAlertView.dismissAll(); 将对当前JKAlertView无效
 */
- (JKAlertView *(^)(BOOL isNoneffective))setDismissAllNoneffective {
    
    return ^(BOOL isNoneffective) {
        
        self.isDismissAllNoneffective = isNoneffective;
        
        return self;
    };
}

/**
 * 设置用于通知消失的类别
 * 可以将多个弹框设置同一类别，方便移除同一类别的弹框
 * 设置该值后可以使用类方法 JKAlertView.dismissForCategory(dismissCategory); 来手动消失
 */
- (JKAlertView *(^)(NSString *dismissCategory))setDismissCategory {
    
    return ^(NSString *dismissCategory) {
        
        self.dismissCategory = dismissCategory;
        
        return self;
    };
}

/**
 * 移除设置了dismissKey的JKAlertView
 * 本质是发送一个通知，让dismissKey为该值的JKAlertView对象执行消失操作
 */
+ (void(^)(NSString *dismissKey))dismissForKey {
    
    return ^(NSString *dismissKey) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:JKAlertDismissForKeyNotification object:dismissKey];
    };
}

/**
 * 移除设置了同一dismissCategory的多个JKAlertView
 * 本质是发送一个通知，让dismissCategory为该值的JKAlertView对象执行消失操作
 */
+ (void(^)(NSString *dismissCategory))dismissForCategory {
    
    return ^(NSString *dismissCategory) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:JKAlertDismissForCategoryNotification object:dismissCategory];
    };
}

/**
 * 移除当前所有的JKAlertView
 * 本质是发送一个通知，让所有的JKAlertView对象执行消失操作
 * 注意如果某个对象setDismissAllNoneffective为YES时，该对象将不会响应通知
 * ***谨慎使用该方法***
 */
+ (void(^)(void))dismissAll {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:JKAlertDismissAllNotification object:nil];
    
    return ^{};
}

/**
 * 清空当前所有的JKAlertView
 * 本质是发送一个通知，让所有的JKAlertView对象执行消失操作
 * 执行该操作会清空所有的JKAlertView，即使setDismissAllNoneffective为YES亦然，请谨慎操作
 * ***谨慎使用该方法***
 */
+ (void(^)(void))clearAll {
    
    return ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:JKAlertClearAllNotification object:nil];
    };
}
@end
