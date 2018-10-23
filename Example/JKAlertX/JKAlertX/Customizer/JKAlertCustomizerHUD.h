//
//  JKAlertCustomizerHUD.h
//  JKAlertX
//
//  Created by albert on 2018/10/17.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "JKAlertBaseCustomizer.h"

@interface JKAlertCustomizerHUD : JKAlertBaseCustomizer

/**
 * HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
@property (nonatomic, assign, readonly) CGFloat dismissInterval;

/**
 * 设置HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
@property (nonatomic, copy, readonly) JKAlertCustomizerHUD *(^setDismissInterval)(CGFloat dismissInterval);




/**
 * HUD样式高度，不包含customHUD
 * 小于0将没有效果，默认-1
 */
@property (nonatomic, assign, readonly) CGFloat HUDHeight;

/**
 * 设置HUD样式高度，不包含customHUD
 * 小于0将没有效果，默认-1
 */
@property (nonatomic, copy, readonly) JKAlertCustomizerHUD *(^setHUDHeight)(CGFloat height);
@end
