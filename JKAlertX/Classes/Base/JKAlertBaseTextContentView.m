//
//  JKAlertBaseTextContentView.m
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseTextContentView.h"
#import "JKAlertTextView.h"
#import "JKAlertMultiColor.h"
#import "JKAlertConst.h"

@interface JKAlertBaseTextContentView ()
{
    __weak JKAlertTextView *_titleTextView;
    __weak JKAlertTextView *_messageTextView;
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
    self.titleTextView.shouldSelectText = self.textViewShouldSelectText;
    self.titleTextView.textAlignment = self.titleTextViewAlignment;
    self.titleTextView.font = self.titleFont;
    
    self.titleTextView.text = nil;
    self.titleTextView.attributedText = nil;
    
    if (self.customContentView ||
        self.customTitleView) {
        
        self.titleTextView.hidden = YES;
        
    } else if (self.alertAttributedTitle) {
        
        self.titleTextView.hidden = NO;
        
        self.titleTextView.attributedText = self.alertAttributedTitle;
        
    } else if (self.alertTitle) {
        
        self.titleTextView.hidden = NO;
        
        self.titleTextView.text = self.alertTitle;
        
    } else {
        
        self.titleTextView.hidden = YES;
    }
    
    self.messageTextView.userInteractionEnabled = self.textViewUserInteractionEnabled;
    self.messageTextView.shouldSelectText = self.textViewShouldSelectText;
    self.messageTextView.textAlignment = self.messageTextViewAlignment;
    self.messageTextView.font = self.messageFont;
    
    self.messageTextView.text = nil;
    self.messageTextView.attributedText = nil;
    
    if (self.customContentView ||
        self.customMessageView) {
        
        self.messageTextView.hidden = YES;
        
    } else if (self.attributedMessage) {
        
        self.messageTextView.hidden = NO;
        
        self.messageTextView.attributedText = self.attributedMessage;
        
    } else if (self.alertMessage) {
        
        self.messageTextView.hidden = NO;
        
        self.messageTextView.text = self.alertMessage;
        
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
        
        frame = [self.titleTextView calculateFrameWithMaxWidth:width minHeight:self.titleMinHeight originY:originY superView:self.contentView];
        
        frame.origin.x = self.titleInsets.left + self.safeAreaInsets.left;
        
        self.titleTextView.frame = frame;
        
        rect.size.height = CGRectGetMaxY(frame) + self.titleInsets.bottom;
    }
    
    if (!self.separatorLineView.hidden) {
        
        originY = CGRectGetMaxY(rect) + self.separatorLineInsets.top;
        
        if (rect.size.height <= 0) {
            
            originY += self.safeAreaInsets.top;
        }
        
        // 分隔线不计算左右安全区域
        width = self.contentWidth - self.separatorLineInsets.left - self.separatorLineInsets.right;
        
        frame = CGRectMake(self.separatorLineInsets.left, originY, width, 0.5);
        
        self.separatorLineView.frame = frame;
        
        rect.size.height = CGRectGetMaxY(frame) + self.separatorLineInsets.bottom;
    }
    
    if (self.customMessageView) { // 自定义titleView
        
        originY = CGRectGetMaxY(rect);
        
        rect.origin.y = originY;
        
        rect.size.height = self.customMessageView.frame.size.height;
        
        self.customMessageView.frame = rect;
        
    } else if (!self.messageTextView.hidden) {
        
        originY = CGRectGetMaxY(rect) + self.messageInsets.top;
        
        if (rect.size.height <= 0) {
            
            originY += self.safeAreaInsets.top;
        }
        
        width = self.contentWidth - self.messageInsets.left - self.messageInsets.right;
        
        frame = [self.messageTextView calculateFrameWithMaxWidth:width minHeight:self.messageMinHeight originY:originY superView:self.contentView];
        
        frame.origin.x = self.messageInsets.left + self.safeAreaInsets.left;
        
        self.messageTextView.frame = frame;
        
        rect.size.height = CGRectGetMaxY(frame);
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
    
    self.titleTextView.textColor = self.titleTextColor.lightColor;
    self.messageTextView.textColor = self.messageTextColor.lightColor;
    
    self.separatorLineView.backgroundColor = self.separatorLineColor.lightColor;
}

- (void)updateDarkModeUI {
    [super updateDarkModeUI];
    
    self.titleTextView.textColor = self.titleTextColor.darkColor;
    self.messageTextView.textColor = self.messageTextColor.darkColor;
    
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
    
    _titleMinHeight = 30;
    _messageMinHeight = 30;
    _separatorLineHidden = YES;
    
    _titleInsets = UIEdgeInsetsMake(20, 20, 3.5, 20);
    _messageInsets = UIEdgeInsetsMake(3.5, 20, 20, 20);
    
    _titleTextViewAlignment = NSTextAlignmentCenter;
    _messageTextViewAlignment = NSTextAlignmentCenter;
    
    _textViewUserInteractionEnabled = YES;
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

- (JKAlertTextView *)titleTextView {
    if (!_titleTextView) {
        JKAlertTextView *titleTextView = [[JKAlertTextView alloc] init];
        titleTextView.font = [UIFont systemFontOfSize:17];
        // TODO: JKTODO <#注释#>
        titleTextView.textColor = JKAlertAdaptColor(JKAlertSameRGBColor(89.25), JKAlertSameRGBColor(165.75));
        [self.contentView addSubview:titleTextView];
        _titleTextView = titleTextView;
    }
    return _titleTextView;
}

- (JKAlertTextView *)messageTextView {
    if (!_messageTextView) {
        JKAlertTextView *messageTextView = [[JKAlertTextView alloc] init];
        messageTextView.font = [UIFont systemFontOfSize:13];
        // TODO: JKTODO <#注释#>
        messageTextView.textColor = JKAlertAdaptColor(JKAlertSameRGBColor(76.5), JKAlertSameRGBColor(178.5));
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
