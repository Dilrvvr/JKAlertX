//
//  JKAlertThemeManager.m
//  JKAlertX
//
//  Created by albert on 2020/7/10.
//

#import "JKAlertThemeManager.h"
#include <objc/runtime.h>

/// 浅色
NSString * const JKAlertDefaultThemeLight = @"JKAlertDefaultThemeLight";

/// 深色
NSString * const JKAlertDefaultThemeDark = @"JKAlertDefaultThemeDark";

/** 系统深色/浅色样式改变的通知 */
NSString * const JKAlertThemeDidChangeNotification = @"JKAlertThemeDidChangeNotification";

/// 监听UITraitCollection的keyPath
NSString * const UITraitCollectionObserveKeyPath = @"_userInterfaceStyle";

@interface JKAlertThemeManager ()

/** isObserverAdded */
@property (nonatomic, assign) BOOL isObserverAdded;
@end

@implementation JKAlertThemeManager






#pragma mark
#pragma mark - Public Method

+ (instancetype)sharedManager {
    
    static JKAlertThemeManager *sharedManager_ = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager_ = [[JKAlertThemeManager alloc] init];
    });
    
    return sharedManager_;
}

- (void)setThemeName:(NSString *)themeName {
    
    if (!themeName ||
        ![themeName isKindOfClass:[NSString class]] ||
        themeName.length <= 0) {
        
        return;
    }
    
    _themeName = [themeName copy];
}

- (void)setAutoSwitchDarkMode:(BOOL)autoSwitchDarkMode {
    _autoSwitchDarkMode = autoSwitchDarkMode;
    
    if (@available(iOS 13.0, *)) {
        
        if (autoSwitchDarkMode) {
            
            [self addTraitCollectionObserver];
            
        } else {
            
            [self removeTraitCollectionObserver];
        }
    }
}

#pragma mark
#pragma mark - Private Method

