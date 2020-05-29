//
//  JKAlertBaseTextContentView.m
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseTextContentView.h"
#import "JKAlertTextView.h"

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
}

- (void)setCustomTitleView:(UIView *)customTitleView {
    
    if (_customTitleView) {
        
        [_customTitleView removeFromSuperview];
    }
    
}

- (void)setCustomMessageView:(UIView *)customMessageView {
    
    if (_customMessageView) {
        
        [_customMessageView removeFromSuperview];
    }
    
}

- (void)updateTextViewProperty {
    
    self.titleTextView.userInteractionEnabled = self.textViewUserInteractionEnabled;
    self.titleTextView.shouldSelectText = self.textViewShouldSelectText;
    self.titleTextView.textAlignment = self.titleTextViewAlignment;
    self.titleTextView.textColor = self.titleTextColor;
    self.titleTextView.font = self.titleFont;
    
    self.titleTextView.text = nil;
    self.titleTextView.attributedText = nil;
    
    if (self.alertAttributedTitle) {
        
        self.titleTextView.attributedText = self.alertAttributedTitle;
        
    } else if (self.alertTitle) {
        
        self.titleTextView.text = self.alertTitle;
        
    } else {
        
        self.titleTextView.hidden = YES;
    }
    
    self.messageTextView.userInteractionEnabled = self.textViewUserInteractionEnabled;
    self.messageTextView.shouldSelectText = self.textViewShouldSelectText;
    self.messageTextView.textAlignment = self.messageTextViewAlignment;
    self.messageTextView.textColor = self.messageTextColor;
    self.messageTextView.font = self.messageFont;
    
    self.messageTextView.text = nil;
    self.messageTextView.attributedText = nil;
    
    if (self.attributedMessage) {
        
        self.messageTextView.attributedText = self.attributedMessage;
        
    } else if (self.alertMessage) {
        
        self.messageTextView.text = self.alertMessage;
        
    } else {
        
        self.messageTextView.hidden = YES;
    }
}

- (void)calculateUI {
    
    
}

#pragma mark
#pragma mark - Override

- (void)dealloc {
    
    NSLog(@"[ClassName: %@], %d, %s", NSStringFromClass([self class]), __LINE__, __func__);
}

#pragma mark
#pragma mark - Private Methods



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
        [self.contentView addSubview:titleTextView];
        _titleTextView = titleTextView;
    }
    return _titleTextView;
}

- (JKAlertTextView *)messageTextView {
    if (!_messageTextView) {
        JKAlertTextView *messageTextView = [[JKAlertTextView alloc] init];
        [self.contentView addSubview:messageTextView];
        _messageTextView = messageTextView;
    }
    return _messageTextView;
}

@end
