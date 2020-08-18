//
//  JKAlertHUDTextContentView.m
//  JKAlertX
//
//  Created by Albert on 2020/5/31.
//

#import "JKAlertHUDTextContentView.h"
#import "JKAlertTheme.h"

@implementation JKAlertHUDTextContentView

#pragma mark
#pragma mark - Public Methods

- (void)setDefaultDarkStyle:(BOOL)defaultDarkStyle {
    
    if (_defaultDarkStyle == defaultDarkStyle) { return; }
    
    _defaultDarkStyle = defaultDarkStyle;
    
    [self.titleTextView.textView.jkalert_themeProvider executeProvideHandlerForKey:NSStringFromSelector(@selector(textColor))];
}

#pragma mark
#pragma mark - Override



#pragma mark
#pragma mark - Private Methods



#pragma mark
#pragma mark - Private Selector



#pragma mark
#pragma mark - Custom Delegates



#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 */
- (void)initializeProperty {
    [super initializeProperty];
    
    self.titleInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    
    self.titleTextView.textView.font = [UIFont systemFontOfSize:17];
    
    _defaultDarkStyle = YES;
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
}

/** 创建UI */
- (void)createUI {
    [super createUI];
    
}

/** 布局UI */
- (void)layoutUI {
    [super layoutUI];
    
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
    [self updateTitleTextColor];
}

- (void)updateTitleTextColor {
    
    if ([self.titleTextView.textView.jkalert_themeProvider provideHandlerForKey:NSStringFromSelector(@selector(textColor))]) {
        
        __weak typeof(self) weakSelf = self;
        
        [JKAlertThemeProvider providerTextColorWithOwner:self.titleTextView.textView provideHandler:^(JKAlertThemeProvider *provider, JKAlertTextView *providerOwner) {
            
            providerOwner.textColor = JKAlertCheckDarkMode(weakSelf.defaultDarkStyle ? [UIColor whiteColor] : [UIColor blackColor], weakSelf.defaultDarkStyle ? [UIColor blackColor] : [UIColor whiteColor]);
        }];
    }
}

#pragma mark
#pragma mark - Private Property

- (NSString *)alertMessage {
    
    return nil;
}

- (NSAttributedString *)attributedMessage {
    
    return nil;
}
@end
