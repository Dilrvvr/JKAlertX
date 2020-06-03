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
 * HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeHudDismissTimeInterval)(NSTimeInterval timeInterval);

/**
 * HUD样式高度，不包含customHUD
 * 小于等于0将没有效果，自动计算高度，默认0
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeHudHeight)(CGFloat height);
@end
