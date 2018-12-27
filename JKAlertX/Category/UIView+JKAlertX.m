//
//  UIView+JKAlertX.m
//  JKAlertX
//
//  Created by albert on 2018/12/12.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "UIView+JKAlertX.h"

@implementation UIView (JKAlertX)

/** 切圆角 */
- (void)JKAlertX_clipRoundWithRadius:(CGFloat)radius corner:(UIRectCorner)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    
    if (radius > 0) {
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        self.layer.mask = shapeLayer;
        borderWidth *= 2;
    }
    
    if (borderWidth <= 0 || !borderColor) return;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    
    UIBezierPath *path2 = nil;
    
    if (radius <= 0) {
        
        path2 = [UIBezierPath bezierPathWithRect:CGRectMake(borderWidth * 0.5, borderWidth * 0.5, self.bounds.size.width - borderWidth, self.bounds.size.height - borderWidth)];
    }
    
    borderLayer.path = (radius <= 0) ? path2.CGPath : path.CGPath;
    borderLayer.lineWidth = borderWidth;
    borderLayer.strokeColor = borderColor.CGColor;
    borderLayer.fillColor = nil;
    
    [self.layer addSublayer:borderLayer];
}

/** 无限旋转动画 */
- (void)JKAlertX_addInfinityRotationAnimationWithDuration:(CGFloat)duration key:(NSString *)key{
    
    if (key && [self.layer animationForKey:key]) {
        
        return;
    }
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = duration;
    rotationAnimation.autoreverses = NO;
    rotationAnimation.repeatCount = INFINITY;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:rotationAnimation forKey:key];
    
    self.layer.beginTime = CACurrentMediaTime();
    self.layer.speed = 1.0;
}
@end
