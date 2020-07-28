//
//  JKAlertThemeProvider.h
//  JKAlertX
//
//  Created by albert on 2020/7/7.
//

#import <UIKit/UIKit.h>
#import "JKAlertThemeUtility.h"

@class JKAlertThemeProvider;

/// handler类型
typedef void(^JKAlertThemeProvideHandler)(JKAlertThemeProvider *provider, id providerOwner);

@interface JKAlertThemeProvider : NSObject

/** owner */
@property (nonatomic, weak, readonly) NSObject <JKAlertThemeProviderProtocol> *owner;

/**
 * 创建一个JKAlertThemeProvider实例
 *
 * owner : JKAlertThemeProvider实例的拥有者
 *         若owner已有JKAlertThemeProvider实例，将不会创建新的实例而是将provideHandler添加至该实例
 * handlerKey : provideHandler的缓存可以，使用key可支持handler替换
 * provideHandler : 切换皮肤后调用的block，赋值后将会立即执行一次
 */
+ (JKAlertThemeProvider *)providerWithOwner:(id <JKAlertThemeProviderProtocol>)owner
                                 handlerKey:(NSString *)handlerKey
                             provideHandler:(JKAlertThemeProvideHandler)provideHandler;

/**
 * 创建一个JKAlertThemeProvider实例
 * 自动将JKAlertThemeBackgroundColorHandlerKey == @"backgroundColor"作为handlerKey
 */
+ (JKAlertThemeProvider *)providerBackgroundColorWithOwner:(id <JKAlertThemeProviderProtocol>)owner
                                            provideHandler:(JKAlertThemeProvideHandler)provideHandler;

/**
 * 创建一个JKAlertThemeProvider实例
 * 自动将@"textColor"作为handlerKey
 */
+ (JKAlertThemeProvider *)providerTextColorWithOwner:(id <JKAlertThemeProviderProtocol>)owner
                                      provideHandler:(JKAlertThemeProvideHandler)provideHandler;

/**
 * 添加一个处理主题变更的handler
 *
 * key : handler的缓存key，使用key可支持handler替换
 * handler : 切换皮肤后调用的block，赋值后将会立即执行一次
 */
- (void)addProvideHandlerForKey:(NSString *)key
                        handler:(JKAlertThemeProvideHandler)handler;

/**
 * 执行所有的handler
 */
- (void)executeAllProvideHandler;

/**
 * 根据key获取某一handler
 */
- (JKAlertThemeProvideHandler)provideHandlerForKey:(NSString *)key;

/**
 * 根据key执行某一handler
 */
- (void)executeProvideHandlerForKey:(NSString *)key;

/**
 * 根据key移除handler
 */
- (void)removeProvideHandlerForKey:(NSString *)key;

/**
 * 移除所有handler
 */
- (void)clearAllProvideHandler;
@end
