//
//  JKAlertConst.h
//  JKAlertX
//
//  Created by albert on 2018/10/22.
//  Copyright © 2018 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark
#pragma mark - 协议



#pragma mark
#pragma mark - 枚举

typedef enum : NSUInteger {
    
    /**
     * none
     * 该样式将不会创建JKAlertView
     */
    JKAlertStyleNone = 0,
    
    /**
     * 面板
     * use JKAlertStyleAlert instead.
     */
    JKAlertStylePlain = 1,
    
    /** 列表 */
    JKAlertStyleActionSheet = 2,
    
    /**
     * collectionView样式
     * 该样式没有message，只有一个title
     */
    JKAlertStyleCollectionSheet = 3,
    
    /**
     * HUD提示
     * 该样式没有message，只有一个title
     */
    JKAlertStyleHUD = 4,
    
    /** 顶部通知 */
    JKAlertStyleNotification = 5,
    
    /** 自定义 */
    //JKAlertStyleCustom = 6,
    
    /** 面板 */
    JKAlertStyleAlert = JKAlertStylePlain,
    
} JKAlertStyle;

typedef enum : NSUInteger {
    
    /**
     * 默认样式
     * plain默认系统蓝色 [UIColor colorWithRed:0 green:122.0/255.0 blue:255.0/255.0 alpha:1]
     * 其它样式默认黑色字体 RGB都为51
     */
    JKAlertActionStyleDefault,
    
    /** 红色字体 */
    JKAlertActionStyleDestructive,
    
    /** 灰色字体 RGB都为153 */
    JKAlertActionStyleCancel,
    
} JKAlertActionStyle;

typedef NS_ENUM(NSUInteger, JKAlertScrollDirection) {
    JKAlertScrollDirectionNone = 0,
    JKAlertScrollDirectionUp,
    JKAlertScrollDirectionDown,
    JKAlertScrollDirectionLeft,
    JKAlertScrollDirectionRight,
};



#pragma mark
#pragma mark - 通知

/** 移除全部的通知 */
UIKIT_EXTERN NSString * const JKAlertDismissAllNotification;

/** 根据key来移除的通知 */
UIKIT_EXTERN NSString * const JKAlertDismissForKeyNotification;

/** 根据category来移除的通知 */
UIKIT_EXTERN NSString * const JKAlertDismissForCategoryNotification;

/** 清空全部弹框的通知 */
UIKIT_EXTERN NSString * const JKAlertClearAllNotification;



#pragma mark
#pragma mark - 常量

/** 可以手势滑动退出时 点击空白处不dismiss的抖动动画key */
UIKIT_EXTERN NSString * const JKAlertDismissFailedShakeAnimationKey;

UIKIT_EXTERN CGFloat    const JKAlertMinTitleLabelH;// = (22.0);
UIKIT_EXTERN CGFloat    const JKAlertMinMessageLabelH;// = (17.0);
UIKIT_EXTERN CGFloat    const JKAlertScrollViewMaxH;// = 176.0; // (JKAlertButtonH * 4.0)

UIKIT_EXTERN CGFloat    const JKAlertButtonH;// = 46.0;
UIKIT_EXTERN NSInteger  const JKAlertPlainButtonBeginTag;// = 100;

UIKIT_EXTERN CGFloat    const JKAlertSheetTitleMargin;// = 6.0;

UIKIT_EXTERN CGFloat    const JKAlertTopGestureIndicatorHeight;// = 20.0;

UIKIT_EXTERN CGFloat    const JKAlertTopGestureIndicatorLineWidth;// = 40.0;

UIKIT_EXTERN CGFloat    const JKAlertTopGestureIndicatorLineHeight;// = 4.0;



#pragma mark
#pragma mark - 宏定义

#define JKAlertScreenScale [UIScreen mainScreen].scale

#define JKAlertAdjustHomeIndicatorHeight (AutoAdjustHomeIndicator ? JKAlertCurrentHomeIndicatorHeight() : 0.0)

#define JKAlertRowHeight ((JKAlertScreenW > 321.0) ? 53.0 : 46.0)

#define JKAlertTextContainerViewMaxH (JKAlertPlainViewMaxH - JKAlertScrollViewMaxH)


// 快速设置颜色
#define JKAlertColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define JKAlertColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// RGB相等颜色
#define JKAlertSameRGBColor(rgb) [UIColor colorWithRed:(rgb)/255.0 green:(rgb)/255.0 blue:(rgb)/255.0 alpha:1.0]
#define JKAlertSameRGBColorAlpha(rgb, a) [UIColor colorWithRed:(rgb)/255.0 green:(rgb)/255.0 blue:(rgb)/255.0 alpha:(a)]

// 随机色
#define JKAlertRandomColor [UIColor colorWithRed:(arc4random_uniform(256)/255.0) green:(arc4random_uniform(256)/255.0) blue:(arc4random_uniform(256)/255.0) alpha:1.0]

#define JKAlertSystemBlueColor [UIColor colorWithRed:0.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0]

#define JKAlertSystemRedColor [UIColor colorWithRed:255.0/255.0 green:59.0/255.0 blue:48.0/255.0 alpha:1.0]

#define JKAlertXDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

//#define JKAlertXDeprecatedCustomizer NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, "请使用customizer")



#pragma mark
#pragma mark - 函数

/// 判断黑暗模式获取其中一个对象
id JKAlertJudgeDarkMode (id <UITraitEnvironment> environment, id light, id dark);

/// 颜色适配
UIColor * JKAlertAdaptColor (UIColor *lightColor, UIColor *darkColor);

/// 全局背景色
UIColor * JKAlertGlobalBackgroundColor (void);

/// 全局高亮背景色
UIColor * JKAlertGlobalHighlightedBackgroundColor (void);

/// 是否X设备
BOOL JKAlertIsDeviceX (void);

/// 是否iPad
BOOL JKAlertIsDeviceiPad (void);

/// 当前是否横屏
BOOL JKAlertIsLandscape (void);

/// 当前HomeIndicator高度
CGFloat JKAlertCurrentHomeIndicatorHeight (void);



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
#pragma mark - DEBUG

/// 仅DEBUG下执行
void JKTodo_Debug_Execute(void(^executeBlock)(void));

/// 在DEBUG/Develop下执行
void JKTodo_Debug_Develop_Execute(void(^executeBlock)(void));

/// 弹框展示debug信息
void JKTodo_Debug_Alert(NSString *title, NSString *message, NSTimeInterval showDelay);

/// 弹框展示debug信息
void JKTodo_Debug_Develop_Alert(NSString *title, NSString *message, NSTimeInterval showDelay);
