//
//  JKAlertThemeConst.h
//  JKAlertX
//
//  Created by albert on 2020/7/11.
//

#import <Foundation/Foundation.h>

#pragma mark
#pragma mark - Enum

typedef NS_ENUM(NSUInteger, JKAlertThemeStyle) {
    
    /** 跟随系统 */
    JKAlertThemeStyleSystem = 0,
    
    /** 浅色 */
    JKAlertThemeStyleLight,
    
    /** 深色 */
    JKAlertThemeStyleDark,
};

#pragma mark
#pragma mark - 宏定义




#pragma mark
#pragma mark - Notification & key

/// 浅色主题名称
UIKIT_EXTERN NSString * const JKAlertDefaultThemeLight;

/// 深色主题名称
UIKIT_EXTERN NSString * const JKAlertDefaultThemeDark;

/** 系统深色/浅色样式改变的通知 */
UIKIT_EXTERN NSString * const JKAlertThemeDidChangeNotification;

/// 默认的存储handler的key
UIKIT_EXTERN NSString * const JKAlertThemeProvideHandlerKey;


#pragma mark
#pragma mark - Protocol

@class JKAlertThemeProvider;

@protocol JKAlertThemeProviderProtocol <NSObject>

@required

@property (nonatomic, strong) JKAlertThemeProvider *jkalert_themeProvider;
@end
