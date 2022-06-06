//
//  JKAlertCustomizer.m
//  JKAlertX
//
//  Created by albert on 2020/7/30.
//

#import "JKAlertCustomizer.h"
#import "JKAlertX.h"

@implementation JKAlertCustomizer

#pragma mark
#pragma mark - 自定义弹框

/**
 * 自定义alert(plain)样式
 * 默认将移除弹框内容背景色，但不移除全屏黑色透明背景色
 * viewHandler : 在这里返回自定义alert的view
 * configurationBeforeShow : 在show之前配置一些内容
 */
+ (JKAlertView *)showCustomAlertWithViewHandler:(UIView *(^)(JKAlertView *innerAlertView))viewHandler
                        configurationBeforeShow:(void(^)(JKAlertView *innerAlertView))configuration {
    
    return [self showCustomAlertWithViewHandler:viewHandler clearAlertBackgroundColor:YES clearFullBackgroundColor:NO configurationBeforeShow:configuration];
}

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
    
    // 移除全屏黑色透明背景色 如需还原，调用[alertView restoreFullBackgroundColor];
    if (clearFullBackgroundColor) {
        
        alertView.makeFullBackgroundColor(nil);
    }
    
    // 自定义view
    alertView.makeCustomTextContentView(viewHandler);
    
    // show之前配置一些内容
    !configuration ? : configuration(alertView);
    
    // show
    alertView.show();
    
    return alertView;
}

#pragma mark
#pragma mark - 自定义sheet

/**
 * 自定义sheet样式
 * 默认将移除弹框内容背景色，但不移除全屏黑色透明背景色 
 * viewHandler : 在这里返回自定义sheet的view
 * configurationBeforeShow : 在show之前配置一些内容
 */
+ (JKAlertView *)showCustomSheetWithViewHandler:(UIView *(^)(JKAlertView *innerAlertView))viewHandler
                        configurationBeforeShow:(void(^)(JKAlertView *innerAlertView))configuration {
    
    return [self showCustomSheetWithViewHandler:viewHandler clearAlertBackgroundColor:YES clearFullBackgroundColor:NO configurationBeforeShow:configuration];
}

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
                        configurationBeforeShow:(void(^)(JKAlertView *innerAlertView))configuration {
    
    // 创建alertView
    JKAlertView *alertView = JKAlertView.alertView(nil, nil, JKAlertStyleActionSheet);
    
    // 不自动适配X设备底部间距
    alertView.makeHomeIndicatorAdapted(NO);
    
    // 最大高度设置为屏幕高度
    CGFloat maxHeight = MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    alertView.makeActionSheetMaxHeight(maxHeight);
    
    // 移除弹框内容背景色
    if (clearAlertBackgroundColor) {
        
        alertView.makeAlertBackgroundColor(nil).makeActionSheetTopBackgroundColor(nil);
    }
    
    // 移除全屏黑色透明背景色 如需还原，调用[alertView restoreFullBackgroundColor];
    if (clearFullBackgroundColor) {
        
        alertView.makeFullBackgroundColor(nil);
    }
    
    // 移除底部默认的取消按钮
    alertView.makeCancelAction(JKAlertAction.action(nil, JKAlertActionStyleDefault, nil).makeCustomView(^UIView *(JKAlertAction *innerAction) {
        
        return [UIView new];
        
    })).makeTitleMessageSeparatorLineHidden(YES);
    
    // 自定义view
    alertView.makeCustomTextContentView(viewHandler);
    
    // show之前配置一些内容
    !configuration ? : configuration(alertView);
    
    // show
    alertView.show();
    
    return alertView;
}
@end
