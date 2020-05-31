//
//  JKAlertHUDContentView.m
//  JKAlertX
//
//  Created by albertcc on 2020/5/31.
//

#import "JKAlertHUDContentView.h"

@interface JKAlertHUDContentView ()

@end

@implementation JKAlertHUDContentView

#pragma mark
#pragma mark - Public Methods

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    
    self.layer.cornerRadius = cornerRadius;
}

- (void)calculateUI {
    
    self.textContentView.contentWidth = self.contentWidth;
    
    [self.textContentView calculateUI];
    
    [self adjustHUDFrame];
}

#pragma mark
#pragma mark - Override

- (void)dealloc {
    
    NSLog(@"[ClassName: %@], %d, %s", NSStringFromClass([self class]), __LINE__, __func__);
}

#pragma mark
#pragma mark - Private Methods

- (void)adjustHUDFrame {
    
    self.frame = self.textContentView.bounds;
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
    
    _cornerRadius = 8;
    
    self.darkBlurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    
    self.lightBlurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
}

/** 创建UI */
- (void)createUI {
    [super createUI];
    
    JKAlertHUDTextContentView *textContentView = [[JKAlertHUDTextContentView alloc] init];
    [self.contentView addSubview:textContentView];
    _textContentView = textContentView;
}

/** 布局UI */
- (void)layoutUI {
    [super layoutUI];
    
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.cornerRadius;
}

#pragma mark
#pragma mark - Private Property




@end
