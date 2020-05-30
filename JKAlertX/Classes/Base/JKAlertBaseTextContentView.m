//
//  JKAlertBaseTextContentView.m
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseTextContentView.h"
#import "JKAlertTextContainerView.h"
#import "JKAlertMultiColor.h"
#import "JKAlertConst.h"

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
    
    if (_customContentView) {
        
        [_customContentView removeFromSuperview];
    }
    
    _customContentView = customContentView;
    
    [self.contentView addSubview:_customContentView];
    
    self.titleTextView.hidden = YES;
    self.messageTextView.hidden = YES;
}

- (void)setCustomTitleView:(UIView *)customTitleView {
    
    if (_customTitleView) {
        
        [_customTitleView removeFromSuperview];
    }
    
    _customTitleView = customTitleView;
    
    [self.contentView addSubview:_customTitleView];
    
    self.titleTextView.hidden = YES;
}

- (void)setCustomMessageView:(UIView *)customMessageView {
    
    if (_customMessageView) {
        
        [_customMessageView removeFromSuperview];
    }
    
    _customMessageView = customMessageView;
    
    [self.contentView addSubview:_customMessageView];
    
    self.messageTextView.hidden = YES;
}

- (void)updateTextViewProperty {
    
    self.titleTextView.userInteractionEnabled = self.textViewUserInteractionEnabled;
    self.titleTextView.textView.shouldSelectText = self.textViewShouldSelectText;
    self.titleTextView.textView.textAlignment = self.titleTextViewAlignment;
    self.titleTextView.textView.font = self.titleFont;
    
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
    
    self.messageTextView.userInteractionEnabled = self.textViewUserInteractionEnabled;
    self.messageTextView.textView.shouldSelectText = self.textViewShouldSelectText;
    self.messageTextView.textView.textAlignment = self.messageTextViewAlignment;
    self.messageTextView.textView.font = self.messageFont;
    
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
    
    CGRect frame = CGRectZero;
    
    CGFloat originY = 0;
    CGFloat width = 0;
    
    BOOL noCustom = (!self.customContentView && !self.customTitleView && !self.customMessageView);
    
    CGFloat minHeight = 0;
    
    if (self.customContentView) {
        
        rect.size.height = self.customContentView.frame.size.height;
        
        self.customContentView.frame = rect;
        
        self.frame = rect;
        
        return;
    }
    
    if (self.customTitleView) { // 自定义titleView
        
        rect.size.height = self.customTitleView.frame.size.height;
        
        self.customTitleView.frame = rect;
        
    } else if (!self.titleTextView.hidden) {
        
        originY = self.titleInsets.top + self.safeAreaInsets.top;
        
        width = self.contentWidth - self.titleInsets.left - self.titleInsets.right - self.safeAreaInsets.left - self.safeAreaInsets.right;
        
        minHeight = (noCustom && self.messageTextView.hidden) ? self.singleMinHeight : self.titleMinHeight;
        
        frame = [self.titleTextView calculateFrameWithContentWidth:width minHeight:minHeight originY:originY];
        
        frame.origin.x = self.titleInsets.left + self.safeAreaInsets.left;
        
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
            
            originY += self.safeAreaInsets.top;
        }
        
        // 分隔线不计算左右安全区域
        width = self.contentWidth - self.separatorLineInsets.left - self.separatorLineInsets.right;
        
        frame = CGRectMake(self.separatorLineInsets.left, originY, width, self.separatorLineHeight);
        
        self.separatorLineView.frame = frame;
        
        rect.size.height = CGRectGetMaxY(frame) + self.separatorLineInsets.bottom;
    }
    
    if (self.customMessageView) { // 自定义titleView
        
        originY = CGRectGetMaxY(rect);
        
        rect.origin.y = originY;
        
        rect.size.height = self.customMessageView.frame.size.height;
        
        self.customMessageView.frame = rect;
        
    } else if (!self.messageTextView.hidden) {
        
        if (self.titleTextView.hidden) {
            
            originY = CGRectGetMaxY(rect) + self.titleInsets.top;
            
        } else {
            
            originY = CGRectGetMaxY(rect) + self.messageInsets.top;
        }
        
        if (rect.size.height <= 0) {
            
            originY += self.safeAreaInsets.top;
        }
        
        width = self.contentWidth - self.messageInsets.left - self.messageInsets.right;
        
        minHeight = (noCustom && self.titleTextView.hidden) ? self.singleMinHeight : self.messageMinHeight;
        
        frame = [self.messageTextView calculateFrameWithContentWidth:width minHeight:minHeight originY:originY];
        
        frame.origin.x = self.messageInsets.left + self.safeAreaInsets.left;
        
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
}

#pragma mark
#pragma mark - Override

- (void)dealloc {
    
    NSLog(@"[ClassName: %@], %d, %s", NSStringFromClass([self class]), __LINE__, __func__);
}

#pragma mark
#pragma mark - Private Methods

- (void)updateLightModetUI {
    [super updateLightModetUI];
    
    self.titleTextView.textView.textColor = self.titleTextColor.lightColor;
    self.messageTextView.textView.textColor = self.messageTextColor.lightColor;
    
    self.separatorLineView.backgroundColor = self.separatorLineColor.lightColor;
}

- (void)updateDarkModeUI {
    [super updateDarkModeUI];
    
    self.titleTextView.textView.textColor = self.titleTextColor.darkColor;
    self.messageTextView.textView.textColor = self.messageTextColor.darkColor;
    
    self.separatorLineView.backgroundColor = self.separatorLineColor.darkColor;
}

#pragma mark
#pragma mark - Private Selector



#pragma mark
#pragma mark - UITableViewDataSource & UITableViewDelegate



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
    
    _titleFont = [UIFont systemFontOfSize:17];
    _messageFont = [UIFont systemFontOfSize:13];
    
    _titleTextColor = [JKAlertMultiColor colorWithLightColor:JKAlertSameRGBColor(89.25) darkColor:JKAlertSameRGBColor(165.75)];
    _messageTextColor = [JKAlertMultiColor colorWithLightColor:JKAlertSameRGBColor(76.5) darkColor:JKAlertSameRGBColor(178.5)];
    
    _titleTextViewAlignment = NSTextAlignmentCenter;
    _messageTextViewAlignment = NSTextAlignmentCenter;
    
    _textViewUserInteractionEnabled = YES;
    
    _singleMinHeight = 30;
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
    
}

#pragma mark
#pragma mark - Private Property

- (JKAlertTextContainerView *)titleTextView {
    if (!_titleTextView) {
        JKAlertTextContainerView *titleTextView = [[JKAlertTextContainerView alloc] init];
        [self.contentView addSubview:titleTextView];
        _titleTextView = titleTextView;
    }
    return _titleTextView;
}

- (JKAlertTextContainerView *)messageTextView {
    if (!_messageTextView) {
        JKAlertTextContainerView *messageTextView = [[JKAlertTextContainerView alloc] init];
        [self.contentView addSubview:messageTextView];
        _messageTextView = messageTextView;
    }
    return _messageTextView;
}

- (UIView *)separatorLineView {
    if (!_separatorLineView) {
        UIView *separatorLineView = [[UIView alloc] init];
        separatorLineView.hidden = YES;
        [self.contentView addSubview:separatorLineView];
        _separatorLineView = separatorLineView;
    }
    return _separatorLineView;
}
@end
