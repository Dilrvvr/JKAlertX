//
//  NSObject+JKAlertDarkMode.h
//  JKAlertX
//
//  Created by albert on 2020/7/9.
//

#import <Foundation/Foundation.h>
#import "JKAlertDarkModeProvider.h"

@interface NSObject (JKAlertDarkMode) <JKAlertDarkModeProviderProtocol>

@property (nonatomic, strong) JKAlertDarkModeProvider *darkModeProvider;
@end
