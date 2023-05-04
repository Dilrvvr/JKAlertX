//
//  NSObject+JKAlertTheme.h
//  JKAlertX
//
//  Created by albert on 2020/7/11.
//

#import <UIKit/UIKit.h>
#import "JKAlertThemeUtility.h"

@class JKAlertThemeProvider;

@interface NSObject (JKAlertTheme) <JKAlertThemeProviderProtocol>

@property (nonatomic, strong) JKAlertThemeProvider *jkalert_themeProvider;
@end
