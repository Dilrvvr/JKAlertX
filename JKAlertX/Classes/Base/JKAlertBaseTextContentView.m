//
//  JKAlertBaseTextContentView.m
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseTextContentView.h"
#import "JKAlertUtility.h"
#import "JKAlertTheme.h"

@interface JKAlertBaseTextContentView ()
{
    __weak JKAlertTextContainerView *_titleTextView;
    __weak JKAlertTextContainerView *_messageTextView;
}
@end

@implementation JKAlertBaseTextContentView

#pragma mark
#pragma mark - Public Methods

- (void)setCustomContentView:(UIView *)customContentView {
    
    if (_customContentView &&
        _customContentView.superview == self) {
        
        [_customContentView removeFromSuperview];
    }
    
    if (customContentView) {
        
        [self addSubview:customContentView];
    }
    
    _customContentView = customContentView;
    
    self.customTitleView.hidden = (_customContentView != nil);
    self.customMessageView.hidden = self.customTitleView.hidden;
    
    self.titleTextView.hidden = YES;
    self.messageTextView.hidden = YES;
}

- (void)setCustomTitleView:(UIView *)customTitleView {
    
    if (_customTitleView) {
        
        [_customTitleView removeFromSuperview];
    }
    
    _customTitleView = customTitleView;
    
    if (self.customContentView) {
        
        _customTitleView.hidden = YES;
    }
    
    [self addSubview:_customTitleView];
    
    self.titleTextView.hidden = YES;
}

- (void)setCustomMessageView:(UIView *)customMessageView {
    
    if (_customMessageView) {
        
        [_customMessageView removeFromSuperview];
    }
    
    if (self.customContentView) {
        
        _customMessageView.hidden = YES;
    }
    
    _customMessageView = customMessageView;
    
    [self addSubview:_customMessageView];
    
    self.messageTextView.hidden = YES;
}

- (void)updateTextViewProperty {
    
    self.titleTextView.textView.text = nil;
    self.titleTextView.textView.attributedText = nil;
    
    if (self.customContentView ||
        self.customTitleView) {
        
        self.titleTextView.hidden = YES;
        
    } else if (self.alertAttributedTitle) {
        
        self.titleTextView.hidden = NO;
        
        self.titleTextView.textView.attributedText = self.alertAttributedTitle;
        
    } else if (self.alertTitle) {
        
        self.titleTextView.hidden = NO;
        
        self.titleTextView.textView.text = self.alertTitle;
        
    } else {
        
        self.titleTextView.hidden = YES;
    }
    
    self.messageTextView.textView.text = nil;
    self.messageTextView.textView.attributedText = nil;
    
    if (self.customContentView ||
        self.customMessageView) {
        
        self.messageTextView.hidden = YES;
        
    } else if (self.attributedMessage) {
        
        self.messageTextView.hidden = NO;
        
        self.messageTextView.textView.attributedText = self.attributedMessage;
        
    } else if (self.alertMessage) {
        
        self.messageTextView.hidden = NO;
        
        self.messageTextView.textView.text = self.alertMessage;
        
    } else {
        
        self.messageTextView.hidden = YES;
    }
    
    self.separatorLineView.hidden = self.separatorLineHidden;
}

