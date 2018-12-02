//
//  JKAlertCategory.h
//  JKAlertX
//
//  Created by albert on 2018/12/2.
//  Copyright © 2018 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark
#pragma mark - UIView分类


@interface UIView (JKAlertX)

/** 切圆角 */
- (void)JKAlertX_clipRoundWithRadius:(CGFloat)radius
                              corner:(UIRectCorner)corner
                         borderWidth:(CGFloat)borderWidth
                         borderColor:(UIColor *)borderColor;
@end

#pragma mark
#pragma mark - UIControl点击分类

@interface UIControl (JKAlertX)


- (void)JKAlertX_addClickOperation:(void(^)(id control))clickOperation;

- (void)JKAlertX_addOperation:(void(^)(id control))clickOperation forControlEvents:(UIControlEvents)controlEvents;
@end


#pragma mark
#pragma mark - 手势分类

@interface UIGestureRecognizer (JKAlertX)


+ (instancetype)JKAlertX_gestureWithOperation:(void(^)(id gesture))gestureOperation;

- (void)JKAlertX_addGestureOperation:(void(^)(id gesture))gestureOperation;
@end
