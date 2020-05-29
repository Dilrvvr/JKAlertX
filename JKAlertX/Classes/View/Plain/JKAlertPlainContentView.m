//
//  JKAlertPlainContentView.m
//  JKAlertX
//
//  Created by albert on 2020/5/29.
//

#import "JKAlertPlainContentView.h"
#import "JKAlertPlainActionButton.h"
#import "JKAlertAction.h"
#import "JKAlertConst.h"

@interface JKAlertPlainContentView ()

/** actionContainerView */
@property (nonatomic, weak) UIView *actionContainerView;

/** horizontalSeparatorLineView */
@property (nonatomic, weak) UIView *horizontalSeparatorLineView;

/** verticalSeparatorLineView */
@property (nonatomic, weak) UIView *verticalSeparatorLineView;
@end

@implementation JKAlertPlainContentView

#pragma mark
#pragma mark - Public Methods

- (void)calculateUI {
    
    self.textContentView.contentWidth = self.contentWidth;
    self.textContentView.separatorLineHeight = self.separatorLineWH;
    
    [self.textContentView calculateUI];
    
    [self layoutPlainButtons];
    
    [self adjustPlainFrame];
}

#pragma mark
#pragma mark - Override

- (void)dealloc {
    
    NSLog(@"[ClassName: %@], %d, %s", NSStringFromClass([self class]), __LINE__, __func__);
}

#pragma mark
#pragma mark - Private Methods

- (void)adjustPlainFrame {
    
    CGRect frame = CGRectZero;
    
    // 总高度未超过最大高度
    if (self.maxHeight <= 0 ||
        self.textContentView.frame.size.height + self.actionContainerView.frame.size.height <= self.maxHeight) {
        
        frame = self.textContentView.bounds;
        self.textScrollView.frame = frame;
        
        frame = self.actionContainerView.bounds;
        frame.origin.y = CGRectGetMaxY(self.textScrollView.frame);
        self.actionScrollView.frame = frame;
        
        self.textScrollView.scrollEnabled = NO;
        self.actionScrollView.scrollEnabled = NO;
        
        return;
    }
    
    CGFloat halfHeight = self.maxHeight * 0.5;
    
    if (self.textContentView.frame.size.height > halfHeight) {
        
        self.textScrollView.frame = CGRectMake(0, 0, self.contentWidth, halfHeight);
        
        self.textScrollView.scrollEnabled = YES;
        
        self.textScrollView.contentSize = CGSizeMake(0, self.textContentView.frame.size.height);
    }
    
    if (self.actionContainerView.frame.size.height > halfHeight) {
        
        self.actionScrollView.scrollEnabled = YES;
        
        self.actionScrollView.contentSize = CGSizeMake(0, self.actionContainerView.frame.size.height);
    }
}

