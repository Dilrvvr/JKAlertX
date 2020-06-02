//
//  JKAlertView+Plain.m
//  JKAlertX
//
//  Created by albertcc on 2020/5/31.
//

#import "JKAlertView+Plain.h"
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





















/// 不是plain样式将不执行handler
- (JKAlertView *)checkPlainStyleHandler:(void(^)(void))handler {
    
    if (self.alertStyle != JKAlertStylePlain) { return self; }
    
    !handler ? : handler();
    
    return self;
}
@end
