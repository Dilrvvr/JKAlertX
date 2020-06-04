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
@end
