//
//  JKAlertConst.m
//  JKAlertX
//
//  Created by albert on 2018/10/22.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "JKAlertConst.h"

#pragma mark
#pragma mark - 通知

/** 移除全部的通知 */
NSString * const JKAlertDismissAllNotification = @"JKAlertDismissAllNotification";

/** 根据key来移除的通知 */
NSString * const JKAlertDismissForKeyNotification = @"JKAlertDismissForKeyNotification";


#pragma mark
#pragma mark - 常量

CGFloat    const JKAlertMinTitleLabelH = (22.0);
CGFloat    const JKAlertMinMessageLabelH = (17.0);
CGFloat    const JKAlertScrollViewMaxH = 176.0; // (JKAlertButtonH * 4.0)

CGFloat    const JKAlertButtonH = 46.0;

NSInteger  const JKAlertPlainButtonBeginTag = 100;

CGFloat    const JKAlertSheetTitleMargin = 6.0;

CGFloat    const JKAlertTopGestureIndicatorHeight = 20.0;

CGFloat    const JKAlertTopGestureIndicatorLineWidth = 40.0;

CGFloat    const JKAlertTopGestureIndicatorLineHeight = 4.0;



#pragma mark
#pragma mark - 函数

/// 颜色适配
UIColor * JKALertAdaptColor (UIColor *lightColor, UIColor *darkColor) {
    
    if (@available(iOS 13.0, *)) {
        
        UIColor *color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            
            if ([traitCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                
                return lightColor;
            }

            return darkColor;
        }];
        
        return color;
        
    } else {
        
        return lightColor;
    }
}

/// 全局背景色
UIColor * JKALertGlobalBackgroundColor (void) {
    
    static UIColor *GlobalBackgroundColor_ = nil;
    
    if (!GlobalBackgroundColor_) {
        
        GlobalBackgroundColor_ = JKALertAdaptColor(JKAlertSameRGBColorAlpha(247.0, 0.7), JKAlertSameRGBColorAlpha(8.0, 0.7));
    }
    
    return GlobalBackgroundColor_;
}

/// 全局高亮背景色
UIColor * JKALertGlobalHighlightedBackgroundColor (void) {
    
    static UIColor *HighlightedBackgroundColor_ = nil;
    
    if (!HighlightedBackgroundColor_) {
        
        HighlightedBackgroundColor_ = JKALertAdaptColor(JKAlertSameRGBColorAlpha(247.0, 0.3), JKAlertSameRGBColorAlpha(8.0, 0.3));
    }
    
    return HighlightedBackgroundColor_;
}

/// 是否X设备
BOOL JKALertIsDeviceX (void) {
    
    static BOOL JKALertIsDeviceX_ = NO;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (@available(iOS 11.0, *)) {
            
            if (!JKALertIsDeviceiPad()) {
                
                JKALertIsDeviceX_ = [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom > 0.0;
            }
        }
    });
    
    return JKALertIsDeviceX_;
}

/// 是否iPad
BOOL JKALertIsDeviceiPad (void){
    
    static BOOL JKALertIsDeviceiPad_ = NO;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (@available(iOS 11.0, *)) {
            
            JKALertIsDeviceiPad_ = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
        }
    });
    
    return JKALertIsDeviceiPad_;
}

/// 当前是否横屏
BOOL JKALertIsLandscape (void) {
    
    return [UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height;
}

/// 当前HomeIndicator高度
CGFloat JKAlertCurrentHomeIndicatorHeight (void) {
    
    return JKALertIsDeviceX() ? (JKALertIsLandscape() ? 21.0 : 34.0) : 0.0;
}
