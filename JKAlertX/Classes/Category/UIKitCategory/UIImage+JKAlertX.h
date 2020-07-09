//
//  UIImage+JKAlertX.h
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import <UIKit/UIKit.h>

@interface UIImage (JKAlertX)

+ (UIImage *)JKAlertX_createImageWithColor:(UIColor *)color
                                 imageSize:(CGSize)imageSize
                              cornerRadius:(CGFloat)cornerRadius;

//+ (UIImage *)imageWithLightImageProvider:()lightImageProvider darkImageProvider:()darkImageProvider;
@end
