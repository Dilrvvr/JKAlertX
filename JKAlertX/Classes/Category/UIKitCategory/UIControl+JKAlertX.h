//
//  UIControl+JKAlertX.h
//  JKAlertX
//
//  Created by albert on 2018/12/12.
//  Copyright © 2018 Albert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (JKAlertX)

- (void)JKAlertX_addClickOperation:(void (^)(id control))clickOperation;

- (void)JKAlertX_addOperation:(void (^)(id control))clickOperation forControlEvents:(UIControlEvents)controlEvents;
@end
