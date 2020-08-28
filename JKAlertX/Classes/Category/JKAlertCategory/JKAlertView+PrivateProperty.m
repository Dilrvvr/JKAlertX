//
//  JKAlertView+PrivateProperty.m
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertView+PrivateProperty.h"
#import "JKAlertView+Public.h"
#import "JKAlertUtility.h"

@implementation JKAlertView (PrivateProperty)

- (void)updateWidthHeight {
    
    UIWindow *keyWindow = JKAlertUtility.keyWindow;
    
    UIView *superView = self.superview ? self.superview : keyWindow;
    
    switch ([UIApplication sharedApplication].statusBarOrientation) {
        case UIInterfaceOrientationPortrait:{
            
            //orientationLabel.text = "面向设备保持垂直，Home键位于下部"
            
            /** 屏幕宽度 */
            //self.superWidth =  MIN(superView.bounds.size.width, superView.bounds.size.height);
            /** 屏幕高度 */
            //self.superHeight =  MAX(superView.bounds.size.width, superView.bounds.size.height);
            
            self.isLandScape = NO;
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:{
            
            //orientationLabel.text = "面向设备保持垂直，Home键位于上部"
            
            /** 屏幕宽度 */
            //self.superWidth =  MIN(superView.bounds.size.width, superView.bounds.size.height);
            /** 屏幕高度 */
            //self.superHeight =  MAX(superView.bounds.size.width, superView.bounds.size.height);
            
            self.isLandScape = NO;
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            
            //orientationLabel.text = "面向设备保持水平，Home键位于左侧"
            
            /** 屏幕宽度 */
            //self.superWidth =  MAX(superView.bounds.size.width, superView.bounds.size.height);
            /** 屏幕高度 */
            //self.superHeight =  MIN(superView.bounds.size.width, superView.bounds.size.height);
            
            self.isLandScape = YES;
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            
            //orientationLabel.text = "面向设备保持水平，Home键位于右侧"
            
            /** 屏幕宽度 */
            //self.superWidth =  MAX(superView.bounds.size.width, superView.bounds.size.height);
            /** 屏幕高度 */
            //self.superHeight =  MIN(superView.bounds.size.width, superView.bounds.size.height);
            
            self.isLandScape = YES;
        }
            break;
        default:{
            
            // orientationLabel.text = "方向未知"
        }
            break;
    }
    
    /** 屏幕宽度 */
    self.superWidth =  superView.bounds.size.width;//MIN(superView.bounds.size.width, superView.bounds.size.height);
    /** 屏幕高度 */
    self.superHeight =  superView.bounds.size.height;//MAX(superView.bounds.size.width, superView.bounds.size.height);
    
    [self updateMaxHeight];
}

- (void)updateMaxHeight {
    
    self.maxPlainHeight = self.originalPlainMaxHeight > 0 ? self.originalPlainMaxHeight : (self.superHeight - 100);
    
    if (!self.maxSheetHeightSetted) {
        
        self.maxSheetHeight = (self.superHeight > self.superWidth) ? self.superHeight * 0.85 : self.superHeight * 0.8;
    }
}










/// 不是plain样式将不执行handler
- (JKAlertView *)checkPlainStyleHandler:(void (^)(void))handler {
    
    return [self checkAlertStyle:JKAlertStylePlain handler:handler];
}

/// 不是HUD样式将不执行handler
- (JKAlertView *)checkHudStyleHandler:(void (^)(void))handler {
    
    return [self checkAlertStyle:JKAlertStyleHUD handler:handler];
}

/// 不是collectionSheet样式将不执行handler
- (JKAlertView *)checkCollectionSheetStyleHandler:(void (^)(void))handler {
    
    return [self checkAlertStyle:JKAlertStyleCollectionSheet handler:handler];
}

/// 不是actionSheet样式将不执行handler
- (JKAlertView *)checkActionSheetStyleHandler:(void (^)(void))handler {
    
    return [self checkAlertStyle:JKAlertStyleActionSheet handler:handler];
}

/// 检查样式判断是否执行handler
- (JKAlertView *)checkAlertStyle:(JKAlertStyle)alertStyle
                         handler:(void (^)(void))handler {
    
    if (alertStyle != self.alertStyle) { return self; }
    
    !handler ? : handler();
    
    return self;
}
@end
