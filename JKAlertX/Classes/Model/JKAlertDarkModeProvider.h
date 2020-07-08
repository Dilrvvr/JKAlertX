//
//  JKAlertDarkModeProvider.h
//  JKAlertX
//
//  Created by albert on 2020/7/7.
//

#import <UIKit/UIKit.h>

@class JKAlertDarkModeProvider;

@protocol JKAlertDarkModeProviderProtocol <NSObject>

@required

@property (nonatomic, strong) JKAlertDarkModeProvider *darkModeProvider;
@end

@interface JKAlertDarkModeProvider : NSObject

+ (UIColor *)providerWithLighColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor object:(id)object selector:(SEL)selector;

+ (JKAlertDarkModeProvider *)providerWithObject:(id <JKAlertDarkModeProviderProtocol>)object
                                  colorProvider:(void (^)(JKAlertDarkModeProvider *provider, UIColor * (^colorProvider)(JKAlertDarkModeProvider *provider, UIColor *lightColor, UIColor *darkColor)))colorProvider;

+ (JKAlertDarkModeProvider *)providerWithObject:(id <JKAlertDarkModeProviderProtocol>)object
                                  imageProvider:(void (^)(JKAlertDarkModeProvider *provider, UIImage * (^imageProvider)(JKAlertDarkModeProvider *provider, UIImage *lightImage, UIImage *darkImage)))imageProvider;
@end
