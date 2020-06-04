//
//  JKAlertView+LifeCycle.h
//  JKAlertX
//
//  Created by albert on 2020/6/4.
//

#import "JKAlertView.h"

@interface JKAlertView (LifeCycle)

/** 监听即将开始显示动画 */
@property (nonatomic, copy, readonly) JKAlertView *(^setWillShowHandler)(void(^willShowHandler)(JKAlertView *view));

/** 监听显示动画完成 */
@property (nonatomic, copy, readonly) JKAlertView *(^setDidShowHandler)(void(^didShowHandler)(JKAlertView *view));

/** 监听JKAlertView即将开始消失动画 */
@property (nonatomic, copy, readonly) JKAlertView *(^setWillDismissHandler)(void(^willDismissHandler)(void));

/** 监听JKAlertView消失动画完成 */
@property (nonatomic, copy, readonly) JKAlertView *(^setDidDismissHandler)(void(^didDismissHandler)(void));

/** 设置是否允许dealloc打印，用于检查循环引用 */
@property (nonatomic, copy, readonly) JKAlertView *(^enableDeallocLog)(BOOL enable);

/** 设置dealloc时会调用的block */
@property (nonatomic, copy, readonly) void (^setDeallocBlock)(void(^deallocBlock)(void));
@end
