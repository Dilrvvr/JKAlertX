//
//  JKAlertThemeManager.h
//  JKAlertX
//
//  Created by albert on 2020/7/10.
//

#import <Foundation/Foundation.h>
#import "JKAlertThemeUtility.h"

@interface JKAlertThemeManager : NSObject

/**
 * 单例对象
 */
+ (instancetype)sharedManager;

/**
 * 判断当前是否深色模式
 */
- (BOOL)checkIsDarkMode;

/** themeStyle */
@property (nonatomic, assign) JKAlertThemeStyle themeStyle;

/**
 * 是否自动切换深色/浅色模式
 */
@property (nonatomic, assign) BOOL autoSwitchDarkMode API_AVAILABLE(ios(13.0));

/**
 * 当前的系统样式
 */
@property (nonatomic, assign, readonly) UIUserInterfaceStyle userInterfaceStyle API_AVAILABLE(ios(13.0));

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


#pragma mark
#pragma mark - Private

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
@end
