//
//  JKAlertMultiColor.h
//  JKAlertX
//
//  Created by albert on 2020/5/29.
//

#import <Foundation/Foundation.h>

@interface JKAlertMultiColor : NSObject

/// 无颜色
+ (JKAlertMultiColor *)colorWithNoColor;

/// 将动态color转为JKAlertMultiColor
+ (JKAlertMultiColor *)colorWithDynamicColor:(UIColor *)color;

/// 浅色/深色 颜色保持一致
+ (JKAlertMultiColor *)colorWithSameColor:(UIColor *)singleColor;

/// 创建 浅色/深色 颜色
+ (JKAlertMultiColor *)colorWithLightColor:(UIColor *)lightColor
                                 darkColor:(UIColor *)darkColor;

/** lightColor */
@property (nonatomic, strong, readonly) UIColor *lightColor;

/** darkColor */
@property (nonatomic, strong, readonly) UIColor *darkColor;

/** dynamicColor */
@property (nonatomic, strong, readonly) UIColor *dynamicColor;
@end
