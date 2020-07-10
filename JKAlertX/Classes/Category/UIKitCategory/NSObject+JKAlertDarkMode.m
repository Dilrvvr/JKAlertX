//
//  NSObject+JKAlertDarkMode.m
//  JKAlertX
//
//  Created by albert on 2020/7/9.
//

#import "NSObject+JKAlertDarkMode.h"
#include <objc/runtime.h>

@implementation NSObject (JKAlertDarkMode)

- (void)setThemeProvider:(JKAlertThemeProvider *)darkModeProvider {
    
    objc_setAssociatedObject(self, @selector(themeProvider), darkModeProvider, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JKAlertThemeProvider *)themeProvider {
    
    return objc_getAssociatedObject(self, _cmd);
}
@end
