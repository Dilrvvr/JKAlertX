//
//  JKAlertView+HUD.m
//  JKAlertX
//
//  Created by albert on 2020/6/3.
//

#import "JKAlertView+HUD.h"
#import "JKAlertView+Public.h"
#import "JKAlertView+PrivateProperty.h"

@implementation JKAlertView (HUD)

/**
 * HUD样式是否允许用户交互
 * 默认NO
 */
- (JKAlertView *(^)(BOOL allowUserInteractionEnabled))makeHudAllowUserInteractionEnabled {
    
    return ^(BOOL allowUserInteractionEnabled) {
        
        return [self checkHudStyleHandler:^{
            
            self.userInteractionEnabled = !allowUserInteractionEnabled;
        }];
    };
}

/**
 * HUD样式是否默认深色样式
 * 默认YES
 */
- (JKAlertView *(^)(BOOL defaultDarkStyle))makeHudDefaultDarkStyle {
    
    return ^(BOOL defaultDarkStyle) {
        
        return [self checkHudStyleHandler:^{
            
            self.hudContentView.defaultDarkStyle = defaultDarkStyle;
        }];
    };
}

/**
 * HUD样式宽度
 */
- (JKAlertView *(^)(CGFloat width))makeHudWidth {
    
    return ^(CGFloat width) {
        
        return [self checkHudStyleHandler:^{
            
            self.plainWidth = width;
            self.originalPlainWidth = width;
        }];
    };
}

/**
 * 是否自动缩小HUD样式的宽度以适应屏幕宽度 默认NO
 */
- (JKAlertView *(^)(BOOL autoReduceWidth))makeHudAutoReduceWidth {
    
    return ^(BOOL autoReduceWidth) {
        
        return [self checkHudStyleHandler:^{
            
            self.autoReducePlainWidth = autoReduceWidth;
        }];
    };
}

/**
 * HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
- (JKAlertView *(^)(NSTimeInterval timeInterval))makeHudDismissTimeInterval {
    
    return ^(NSTimeInterval timeInterval) {
        
        return [self checkHudStyleHandler:^{
            
            self.dismissTimeInterval = timeInterval;
        }];
    };
}

/**
 * HUD样式高度，不包含customHUD
 * 小于等于0将没有效果，自动计算高度，默认0
 */
- (JKAlertView *(^)(CGFloat height))makeHudHeight {
    
    return ^(CGFloat height) {
        
        return [self checkHudStyleHandler:^{
            
            self.hudContentView.hudHeight = height;
        }];
    };
}

/**
 * HUD样式center的偏移
 * 正数表示向下/右偏移，负数表示向上/左偏移
 */
- (JKAlertView *(^)(CGPoint centerOffsetY))makeHudCenterOffset {
    
    return ^(CGPoint centerOffset) {
        
        return [self checkHudStyleHandler:^{
            
            self.plainCenterOffset = centerOffset;
        }];
    };
}

/**
 * 展示完成后 移动HUD样式center
 * 仅在执行show之后有效
 * 正数表示向下/右偏移，负数表示向上/左偏移
 * rememberFinalPosition : 是否记住最终位置 YES将会累加 makeHudCenterOffset
 */
- (JKAlertView *(^)(CGPoint centerOffset, BOOL animated, BOOL rememberFinalPosition))makeHudMoveCenterOffset {
    
    return ^(CGPoint centerOffset, BOOL animated, BOOL rememberFinalPosition) {
        
        // 还没有show，不执行
        if (!self.isShowed) { return self; }
        
        return [self checkHudStyleHandler:^{
            
            CGPoint center = self.hudContentView.center;
            
            CGPoint finalCenter = CGPointMake(center.x + centerOffset.x, center.y + centerOffset.y);
            
            // 记住偏移
            if (rememberFinalPosition) {
                
                CGPoint offset = self.plainCenterOffset;
                offset.x += centerOffset.x;
                offset.y += centerOffset.y;
                
                self.makeHudCenterOffset(offset);
            }
            
            if (!animated) {
                
                self.hudContentView.center = finalCenter;
                
                return;
            }
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.hudContentView.center = finalCenter;
            }];
        }];
    };
}
@end

