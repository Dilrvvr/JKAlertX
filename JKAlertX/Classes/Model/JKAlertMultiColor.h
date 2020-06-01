//
//  JKAlertMultiColor.h
//  JKAlertX
//
//  Created by albert on 2020/5/29.
//

#import <Foundation/Foundation.h>

@interface JKAlertMultiColor : NSObject

+ (JKAlertMultiColor *)colorWithSingleColor:(UIColor *)singleColor;

+ (JKAlertMultiColor *)colorWithLightColor:(UIColor *)lightColor
                                 darkColor:(UIColor *)darkColor;

/** lightColor */
@property (nonatomic, strong, readonly) UIColor *lightColor;

/** darkColor */
@property (nonatomic, strong, readonly) UIColor *darkColor;

/** dynamicColor */
@property (nonatomic, strong, readonly) UIColor *dynamicColor;
@end
