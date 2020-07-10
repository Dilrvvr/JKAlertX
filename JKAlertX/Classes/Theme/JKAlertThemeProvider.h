//
//  JKAlertThemeProvider.h
//  JKAlertX
//
//  Created by albert on 2020/7/7.
//

#import <UIKit/UIKit.h>

#define JKAlertCheckDarkMode(provider, light, dark) ([(provider) checkIsDarkMode] ? (dark) : (light))

@class JKAlertThemeProvider;

typedef void(^JKAlertDarkModeProvideHandler)(JKAlertThemeProvider *provider, id providerOwner);

@protocol JKAlertThemeProviderProtocol <NSObject>

@required

@property (nonatomic, strong) JKAlertThemeProvider *themeProvider;
@end

@interface JKAlertThemeProvider : NSObject

/** owner */
@property (nonatomic, weak, readonly) id <JKAlertThemeProviderProtocol> owner;

/**
 * 创建一个JKAlertThemeProvider实例
 *
 * owner : JKAlertThemeProvider实例的拥有者
 *         若owner已有JKAlertThemeProvider实例，将不会创建信的实例而是将provideHandler添加至该实例
 * handlerKey : provideHandler的缓存可以，使用key可支持handler覆盖
 * provideHandler : 切换皮肤后调用的block，赋值后将会立即执行一次
 */
+ (JKAlertThemeProvider *)providerWithOwner:(id <JKAlertThemeProviderProtocol>)owner
                                 handlerKey:(NSString *)handlerKey
                             provideHandler:(JKAlertDarkModeProvideHandler)provideHandler;

/**
 * 添加一个处理主题变更的handler
 *
 * key : handler的缓存key，使用key可支持handler覆盖
 * handler : 切换皮肤后调用的block，赋值后将会立即执行一次
 */
- (void)addProvideHandlerForKey:(NSString *)key
                        handler:(JKAlertDarkModeProvideHandler)handler;

/**
 * 根据key移除handler
 */
- (void)removeProvideHandlerForKey:(NSString *)key;

/**
 * 移除所有handler
 */
- (void)clearAllProvideHandler;

/**
 * 判断当前是否深色模式
 */
- (BOOL)checkIsDarkMode;
@end
