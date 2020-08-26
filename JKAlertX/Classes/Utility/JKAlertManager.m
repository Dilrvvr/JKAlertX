//
//  JKAlertManager.m
//  JKAlertX
//
//  Created by albert on 2020/7/30.
//

#import "JKAlertManager.h"
#import "JKAlertX.h"

@implementation JKAlertManager

/**
 * 自定义alert(plain)样式
 * 默认将移除alert背景色
 * viewHandler : 在这里返回自定义alert的view
 * configurationBeforeShow : 在show之前配置一些内容
 */
+ (JKAlertView *)showCustomAlertWithViewHandler:(UIView *(^)(void))viewHandler
                        configurationBeforeShow:(void(^)(JKAlertView *innerAlertView))configuration {
    
    return [self showCustomAlertWithViewHandler:viewHandler clearAlertBackgroundColor:YES configurationBeforeShow:configuration];
}

/**
 * 自定义alert(plain)样式
 * viewHandler : 在这里返回自定义alert的view
 * clearAlertBackgroundColor : 是否移除背景色
 * configurationBeforeShow : 在show之前配置一些内容
 */
+ (JKAlertView *)showCustomAlertWithViewHandler:(UIView *(^)(void))viewHandler
                      clearAlertBackgroundColor:(BOOL)clearAlertBackgroundColor
                        configurationBeforeShow:(void(^)(JKAlertView *innerAlertView))configuration {
    
    // 创建alertView
    JKAlertView *alertView = JKAlertView.alertView(nil, nil, JKAlertStyleAlert);
    
    // 不自动适配X设备底部间距
    alertView.makeHomeIndicatorAdapted(NO);
    
    // 最大高度设置为屏幕高度
    alertView.makeActionSheetMaxHeight([UIScreen mainScreen].bounds.size.height);
    
    // 移除背景色
    if (clearAlertBackgroundColor) {
        
        alertView.makeAlertBackgroundColor(nil);
    }
    
    // 自动
    alertView.makeCustomTextContentView(viewHandler);
    
    // show之前配置一些内容
    !configuration ? : configuration(alertView);
    
    // show
    alertView.show();
    
    return alertView;
}

/**
 * 自定义sheet样式
 * 默认将移除sheet背景色
 * viewHandler : 在这里返回自定义sheet的view
 * configurationBeforeShow : 在show之前配置一些内容
 */
+ (JKAlertView *)showCustomSheetWithViewHandler:(UIView *(^)(void))viewHandler
                        configurationBeforeShow:(void(^)(JKAlertView *innerAlertView))configuration {
    
    return [self showCustomSheetWithViewHandler:viewHandler clearAlertBackgroundColor:YES configurationBeforeShow:configuration];
}

/**
 * 自定义sheet样式
 * viewHandler : 在这里返回自定义sheet的view
 * clearAlertBackgroundColor : 是否移除背景色
 * configurationBeforeShow : 在show之前配置一些内容
 */
+ (JKAlertView *)showCustomSheetWithViewHandler:(UIView *(^)(void))viewHandler
                      clearAlertBackgroundColor:(BOOL)clearAlertBackgroundColor
                        configurationBeforeShow:(void(^)(JKAlertView *innerAlertView))configuration {
    
    // 创建alertView
    JKAlertView *alertView = JKAlertView.alertView(nil, nil, JKAlertStyleActionSheet);
    
    // 不自动适配X设备底部间距
    alertView.makeHomeIndicatorAdapted(NO);
    
    // 最大高度设置为屏幕高度
    alertView.makeActionSheetMaxHeight([UIScreen mainScreen].bounds.size.height);
    
    // 移除背景色
    if (clearAlertBackgroundColor) {
        
        alertView.makeAlertBackgroundColor(nil).makeActionSheetTopBackgroundColor(nil);
    }
    
    // 移除底部默认的取消按钮
    alertView.makeCancelAction(JKAlertAction.action(nil, JKAlertActionStyleDefault, nil).makeCustomView(^UIView *(JKAlertAction *innerAction) {
        
        return [UIView new];
        
    })).makeTitleMessageSeparatorLineHidden(YES);
    
    // 自动
    alertView.makeCustomTextContentView(viewHandler);
    
    // show之前配置一些内容
    !configuration ? : configuration(alertView);
    
    // show
    alertView.show();
    
    return alertView;
}
@end
