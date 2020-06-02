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

/// 无颜色
+ (JKAlertMultiColor *)colorWithNoColor {
    
    return [[JKAlertMultiColor alloc] init];
}

/// 将动态color转为JKAlertMultiColor
+ (JKAlertMultiColor *)colorWithDynamicColor:(UIColor *)color {
    
    if (!color) { return [self colorWithNoColor]; }

    UIColor *lightColor = color;
    UIColor *darkColor = color;
    
    if (@available(iOS 13.0, *)) {
        
        UITraitCollection *lightCollection = [UITraitCollection traitCollectionWithUserInterfaceStyle:(UIUserInterfaceStyleLight)];
        
        UITraitCollection *darkCollection = [UITraitCollection traitCollectionWithUserInterfaceStyle:(UIUserInterfaceStyleLight)];
        
        lightColor = [color resolvedColorWithTraitCollection:lightCollection];
        darkColor = [color resolvedColorWithTraitCollection:darkCollection];
    }
    
    return [JKAlertMultiColor colorWithLightColor:lightColor darkColor:darkColor];
}

/// 浅色/深色 颜色保持一致
+ (JKAlertMultiColor *)colorWithSameColor:(UIColor *)singleColor {
    
    return [self colorWithLightColor:singleColor darkColor:singleColor];
}

/// 创建 浅色/深色 颜色
+ (JKAlertMultiColor *)colorWithLightColor:(UIColor *)lightColor
                                 darkColor:(UIColor *)darkColor {
    
    JKAlertMultiColor *multiColor = [JKAlertMultiColor new];
    
    multiColor->_lightColor = lightColor;
    multiColor->_darkColor = darkColor;
    
    return multiColor;
}

- (void)setLightColor:(UIColor *)lightColor {
    _lightColor = lightColor;
    
    _dynamicColor = nil;
}

- (void)setDarkColor:(UIColor *)darkColor {
    _darkColor = darkColor;
    
    _dynamicColor = nil;
}

- (UIColor *)dynamicColor {
    
    if (_dynamicColor) { return _dynamicColor; }
    
    if (!_lightColor && !_darkColor) { return nil; }
    
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
