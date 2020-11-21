//
//  JKAlertBaseAlertContentView.m
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseAlertContentView.h"
#import "JKAlertConstraintManager.h"
#import "JKAlertAction.h"
#import "JKAlertTheme.h"

@interface JKAlertBaseAlertContentView ()
{
    JKAlertAction *_cancelAction;
}
@end

@implementation JKAlertBaseAlertContentView

#pragma mark
#pragma mark - Public Methods

- (void)calculateUI {
    
    if (_cancelAction && !_cancelAction.alertView) {
        
        _cancelAction.alertView = (JKAlertView *)self.delegate;
    }
}

- (void)setCustomBackgroundView:(UIView *)customBackgroundView {
    
    if (_customBackgroundView) {
        
        [_customBackgroundView removeFromSuperview];
    }
    
    _customBackgroundView = customBackgroundView;
    
    if (_customBackgroundView) {
        
        [self.backgroundView addSubview:_customBackgroundView];
        
        [JKAlertConstraintManager addZeroEdgeConstraintsWithTargetView:_customBackgroundView constraintsView:self.backgroundView];
        
        return;
    }
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
    
    [JKAlertConstraintManager addZeroEdgeConstraintsWithTargetView:self.backgroundEffectView constraintsView:self.backgroundView];
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
    [self restoreAlertBackgroundColor];
}

- (void)restoreAlertBackgroundColor {
    
    [JKAlertThemeProvider providerBackgroundColorWithOwner:self.backgroundView provideHandler:^(JKAlertThemeProvider *provider, UIView *providerOwner) {
        
        providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertUtility.globalLightBackgroundColor, JKAlertUtility.globalDarkBackgroundColor);
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
        backgroundEffectView.hidden = YES;
        backgroundEffectView.clipsToBounds = YES;
        [self.backgroundView addSubview:backgroundEffectView];
        _backgroundEffectView = backgroundEffectView;
    }
    return _backgroundEffectView;
}

- (NSMutableArray *)actionArray {
    if (!_actionArray) {
        _actionArray = [NSMutableArray array];
    }
    return _actionArray;
}

- (JKAlertAction *)cancelAction {
    if (!_cancelAction) {
        _cancelAction = [JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {}];
        _cancelAction.separatorLineHidden = YES;
        
        _cancelAction.alertView = (JKAlertView *)self.delegate;
    }
    return _cancelAction;
}
@end
