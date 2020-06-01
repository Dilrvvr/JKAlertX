//
//  JKAlertTextContainerView.m
//  JKAlertX
//
//  Created by albertcc on 2020/5/30.
//

#import "JKAlertTextContainerView.h"

@interface JKAlertTextContainerView ()

@end

@implementation JKAlertTextContainerView

#pragma mark
#pragma mark - Public Methods

/** 计算frame */
- (CGRect)calculateFrameWithContentWidth:(CGFloat)contentWidth
                               minHeight:(CGFloat)minHeight
                                 originY:(CGFloat)originY {
    
    CGRect rect = [self.textView calculateFrameWithMaxWidth:contentWidth minHeight:0 originY:0 superView:self];
    
    if (rect.size.height < minHeight) {
        
        rect.size.height = minHeight;
    }
    
    rect.origin.y = originY;
    
    self.frame = rect;
    
    self.textView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    return rect;
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
    
    JKAlertTextView *textView = [[JKAlertTextView alloc] init];
    textView.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:textView];
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




@end
