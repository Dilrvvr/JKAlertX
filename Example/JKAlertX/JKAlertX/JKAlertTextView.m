//
//  JKAlertTextView.m
//  JKAlert
//
//  Created by albert on 2018/4/7.
//  Copyright © 2018年 安永博. All rights reserved.
//

#import "JKAlertTextView.h"

@interface JKAlertTextView ()

/** 是否可以成为第一响应者 */
@property (nonatomic, assign) BOOL canBecomeFirst;
@end

@implementation JKAlertTextView

/** 计算frame */
- (CGRect)calculateFrameWithMaxWidth:(CGFloat)maxWidth minHeight:(CGFloat)minHeight originY:(CGFloat)originY superView:(UIView *)superView{
    
    if (self.hidden) {
        return CGRectZero;
    }
    
    CGRect rect = self.frame;
    rect.origin.y = originY;
    rect.size = [self sizeThatFits:CGSizeMake(maxWidth, INFINITY)];
    
    rect.size.width = maxWidth;
    rect.size.height = ceil(rect.size.height);
    
    if (rect.size.height < minHeight) {
        
        self.textContainerInset = UIEdgeInsetsMake((minHeight - rect.size.height) * 0.5, 0, 0, 0);
        rect.size.height = minHeight;
    }
    
    self.frame = rect;
    
    CGPoint center = self.center;
    center.x = superView.frame.size.width * 0.5;
    self.center = center;
    
    return rect;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
    }
    return self;
}

- (void)initialization{
    
    self.backgroundColor = nil;
    self.textAlignment = NSTextAlignmentCenter;
    self.scrollsToTop = NO;
    self.editable = NO;
    self.textContainer.lineFragmentPadding = 0;
    self.textContainerInset = UIEdgeInsetsZero;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if (_canSelectText) {
        
        return [super canPerformAction:action withSender:sender];
    }
    
    [self resignFirstResponder];
    
    [UIMenuController sharedMenuController].menuVisible = NO;
    
    return NO;
}
@end
