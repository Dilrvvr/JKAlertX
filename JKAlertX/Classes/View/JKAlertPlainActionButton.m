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

@implementation JKAlertPlainActionButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIView *topSeparatorLineView = [[UIView alloc] init];
        topSeparatorLineView.hidden = YES;
        // TODO: JKTODO <#注释#>
        topSeparatorLineView.backgroundColor = JKAlertGlobalSeparatorLineColor();
        [self addSubview:topSeparatorLineView];
        _topSeparatorLineView = topSeparatorLineView;
        
        CGFloat lineHeight = JKAlertGlobalSeparatorLineThickness();
        
        [JKAlertVisualFormatConstraintManager addConstraintsWithHorizontalFormat:@"H:|-0-[view]-0-|" verticalFormat:[NSString stringWithFormat:@"V:|-0-[view(%.2f)]", lineHeight] viewKeyName:@"view" targetView:self.topSeparatorLineView constraintsView:self];
    }
    return self;
}

- (void)setAction:(JKAlertAction *)action {
    _action = action;
    
    self.topSeparatorLineView.hidden = action.separatorLineHidden;
    
    if (action.customView) {
        
        [self insertSubview:action.customView belowSubview:self.topSeparatorLineView];
        
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
    
    self.backgroundColor = highlighted ? JKAlertGlobalHighlightedBackgroundColor() : nil;
}

@end
