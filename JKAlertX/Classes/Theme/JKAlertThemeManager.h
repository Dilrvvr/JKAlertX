//
//  JKAlertThemeManager.h
//  JKAlertX
//
//  Created by albert on 2020/7/10.
//

#import <Foundation/Foundation.h>

/// 浅色
UIKIT_EXTERN NSString * const JKAlertDefaultThemeLight;

/// 深色
UIKIT_EXTERN NSString * const JKAlertDefaultThemeDark;

/** 系统深色/浅色样式改变的通知 */
UIKIT_EXTERN NSString * const JKAlertThemeDidChangeNotification;

@interface JKAlertThemeManager : NSObject

+ (instancetype)sharedManager;

/**
 * 浅色主题名称
 * 自动跟随系统切换时的浅色主题名称
 * 默认JKAlertDefaultThemeLight
 */
@property (nonatomic, copy) NSString *lightThemeName;

/**
 * 深色主题名称
 * 自动跟随系统切换时的深色主题名称
 * 默认JKAlertDefaultThemeDark
 */
@property (nonatomic, copy) NSString *darkThemeName;

/**
 * 主题名称
 * 默认JKAlertDefaultThemeLight
 */
@property (nonatomic, copy) NSString *themeName;

/**
 * 是否自动切换深色/浅色模式
 */
@property (nonatomic, assign) BOOL autoSwitchDarkMode;
@end
