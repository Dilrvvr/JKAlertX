//
//  JKAlertCustomizer.h
//  JKAlertX
//
//  Created by albert on 2020/7/30.
//

#import <Foundation/Foundation.h>

@class JKAlertView;

@interface JKAlertCustomizer : NSObject

/**
 * 自定义alert(plain)样式
 * 默认将移除alert背景色 
 * viewHandler : 在这里返回自定义alert的view
 * configurationBeforeShow : 在show之前配置一些内容
 */
+ (JKAlertView *)showCustomAlertWithViewHandler:(UIView *(^)(JKAlertView *innerAlertView))viewHandler
                        configurationBeforeShow:(void(^)(JKAlertView *innerAlertView))configuration;

/**
 * 自定义alert(plain)样式
 * viewHandler : 在这里返回自定义alert的view
 * clearAlertBackgroundColor : 是否移除背景色
 * configurationBeforeShow : 在show之前配置一些内容
 */
+ (JKAlertView *)showCustomAlertWithViewHandler:(UIView *(^)(JKAlertView *innerAlertView))viewHandler
                      clearAlertBackgroundColor:(BOOL)clearAlertBackgroundColor
                        configurationBeforeShow:(void(^)(JKAlertView *innerAlertView))configuration;

/**
 * 自定义sheet样式
 * 默认将移除sheet背景色
 * viewHandler : 在这里返回自定义sheet的view
 * configurationBeforeShow : 在show之前配置一些内容
 */
+ (JKAlertView *)showCustomSheetWithViewHandler:(UIView *(^)(JKAlertView *innerAlertView))viewHandler
                        configurationBeforeShow:(void(^)(JKAlertView *innerAlertView))configuration;

/**
 * 自定义sheet样式
 * viewHandler : 在这里返回自定义sheet的view
 * clearAlertBackgroundColor : 是否移除背景色
 * configurationBeforeShow : 在show之前配置一些内容
 */
+ (JKAlertView *)showCustomSheetWithViewHandler:(UIView *(^)(JKAlertView *innerAlertView))viewHandler
                      clearAlertBackgroundColor:(BOOL)clearAlertBackgroundColor
                        configurationBeforeShow:(void(^)(JKAlertView *innerAlertView))configuration;
@end
