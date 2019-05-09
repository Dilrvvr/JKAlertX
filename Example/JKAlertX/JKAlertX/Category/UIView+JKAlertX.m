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

/**
 * 添加虚线
 * 要添加虚线的view
 */
- (id)JKAlertX_addDashLineWithLineWidth:(CGFloat)lineWidth
                              lineColor:(UIColor *)lineColor
                              dashWidth:(CGFloat)dashWidth
                              dashSpace:(CGFloat)dashSpace
                             startPoint:(CGPoint)startPoint
                               endPoint:(CGPoint)endPoint
                          isRenderImage:(BOOL)isRenderImage{
    
    assert(lineColor);
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFrame:self.bounds];
    shapeLayer.masksToBounds = YES;
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) * 0.5, CGRectGetHeight(self.frame) * 0.5)];
    
    [shapeLayer setStrokeColor:lineColor.CGColor];
    [shapeLayer setLineWidth:lineWidth];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:@[@(dashWidth), @(dashSpace)]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    
    [shapeLayer setPath:path];
    
    CGPathRelease(path);
    
    if (isRenderImage) {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [shapeLayer renderInContext:ctx];
        UIImage *tImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return tImage;
    }
    
    //  把绘制好的虚线添加上来
    [self.layer insertSublayer:shapeLayer atIndex:0];
    
    return shapeLayer;
}

/** 渐变背景 */
- (CAGradientLayer *)JKAlertX_addGradientLayerWithColors:(NSArray <UIColor *> *)colors
                                               locations:(NSArray *)locations
                                              startPoint:(CGPoint)startPoint
                                                endPoint:(CGPoint)endPoint
                                                   frame:(CGRect)frame{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
    NSMutableArray *arrM = [NSMutableArray array];
    
    for (UIColor *color in colors) {
        
        [arrM addObject:(id)[color CGColor]];
    }
    
    gradientLayer.colors = arrM;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = frame;
    
    return gradientLayer;
}
@end
