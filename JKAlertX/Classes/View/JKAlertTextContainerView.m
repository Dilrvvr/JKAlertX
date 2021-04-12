//
//  JKAlertTextContainerView.m
//  JKAlertX
//
//  Created by Albert on 2020/5/30.
//

#import "JKAlertTextContainerView.h"

@interface JKAlertTextContainerView ()

@end

@implementation JKAlertTextContainerView

#pragma mark
#pragma mark - Public Methods

/** 计算frame */
- (CGRect)calculateFrameWithContentWidth:(CGFloat)contentWidth
                               minHeight:(CGFloat)minHeight {
    
    CGRect rect = [self.textView calculateFrameWithMaxWidth:contentWidth];
    
    self.textView.frame = rect;
    
    if (rect.size.height < minHeight) {
        
        rect.size.height = minHeight;
    }
    
    return rect;
}

#pragma mark
#pragma mark - Override

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textView.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

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
    
    JKAlertTextView *textView = [[JKAlertTextView alloc] init];
    textView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:textView];
    _textView = textView;
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

- (BOOL)autoAddBasicViews {
    
    return NO;
}

- (UIView *)backgroundView {
    
    return nil;
}

- (UIView *)contentView {
    
    return nil;
}
@end
