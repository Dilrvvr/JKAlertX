//
//  JKAlertView+HUD.h
//  JKAlertX
//
//  Created by albert on 2020/6/3.
//

#import "JKAlertView.h"

@interface JKAlertView ()

/**
 * HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
@property (nonatomic, assign) NSTimeInterval dismissTimeInterval;
@end




@interface JKAlertView (HUD)

/**
 * HUD样式是否允许用户交互
 * 默认NO
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeHudAllowUserInteractionEnabled)(BOOL allowUserInteractionEnabled);

/**
 * HUD样式宽度
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeHudWidth)(CGFloat width);

/**
 * 是否自动缩小HUD样式的宽度以适应屏幕宽度 默认NO
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeHudAutoReduceWidth)(BOOL autoReduceWidth);

/**
 * HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeHudDismissTimeInterval)(NSTimeInterval timeInterval);

/**
 * HUD样式高度，不包含customHUD
 * 小于等于0将没有效果，自动计算高度，默认0
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeHudHeight)(CGFloat height);

/**
 * HUD样式center的偏移
 * 正数表示向下/右偏移，负数表示向上/左偏移
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeHudCenterOffset)(CGPoint centerOffset);

/**
 * 展示完成后 移动HUD样式center
 * 仅在执行show之后有效
 * 正数表示向下/右偏移，负数表示向上/左偏移
 * rememberFinalPosition : 是否记住最终位置 YES将会累加 makeHudCenterOffset
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeHudMoveCenterOffset)(CGPoint centerOffset, BOOL animated, BOOL rememberFinalPosition);
@end
