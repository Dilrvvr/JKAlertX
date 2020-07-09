//
//  NSObject+JKAlertDarkMode.m
//  JKAlertX
//
//  Created by albert on 2020/7/9.
//

#import "NSObject+JKAlertDarkMode.h"
#include <objc/runtime.h>

@implementation NSObject (JKAlertDarkMode)

- (void)setDarkModeProvider:(JKAlertDarkModeProvider *)darkModeProvider {
    
    objc_setAssociatedObject(self, @selector(darkModeProvider), darkModeProvider, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JKAlertDarkModeProvider *)darkModeProvider {
    
    return objc_getAssociatedObject(self, _cmd);
}
@end
