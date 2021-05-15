//
//  JKAlertUtility.h
//  JKAlertX
//
//  Created by albert on 2018/10/22.
//  Copyright © 2018 Albert. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JKAlertView;

#pragma mark
#pragma mark - 协议

/// 外部自定义tableView时用于滑动退出
@protocol JKAlertVerticalSlideToDismissDelegate <NSObject>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset;

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
@end

/// 外部自定义tableView时用于滑动退出
@protocol JKAlertVerticalSlideToDismissProtocol <NSObject>

@property (nonatomic, weak) id <JKAlertVerticalSlideToDismissDelegate> jkalert_verticalSlideToDismissDelegate;
@end

#pragma mark
#pragma mark - 枚举

typedef NS_ENUM(NSUInteger, JKAlertStyle) {
    
    /// none 该样式将默认为JKAlertStylePlain
    JKAlertStyleNone = 0,
    
    /// 面板 use JKAlertStyleAlert instead.
    JKAlertStylePlain = 1,
    
    /// 列表
    JKAlertStyleActionSheet = 2,
    
    /// collectionView样式，该样式没有message，只有一个title
    JKAlertStyleCollectionSheet = 3,
    
    /// HUD提示，该样式没有message，只有一个title
    JKAlertStyleHUD = 4,
    
    /// 顶部通知
    //JKAlertStyleNotification = 5,
    
    /// 自定义
    //JKAlertStyleCustom = 6,
    
    /// 面板
    JKAlertStyleAlert = JKAlertStylePlain,
    
};

typedef NS_ENUM(NSUInteger, JKAlertActionStyle) {
    
    /// 默认样式 默认黑色字体 RGB都为51
    JKAlertActionStyleDefault,
    
    /// 红色字体
    JKAlertActionStyleDestructive,
    
    /// 灰色字体 RGB都为153
    JKAlertActionStyleCancel,
    
    /// 默认系统蓝色 [UIColor colorWithRed:0 green:122.0/255.0 blue:255.0/255.0 alpha:1]
    JKAlertActionStyleDefaultBlue,
    
    /// 默认样式 默认黑色字体 RGB都为51
    JKAlertActionStyleDefaultBlack = JKAlertActionStyleDefault,
    
};

/// sheet样式展示动画
typedef NS_ENUM(NSUInteger, JKAlertSheetShowAnimationType) {
    
    /// 从底部弹出 默认
    JKAlertSheetShowAnimationTypeFromBottom = 0,
    
    /// 从右侧向左弹出 ←
    JKAlertSheetShowAnimationTypeFromRight,
    
    /// 从左侧向右弹出 →
    JKAlertSheetShowAnimationTypeFromLeft,
};

/// sheet样式消失动画
typedef NS_ENUM(NSUInteger, JKAlertSheetDismissAnimationType) {
    
    /// 滑向底部消失 默认
    JKAlertSheetDismissAnimationTypeToBottom = 0,
    
    /// 向右滑动消失 →
    JKAlertSheetDismissAnimationTypeToRight,
    
    /// 向左滑动消失 ←
    JKAlertSheetDismissAnimationTypeToLeft,
};

/// sheet样式横向手势滑动消失方向
typedef NS_ENUM(NSUInteger, JKAlertSheetHorizontalGestureDismissDirection) {
    
    /// 不支持手势横向滑动消失
    JKAlertSheetHorizontalGestureDismissDirectionNone = 0,
    
    /// 支持手势左右方向滑动消失 ← →
    JKAlertSheetHorizontalGestureDismissDirectionHorizontal,
    
    /// 仅支持手势向左方向滑动消失 ←
    JKAlertSheetHorizontalGestureDismissDirectionToLeft,
    
    /// 仅支持手势向右方向滑动消失 →
    JKAlertSheetHorizontalGestureDismissDirectionToRight,
};

