//
//  UIView+JKAlertX.h
//  JKAlertX
//
//  Created by albert on 2018/12/12.
//  Copyright © 2018 Albert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JKAlertX)

/**
 * 切圆角
 * return 切圆角的mask
 */
- (CAShapeLayer *)JKAlertX_clipRoundWithRadius:(CGFloat)radius
                                        corner:(UIRectCorner)corner;
/**
 * 切圆角 + 边框
 * return 切圆角的mask
 */
- (CAShapeLayer *)JKAlertX_clipRoundWithRadius:(CGFloat)radius
                              corner:(UIRectCorner)corner
                         borderWidth:(CGFloat)borderWidth
                         borderColor:(UIColor *)borderColor;

/** 无限旋转动画 */
- (void)JKAlertX_addInfinityRotationAnimationWithDuration:(CGFloat)duration
                                                      key:(NSString *)key;

/** 旋转动画 */
- (void)JKAlertX_addRotationAnimationWithDuration:(CGFloat)duration
                                      repeatCount:(float)repeatCount
                                              key:(NSString *)key;

/**
 * 添加虚线
 * 要添加虚线的view
 * return value : isRenderImage == YES返回UIImage 否则返回CAShapeLayer
 */
- (id)JKAlertX_addDashLineWithLineWidth:(CGFloat)lineWidth
                              lineColor:(UIColor *)lineColor
                              dashWidth:(CGFloat)dashWidth
                              dashSpace:(CGFloat)dashSpace
                             startPoint:(CGPoint)startPoint
                               endPoint:(CGPoint)endPoint
                          isRenderImage:(BOOL)isRenderImage;

/** 渐变背景 */
- (CAGradientLayer *)JKAlertX_addGradientLayerWithColors:(NSArray <UIColor *> *)colors
                                               locations:(NSArray *)locations
                                              startPoint:(CGPoint)startPoint
                                                endPoint:(CGPoint)endPoint
                                                   frame:(CGRect)frame;
@end
