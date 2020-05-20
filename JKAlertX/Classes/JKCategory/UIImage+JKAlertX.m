//
//  UIImage+JKAlertX.m
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "UIImage+JKAlertX.h"

@implementation UIImage (JKAlertX)

+ (UIImage *)JKAlertX_createImageWithColor:(UIColor *)color
                                 imageSize:(CGSize)imageSize
                              cornerRadius:(CGFloat)cornerRadius {
    
    if ( !color || imageSize.width <= 0 || imageSize.height <= 0) { return nil; }
    
    CGRect rect = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    if (cornerRadius > 0) {
        
        // NO代表透明
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
        
        // 获取上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        // 添加一个圆
        //CGContextAddEllipseInRect(ctx, rect);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerAllCorners) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        
        CGContextAddPath(ctx, path.CGPath);
        
        // 裁剪
        CGContextClip(ctx);
        
        // 将图片画上去
        [theImage drawInRect:rect];
        
        theImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
    
    return theImage;
}
@end