/// 记录ScrollView滑动方向
typedef NS_ENUM(NSUInteger, JKAlertScrollDirection) {
    
    /// 无方向记录
    JKAlertScrollDirectionNone = 0,
    
    /// 向上滑动 ↑
    JKAlertScrollDirectionUp,
    
    /// 向下滑动 ↓
    JKAlertScrollDirectionDown,
    
    /// 向左滑动 ←
    JKAlertScrollDirectionLeft,
    
    /// 向右滑动 →
    JKAlertScrollDirectionRight,
};

#pragma mark
#pragma mark - 通知

/// 移除全部的通知
UIKIT_EXTERN NSString * const JKAlertDismissAllNotification;

/// 根据key来移除的通知
UIKIT_EXTERN NSString * const JKAlertDismissForKeyNotification;

/// 根据category来移除的通知
UIKIT_EXTERN NSString * const JKAlertDismissForCategoryNotification;

/// 清空全部弹框的通知
UIKIT_EXTERN NSString * const JKAlertClearAllNotification;



#pragma mark
#pragma mark - 常量

/// 可以手势滑动退出时 点击空白处不dismiss的抖动动画key
UIKIT_EXTERN NSString * const JKAlertDismissFailedShakeAnimationKey;

UIKIT_EXTERN CGFloat    const JKAlertSheetSpringHeight;// = 15.0;

UIKIT_EXTERN CGFloat    const JKAlertTopGestureIndicatorHeight;// = 20.0;

UIKIT_EXTERN CGFloat    const JKAlertTopGestureIndicatorLineWidth;// = 40.0;

UIKIT_EXTERN CGFloat    const JKAlertTopGestureIndicatorLineHeight;// = 4.0;



#pragma mark
#pragma mark - 宏定义

/// 判断深色模式返回对应的数据
#define JKAlertCheckDarkMode(light, dark) (JKAlertUtility.isDarkMode ? (dark) : (light))

#define JKAlertAdjustHomeIndicatorHeight (self.autoAdjustHomeIndicator ? JKAlertUtility.currentHomeIndicatorHeight : 0.0)

#define JKAlertXDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)



#define JKAlertScreenScale [UIScreen mainScreen].scale

#define JKAlertScreenBounds [UIScreen mainScreen].bounds

#define JKAlertScreenWidth [UIScreen mainScreen].bounds.size.width

#define JKAlertScreenHeight [UIScreen mainScreen].bounds.size.height

/// 快速设置颜色
#define JKAlertColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define JKAlertColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

/// RGB相等颜色
#define JKAlertSameRGBColor(rgb) [UIColor colorWithRed:(rgb)/255.0 green:(rgb)/255.0 blue:(rgb)/255.0 alpha:1.0]
#define JKAlertSameRGBColorAlpha(rgb, a) [UIColor colorWithRed:(rgb)/255.0 green:(rgb)/255.0 blue:(rgb)/255.0 alpha:(a)]

/// 随机色
#define JKAlertRandomColor [UIColor colorWithRed:(arc4random_uniform(256)/255.0) green:(arc4random_uniform(256)/255.0) blue:(arc4random_uniform(256)/255.0) alpha:1.0]

#define JKAlertSystemBlueColor [UIColor colorWithRed:0.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0]

#define JKAlertSystemRedColor [UIColor colorWithRed:255.0/255.0 green:59.0/255.0 blue:48.0/255.0 alpha:1.0]



#pragma mark
#pragma mark - 封装定时器

/// 停止定时器的block
typedef void(^JKAlertXStopTimerBlock)(void);

/**
 开启一个定时器，默认在dispatch_get_global_queue队里执行
 warning : 注意循环引用！！！
 
 @param target 定时器判断对象，若该对象销毁，定时器将自动销毁
 @param delay 延时执行时间
 @param timeInterval 执行间隔时间
 @param repeat 是否重复执行
 @param handler 重复执行事件
 */
