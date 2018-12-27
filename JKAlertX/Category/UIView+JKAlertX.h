//
//  UIView+JKAlertX.h
//  JKAlertX
//
//  Created by albert on 2018/12/12.
//  Copyright © 2018 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JKAlertX)

/** 切圆角 */
- (void)JKAlertX_clipRoundWithRadius:(CGFloat)radius
                              corner:(UIRectCorner)corner
                         borderWidth:(CGFloat)borderWidth
                         borderColor:(UIColor *)borderColor;

/** 无限旋转动画 */
- (void)JKAlertX_addInfinityRotationAnimationWithDuration:(CGFloat)duration key:(NSString *)key;
@end
