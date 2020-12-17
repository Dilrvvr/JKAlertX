//
//  JKAlertThemeManager.m
//  JKAlertX
//
//  Created by albert on 2020/7/10.
//

#import "JKAlertThemeManager.h"
#include <objc/runtime.h>
#import "JKAlertThemeUtility.h"

@interface JKAlertThemeManager ()

@end

@implementation JKAlertThemeManager

#pragma mark
#pragma mark - Public Method

/**
 * 单例对象
 */
+ (instancetype)sharedManager {
    
    static JKAlertThemeManager *sharedManager_ = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedManager_ = [[self alloc] init];
    });
    
    return sharedManager_;
}

/**
 * 判断当前是否深色模式
 */
- (BOOL)checkIsDarkMode {
    
    BOOL isDark = NO;
    
    if (@available(iOS 13.0, *)) {
        
        if (self.autoSwitchDarkMode) {
            
            isDark = (UIUserInterfaceStyleDark == self.userInterfaceStyle);
            
            return isDark;
        }
    }
    
    isDark = [self.themeName isEqualToString:self.darkThemeName];
    
    return isDark;
}

- (void)setThemeStyle:(JKAlertThemeStyle)themeStyle {
    
    // 无变化
    if (_themeStyle == themeStyle) { return; }
    
    _themeStyle = themeStyle;
    
    [self postThemeStyleDidChangeNotification];
    
    switch (themeStyle) {
        case JKAlertThemeStyleSystem:
            if (@available(iOS 13.0, *)) {
                self.autoSwitchDarkMode = YES;
                self.themeName = [[JKAlertThemeManager sharedManager] checkIsDarkMode] ? self.darkThemeName : self.lightThemeName;
            } else {
                self.themeName = self.lightThemeName;
            }
            break;
        case JKAlertThemeStyleLight:
            if (@available(iOS 13.0, *)) {
                self.autoSwitchDarkMode = NO;
            }
            self.themeName = self.lightThemeName;
            break;
        case JKAlertThemeStyleDark:
            if (@available(iOS 13.0, *)) {
                self.autoSwitchDarkMode = NO;
            }
            self.themeName = self.darkThemeName;
            break;
            
        default:
            break;
    }
}

- (void)setThemeName:(NSString *)themeName {
    
    if (!themeName ||
        ![themeName isKindOfClass:[NSString class]] ||
        themeName.length <= 0) {
        
        return;
    }
    
    // 主题名称无变化
    if ([_themeName isEqualToString:themeName]) {
        
        return;
    }
    
    _themeName = [themeName copy];
    
    [self postThemeDidChangeNotification];
}

#pragma mark
#pragma mark - Private Method

- (void)postThemeStyleDidChangeNotification {
    
    if (@available(iOS 13.0, *)) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:JKAlertThemeStyleDidChangeNotification object:@(self.themeStyle)];
    }
}

- (void)postThemeDidChangeNotification {
    
    UIWindow *keyWindow = JKAlertThemeUtility.keyWindow;
    
    UIView *snapShotImageView = [keyWindow snapshotViewAfterScreenUpdates:NO];
    
    [keyWindow addSubview:snapShotImageView];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:JKAlertThemeDidChangeNotification object:self.themeName];
    
    if (@available(iOS 10.0, *)) {
        
        [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:0.25 delay:0 options:0 animations:^{
            
            snapShotImageView.alpha = 0;
            
        } completion:^(UIViewAnimatingPosition finalPosition) {
            
            [snapShotImageView removeFromSuperview];
        }];
        
    } else {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            snapShotImageView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [snapShotImageView removeFromSuperview];
        }];
    }
}

- (void)jkalert_traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [[JKAlertThemeManager sharedManager] jkalert_traitCollectionDidChange:previousTraitCollection];
    
    // 此时self类型为UIScreen
    if (@available(iOS 13.0, *)) {
        
        if ((UIScreen *)self != [UIScreen mainScreen]) { return; }
        
        BOOL appearanceChanged = [[UIScreen mainScreen].traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection];
        
        if (!appearanceChanged) { return; }
        
        [[JKAlertThemeManager sharedManager] traitCollectionDidChangeUserInterfaceStyle];
    }
}

- (void)traitCollectionDidChangeUserInterfaceStyle {
    
    if (@available(iOS 13.0, *)) {
        
        _userInterfaceStyle = [UIScreen mainScreen].traitCollection.userInterfaceStyle;
        
        BOOL isDark = (UIUserInterfaceStyleDark == _userInterfaceStyle);
        
        if (!self.autoSwitchDarkMode) { return; }
        
        self.themeName = isDark ? self.darkThemeName : self.lightThemeName;
    }
}

+ (void)swizzleInstanceMethodWithOriginalClass:(Class)originalClass
                              originalSelector:(SEL)originalSelector
                                 swizzledClass:(Class)swizzledClass
                              swizzledSelector:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
    
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    
    // Method中包含IMP函数指针，通过替换IMP，使SEL调用不同函数实现
    // isAdd 返回值表示是否添加成功
    BOOL isAdd = class_addMethod(originalClass, originalSelector,
                                 method_getImplementation(swizzledMethod),
                                 method_getTypeEncoding(swizzledMethod));
    
    // class_addMethod : 如果发现方法已经存在，会失败返回，也可以用来做检查用,我们这里是为了避免源方法没有实现的情况;
    // 如果方法没有存在,我们则先尝试添加被替换的方法的实现
    if (isAdd) {
        
        class_replaceMethod(swizzledClass, swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        
        // 添加失败：说明源方法已经有实现，直接将两个方法的实现交换即
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark
#pragma mark - Override

+ (void)load {
    
    // 交换UIScreen的 '- traitCollectionDidChange:' 方法来监听系统深色/浅色模式改变
    [self swizzleInstanceMethodWithOriginalClass:[UIScreen class] originalSelector:@selector(traitCollectionDidChange:) swizzledClass:[self class] swizzledSelector:@selector(jkalert_traitCollectionDidChange:)];
}

- (instancetype)init {
    if (self = [super init]) {
        
        if (@available(iOS 13.0, *)) {
            
            _userInterfaceStyle = [UIScreen mainScreen].traitCollection.userInterfaceStyle;
            
            self.autoSwitchDarkMode = YES;
            
            _themeName = (UIUserInterfaceStyleDark == _userInterfaceStyle) ? self.darkThemeName : self.lightThemeName;
        }
    }
    return self;
}

#pragma mark
#pragma mark - Property

- (NSString *)lightThemeName {
    if (!_lightThemeName) {
        _lightThemeName = JKAlertDefaultThemeLight;
    }
    return _lightThemeName;
}

- (NSString *)darkThemeName {
    if (!_darkThemeName) {
        _darkThemeName = JKAlertDefaultThemeDark;
    }
    return _darkThemeName;
}
@end
