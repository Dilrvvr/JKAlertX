//
//  JKAlertPlainActionButton.m
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertPlainActionButton.h"
#import "JKAlertUtility.h"
#import "JKAlertAction.h"
#import "JKAlertConstraintManager.h"
#import "JKAlertTheme.h"

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
        
        [JKAlertThemeProvider providerBackgroundColorWithOwner:topSeparatorLineView provideHandler:^(JKAlertThemeProvider *provider, UIView *providerOwner) {
            
            providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertUtility.separatorLineLightColor, JKAlertUtility.separatorLineDarkColor);
        }];
        
        CGFloat lineHeight = JKAlertUtility.separatorLineThickness;
        
        [JKAlertConstraintManager addConstraintsWithHorizontalFormat:@"H:|-0-[view]-0-|" verticalFormat:[NSString stringWithFormat:@"V:|-0-[view(%.2f)]", lineHeight] viewKeyName:@"view" targetView:self.topSeparatorLineView constraintsView:self];
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
    
    [self updateBackgroundColor];
    
    self.topSeparatorLineView.hidden = action.separatorLineHidden;
    
    if (self.customView &&
        self.customView.superview == self) {
        
        [self.customView removeFromSuperview];
        self.customView = nil;
    }
    
    if (action.customView) {
        
        [self insertSubview:action.customView belowSubview:self.topSeparatorLineView];
        self.customView = action.customView;
        
        // 有customView，清空文字
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
    
    [self updateBackgroundColor];
    
    if (self.action.customView) {
        
        self.action.customView.alpha = highlighted ? 0.5 : 1;
    }
}

- (void)updateBackgroundColor {
    
    self.backgroundColor = self.highlighted ? self.action.seletedBackgroundColor : self.action.backgroundColor;
}
@end
