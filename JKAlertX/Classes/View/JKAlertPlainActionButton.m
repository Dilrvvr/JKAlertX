//
//  JKAlertPlainActionButton.m
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertPlainActionButton.h"
#import "JKAlertConst.h"
#import "JKAlertAction.h"
#import "JKAlertVisualFormatConstraintManager.h"

@interface JKAlertPlainActionButton ()

/** customView */
@property (nonatomic, weak) UIView *customView;
@end

@implementation JKAlertPlainActionButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIView *topSeparatorLineView = [[UIView alloc] init];
        topSeparatorLineView.userInteractionEnabled = NO;
        topSeparatorLineView.hidden = YES;
        [self addSubview:topSeparatorLineView];
        _topSeparatorLineView = topSeparatorLineView;
        
        [JKAlertThemeProvider providerWithOwner:topSeparatorLineView handlerKey:NSStringFromSelector(@selector(backgroundColor)) provideHandler:^(JKAlertThemeProvider *provider, UIView *providerOwner) {
            
            providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertGlobalSeparatorLineLightColor(), JKAlertGlobalSeparatorLineDarkColor());
        }];
        
        CGFloat lineHeight = JKAlertGlobalSeparatorLineThickness();
        
        [JKAlertVisualFormatConstraintManager addConstraintsWithHorizontalFormat:@"H:|-0-[view]-0-|" verticalFormat:[NSString stringWithFormat:@"V:|-0-[view(%.2f)]", lineHeight] viewKeyName:@"view" targetView:self.topSeparatorLineView constraintsView:self];
        
        [JKAlertThemeProvider providerWithOwner:self handlerKey:NSStringFromSelector(@selector(backgroundColor)) provideHandler:^(JKAlertThemeProvider *provider, JKAlertPlainActionButton *providerOwner) {
           
            providerOwner.backgroundColor = providerOwner.highlighted ? JKAlertCheckDarkMode(JKAlertGlobalHighlightedLightBackgroundColor(), JKAlertGlobalHighlightedDarkBackgroundColor()) : nil;
        }];
    }
    return self;
}

- (void)setAction:(JKAlertAction *)action {
    _action = action;
    
    __weak typeof(self) weakSelf = self;
    [action setRefreshAppearanceHandler:^(JKAlertAction *refreshAction) {
        
        if (refreshAction != weakSelf.action) { return; }
        
        [weakSelf refreshWithAction:refreshAction];
    }];
    
    [self refreshWithAction:action];
}

- (void)refreshWithAction:(JKAlertAction *)action {
    
    self.topSeparatorLineView.hidden = action.separatorLineHidden;
    
    if (self.customView &&
        self.customView.superview == self) {
        
        [self.customView removeFromSuperview];
        self.customView = nil;
    }
    
    if (action.customView) {
        
        [self insertSubview:action.customView belowSubview:self.topSeparatorLineView];
        self.customView = action.customView;
        
        // 有customViewm，清空文字
        [self setTitle:nil forState:(UIControlStateNormal)];
        [self setAttributedTitle:nil forState:(UIControlStateNormal)];
        
        return;
    }
    
    if (action.title) {
        
        [self setTitle:action.title forState:(UIControlStateNormal)];
    }
    
    if (action.attributedTitle) {
        
        [self setAttributedTitle:action.attributedTitle forState:(UIControlStateNormal)];
    }
    
    self.titleLabel.font = action.titleFont;
    [self setTitleColor:action.titleColor forState:(UIControlStateNormal)];
    [self setTitleColor:[action.titleColor colorWithAlphaComponent:0.5] forState:(UIControlStateHighlighted)];
    
    if (action.normalImage) {
        
        [self setImage:action.normalImage forState:(UIControlStateNormal)];
    }
    
    if (action.hightlightedImage) {
        
        [self setImage:action.hightlightedImage forState:(UIControlStateHighlighted)];
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    self.backgroundColor = highlighted ? JKAlertCheckDarkMode(JKAlertGlobalHighlightedLightBackgroundColor(), JKAlertGlobalHighlightedDarkBackgroundColor()) : nil;
    
    if (self.action.customView) {
        
        self.action.customView.alpha = highlighted ? 0.5 : 1;
    }
}

@end
