//
//  JKAlertPlainTextContentView.m
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertPlainTextContentView.h"
#import "JKAlertTextContainerView.h"

@implementation JKAlertPlainTextContentView

#pragma mark
#pragma mark - Public Methods



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
    
    self.titleTextView.textView.font = [UIFont boldSystemFontOfSize:17];
    self.messageTextView.textView.font = [UIFont systemFontOfSize:14];
}

#pragma mark
#pragma mark - Private Property




@end
