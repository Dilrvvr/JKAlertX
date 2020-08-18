//
//  UIGestureRecognizer+JKAlertX.m
//  JKAlertX
//
//  Created by albert on 2018/12/12.
//  Copyright © 2018 Albert. All rights reserved.
//

#import "UIGestureRecognizer+JKAlertX.h"
#import <objc/runtime.h>

@implementation UIGestureRecognizer (JKAlertX)

static char JKAlertXGestureActionTag;

+ (instancetype)JKAlertX_gestureWithOperation:(void (^)(id gesture))gestureOperation {
    
    if (!gestureOperation) { return [self new]; }
    
    UIGestureRecognizer *gesture = [[self alloc] initWithTarget:self action:@selector(JKAlertX_gestureAction:)];
    
    objc_setAssociatedObject(gesture, &JKAlertXGestureActionTag, gestureOperation, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return gesture;
}

+ (void)JKAlertX_gestureAction:(UIGestureRecognizer *)gesture {
    
    void(^gestureOperation)(id gesture) = objc_getAssociatedObject(gesture, &JKAlertXGestureActionTag);
    
    !gestureOperation ? : gestureOperation(gesture);
}

- (void)JKAlertX_addGestureOperation:(void (^)(id gesture))gestureOperation {
    
    if (!gestureOperation) { return; }
    
    objc_setAssociatedObject(self, &JKAlertXGestureActionTag, gestureOperation, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addTarget:self action:@selector(JKAlertX_gestureAction:)];
}

- (void)JKAlertX_gestureAction:(UIGestureRecognizer *)gesture {
    
    void(^gestureOperation)(id gesture) = objc_getAssociatedObject(self, &JKAlertXGestureActionTag);
    
    !gestureOperation ? : gestureOperation(self);
}
@end
