//
//  JKAlertConst.h
//  JKAlertX
//
//  Created by albert on 2018/10/22.
//  Copyright © 2018 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JKAlertView;

#pragma mark
#pragma mark - 协议

@protocol JKAlertViewProtocol

@required

/** 退出 */
- (void(^)(void))dismiss;

/** 监听JKAlertView即将即将开始消失动画 */
- (id<JKAlertViewProtocol> (^)(void(^willDismiss)(void)))setWillDismiss;

/** 监听JKAlertView消失动画完成 */
- (id<JKAlertViewProtocol> (^)(void(^dismissComplete)(void)))setDismissComplete;

/** 重新布局 */
- (id<JKAlertViewProtocol> (^)(BOOL animated))relayout;

/** 监听重新布局完成 */
- (id<JKAlertViewProtocol> (^)(void(^relayoutComplete)(JKAlertView *view)))setRelayoutComplete;

/** 重新设置alertTitle */
- (id<JKAlertViewProtocol> (^)(NSString *alertTitle))resetAlertTitle;

/** 重新设置alertAttributedTitle */
- (id<JKAlertViewProtocol> (^)(NSAttributedString *alertAttributedTitle))resetAlertAttributedTitle;

/** 重新设置message */
- (id<JKAlertViewProtocol> (^)(NSString *message))resetMessage;

/** 重新设置attributedMessage */
- (id<JKAlertViewProtocol> (^)(NSAttributedString *attributedMessage))resetAttributedMessage;

/** 重新设置其它属性，调用该方法返回JKAlertView，设置好其它属性后，再调用relayout即可 */
- (JKAlertView * (^)(void))resetOther;
@end


#pragma mark
#pragma mark - 枚举

typedef enum : NSUInteger {
    
    /**
     * none
     * 该样式将不会创建JKAlertView
     */
    JKAlertStyleNone = 0,
    
    /** 面板 use JKAlertStyleAlert instead. */
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



#pragma mark
#pragma mark - 通知

/** 移除全部的通知 */
UIKIT_EXTERN NSString * const JKAlertDismissAllNotification;

/** 根据key来移除的通知 */
UIKIT_EXTERN NSString * const JKAlertDismissForKeyNotification;



#pragma mark
#pragma mark - 常量

UIKIT_EXTERN CGFloat    const JKAlertMinTitleLabelH;// = (22);
UIKIT_EXTERN CGFloat    const JKAlertMinMessageLabelH;// = (17);
UIKIT_EXTERN CGFloat    const JKAlertScrollViewMaxH;// = 176; // (JKAlertButtonH * 4)

UIKIT_EXTERN CGFloat    const JKAlertButtonH;// = 46;
UIKIT_EXTERN NSInteger  const JKAlertPlainButtonBeginTag;// = 100;

UIKIT_EXTERN CGFloat    const JKAlertSheetTitleMargin;// = 6;



#pragma mark
#pragma mark - 宏定义

#define JKAlertScreenScale [UIScreen mainScreen].scale

#define JKAlertCurrentHomeIndicatorHeight (JKAlertIsIphoneX ? 34: 0)

#define JKAlertAdjustHomeIndicatorHeight (AutoAdjustHomeIndicator ? JKAlertCurrentHomeIndicatorHeight : 0)

#define JKAlertRowHeight ((JKAlertScreenW > 321) ? 53 : 46)

#define JKAlertTextContainerViewMaxH (JKAlertPlainViewMaxH - JKAlertScrollViewMaxH)


#define JKAlertSystemBlueColor [UIColor colorWithRed:0.f green:122.0/255.0 blue:255.0/255.0 alpha:1]

#define JKAlertSystemRedColor [UIColor colorWithRed:255.0/255.0 green:59.0/255.0 blue:48.0/255.0 alpha:1]



//#define JKAlertXDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

//#define JKAlertXDeprecatedCustomizer NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, "请使用customizer")
