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

CGFloat    const JKAlertMinTitleLabelH = (22);
CGFloat    const JKAlertMinMessageLabelH = (17);
CGFloat    const JKAlertScrollViewMaxH = 176; // (JKAlertButtonH * 4)

CGFloat    const JKAlertButtonH = 46;
NSInteger  const JKAlertPlainButtonBeginTag = 100;

CGFloat    const JKAlertSheetTitleMargin = 6;



#pragma mark
#pragma mark - 函数

/// 颜色适配
UIColor * JKALertAdaptColor (UIColor *lightColor, UIColor *darkColor) {
    
    if (@available(iOS 13.0, *)) {
        
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            
            if ([traitCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                
                return lightColor;
            }

            return darkColor;
        }];
        
    } else {
        
        return lightColor;
    }
}

/// 全局背景色
UIColor * JKALertGlobalBackgroundColor (void) {
    
    static UIColor *GlobalBackgroundColor_ = nil;
    
    if (!GlobalBackgroundColor_) {
        
        GlobalBackgroundColor_ = JKALertAdaptColor(JKAlertSameRGBColorAlpha(247, 0.7), JKAlertSameRGBColorAlpha(8, 0.7));
    }
    
    return GlobalBackgroundColor_;
}

/// 全局高亮背景色
UIColor * JKALertGlobalHighlightedBackgroundColor (void) {
    
    static UIColor *HighlightedBackgroundColor_ = nil;
    
    if (!HighlightedBackgroundColor_) {
        
        HighlightedBackgroundColor_ = JKALertAdaptColor(JKAlertSameRGBColorAlpha(247, 0.3), JKAlertSameRGBColorAlpha(8, 0.3));
    }
    
    return HighlightedBackgroundColor_;
}
