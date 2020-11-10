//
//  JKAlertTextView.m
//  JKAlert
//
//  Created by albert on 2018/4/7.
//  Copyright © 2018年 Albert. All rights reserved.
//

#import "JKAlertTextView.h"

@interface JKAlertTextView ()

@end

@implementation JKAlertTextView

/** 计算frame */
- (CGRect)calculateFrameWithMaxWidth:(CGFloat)maxWidth {
    
    if (self.hidden) { return CGRectZero; }
    
    CGSize size = [self sizeThatFits:CGSizeMake(maxWidth, INFINITY)];
    size.width = maxWidth;
    size.height = ceil(size.height);
    
    CGRect rect = CGRectZero;
    rect.size = size;
    
    return rect;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    
    self.backgroundColor = nil;
    self.textAlignment = NSTextAlignmentCenter;
    self.scrollsToTop = NO;
    self.editable = NO;
    self.textContainer.lineFragmentPadding = 0;
    self.textContainerInset = UIEdgeInsetsZero;
    self.showsHorizontalScrollIndicator = NO;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if (_shouldSelectText) {
        
        return [super canPerformAction:action withSender:sender];
    }
    
    [self resignFirstResponder];
    
    [UIMenuController sharedMenuController].menuVisible = NO;
    
    return NO;
}
@end
