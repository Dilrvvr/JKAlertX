//
//  NSObject+JKSafeCrachProtection.m
//  JKWheels
//
//  Created by albert on 2020/3/5.
//  Copyright © 2020 安永博. All rights reserved.
//

#import "NSObject+JKSafeCrachProtection.h"
#import <objc/runtime.h>

@implementation NSObject (JKSafeCrachProtection)

/// 封装交换实例方法
void jk_swizzle_instance_method(Class targetClass, SEL originalSelector, SEL swizzledSelector) {
    
    Method originalMethod = class_getInstanceMethod(targetClass, originalSelector);
    
    Method swizzledMethod = class_getInstanceMethod(targetClass, swizzledSelector);
    
    // Method中包含IMP函数指针，通过替换IMP，使SEL调用不同函数实现
    // isAdd 返回值表示是否添加成功
    BOOL isAdd = class_addMethod(targetClass, originalSelector,
                                 method_getImplementation(swizzledMethod),
                                 method_getTypeEncoding(swizzledMethod));
    
    // class_addMethod : 如果发现方法已经存在，会失败返回，也可以用来做检查用,我们这里是为了避免源方法没有实现的情况;
    // 如果方法没有存在,我们则先尝试添加被替换的方法的实现
    if (isAdd) {
        
        class_replaceMethod(targetClass, swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        
        // 添加失败：说明源方法已经有实现，直接将两个方法的实现交换即
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

/// 封装交换类方法
void jk_swizzle_class_method(Class targetClass, SEL originalSelector, SEL swizzledSelector) {
    
    Method originalMethod = class_getClassMethod(targetClass, originalSelector);
    
    Method swizzledMethod = class_getClassMethod(targetClass, swizzledSelector);
    
    // Method中包含IMP函数指针，通过替换IMP，使SEL调用不同函数实现
    // isAdd 返回值表示是否添加成功
    BOOL isAdd = class_addMethod(targetClass, originalSelector,
                                 method_getImplementation(swizzledMethod),
                                 method_getTypeEncoding(swizzledMethod));
    
    // class_addMethod : 如果发现方法已经存在，会失败返回，也可以用来做检查用,我们这里是为了避免源方法没有实现的情况;
    // 如果方法没有存在,我们则先尝试添加被替换的方法的实现
    if (isAdd) {
        
        class_replaceMethod(targetClass, swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        
        // 添加失败：说明源方法已经有实现，直接将两个方法的实现交换即
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

/// 动态添加的方法实现
static int jk_safe_crash_protection_method(id slf, SEL selector) {
    
    return 0;
}

+ (void)load{
    
#ifdef DEBUG
    
#else
    // 交换实例方法
    jk_swizzle_instance_method([self class], @selector(forwardingTargetForSelector:), @selector(jk_safe_forwardingTargetForSelector:));
    
    // 交换类方法
    jk_swizzle_class_method([self class], @selector(forwardingTargetForSelector:), @selector(jk_safe_forwardingTargetForSelector:));
#endif
}

// 自定义实现 `- jk_safe_forwardingTargetForSelector:` 方法
- (id)jk_safe_forwardingTargetForSelector:(SEL)aSelector {
    
    SEL forwarding_sel = @selector(forwardingTargetForSelector:);
    
    // 获取 NSObject 的消息转发方法
    Method root_forwarding_method = class_getInstanceMethod([NSObject class], forwarding_sel);
    
    // 获取 当前类 的消息转发方法
    Method current_forwarding_method = class_getInstanceMethod([self class], forwarding_sel);
    
    // 判断当前类本身是否实现第二步:消息接受者重定向
    BOOL isRealized = method_getImplementation(current_forwarding_method) != method_getImplementation(root_forwarding_method);
    
    // 如果没有实现第二步:消息接受者重定向
    if (!isRealized) {
        
        // 判断有没有实现第三步:消息重定向
        SEL methodSignature_sel = @selector(methodSignatureForSelector:);
        
        Method root_methodSignature_method = class_getInstanceMethod([NSObject class], methodSignature_sel);
        
        Method current_methodSignature_method = class_getInstanceMethod([self class], methodSignature_sel);
        
        isRealized = method_getImplementation(current_methodSignature_method) != method_getImplementation(root_methodSignature_method);
        
        // 如果没有实现第三步:消息重定向
        if (!isRealized) {
            
            // 创建一个新类
            NSString *errClassName = NSStringFromClass([self class]);
            
            NSString *errSel = NSStringFromSelector(aSelector);
            
            NSLog(@"*** Crash Message: - [%@ %@]: unrecognized selector sent to instance %p ***",errClassName, errSel, self);
            
            NSString *className = @"CrachClass";
            
            Class cls = NSClassFromString(className);
            
            // 如果类不存在 动态创建一个类
            if (!cls) {
                
                Class superClsss = [NSObject class];
                
                cls = objc_allocateClassPair(superClsss, className.UTF8String, 0);
                
                // 注册类
                objc_registerClassPair(cls);
            }
            
            // 如果类没有对应的方法，则动态添加一个
            if (!class_getInstanceMethod(NSClassFromString(className), aSelector)) {
                
                class_addMethod(cls, aSelector, (IMP)jk_safe_crash_protection_method, "@@:@");
            }
            
            // 把消息转发到当前动态生成类的实例对象上
            return [[cls alloc] init];
        }
    }
    
    return [self jk_safe_forwardingTargetForSelector:aSelector];
}

// 自定义实现 `+ jk_safe_forwardingTargetForSelector:` 方法
+ (id)jk_safe_forwardingTargetForSelector:(SEL)aSelector {
    
    SEL forwarding_sel = @selector(forwardingTargetForSelector:);
    
    // 获取 NSObject 的消息转发方法
    Method root_forwarding_method = class_getClassMethod([NSObject class], forwarding_sel);
    
    // 获取 当前类 的消息转发方法
    Method current_forwarding_method = class_getClassMethod([self class], forwarding_sel);
    
    // 判断当前类本身是否实现第二步:消息接受者重定向
    BOOL isRealized = method_getImplementation(current_forwarding_method) != method_getImplementation(root_forwarding_method);
    
    // 如果没有实现第二步:消息接受者重定向
    if (!isRealized) {
        
        // 判断有没有实现第三步:消息重定向
        SEL methodSignature_sel = @selector(methodSignatureForSelector:);
        
        Method root_methodSignature_method = class_getClassMethod([NSObject class], methodSignature_sel);
        
        Method current_methodSignature_method = class_getClassMethod([self class], methodSignature_sel);
        
        isRealized = method_getImplementation(current_methodSignature_method) != method_getImplementation(root_methodSignature_method);
        
        // 如果没有实现第三步:消息重定向
        if (!isRealized) {
            
            // 创建一个新类
            NSString *errClassName = NSStringFromClass([self class]);
            NSString *errSel = NSStringFromSelector(aSelector);
            
            NSLog(@"*** Crash Message: + [%@ %@]: unrecognized selector sent to class %p ***", errClassName, errSel, self);
            
            NSString *className = @"CrachClass";
            
            Class cls = NSClassFromString(className);
            
            // 如果类不存在 动态创建一个类
            if (!cls) {
                
                Class superClsss = [NSObject class];
                cls = objc_allocateClassPair(superClsss, className.UTF8String, 0);
                
                // 注册类
                objc_registerClassPair(cls);
            }
            
            // 如果类没有对应的方法，则动态添加一个
            if (!class_getInstanceMethod(NSClassFromString(className), aSelector)) {
                
                class_addMethod(cls, aSelector, (IMP)jk_safe_crash_protection_method, "@@:@");
            }
            
            // 把消息转发到当前动态生成类的实例对象上
            return [[cls alloc] init];
        }
    }
    
    return [self jk_safe_forwardingTargetForSelector:aSelector];
}
@end
