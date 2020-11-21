//
//  JKAlertHUDContentView.m
//  JKAlertX
//
//  Created by Albert on 2020/5/31.
//

#import "JKAlertHUDContentView.h"
#import "JKAlertTheme.h"

@interface JKAlertHUDContentView ()

@end

@implementation JKAlertHUDContentView

#pragma mark
#pragma mark - Public Methods

- (void)setCustomBackgroundView:(UIView *)customBackgroundView {
    [super setCustomBackgroundView:customBackgroundView];
    
    self.backgroundEffectView.hidden = (customBackgroundView != nil);
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    [super setCornerRadius:cornerRadius];
    
    self.layer.cornerRadius = cornerRadius;
}

- (void)setDefaultDarkStyle:(BOOL)defaultDarkStyle {
    
    if (_defaultDarkStyle == defaultDarkStyle) { return; }
    
    _defaultDarkStyle = defaultDarkStyle;
    
    [self.backgroundEffectView.jkalert_themeProvider executeProvideHandlerForKey:NSStringFromSelector(@selector(effect))];
    
    self.textContentView.defaultDarkStyle = defaultDarkStyle;
}

- (void)calculateUI {
    [super calculateUI];
    
    self.textContentView.contentWidth = self.alertWidth;
    
    [self.textContentView calculateUI];
    
    [self adjustHUDFrame];
}

#pragma mark
#pragma mark - Override



#pragma mark
#pragma mark - Private Methods

- (void)adjustHUDFrame {
    
    CGRect rect = self.textContentView.bounds;
    
    if (self.hudHeight > 0 &&
        !self.textContentView.customContentView) {
        
        rect.size.height = self.hudHeight;
        
        self.textContentView.center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    }
    
    self.frame = rect;
}

#pragma mark
#pragma mark - Private Selector



#pragma mark
#pragma mark - Custom Delegates



#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 */
- (void)initializeProperty {
    [super initializeProperty];
    
    _defaultDarkStyle = YES;
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];

}

/** 创建UI */
- (void)createUI {
    [super createUI];
    
    JKAlertHUDTextContentView *textContentView = [[JKAlertHUDTextContentView alloc] init];
    [self.contentView addSubview:textContentView];
    _textContentView = textContentView;
}

/** 布局UI */
- (void)layoutUI {
    [super layoutUI];
    
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.cornerRadius;
    
    self.backgroundEffectView.hidden = NO;
    
    self.backgroundView.backgroundColor = nil;
    
    [self.backgroundView.jkalert_themeProvider removeProvideHandlerForKey:NSStringFromSelector(@selector(backgroundColor))];
    
    __weak typeof(self) weakSelf = self;
    
    [JKAlertThemeProvider providerWithOwner:self.backgroundEffectView handlerKey:NSStringFromSelector(@selector(effect)) provideHandler:^(JKAlertThemeProvider *provider, UIVisualEffectView *providerOwner) {
        
        [providerOwner setEffect:JKAlertCheckDarkMode([UIBlurEffect effectWithStyle:(weakSelf.defaultDarkStyle ? UIBlurEffectStyleDark : UIBlurEffectStyleExtraLight)], [UIBlurEffect effectWithStyle:(weakSelf.defaultDarkStyle ? UIBlurEffectStyleExtraLight : UIBlurEffectStyleDark)])];
    }];
}

#pragma mark
#pragma mark - Private Property



@end
