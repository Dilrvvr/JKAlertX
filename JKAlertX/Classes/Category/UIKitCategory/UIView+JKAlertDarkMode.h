//
//  UIView+JKAlertDarkMode.h
//  JKAlertX
//
//  Created by albert on 2020/7/7.
//

#import <UIKit/UIKit.h>
#import "JKAlertDarkModeProvider.h"

@interface UIView (JKAlertDarkMode) <JKAlertDarkModeProviderProtocol>

@property (nonatomic, strong) JKAlertDarkModeProvider *darkModeProvider;
@end
