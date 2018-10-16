//
//  ViewController.h
//  JKAlertX
//
//  Created by albert on 2018/4/10.
//  Copyright © 2018年 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@end

#if 0
@protocol JKAlertViewProtocol

@required

/** 监听JKAlertView即将展示 展示动画开始前调用 */
- (void(^)(void(^willShowHandler)(void)))setWillShowHandler;

/** 监听JKAlertView展示完成 展示动画完成时调用 */
- (void(^)(void(^didShowHandler)(void)))setDidShowHandler;

/** 退出 */
- (void(^)(void))dismiss;

/** 监听JKAlertView即将消失 消失动画开始前调用 */
- (void(^)(void(^willDismissHandler)(void)))setWillDismissHandler;

/** 监听JKAlertView消失完成 消失动画完成时调用 */
- (void(^)(void(^didDismissHandler)(void)))setDidDismissHandler;

@end

NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, "")

#pragma mark - 状态监听

/** 监听JKAlertView即将展示 展示动画开始前调用 */
@property (nonatomic, copy, readonly) void (^setWillShowHandler)(void(^willShowHandler)(void));

/** 监听JKAlertView展示完成 展示动画完成时调用 */
@property (nonatomic, copy, readonly) id<JKAlertViewProtocol> (^setDidShowHandler)(void(^didShowHandler)(void));

/** 监听JKAlertView即将消失 消失动画开始前调用 */
@property (nonatomic, copy, readonly) void (^setWillDismissHandler)(void(^willDismissHandler)(void));

/** 监听JKAlertView消失完成 消失动画完成时调用 */
@property (nonatomic, copy, readonly) void (^setDidDismissHandler)(void(^didDismissHandler)(void));

#endif
