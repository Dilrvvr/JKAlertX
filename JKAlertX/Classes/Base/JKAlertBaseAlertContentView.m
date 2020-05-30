//
//  JKAlertBaseAlertContentView.m
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseAlertContentView.h"
#import "JKAlertVisualFormatConstraintManager.h"

@interface JKAlertBaseAlertContentView ()
{
    //NSMutableArray *_actionArray;
}
/** backgroundEffectView */
@property (nonatomic, weak) UIVisualEffectView *backgroundEffectView;
@end

@implementation JKAlertBaseAlertContentView

#pragma mark
#pragma mark - Public Methods

- (void)calculateUI {
    
}

- (void)setCustomBackgroundView:(UIView *)customBackgroundView {
    
    if (_customBackgroundView) {
        
        [_customBackgroundView removeFromSuperview];
    }
    
    _customBackgroundView = customBackgroundView;
    
    if (_customBackgroundView) {
        
        self.backgroundEffectView.hidden = YES;
        
        [self.backgroundView addSubview:_customBackgroundView];
        
        [JKAlertVisualFormatConstraintManager addZeroEdgeConstraintsWithTargetView:_customBackgroundView constraintsView:self.backgroundView];
        
        return;
    }
    
    self.backgroundEffectView.hidden = NO;
}

#pragma mark
#pragma mark - Override



#pragma mark
#pragma mark - Private Methods

- (void)updateLightModetUI {
    [super updateLightModetUI];
    
    if (!self.backgroundEffectView.hidden) {
        
        [self.backgroundEffectView setEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    }
}

- (void)updateDarkModeUI {
    [super updateDarkModeUI];
    
    if (!self.backgroundEffectView.hidden) {
        
        [self.backgroundEffectView setEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    }
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
    
    UIScrollView *textScrollView = [[UIScrollView alloc] init];
    textScrollView.showsHorizontalScrollIndicator = NO;
    textScrollView.scrollsToTop = NO;
    textScrollView.scrollEnabled = NO;
    if (@available(iOS 11.0, *)) {
        textScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    if (@available(iOS 13.0, *)) {
        textScrollView.automaticallyAdjustsScrollIndicatorInsets = NO;
    }
    [self.contentView addSubview:textScrollView];
    _textScrollView = textScrollView;
    
    UIScrollView *actionScrollView = [[UIScrollView alloc] init];
    actionScrollView.showsHorizontalScrollIndicator = NO;
    actionScrollView.scrollsToTop = NO;
    actionScrollView.scrollEnabled = NO;
    if (@available(iOS 11.0, *)) {
        actionScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    if (@available(iOS 13.0, *)) {
        actionScrollView.automaticallyAdjustsScrollIndicatorInsets = NO;
    }
    [self.contentView addSubview:actionScrollView];
    _actionScrollView = actionScrollView;
}

/** 布局UI */
- (void)layoutUI {
    [super layoutUI];
    
    [JKAlertVisualFormatConstraintManager addZeroEdgeConstraintsWithTargetView:self.backgroundEffectView constraintsView:self.backgroundView];
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
}

#pragma mark
#pragma mark - Private Property



@end