- (void)calculateUI {
    
    [self updateTextViewProperty];
    
    CGRect rect = CGRectMake(0, 0, self.contentWidth, 0);
    
    CGRect frame = CGRectMake(0, 0, self.contentWidth, 0);
    
    CGFloat originY = 0;
    CGFloat width = 0;
    
    BOOL noCustom = (!self.customContentView && !self.customTitleView && !self.customMessageView);
    
    CGFloat minHeight = 0;
    
    if (self.customContentView) {
        
        self.separatorLineView.hidden = YES;
        
        rect.size.width = self.contentWidth;
        rect.size.height = self.customContentView.frame.size.height;
        
        self.customContentView.frame = rect;
        
        self.frame = rect;
        
        self.hidden = self.frame.size.height <= 0;
        
        return;
    }
    
    if (self.customTitleView) { // 自定义titleView
        
        frame.size.height = self.customTitleView.frame.size.height;
        
        self.customTitleView.frame = frame;
        
        rect.size.height = CGRectGetMaxY(frame);
        
    } else if (!self.titleTextView.hidden) {
        
        originY = self.titleInsets.top + self.screenSafeInsets.top;
        
        width = self.contentWidth - self.titleInsets.left - self.titleInsets.right - self.screenSafeInsets.left - self.screenSafeInsets.right;
        
        minHeight = (noCustom && self.messageTextView.hidden) ? self.singleMinHeight : self.titleMinHeight;
        
        frame = [self.titleTextView calculateFrameWithContentWidth:width minHeight:minHeight];
        
        frame.origin.x = self.titleInsets.left + self.screenSafeInsets.left;
        frame.origin.y = originY;
        
        self.titleTextView.frame = frame;
        
        if (self.messageTextView.hidden) {
            
            rect.size.height = CGRectGetMaxY(frame) + self.messageInsets.bottom;
            
        } else {
            
            rect.size.height = CGRectGetMaxY(frame) + self.titleInsets.bottom;
        }
    }
    
    if (!self.separatorLineView.hidden) {
        
        originY = CGRectGetMaxY(rect) + self.separatorLineInsets.top;
        
        if (rect.size.height <= 0) {
            
            originY += self.screenSafeInsets.top;
        }
        
        // 分隔线不计算左右安全区域
        width = self.contentWidth - self.separatorLineInsets.left - self.separatorLineInsets.right;
        
        frame = CGRectMake(self.separatorLineInsets.left, originY, width, JKAlertUtility.separatorLineThickness);
        
        self.separatorLineView.frame = frame;
        
        rect.size.height = CGRectGetMaxY(frame) + self.separatorLineInsets.bottom;
        
        [self bringSubviewToFront:self.separatorLineView];
    }
    
    if (self.customMessageView) { // 自定义titleView
        
        originY = CGRectGetMaxY(rect);
        
        frame.origin.x = 0;
        frame.origin.y = originY;
        frame.size.width = self.contentWidth;
        frame.size.height = self.customMessageView.frame.size.height;
        
        self.customMessageView.frame = frame;
        
        rect.size.height = CGRectGetMaxY(frame);
        
    } else if (!self.messageTextView.hidden) {
        
        if (self.titleTextView.hidden) {
            
            originY = CGRectGetMaxY(rect) + self.titleInsets.top;
            
        } else {
            
            originY = CGRectGetMaxY(rect) + self.messageInsets.top;
        }
        
        if (rect.size.height <= 0) {
            
            originY += self.screenSafeInsets.top;
        }
        
        width = self.contentWidth - self.messageInsets.left - self.messageInsets.right - self.screenSafeInsets.left - self.screenSafeInsets.right;
        
        minHeight = (noCustom && self.titleTextView.hidden) ? self.singleMinHeight : self.messageMinHeight;
        
        frame = [self.messageTextView calculateFrameWithContentWidth:width minHeight:minHeight];
        
        frame.origin.x = self.messageInsets.left + self.screenSafeInsets.left;
        frame.origin.y = originY;
        
        self.messageTextView.frame = frame;
        
        rect.size.height = CGRectGetMaxY(frame) + self.messageInsets.bottom;
        
        CGFloat delta = self.messageMinHeight - self.messageTextView.frame.size.height;
        
        if (delta > 0) {
            
            rect.size.height += delta;
            
            frame.origin.y += (delta * 0.5);
            
            self.messageTextView.frame = frame;
        }
    }
    
    self.frame = rect;
    
    self.hidden = self.frame.size.height <= 0;
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
    
    _separatorLineHidden = YES;
    
    _titleInsets = UIEdgeInsetsMake(20, 20, 3.5, 20);
    _messageInsets = UIEdgeInsetsMake(3.5, 20, 20, 20);
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
    
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
    [JKAlertThemeProvider providerTextColorWithOwner:self.titleTextView.textView provideHandler:^(JKAlertThemeProvider *provider, JKAlertTextView *providerOwner) {
        
        providerOwner.textColor = JKAlertCheckDarkMode(JKAlertSameRGBColor(25.5), JKAlertSameRGBColor(229.5));
    }];
    
    [JKAlertThemeProvider providerTextColorWithOwner:self.messageTextView.textView provideHandler:^(JKAlertThemeProvider *provider, JKAlertTextView *providerOwner) {
        
        providerOwner.textColor = JKAlertCheckDarkMode(JKAlertSameRGBColor(53), JKAlertSameRGBColor(202));
    }];
}

#pragma mark
#pragma mark - Private Property

- (BOOL)autoAddBasicViews {
    
    return NO;
}

- (UIView *)backgroundView {
    
    return nil;
}

- (UIView *)contentView {
    
    return nil;
}

- (JKAlertTextContainerView *)titleTextView {
    if (!_titleTextView) {
        JKAlertTextContainerView *titleTextView = [[JKAlertTextContainerView alloc] init];
        titleTextView.textView.font = [UIFont systemFontOfSize:17];
        [self addSubview:titleTextView];
        _titleTextView = titleTextView;
    }
    return _titleTextView;
}

- (JKAlertTextContainerView *)messageTextView {
    if (!_messageTextView) {
        JKAlertTextContainerView *messageTextView = [[JKAlertTextContainerView alloc] init];
        messageTextView.textView.font = [UIFont systemFontOfSize:13];
        [self addSubview:messageTextView];
        _messageTextView = messageTextView;
    }
    return _messageTextView;
}

- (UIView *)separatorLineView {
    if (!_separatorLineView) {
        UIView *separatorLineView = [[UIView alloc] init];
        separatorLineView.userInteractionEnabled = NO;
        separatorLineView.hidden = YES;
        [self addSubview:separatorLineView];
        _separatorLineView = separatorLineView;
        
        [JKAlertThemeProvider providerBackgroundColorWithOwner:separatorLineView provideHandler:^(JKAlertThemeProvider *provider, UIView *providerOwner) {
            
            providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertUtility.separatorLineLightColor, JKAlertUtility.separatorLineDarkColor);
        }];
    }
    return _separatorLineView;
}
@end
