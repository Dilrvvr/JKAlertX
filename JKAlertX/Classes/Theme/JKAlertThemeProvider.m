//
//  JKAlertThemeProvider.m
//  JKAlertX
//
//  Created by albert on 2020/7/7.
//

#import "JKAlertThemeProvider.h"
#import "JKAlertConst.h"
#import "NSObject+JKAlertDarkMode.h"

@interface JKAlertThemeProvider ()

/** handlerDictionary */
@property (nonatomic, strong) NSMutableDictionary *handlerDictionary;

/** handlerArray */
@property (nonatomic, strong) NSMutableArray *handlerArray;

/** userInterfaceStyle */
@property (nonatomic, assign) JKAlertUserInterfaceStyle userInterfaceStyle;

/** currentSystemUserInterfaceStyle */
@property (nonatomic, assign) NSInteger currentSystemUserInterfaceStyle;
@end

@implementation JKAlertThemeProvider

#pragma mark
#pragma mark - Public Method

/**
 * 创建一个JKAlertThemeProvider实例
 *
 * owner : JKAlertThemeProvider实例的拥有者
 *         若owner已有JKAlertThemeProvider实例，将不会创建信的实例而是将provideHandler添加至该实例
 * handlerKey : provideHandler的缓存可以，使用key可支持handler覆盖
 * provideHandler : 切换皮肤后调用的block，赋值后将会立即执行一次
 */
+ (JKAlertThemeProvider *)providerWithOwner:(id <JKAlertThemeProviderProtocol>)owner
                                 handlerKey:(NSString *)handlerKey
                             provideHandler:(JKAlertDarkModeProvideHandler)provideHandler {
    
    if (owner.themeProvider) {
        
        [owner.themeProvider addProvideHandlerForKey:handlerKey handler:provideHandler];
        
        return owner.themeProvider;
    }
    
    JKAlertThemeProvider *themeProvider = [JKAlertThemeProvider new];
    
    [themeProvider setOwner:owner];
    
    owner.themeProvider = themeProvider;
    
    [owner.themeProvider addProvideHandlerForKey:handlerKey handler:provideHandler];
    
    return themeProvider;
}

/**
 * 添加一个处理主题变更的handler
 *
 * key : handler的缓存key，使用key可支持handler覆盖
 * handler : 切换皮肤后调用的block，赋值后将会立即执行一次
 */
- (void)addProvideHandlerForKey:(NSString *)key
                        handler:(JKAlertDarkModeProvideHandler)handler {
    
    if (handler) {
        
        [self.handlerArray addObject:handler];
        
        handler(self, self.owner);
    }
}

/**
* 判断当前是否深色模式
*/
- (BOOL)checkIsDarkMode {
    
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

#pragma mark
#pragma mark - Privete Method

- (void)traitCollectionDidChange {
    
    if (@available(iOS 13.0, *)) {
        
        if (self.currentSystemUserInterfaceStyle == [UITraitCollection currentTraitCollection].userInterfaceStyle) { return; }
        
        self.currentSystemUserInterfaceStyle = [UITraitCollection currentTraitCollection].userInterfaceStyle;
    }
    
    [self executeProviderHandler];
}

- (void)executeProviderHandler {
    
    [self.handlerArray enumerateObjectsUsingBlock:^(JKAlertDarkModeProvideHandler _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj(self, self.owner);
    }];
}

- (void)setOwner:(id<JKAlertThemeProviderProtocol>)owner {
    
    _owner = owner;
}

#pragma mark
#pragma mark - Override

- (void)dealloc {
    
    NSLog(@"[ClassName: %@], %d, %s", NSStringFromClass([self class]), __LINE__, __func__);
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

#pragma mark
#pragma mark - Private Property

- (NSMutableArray *)handlerArray {
    if (!_handlerArray) {
        _handlerArray = [NSMutableArray array];
    }
    return _handlerArray;
}

- (NSMutableDictionary *)handlerDictionary {
    if (!_handlerDictionary) {
        _handlerDictionary = [NSMutableDictionary dictionary];
    }
    return _handlerDictionary;
}
@end
