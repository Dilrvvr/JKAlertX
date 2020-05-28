//
//  JKAlertBaseAlertContentView.m
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseAlertContentView.h"

@interface JKAlertBaseAlertContentView ()

/** backgroundEffectView */
@property (nonatomic, weak) UIVisualEffectView *backgroundEffectView;
@end

@implementation JKAlertBaseAlertContentView

#pragma mark
#pragma mark - Public Methods



#pragma mark
#pragma mark - Override



#pragma mark
#pragma mark - Private Methods

- (void)updateLightModetUI {
    [super updateLightModetUI];
    
    [self.backgroundEffectView setEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
}

- (void)updateDarkModeUI {
    [super updateDarkModeUI];
    
    [self.backgroundEffectView setEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
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
    
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
}

/** 创建UI */
- (void)createUI {
    [super createUI];
    
    BOOL isLight = YES;
    
    if (@available(iOS 13.0, *)) {
        
        isLight = ([self.traitCollection userInterfaceStyle] == UIUserInterfaceStyleLight);
    }
    
    UIVisualEffectView *backgroundEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:isLight ? UIBlurEffectStyleExtraLight : UIBlurEffectStyleDark]];
    backgroundEffectView.clipsToBounds = YES;
    [self.backgroundView addSubview:backgroundEffectView];
    _backgroundEffectView = backgroundEffectView;
}

/** 布局UI */
- (void)layoutUI {
    [super layoutUI];
    
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
}

#pragma mark
#pragma mark - Private Property



@end
