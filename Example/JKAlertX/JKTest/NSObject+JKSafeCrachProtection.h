//
//  NSObject+JKSafeCrachProtection.h
//  JKWheels
//
//  Created by albert on 2020/3/5.
//  Copyright © 2020 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (JKSafeCrachProtection)

/// 封装交换实例方法
void jk_swizzle_instance_method(Class targetClass, SEL originalSelector, SEL swizzledSelector);

/// 封装交换类方法
void jk_swizzle_class_method(Class targetClass, SEL originalSelector, SEL swizzledSelector);
@end
