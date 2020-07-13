//
//  JKAlertBaseAlertContentView.m
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseAlertContentView.h"
#import "JKAlertVisualFormatConstraintManager.h"
#import "JKAlertAction.h"

@interface JKAlertBaseAlertContentView ()
{
    JKAlertAction *_cancelAction;
}
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

- (void)setCancelAction:(JKAlertAction *)cancelAction {
    
    if (!cancelAction) { return; }
    
    _cancelAction = cancelAction;
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
    
    _cornerRadius = 10;
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
    
    [JKAlertVisualFormatConstraintManager addZeroEdgeConstraintsWithTargetView:self.backgroundEffectView constraintsView:self.backgroundView];
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
    [JKAlertThemeProvider providerWithOwner:self.backgroundEffectView handlerKey:NSStringFromSelector(@selector(effect)) provideHandler:^(JKAlertThemeProvider *provider, UIVisualEffectView *providerOwner) {

        [providerOwner setEffect:JKAlertCheckDarkMode([UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight], [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark])];
    }];
}

#pragma mark
#pragma mark - Private Property

- (JKAlertScrollContentView *)topContentView {
    if (!_topContentView) {
        JKAlertScrollContentView *topContentView = [[JKAlertScrollContentView alloc] init];
        topContentView.scrollView.delegate = self;
        [self.contentView addSubview:topContentView];
        _topContentView = topContentView;
    }
    return _topContentView;
}

- (JKAlertScrollContentView *)bottomContentView {
    if (!_bottomContentView) {
        JKAlertScrollContentView *bottomContentView = [[JKAlertScrollContentView alloc] init];
        bottomContentView.scrollView.delegate = self;
        [self.contentView addSubview:bottomContentView];
        _bottomContentView = bottomContentView;
    }
    return _bottomContentView;
}

- (UIVisualEffectView *)backgroundEffectView {
    if (!_backgroundEffectView) {
        UIVisualEffectView *backgroundEffectView = [[UIVisualEffectView alloc] initWithEffect:nil];
        backgroundEffectView.clipsToBounds = YES;
        [self.backgroundView addSubview:backgroundEffectView];
        _backgroundEffectView = backgroundEffectView;
    }
    return _backgroundEffectView;
}

- (JKAlertAction *)cancelAction {
    if (!_cancelAction) {
        _cancelAction = [JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {}];
        _cancelAction.separatorLineHidden = YES;
        _cancelAction.alertView = self.alertView;
    }
    return _cancelAction;
}
@end