- (void)addTraitCollectionObserver {
    
    if (@available(iOS 13.0, *)) {
        
        if (self.isObserverAdded) { return; }
        
        // TODO: JKTODO <#注释#>
        
        [[UITraitCollection currentTraitCollection] addObserver:self forKeyPath:UITraitCollectionObserveKeyPath options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
        
        self.isObserverAdded = YES;
    }
}

- (void)removeTraitCollectionObserver {
    
    if (@available(iOS 13.0, *)) {
        
        if (!self.isObserverAdded) { return; }
        
        [[UITraitCollection currentTraitCollection] removeObserver:self forKeyPath:UITraitCollectionObserveKeyPath];
        
        self.isObserverAdded = NO;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    if (@available(iOS 13.0, *)) {
        
        if ([object isKindOfClass:[UITraitCollection class]] &&
            [keyPath isEqualToString:UITraitCollectionObserveKeyPath]) {
            
            UIUserInterfaceStyle oldStyle = [[change objectForKey:NSKeyValueChangeOldKey] integerValue];
            UIUserInterfaceStyle currentStyle = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
            
            if (oldStyle != currentStyle) {
                
                self.themeName = (UIUserInterfaceStyleDark == currentStyle) ? self.darkThemeName : self.lightThemeName;
                
                [[NSNotificationCenter defaultCenter] postNotificationName:JKAlertThemeDidChangeNotification object:self.themeName];
            }
        }
    }
}

#pragma mark
#pragma mark - Override

- (instancetype)init {
    if (self = [super init]) {
        
        _lightThemeName = JKAlertDefaultThemeLight;
        _darkThemeName = JKAlertDefaultThemeDark;
        self.autoSwitchDarkMode = YES;
        
        if (@available(iOS 13.0, *)) {
            
            _themeName = (UIUserInterfaceStyleDark == [UITraitCollection currentTraitCollection].userInterfaceStyle) ? self.darkThemeName : self.lightThemeName;
        }
    }
    return self;
}
@end

//CG_INLINE BOOL
//HasOverrideSuperclassMethod(Class targetClass, SEL targetSelector) {
//    Method method = class_getInstanceMethod(targetClass, targetSelector);
//    if (!method) return NO;
//
//    Method methodOfSuperclass = class_getInstanceMethod(class_getSuperclass(targetClass), targetSelector);
//    if (!methodOfSuperclass) return YES;
//
//    return method != methodOfSuperclass;
//}
//
///**
// *  用 block 重写某个 class 的指定方法
// *  @param targetClass 要重写的 class
// *  @param targetSelector 要重写的 class 里的实例方法，注意如果该方法不存在于 targetClass 里，则什么都不做
// *  @param implementationBlock 该 block 必须返回一个 block，返回的 block 将被当成 targetSelector 的新实现，所以要在内部自己处理对 super 的调用，以及对当前调用方法的 self 的 class 的保护判断（因为如果 targetClass 的 targetSelector 是继承自父类的，targetClass 内部并没有重写这个方法，则我们这个函数最终重写的其实是父类的 targetSelector，所以会产生预期之外的 class 的影响，例如 targetClass 传进来  UIButton.class，则最终可能会影响到 UIView.class），implementationBlock 的参数里第一个为你要修改的 class，也即等同于 targetClass，第二个参数为你要修改的 selector，也即等同于 targetSelector，第三个参数是一个 block，用于获取 targetSelector 原本的实现，由于 IMP 可以直接当成 C 函数调用，所以可利用它来实现“调用 super”的效果，但由于 targetSelector 的参数个数、参数类型、返回值类型，都会影响 IMP 的调用写法，所以这个调用只能由业务自己写。
// */
//CG_INLINE BOOL
//OverrideImplementation(Class targetClass, SEL targetSelector, id (^implementationBlock)(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void))) {
//    Method originMethod = class_getInstanceMethod(targetClass, targetSelector);
//    IMP imp = method_getImplementation(originMethod);
//    BOOL hasOverride = HasOverrideSuperclassMethod(targetClass, targetSelector);
//
//    // 以 block 的方式达到实时获取初始方法的 IMP 的目的，从而避免先 swizzle 了 subclass 的方法，再 swizzle superclass 的方法，会发现前者调用时不会触发后者 swizzle 后的版本的 bug。
//    IMP (^originalIMPProvider)(void) = ^IMP(void) {
//        IMP result = NULL;
//        if (hasOverride) {
//            result = imp;
//        } else {
//            // 如果 superclass 里依然没有实现，则会返回一个 objc_msgForward 从而触发消息转发的流程
//            // https://github.com/Tencent/QMUI_iOS/issues/776
//            Class superclass = class_getSuperclass(targetClass);
//            result = class_getMethodImplementation(superclass, targetSelector);
//        }
//
//        // 这只是一个保底，这里要返回一个空 block 保证非 nil，才能避免用小括号语法调用 block 时 crash
//        // 空 block 虽然没有参数列表，但在业务那边被转换成 IMP 后就算传多个参数进来也不会 crash
//        if (!result) {
//            result = imp_implementationWithBlock(^(id selfObject){
//                // TODO: JKTODO <#注释#>
//                NSlog(([NSString stringWithFormat:@"%@", targetClass]), @"%@ 没有初始实现，%@\n%@", NSStringFromSelector(targetSelector), selfObject, [NSThread callStackSymbols]);
//            });
//        }
//
//        return result;
//    };
//
//    if (hasOverride) {
//        method_setImplementation(originMethod, imp_implementationWithBlock(implementationBlock(targetClass, targetSelector, originalIMPProvider)));
//    } else {
//        const char *typeEncoding = method_getTypeEncoding(originMethod) ?: [targetClass instanceMethodSignatureForSelector:targetSelector].qmui_typeEncoding;
//        class_addMethod(targetClass, targetSelector, imp_implementationWithBlock(implementationBlock(targetClass, targetSelector, originalIMPProvider)), typeEncoding);
//    }
//
//    return YES;
//}
