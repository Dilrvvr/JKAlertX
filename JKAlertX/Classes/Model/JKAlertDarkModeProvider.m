//
//  JKAlertDarkModeProvider.m
//  JKAlertX
//
//  Created by albert on 2020/7/7.
//

#import "JKAlertDarkModeProvider.h"
#import "JKAlertConst.h"

@interface JKAlertDarkModeProvider ()

/** colorProvider */
@property (nonatomic, copy) void (^colorProvider)(JKAlertDarkModeProvider *provider, UIColor * (^)(JKAlertDarkModeProvider *provider, UIColor *lightColor, UIColor *darkColor));

/** imageProvider */
@property (nonatomic, copy) void (^imageProvider)(JKAlertDarkModeProvider *provider, UIImage * (^)(JKAlertDarkModeProvider *provider, UIImage *lightImage, UIImage *darkImage));

/** userInterfaceStyle */
@property (nonatomic, assign) JKAlertUserInterfaceStyle userInterfaceStyle;

/** object */
//@property (nonatomic, weak) id <JKAlertDarkModeProviderProtocol> object;

/** currentSystemUserInterfaceStyle */
@property (nonatomic, assign) NSInteger currentSystemUserInterfaceStyle;
@end

@implementation JKAlertDarkModeProvider

+ (UIColor *)providerWithLighColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor object:(id)object selector:(SEL)selector {
    
    return nil;
}

- (void)dealloc {
    
    NSLog(@"[ClassName: %@], %d, %s", NSStringFromClass([self class]), __LINE__, __func__);
}

- (void)traitCollectionDidChange {
    
    if (@available(iOS 13.0, *)) {
        
        if (self.currentSystemUserInterfaceStyle == [UITraitCollection currentTraitCollection].userInterfaceStyle) { return; }
        
        self.currentSystemUserInterfaceStyle = [UITraitCollection currentTraitCollection].userInterfaceStyle;
    }
    
    [self executeColorProvider];
    
    [self executeImageProvider];
}

- (void)executeColorProvider {
    
    !self.colorProvider ? : self.colorProvider(self, ^UIColor *(JKAlertDarkModeProvider *provider, UIColor *lightColor, UIColor *darkColor) {
        
        return [provider checkIsDark] ? darkColor : lightColor;
    });
}

- (void)executeImageProvider {
    
    !self.imageProvider ? : self.imageProvider(self, ^UIImage *(JKAlertDarkModeProvider *provider, UIImage *lightImage, UIImage *darkImage) {
        
        return [provider checkIsDark] ? darkImage : lightImage;
    });
}

- (BOOL)checkIsDark {
    
    BOOL isDark = NO;
    
    if (JKAlertUserInterfaceStyleSystem == self.userInterfaceStyle) {
        
        if (@available(iOS 13.0, *)) {
            
            isDark = (UIUserInterfaceStyleDark == [UITraitCollection currentTraitCollection].userInterfaceStyle);
        }
        
    } else {
        
        isDark = (JKAlertUserInterfaceStyleDark == self.userInterfaceStyle);
    }
    
    return isDark;
}

+ (JKAlertDarkModeProvider *)providerWithObject:(id <JKAlertDarkModeProviderProtocol>)object
                                   lightHandler:(void (^)(void))lightHandler
                                    darkHandler:(void (^)(void))darkHandler {
    
    
    
    return nil;
}

+ (JKAlertDarkModeProvider *)providerWithObject:(id <JKAlertDarkModeProviderProtocol>)object
                                   colorProvider:(void (^)(JKAlertDarkModeProvider *provider, UIColor * (^colorProvider)(JKAlertDarkModeProvider *provider, UIColor *lightColor, UIColor *darkColor)))colorProvider {
    
    
    JKAlertDarkModeProvider *darkModeProvider = [JKAlertDarkModeProvider new];
    //darkModeProvider.object = object;
    object.darkModeProvider = darkModeProvider;
    darkModeProvider.colorProvider = colorProvider;
    
    [darkModeProvider executeColorProvider];
    
    return darkModeProvider;
}

+ (JKAlertDarkModeProvider *)providerWithObject:(id <JKAlertDarkModeProviderProtocol>)object
                                   imageProvider:(void (^)(JKAlertDarkModeProvider *provider, UIImage * (^imageProvider)(JKAlertDarkModeProvider *provider, UIImage *lightImage, UIImage *darkImage)))imageProvider {
    
    
    JKAlertDarkModeProvider *darkModeProvider = [JKAlertDarkModeProvider new];
    //darkModeProvider.object = object;
    object.darkModeProvider = darkModeProvider;
    darkModeProvider.imageProvider = imageProvider;
    
    [darkModeProvider executeImageProvider];
    
    return darkModeProvider;
}

- (instancetype)init {
    if (self = [super init]) {
        
        _userInterfaceStyle = JKAlertUserInterfaceStyleSystem;
        
        if (@available(iOS 13.0, *)) {
            
            _currentSystemUserInterfaceStyle = [UITraitCollection currentTraitCollection].userInterfaceStyle;
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(traitCollectionDidChange) name:JKAlertTraitCollectionDidChangeNotification object:nil];
    }
    return self;
}
@end
