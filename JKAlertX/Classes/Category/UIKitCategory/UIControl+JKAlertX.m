//
//  UIControl+JKAlertX.m
//  JKAlertX
//
//  Created by albert on 2018/12/12.
//  Copyright © 2018 Albert. All rights reserved.
//

#import "UIControl+JKAlertX.h"
#import <objc/runtime.h>

@implementation UIControl (JKAlertX)

static char JKAlertXControlActionTag;

- (void)JKAlertX_addClickOperation:(void (^)(id control))clickOperation {
    
    [self JKAlertX_addOperation:clickOperation forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)JKAlertX_addOperation:(void (^)(id control))clickOperation forControlEvents:(UIControlEvents)controlEvents{
    
    if (!clickOperation) { return; }
    
    objc_setAssociatedObject(self, &JKAlertXControlActionTag, clickOperation, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addTarget:self action:@selector(JKAlertX_buttonClick:) forControlEvents:(controlEvents)];
}

- (void)JKAlertX_buttonClick:(UIControl *)control {
    
    void(^clickOperation)(id control) = objc_getAssociatedObject(self, &JKAlertXControlActionTag);
    
    !clickOperation ? : clickOperation(self);
}
@end
