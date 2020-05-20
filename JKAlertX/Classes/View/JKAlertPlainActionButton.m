//
//  JKAlertPlainActionButton.m
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertPlainActionButton.h"
#import "JKAlertConst.h"
#import "JKAlertAction.h"

@implementation JKAlertPlainActionButton

- (void)setAction:(JKAlertAction *)action {
    _action = action;
    
    if (action.customView) {
        
        [self addSubview:action.customView];
        
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
