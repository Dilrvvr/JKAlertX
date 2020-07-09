//
//  JKAlertDarkModeProvider.m
//  JKAlertX
//
//  Created by albert on 2020/7/7.
//

#import "JKAlertDarkModeProvider.h"
#import "JKAlertConst.h"

@interface JKAlertDarkModeProvider ()

/** handlerArray */
@property (nonatomic, strong) NSMutableArray *handlerArray;

/** imageProvider */
//@property (nonatomic, copy) void (^providerHandler)(JKAlertDarkModeProvider *provider, id providerOwner, UIImage * (^)(JKAlertDarkModeProvider *provider, id light, id dark));

/** userInterfaceStyle */
@property (nonatomic, assign) JKAlertUserInterfaceStyle userInterfaceStyle;

/** currentSystemUserInterfaceStyle */
@property (nonatomic, assign) NSInteger currentSystemUserInterfaceStyle;
@end

@implementation JKAlertDarkModeProvider

- (void)dealloc {
    
    NSLog(@"[ClassName: %@], %d, %s", NSStringFromClass([self class]), __LINE__, __func__);
}

- (void)traitCollectionDidChange {
    
    if (@available(iOS 13.0, *)) {
        
        if (self.currentSystemUserInterfaceStyle == [UITraitCollection currentTraitCollection].userInterfaceStyle) { return; }
        
        self.currentSystemUserInterfaceStyle = [UITraitCollection currentTraitCollection].userInterfaceStyle;
    }
    
    [self executeProviderHandler];
}

- (void)executeProviderHandler {
    
    [self.handlerArray enumerateObjectsUsingBlock:^(JKAlertDarkModeProvideHandler _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj(self, self.owner, ^UIImage *(JKAlertDarkModeProvider *provider, id light, id dark) {

            return [provider checkIsDark] ? dark : light;
        });
    }];
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

- (void)addExecuteProviderHandler:(JKAlertDarkModeProvideHandler)providerHandler {
    
    if (providerHandler) {
        
        [self.handlerArray addObject:providerHandler];
        
        providerHandler(self, self.owner, ^id (JKAlertDarkModeProvider *provider, id light, id dark) {
            
            return [provider checkIsDark] ? dark : light;
        });
    }
}

+ (JKAlertDarkModeProvider *)providerWithOwner:(id <JKAlertDarkModeProviderProtocol>)owner
                               providerHandler:(JKAlertDarkModeProvideHandler)providerHandler {
    
    
    JKAlertDarkModeProvider *darkModeProvider = [JKAlertDarkModeProvider new];
    [darkModeProvider setOwner:owner];
    owner.darkModeProvider = darkModeProvider;
    [darkModeProvider addExecuteProviderHandler:providerHandler];
    
    return darkModeProvider;
}

- (void)setOwner:(id<JKAlertDarkModeProviderProtocol>)owner {
    
    _owner = owner;
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

- (NSMutableArray *)handlerArray {
    if (!_handlerArray) {
        _handlerArray = [NSMutableArray array];
    }
    return _handlerArray;
}
@end
