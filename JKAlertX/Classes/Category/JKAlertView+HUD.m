//
//  JKAlertView+HUD.m
//  JKAlertX
//
//  Created by albert on 2020/6/3.
//

#import "JKAlertView+HUD.h"
#import "JKAlertView+PrivateProperty.h"

@implementation JKAlertView (HUD)

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








/// 不是HUD样式将不执行handler
- (JKAlertView *)checkHudStyleHandler:(void(^)(void))handler {
    
    if (JKAlertStyleHUD != self.alertStyle) { return self; }
    
    !handler ? : handler();
    
    return self;
}
@end

