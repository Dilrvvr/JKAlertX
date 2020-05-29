//
//  JKAlertMultiColor.m
//  JKAlertX
//
//  Created by albert on 2020/5/29.
//

#import "JKAlertMultiColor.h"

@interface JKAlertMultiColor ()
{
    UIColor *_dynamicColor;
}
@end

@implementation JKAlertMultiColor

+ (JKAlertMultiColor *)colorWithLightColor:(UIColor *)lightColor
                                 darkColor:(UIColor *)darkColor {
    
    JKAlertMultiColor *multiColor = [JKAlertMultiColor new];
    
    multiColor->_lightColor = lightColor;
    multiColor->_darkColor = darkColor;
    
    return multiColor;
}

- (instancetype)init {
    if (self = [super init]) {
        _lightColor = [UIColor blackColor];
        _darkColor = [UIColor whiteColor];
    }
    return self;
}

- (UIColor *)dynamicColor {
    
    if (_dynamicColor) { return _dynamicColor; }
    
    if (@available(iOS 13.0, *)) {
        
        _dynamicColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            
            if ([traitCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                
                return self.lightColor;
            }

            return self.darkColor;
        }];
        
    } else {
        
        _dynamicColor = self.lightColor;
    }
    
    return _dynamicColor;
}
@end
