//
//  JKAlertPanGestureRecognizer.h
//  JKAlertX
//
//  Created by albert on 2019/12/18.
//  Copyright © 2019 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 手势支持的方向 */
typedef NS_ENUM(NSUInteger, JKAlertPanGestureDirection) {
    JKAlertPanGestureDirectionAll = 0,
    JKAlertPanGestureDirectionToLeft,
    JKAlertPanGestureDirectionToRight,
    JKAlertPanGestureDirectionToTop,
    JKAlertPanGestureDirectionToBottom,
    JKAlertPanGestureDirectionHorizontal,
    JKAlertPanGestureDirectionVertical,
};

@interface JKAlertPanGestureRecognizer : UIPanGestureRecognizer

/** 手势支持的方向 */
@property (nonatomic, assign) JKAlertPanGestureDirection direction;

/** shouldDelay */
//@property (nonatomic, assign) BOOL shouldDelay;

/** 最大识别时间 超过该时间将状态置为识别失败 */
@property (nonatomic, assign) NSTimeInterval maxRecognizeTime;

/** panGestureDidDelayBlock */
@property (nonatomic, copy) void (^panGestureDidDelayBlock)(JKAlertPanGestureRecognizer *panGesture);
@end