- (void)layoutPlainButtons {
    
    NSInteger actionsCount = self.actionArray.count;
    
    if (actionsCount <= 0) {
        
        self.actionScrollView.hidden = YES;
        
        return;
    }
    
    self.actionScrollView.hidden = NO;
    
    self.horizontalSeparatorLineView.hidden = YES;
    self.verticalSeparatorLineView.hidden = YES;
    
    NSArray *subViewsArray = [self.actionContainerView.subviews copy];
    
    NSInteger subviewsCount = subViewsArray.count;
    
    [self.actionContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonWidth = self.contentWidth;
    CGFloat buttonHeight = 0;
    
    JKAlertPlainActionButton *previousButton = nil;
    
    BOOL isTwoAction = (actionsCount == 2);
    
    // 布局仅有2个按钮的情况
    if (isTwoAction) {
        
        [self layoutTwoActionPlainButtons];
        
        return;
    }
    
    CGRect rect = CGRectMake(0, 0, self.contentWidth, 0);
    
    CGRect frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    
    for (NSInteger i = 0; i < actionsCount; i++) {
        
        buttonY = (i == 0 ? 0 : CGRectGetMaxY(previousButton.frame));
        
        JKAlertAction *action = self.actionArray[i];
        
        JKAlertPlainActionButton *button = nil;
        
        if (i < subviewsCount) {
            
            button = subViewsArray[i];
        }
        
        if (!button) {
            
            button = [JKAlertPlainActionButton buttonWithType:(UIButtonTypeCustom)];
            
            [button addTarget:self action:@selector(plainButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        
        frame.origin.y = buttonY;
        frame.size.height = action.rowHeight;
        
        button.frame = frame;
        
        if (action.customView) {
            
            frame.size.height = action.customView.frame.size.height;
            
            button.frame = frame;
            
            action.customView.frame = button.bounds;
        }
        
        [self.actionContainerView addSubview:button];
        
        button.action = action;
        
        rect.size.height += button.frame.size.height;
        
        previousButton = button;
    }
    
    self.actionContainerView.frame = rect;
}

- (void)layoutTwoActionPlainButtons {
    
    NSArray *subViewsArray = [self.actionContainerView.subviews copy];
    
    [self.actionContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    CGRect rect = CGRectMake(0, 0, self.contentWidth, 0);
    
    CGRect frame = CGRectZero;
    
    
    JKAlertAction *action1 = self.actionArray.firstObject;
    
    JKAlertPlainActionButton *button1 = [subViewsArray firstObject];
    
    if (![button1 isKindOfClass:[JKAlertPlainActionButton class]]) {
        
        button1 = [JKAlertPlainActionButton buttonWithType:(UIButtonTypeCustom)];
        
        [button1 addTarget:self action:@selector(plainButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    frame.size.width = self.contentWidth * 0.5;
    
    frame.size.height = action1.rowHeight;
    
    button1.frame = frame;
    
    [self.actionContainerView addSubview:button1];
    
    button1.action = action1;
    
    button1.topSeparatorLineView.hidden = YES;
    
    if (action1.customView) {
        
        frame.size.height = action1.customView.frame.size.height;
        
        button1.frame = frame;
        
        action1.customView.frame = button1.bounds;
    }
    
    
    self.horizontalSeparatorLineView.hidden = action1.separatorLineHidden;
    
    JKAlertAction *action2 = self.actionArray.lastObject;
    
    JKAlertPlainActionButton *button2 = [subViewsArray lastObject];
    
    if (![button2 isKindOfClass:[JKAlertPlainActionButton class]]) {
        
        button2 = [JKAlertPlainActionButton buttonWithType:(UIButtonTypeCustom)];
        
        [button2 addTarget:self action:@selector(plainButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    frame.origin.x = self.contentWidth * 0.5;
    
    button2.frame = frame;
    
    button2.action = action2;
    
    button2.topSeparatorLineView.hidden = YES;
    
    // 第二个按钮的高度跟随第一个按钮
    if (action2.customView) {
        
        action2.customView.frame = button2.bounds;
    }
    
    if (!self.horizontalSeparatorLineView.hidden) {
        
        self.horizontalSeparatorLineView.frame = CGRectMake(0, 0, self.contentWidth, self.separatorLineWH);
        [self.actionContainerView bringSubviewToFront:self.horizontalSeparatorLineView];
    }
    
    if (!self.verticalSeparatorLineView.hidden) {
        
        self.verticalSeparatorLineView.frame = CGRectMake((self.contentWidth - self.separatorLineWH) * 0.5, 0, self.separatorLineWH, button1.frame.size.height);
        
        [self.actionContainerView bringSubviewToFront:self.verticalSeparatorLineView];
    }
    
    rect.size.height = CGRectGetMaxY(button1.frame);
    
    self.actionContainerView.frame = rect;
}

#pragma mark
#pragma mark - Private Selector

- (void)plainButtonClick:(JKAlertPlainActionButton *)button {
    
    JKAlertAction *action = button.action;
    
    // TODO: JKTODO <#注释#>
    //if (action.autoDismiss) { [self dismiss]; }
    
    !action.handler ? : action.handler(action);
}

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
    
    JKAlertPlainTextContentView *textContentView = [[JKAlertPlainTextContentView alloc] init];
    [self.textScrollView addSubview:textContentView];
    _textContentView = textContentView;
    
    UIView *actionContainerView = [[UIView alloc] init];
    [self.actionScrollView addSubview:actionContainerView];
    _actionContainerView = actionContainerView;
    
    UIView *horizontalSeparatorLineView = [[UIView alloc] init];
    horizontalSeparatorLineView.hidden = YES;
    [self.actionContainerView addSubview:horizontalSeparatorLineView];
    _horizontalSeparatorLineView = horizontalSeparatorLineView;
    
    UIView *verticalSeparatorLineView = [[UIView alloc] init];
    verticalSeparatorLineView.hidden = YES;
    [self.actionContainerView addSubview:verticalSeparatorLineView];
    _verticalSeparatorLineView = verticalSeparatorLineView;
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
