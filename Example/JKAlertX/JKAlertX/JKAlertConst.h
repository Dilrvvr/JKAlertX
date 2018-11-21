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

@protocol JKAlertViewProtocol

@required

/** 退出 */
- (void(^)(void))dismiss;

/** 监听JKAlertView即将即将开始消失动画 */
- (void(^)(void(^willDismiss)(void)))setWillDismiss;

/** 监听JKAlertView消失动画完成 */
- (void(^)(void(^dismissComplete)(void)))setDismissComplete;

@end


#pragma mark
#pragma mark - 枚举

typedef enum : NSUInteger {
    
    /**
     * none
     * 该样式将不会创建JKAlertView
     */
    JKAlertStyleNone,
    
    /** 面板 */
    JKAlertStylePlain,
    
    /** 列表 */
    JKAlertStyleActionSheet,
    
    /**
     * collectionView样式
     * 该样式没有message，只有一个title
     */
    JKAlertStyleCollectionSheet,
    
    /**
     * HUD提示
     * 该样式没有message，只有一个title
     */
    JKAlertStyleHUD,
    
} JKAlertStyle;




typedef enum : NSUInteger {
    
    /**
     * 默认样式
     * plain默认系统蓝色
     * 其它样式默认黑色字体 RGB都为51
     */
    JKAlertActionStyleDefault,
    
    /** 红色字体 */
    JKAlertActionStyleDestructive,
    
    /** 灰色字体 RGB都为153 */
    JKAlertActionStyleCancel,
    
} JKAlertActionStyle;




#pragma mark
#pragma mark - 宏定义

#define JKAlertXDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

#define JKAlertXDeprecatedCustomizer NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, "请使用customizer")
