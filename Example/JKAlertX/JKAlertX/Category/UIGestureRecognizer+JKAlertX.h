//
//  UIGestureRecognizer+JKAlertX.h
//  JKAlertX
//
//  Created by albert on 2018/12/12.
//  Copyright © 2018 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (JKAlertX)

+ (instancetype)JKAlertX_gestureWithOperation:(void(^)(id gesture))gestureOperation;

- (void)JKAlertX_addGestureOperation:(void(^)(id gesture))gestureOperation;
@end
