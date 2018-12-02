//
//  JKAlertCategory.m
//  JKAlertX
//
//  Created by albert on 2018/12/2.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "JKAlertCategory.h"
#import <objc/runtime.h>

#pragma mark
#pragma mark - UIView分类

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
@end

#pragma mark
#pragma mark - UIControl点击分类

@implementation UIControl (JKAlertX)

static char JKAlertXControlActionTag;

- (void)JKAlertX_addClickOperation:(void(^)(id control))clickOperation{
    
    [self JKAlertX_addOperation:clickOperation forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)JKAlertX_addOperation:(void(^)(id control))clickOperation forControlEvents:(UIControlEvents)controlEvents{
    
    if (!clickOperation) { return; }
    
    objc_setAssociatedObject(self, &JKAlertXControlActionTag, clickOperation, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addTarget:self action:@selector(JKAlertX_buttonClick:) forControlEvents:(controlEvents)];
}

- (void)JKAlertX_buttonClick:(UIControl *)control{
    
    void(^clickOperation)(id control) = objc_getAssociatedObject(self, &JKAlertXControlActionTag);
    
    !clickOperation ? : clickOperation(self);
}
@end


#pragma mark
#pragma mark - 手势分类

@implementation UIGestureRecognizer (JKAlertX)

static char JKAlertXGestureActionTag;

+ (instancetype)JKAlertX_gestureWithOperation:(void(^)(id gesture))gestureOperation{
    
    if (!gestureOperation) { return [self new]; }
    
    UIGestureRecognizer *gesture = [[self alloc] initWithTarget:self action:@selector(JKAlertX_gestureAction:)];
    
    objc_setAssociatedObject(gesture, &JKAlertXGestureActionTag, gestureOperation, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return gesture;
}

+ (void)JKAlertX_gestureAction:(UIGestureRecognizer *)gesture{
    
    void(^gestureOperation)(id gesture) = objc_getAssociatedObject(gesture, &JKAlertXGestureActionTag);
    
    !gestureOperation ? : gestureOperation(gesture);
}

- (void)JKAlertX_addGestureOperation:(void(^)(id gesture))gestureOperation{
    
    if (!gestureOperation) { return; }
    
    objc_setAssociatedObject(self, &JKAlertXGestureActionTag, gestureOperation, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addTarget:self action:@selector(JKAlertX_gestureAction:)];
}

- (void)JKAlertX_gestureAction:(UIGestureRecognizer *)gesture{
    
    void(^gestureOperation)(id gesture) = objc_getAssociatedObject(self, &JKAlertXGestureActionTag);
    
    !gestureOperation ? : gestureOperation(self);
}
@end
