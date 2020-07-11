//
//  NSObject+JKAlertTheme.m
//  JKAlertX
//
//  Created by albert on 2020/7/11.
//

#import "NSObject+JKAlertTheme.h"
#import "JKAlertThemeProvider.h"
#include <objc/runtime.h>

@implementation NSObject (JKAlertTheme)

- (void)setJkalert_themeProvider:(JKAlertThemeProvider *)darkModeProvider {
    
    if (darkModeProvider && ![darkModeProvider isKindOfClass:[JKAlertThemeProvider class]]) { return; }
    
    objc_setAssociatedObject(self, @selector(jkalert_themeProvider), darkModeProvider, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JKAlertThemeProvider *)jkalert_themeProvider {
    
    return objc_getAssociatedObject(self, _cmd);
}
@end
