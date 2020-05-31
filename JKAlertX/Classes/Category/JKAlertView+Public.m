//
//  JKAlertView+Public.m
//  JKAlertX
//
//  Created by albertcc on 2020/5/31.
//

#import "JKAlertView+Public.h"
#import "JKAlertView+PrivateProperty.h"

@implementation JKAlertView (Public)

/**
 * 可以在这个block内自定义其它属性
 */
- (JKAlertView * (^)(void(^handler)(JKAlertView *innerView)))makeCustomizationHandler {
    
    return ^(void(^handler)(JKAlertView *innerView)) {
        
        !handler ? : handler(self);
        
        return self;
    };
}

/**
 * 设置自定义的父控件
 * 默认添加到keywindow上
 * customSuperView在show之前有效
 * customSuperViewsize最好和屏幕大小一致，否则可能出现问题
 */
- (JKAlertView *(^)(UIView *customSuperView))makeCustomSuperView {
    
    return ^(UIView *customSuperView) {
        
        self.customSuperView = customSuperView;
        
        if (customSuperView) {
            
            CGFloat rotation = [[self.customSuperView.layer valueForKeyPath:@"transform.rotation.z"] floatValue];
            
            if ((rotation > 1.57 && rotation < 1.58) ||
                (rotation > -1.58 && rotation < -1.57)) {
                
                self->JKAlertScreenW = self.customSuperView.frame.size.height;//MAX(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
                self->JKAlertScreenH = self.customSuperView.frame.size.width;//MIN(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
                
                [self updateMaxHeight];
                
            } else  {
                
                //self->JKAlertScreenW = MIN(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
                //self->JKAlertScreenH = MAX(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
                
                [self updateWidthHeight];
            }
        }
        
        return self;
    };
}

/**
 * 设置点击空白处是否消失，plain默认NO，其它YES
 */
- (JKAlertView * (^)(BOOL shouldDismiss))makeTapBlankDismiss {
    
    return ^(BOOL shouldDismiss) {
        
        self.tapBlankDismiss = shouldDismiss;
        
        return self;
    };
}

/**
 * 监听点击空白处的block
 */
- (JKAlertView * (^)(void(^handler)(JKAlertView *innerView)))makeTapBlankHandler {
    
    return ^(void(^handler)(JKAlertView *innerView)) {
        
        self.tapBlankHandler = handler;
        
        return self;
    };
}

/**
 * 配置弹出视图的容器view，加圆角等
 */
- (JKAlertView *(^)(void (^configuration)(UIView *containerView)))makeAlertContentViewConfiguration {
    
    return ^(void (^configuration)(UIView *alertContentView)) {
        
        self.alertContentViewConfiguration = configuration;
        
        return self;
    };
}
@end
