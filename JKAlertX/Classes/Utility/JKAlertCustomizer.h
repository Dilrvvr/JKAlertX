//
//  JKAlertCustomizer.h
//  JKAlertX
//
//  Created by albert on 2020/7/30.
//

#import <Foundation/Foundation.h>

@class JKAlertView;

@interface JKAlertCustomizer : NSObject

#pragma mark
#pragma mark - 自定义弹框

/**
 * 自定义alert(plain)样式
 * 默认将移除弹框内容背景色，但不移除全屏黑色透明背景色
 * viewHandler : 在这里返回自定义alert的view
 * configurationBeforeShow : 在show之前配置一些内容
 */
+ (JKAlertView *)showCustomAlertWithViewHandler:(UIView *(^)(JKAlertView *innerAlertView))viewHandler
                        configurationBeforeShow:(void(^)(JKAlertView *innerAlertView))configuration;

/**
 * 自定义alert(plain)样式
 * viewHandler : 在这里返回自定义alert的view
 * clearAlertBackgroundColor : 是否移除弹框内容背景色
 * clearFullBackgroundColor : 是否移除全屏背景色（全屏黑色透明的背景色）
 * configurationBeforeShow : 在show之前配置一些内容
 */
+ (JKAlertView *)showCustomAlertWithViewHandler:(UIView *(^)(JKAlertView *innerAlertView))viewHandler
                      clearAlertBackgroundColor:(BOOL)clearAlertBackgroundColor
                       clearFullBackgroundColor:(BOOL)clearFullBackgroundColor
                        configurationBeforeShow:(void(^)(JKAlertView *innerAlertView))configuration;

#pragma mark
#pragma mark - 自定义sheet

/**
 * 自定义sheet样式
 * 默认将移除弹框内容背景色，但不移除全屏黑色透明背景色
 * viewHandler : 在这里返回自定义sheet的view
 * configurationBeforeShow : 在show之前配置一些内容
 */
+ (JKAlertView *)showCustomSheetWithViewHandler:(UIView *(^)(JKAlertView *innerAlertView))viewHandler
                        configurationBeforeShow:(void(^)(JKAlertView *innerAlertView))configuration;

/**
 * 自定义sheet样式
 * viewHandler : 在这里返回自定义sheet的view
 * clearAlertBackgroundColor : 是否移除弹框内容背景色 
 * clearFullBackgroundColor : 是否移除全屏背景色（全屏黑色透明的背景色）
 * configurationBeforeShow : 在show之前配置一些内容
 */
+ (JKAlertView *)showCustomSheetWithViewHandler:(UIView *(^)(JKAlertView *innerAlertView))viewHandler
                      clearAlertBackgroundColor:(BOOL)clearAlertBackgroundColor
                       clearFullBackgroundColor:(BOOL)clearFullBackgroundColor
                        configurationBeforeShow:(void(^)(JKAlertView *innerAlertView))configuration;
@end
