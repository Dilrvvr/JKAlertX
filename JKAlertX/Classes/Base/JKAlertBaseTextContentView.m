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
