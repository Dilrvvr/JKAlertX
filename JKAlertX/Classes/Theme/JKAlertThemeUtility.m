//
//  JKAlertThemeUtility.m
//  JKAlertX
//
//  Created by albert on 2020/7/11.
//

#import "JKAlertThemeUtility.h"

/** 浅色主题名称 */
NSString * const JKAlertDefaultThemeLight = @"JKAlertDefaultThemeLight";

/** 深色主题名称 */
NSString * const JKAlertDefaultThemeDark = @"JKAlertDefaultThemeDark";

/** 系统深色/浅色样式改变的通知 */
NSString * const JKAlertThemeDidChangeNotification = @"JKAlertThemeDidChangeNotification";

/** ThemeStyle改变的通知 */
NSString * const JKAlertThemeStyleDidChangeNotification = @"JKAlertThemeStyleDidChangeNotification";

/** 默认的背景色handlerKey */
NSString * const JKAlertThemeBackgroundColorHandlerKey = @"backgroundColor";

/** 默认的字体颜色handlerKey */
NSString * const JKAlertThemeTextColorHandlerKey = @"textColor";


#pragma mark
#pragma mark - 工具方法

@implementation JKAlertThemeUtility

/// 获取keyWindow
+ (UIWindow *)keyWindow {
    
    UIWindow *keyWindow = nil;
    
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        
        keyWindow = [[UIApplication sharedApplication].delegate window];
        
    } else {
        
        NSArray *windows = [UIApplication sharedApplication].windows;
        
        for (UIWindow *window in windows) {
            
            if (window.hidden) { continue; }
            
            keyWindow = window;
            
            break;
        }
    }
    
    return keyWindow;
}

@end
