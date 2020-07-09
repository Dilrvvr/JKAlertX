//
//  JKAlertDarkModeProvider.h
//  JKAlertX
//
//  Created by albert on 2020/7/7.
//

#import <UIKit/UIKit.h>

@class JKAlertDarkModeProvider;

typedef void(^JKAlertDarkModeProvideHandler)(JKAlertDarkModeProvider *provider, id providerOwner, id (^checkHandler)(JKAlertDarkModeProvider *provider, id light, id dark));

@protocol JKAlertDarkModeProviderProtocol <NSObject>

@required

@property (nonatomic, strong) JKAlertDarkModeProvider *darkModeProvider;
@end

@interface JKAlertDarkModeProvider : NSObject

/** owner */
@property (nonatomic, weak, readonly) id <JKAlertDarkModeProviderProtocol> owner;

+ (JKAlertDarkModeProvider *)providerWithOwner:(id <JKAlertDarkModeProviderProtocol>)owner
                               providerHandler:(JKAlertDarkModeProvideHandler)providerHandler;

- (void)addExecuteProviderHandler:(JKAlertDarkModeProvideHandler)providerHandler;
@end
