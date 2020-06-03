//
//  JKAlertView+Plain.m
//  JKAlertX
//
//  Created by albertcc on 2020/5/31.
//

#import "JKAlertView+Plain.h"
#import "JKAlertView+Public.h"
#import "JKAlertView+PrivateProperty.h"

@implementation JKAlertView (Plain)

- (JKAlertView *(^)(CGFloat width))makePlainWidth {
    
    return ^(CGFloat width) {
        
        return [self checkPlainStyleHandler:^{
            
            // TODO: JKTODO <#注释#>
            
            self->PlainViewWidth = width;
            self->OriginalPlainWidth = width;
            
            //self.plainContentView.contentWidth = width;
        }];
    };
}

/**
 * 是否自动缩小plain样式的宽度以适应屏幕宽度 默认NO
 */
- (JKAlertView *(^)(BOOL autoReduceWidth))makePlainAutoReduceWidth {
    
    return ^(BOOL autoReduceWidth) {
        
        return [self checkPlainStyleHandler:^{
            
            // TODO: JKTODO <#注释#>
            
            self.autoReducePlainWidth = autoReduceWidth;
        }];
    };
}

/**
 * plain样式的圆角
 * 默认8
 */
- (JKAlertView *(^)(CGFloat cornerRadius))makePlainCornerRadius {
    
    return ^(CGFloat cornerRadius) {
        
        return [self checkPlainStyleHandler:^{
            
            self.plainContentView.cornerRadius = cornerRadius;
        }];
    };
}

/**
 * 是否自动弹出键盘 默认YES
 * 添加了textField时会自动弹出键盘
 */
- (JKAlertView *(^)(BOOL autoShowKeyboard))makePlainAutoShowKeyboard {
    
    return ^(BOOL autoShowKeyboard) {
        
        return [self checkPlainStyleHandler:^{
            
            self.plainContentView.autoShowKeyboard = autoShowKeyboard;
        }];
    };
}

/**
 * 是否自动适配键盘
 * 默认YES
 */
- (JKAlertView *(^)(BOOL autoAdaptKeyboard))makePlainAutoAdaptKeyboard {
    
    return ^(BOOL autoAdaptKeyboard) {
        
        return [self checkPlainStyleHandler:^{
            
            if (autoAdaptKeyboard == self.autoAdaptKeyboard) { return; }
            
            if (autoAdaptKeyboard) {
                
                [self addKeyboardWillChangeFrameNotification];
                
            } else {
                
                [self removeKeyboardWillChangeFrameNotification];
            }
        }];
    };
}

/**
 * 弹框底部与键盘间距
 */
- (JKAlertView *(^)(CGFloat margin))makePlainKeyboardMargin {
    
    return ^(CGFloat margin) {
        
        return [self checkPlainStyleHandler:^{
            
            self.plainKeyboardMargin = margin;
        }];
    };
}

/**
 * plain样式center的偏移
 * 正数表示向下/右偏移，负数表示向上/左偏移
 */
- (JKAlertView *(^)(CGPoint centerOffset))makePlainCenterOffset {
    
    return ^(CGPoint centerOffset) {
        
        return [self checkPlainStyleHandler:^{
            
            self.plainCenterOffset = centerOffset;
        }];
    };
}

/**
 * plain展示完成后 移动plain和HUD样式center
 * 仅在执行show之后有效
 * 正数表示向下/右偏移，负数表示向上/左偏移
 * rememberFinalPosition : 是否记住最终位置 YES将会累加 makePlainCenterOffset
 */
- (JKAlertView *(^)(CGPoint centerOffset, BOOL animated, BOOL rememberFinalPosition))makePlainMoveCenterOffset {
    
    return ^(CGPoint centerOffset, BOOL animated, BOOL rememberFinalPosition) {
        
        // 还没有show，不执行
        if (!self.isShowed) { return self; }
        
        return [self checkPlainStyleHandler:^{
            
            CGPoint center = self.plainContentView.center;
            
            CGPoint finalCenter = CGPointMake(center.x + centerOffset.x, center.y + centerOffset.y);
            
            // 记住偏移
            if (rememberFinalPosition) {
                
                CGPoint offset = self.plainCenterOffset;
                offset.x += centerOffset.x;
                offset.y += centerOffset.y;
                
                self.makePlainCenterOffset(offset);
            }
            
            if (!animated) {
                
                self.plainContentView.center = finalCenter;
                
                return;
            }
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.plainContentView.center = finalCenter;
            }];
        }];
    };
}





















/// 不是plain样式将不执行handler
- (JKAlertView *)checkPlainStyleHandler:(void(^)(void))handler {
    
    if (JKAlertStylePlain != self.alertStyle) { return self; }
    
    !handler ? : handler();
    
    return self;
}
@end
