//
//  UIView+JKAlertDarkMode.m
//  JKAlertX
//
//  Created by albert on 2020/7/7.
//

#import "UIView+JKAlertDarkMode.h"
#import <objc/message.h>

@implementation UIView (JKAlertDarkMode)

- (void)setDarkModeProvider:(JKAlertDarkModeProvider *)darkModeProvider {
    
    objc_setAssociatedObject(self, @selector(darkModeProvider), darkModeProvider, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JKAlertDarkModeProvider *)darkModeProvider {
    
    return objc_getAssociatedObject(self, _cmd);
}
@end