JKAlertXStopTimerBlock JKAlertX_dispatchTimer(id target, double delay, double timeInterval, BOOL repeat, void (^handler)(dispatch_source_t timer, void(^stopTimerBlock)(void)));

/**
 开启一个定时器
 warning : 注意循环引用！！！
 
 @param queue 定时器执行的队列
 @param target 定时器判断对象，若该对象销毁，定时器将自动销毁
 @param delay 延时执行时间
 @param timeInterval 执行间隔时间
 @param repeat 是否重复执行
 @param handler 重复执行事件
 */
JKAlertXStopTimerBlock JKAlertX_dispatchTimerWithQueue(dispatch_queue_t queue, id target, double delay, double timeInterval, BOOL repeat, void (^handler)(dispatch_source_t timer, void(^stopTimerBlock)(void)));




#pragma mark
#pragma mark - 工具方法

@interface JKAlertUtility : NSObject

/// 判断当前是否深色模式
@property (class, nonatomic, readonly) BOOL isDarkMode;

/// 全局背景色 浅色模式 rgb 247
@property (class, nonatomic, readonly) UIColor *globalLightBackgroundColor;

/// 全局背景色 深色模式 rgb 24
@property (class, nonatomic, readonly) UIColor *globalDarkBackgroundColor;

/// 背景色 浅色模式 rgb254
@property (class, nonatomic, readonly) UIColor *lightBackgroundColor;

/// 背景色 深色模式 rgb 30
@property (class, nonatomic, readonly) UIColor *darkBackgroundColor;

/// 高亮背景色 浅色模式 rgb 229
@property (class, nonatomic, readonly) UIColor *highlightedLightBackgroundColor;

/// 高亮背景色 深色模式 rgb 37.5
@property (class, nonatomic, readonly) UIColor *highlightedDarkBackgroundColor;

/// 全局分隔线粗细 1.0 / [UIScreen mainScreen].scale
@property (class, nonatomic, readonly) CGFloat separatorLineThickness;

/// 全局分隔线背景色 浅色模式
@property (class, nonatomic, readonly) UIColor *separatorLineLightColor;

/// 全局分隔线背景色 深色模式
@property (class, nonatomic, readonly) UIColor *separatorLineDarkColor;

/// 是否X设备
@property (class, nonatomic, readonly) BOOL isDeviceX;

/// 是否iPad
@property (class, nonatomic, readonly) BOOL isDeviceiPad;

/// 当前是否横屏
@property (class, nonatomic, readonly) BOOL isLandscape;

/// 当前HomeIndicator高度
@property (class, nonatomic, readonly) CGFloat currentHomeIndicatorHeight;

/// keyWindow
@property (class, nonatomic, readonly) UIWindow *keyWindow;

/// 获取keyWindow的safeAreaInsets
@property (class, nonatomic, readonly) UIEdgeInsets safeAreaInset;

/// 导航条高度
@property (class, nonatomic, readonly) CGFloat navigationBarHeight;

/// 目前iPhone屏幕最大宽度
@property (class, nonatomic, readonly) CGFloat iPhoneMaxScreenWidth;

/// 让手机振动一下
+ (void)vibrateDevice;

/// 仅DEBUG下执行
+ (void)debugExecute:(void (^)(void))executeBlock;

/// 在DEBUG/Develop下执行
+ (void)debugDevelopExecute:(void (^)(void))executeBlock;

/// 弹框展示debug信息 仅debug
+ (void)showDebugAlertWithTitle:(NSString *)title
                        message:(NSString *)message
                          delay:(NSTimeInterval)delay
        configurationBeforeShow:(void(^)(JKAlertView *alertView))configuration;

/// 弹框展示debug信息 debug & develop
+ (void)showDebugDevelopAlertWithTitle:(NSString *)title
                               message:(NSString *)message
                                 delay:(NSTimeInterval)delay
               configurationBeforeShow:(void(^)(JKAlertView *alertView))configuration;
@end
