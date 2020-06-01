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

+ (JKAlertMultiColor *)colorWithColor:(UIColor *)color {

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

+ (JKAlertMultiColor *)colorWithSingleColor:(UIColor *)singleColor {
    
    return [self colorWithLightColor:singleColor darkColor:singleColor];
}

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
