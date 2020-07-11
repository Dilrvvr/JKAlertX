//
//  JKAlertThemeProvider.m
//  JKAlertX
//
//  Created by albert on 2020/7/7.
//

#import "JKAlertThemeProvider.h"
#import "JKAlertThemeManager.h"

@interface JKAlertThemeProvider ()

/** handlerDictionary */
@property (nonatomic, strong) NSMutableDictionary *handlerDictionary;

/** handlerArray */
@property (nonatomic, strong) NSMutableArray *handlerArray;
@end

@implementation JKAlertThemeProvider

+ (void)initialize {
    
    [JKAlertThemeManager sharedManager];
}

#pragma mark
#pragma mark - Public Method

/**
 * 创建一个JKAlertThemeProvider实例
 *
 * owner : JKAlertThemeProvider实例的拥有者
 *         若owner已有JKAlertThemeProvider实例，将不会创建新的实例而是将provideHandler添加至该实例
 * handlerKey : provideHandler的缓存可以，使用key可支持handler覆盖
 * provideHandler : 切换皮肤后调用的block，赋值后将会立即执行一次
 */
+ (JKAlertThemeProvider *)providerWithOwner:(id <JKAlertThemeProviderProtocol>)owner
                                 handlerKey:(NSString *)handlerKey
                             provideHandler:(JKAlertThemeProvideHandler)provideHandler {
    
    if (owner.jkalert_themeProvider) {
        
        [owner.jkalert_themeProvider addProvideHandlerForKey:handlerKey handler:provideHandler];
        
        return owner.jkalert_themeProvider;
    }
    
    if (![owner conformsToProtocol:@protocol(JKAlertThemeProviderProtocol)]) {
        
        return nil;
    }
    
    JKAlertThemeProvider *themeProvider = [JKAlertThemeProvider new];
    
    [themeProvider setOwner:owner];
    
    owner.jkalert_themeProvider = themeProvider;
    
    [owner.jkalert_themeProvider addProvideHandlerForKey:handlerKey handler:provideHandler];
    
    return themeProvider;
}

/**
 * 添加一个处理主题变更的handler
 *
 * key : handler的缓存key，使用key可支持handler覆盖
 * handler : 切换皮肤后调用的block，赋值后将会立即执行一次
 */
- (void)addProvideHandlerForKey:(NSString *)key
                        handler:(JKAlertThemeProvideHandler)handler {
    
    if (handler) {
        
        [self.handlerArray addObject:handler];
        
        handler(self, self.owner);
    }
}

/**
 * 根据key移除handler
 */
- (void)removeProvideHandlerForKey:(NSString *)key {
    
    if (!key) { return; }
    
    if (![self.handlerDictionary objectForKey:key]) { return; }
    
    [self.handlerDictionary removeObjectForKey:key];
}

/**
 * 移除所有handler
 */
- (void)clearAllProvideHandler {
    
    [self.handlerDictionary removeAllObjects];
    
    [self.handlerArray removeAllObjects];
}

#pragma mark
#pragma mark - Privete Method

- (void)themeDidChangeNotification:(NSNotification *)note {
    
    [self executeProviderHandler];
}

- (void)executeProviderHandler {
    
    [self.handlerArray enumerateObjectsUsingBlock:^(JKAlertThemeProvideHandler _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj(self, self.owner);
    }];
    
    [self.handlerDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, JKAlertThemeProvideHandler  _Nonnull obj, BOOL * _Nonnull stop) {
        
        obj(self, self.owner);
    }];
}

- (void)setOwner:(id<JKAlertThemeProviderProtocol>)owner {
    
    _owner = owner;
}

#pragma mark
#pragma mark - Override

- (void)dealloc {
    
    // TODO: JKTODO delete
    
    NSLog(@"[ClassName: %@], %d, %s", NSStringFromClass([self class]), __LINE__, __func__);
}

- (instancetype)init {
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeNotification:) name:JKAlertThemeDidChangeNotification object:nil];
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
