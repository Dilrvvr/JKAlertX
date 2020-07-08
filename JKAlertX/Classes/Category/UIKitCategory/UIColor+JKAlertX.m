//
//  UIColor+JKAlertX.m
//  JKAlertX
//
//  Created by albert on 2020/7/8.
//

#import "UIColor+JKAlertX.h"

@implementation UIColor (JKAlertX)

+ (UIColor *)colorWithLightColor:(UIColor *)lightColor
                       darkColor:(UIColor *)darkColor {
    
    if (@available(iOS 13.0, *)) {
        
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            
            if (UIUserInterfaceStyleDark == [traitCollection userInterfaceStyle]) {
                
                return darkColor;
            }

            return lightColor;
        }];
        
    } else {
        
        return lightColor;
    }
}
@end
