//
//  NSObject+JKAlertDarkMode.h
//  JKAlertX
//
//  Created by albert on 2020/7/9.
//

#import <Foundation/Foundation.h>
#import "JKAlertThemeProvider.h"

@interface NSObject (JKAlertDarkMode) <JKAlertThemeProviderProtocol>

@property (nonatomic, strong) JKAlertThemeProvider *themeProvider;
@end
