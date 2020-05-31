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

// TODO: JKTODO delete
#import "JKAlertView.h"

@interface JKAlertPlainContentView ()

/** actionContainerView */
@property (nonatomic, weak) UIView *actionContainerView;

/** horizontalSeparatorLineView */
@property (nonatomic, weak) UIView *horizontalSeparatorLineView;

/** verticalSeparatorLineView */
@property (nonatomic, weak) UIView *verticalSeparatorLineView;

/** actionButtonArray */
@property (nonatomic, strong) NSMutableArray *actionButtonArray;

/** textFieldContainerView */
@property (nonatomic, weak) UIView *textFieldContainerView;
@end

@implementation JKAlertPlainContentView

#pragma mark
#pragma mark - Public Methods

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    
    self.layer.cornerRadius = cornerRadius;
}

- (void)calculateUI {
    
    self.textContentView.contentWidth = self.contentWidth;
    
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
    
    CGFloat totalHeight = self.textContentView.frame.size.height + self.actionContainerView.frame.size.height;
    
    frame = self.textContentView.bounds;
    self.textScrollView.frame = frame;
    
    self.textScrollView.contentSize = CGSizeMake(0, frame.size.height);
    
    frame = self.actionContainerView.bounds;
    frame.origin.y = CGRectGetMaxY(self.textScrollView.frame);
    self.actionScrollView.frame = frame;
    
    self.actionScrollView.contentSize = CGSizeMake(0, frame.size.height);
    
    CGFloat halfHeight = self.maxHeight * 0.5;
    
    // 总高度未超过最大高度
    if (self.maxHeight <= 0 ||
        totalHeight <= self.maxHeight) {
        
        self.textScrollView.scrollEnabled = NO;
        self.actionScrollView.scrollEnabled = NO;
        
    } else if (self.textScrollView.frame.size.height > halfHeight &&
        self.actionScrollView.frame.size.height > halfHeight) {
        
        // 二者都超过最大高度的一半
        
        self.textScrollView.scrollEnabled = YES;
        self.actionScrollView.scrollEnabled = YES;
        
        frame.origin.y = 0;
        frame.size.height = halfHeight;
        
        self.textScrollView.frame = frame;
        
        frame.origin.y = CGRectGetMaxY(frame);
        
        self.actionScrollView.frame = frame;
        
    } else if (self.textScrollView.frame.size.height > halfHeight) {
        
        // text高度更高
        
        self.textScrollView.scrollEnabled = YES;
        
        frame.size.height = self.maxHeight - self.actionScrollView.frame.size.height;
        frame.origin.y = 0;
        self.textScrollView.frame = frame;
        
        frame.origin.y = CGRectGetMaxY(frame);
        frame.size.height = self.actionScrollView.frame.size.height;
        self.actionScrollView.frame = frame;
        
    } else if (self.actionScrollView.frame.size.height > halfHeight) {
        
        // action高度更高
        
        self.actionScrollView.scrollEnabled = YES;
        
        frame.origin.y = CGRectGetMaxY(self.textScrollView.frame);
        frame.size.height = self.maxHeight - self.textScrollView.frame.size.height;
        self.actionScrollView.frame = frame;
    }
    
    if (!self.horizontalSeparatorLineView.hidden) {
        
        frame = self.horizontalSeparatorLineView.frame;
        frame.size.width = self.contentWidth;
        frame.origin.y = CGRectGetMaxY(self.textScrollView.frame);
        self.horizontalSeparatorLineView.frame = frame;
        
        [self.contentView bringSubviewToFront:self.horizontalSeparatorLineView];
    }
    
    if (!self.verticalSeparatorLineView.hidden) {
        
        frame = self.verticalSeparatorLineView.frame;
        frame.size.height = self.actionScrollView.frame.size.height;
        frame.origin.x = (self.contentWidth - frame.size.width) * 0.5;
        frame.origin.y = CGRectGetMaxY(self.textScrollView.frame);
        
        self.verticalSeparatorLineView.frame = frame;
        
        [self.contentView bringSubviewToFront:self.verticalSeparatorLineView];
    }
    
    self.frame = CGRectMake(0, 0, self.contentWidth, self.textScrollView.frame.size.height + self.actionScrollView.frame.size.height);
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
    
    NSInteger subviewsCount = self.actionButtonArray.count;
    
    [self.actionButtonArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
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
        
        JKAlertAction *action = self.actionArray[i];
        
        JKAlertPlainActionButton *button = nil;
        
        if (i < subviewsCount) {
            
            button = self.actionButtonArray[i];
        }
        
        if (!button) {
            
            button = [JKAlertPlainActionButton buttonWithType:(UIButtonTypeCustom)];
            
            [self.actionButtonArray addObject:button];
            
            [button addTarget:self action:@selector(plainButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        
        button.action = action;
        
        if (i == 0) {
            
            button.topSeparatorLineView.hidden = YES;
            
            self.horizontalSeparatorLineView.hidden = action.separatorLineHidden;
        }
        
        buttonY = (previousButton ? CGRectGetMaxY(previousButton.frame) : 0);
        
        frame.origin.y = buttonY;
        frame.size.height = action.rowHeight;
        
        button.frame = frame;
        
        if (action.customView) {
            
            frame.size.height = action.customView.frame.size.height;
            
            button.frame = frame;
            
            action.customView.frame = button.bounds;
        }
        
        [self.actionContainerView addSubview:button];
        
        rect.size.height += button.frame.size.height;
        
        previousButton = button;
    }
    
    self.actionContainerView.frame = rect;
}

- (void)layoutTwoActionPlainButtons {
    
    CGRect rect = CGRectMake(0, 0, self.contentWidth, 0);
    
    CGRect frame = CGRectZero;
    
    JKAlertAction *action1 = self.actionArray.firstObject;
    
    JKAlertPlainActionButton *button1 = [self.actionButtonArray firstObject];
    
    if (!button1 || ![button1 isKindOfClass:[JKAlertPlainActionButton class]]) {
        
        button1 = [JKAlertPlainActionButton buttonWithType:(UIButtonTypeCustom)];
        
        [self.actionButtonArray addObject:button1];
        
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
    
    JKAlertPlainActionButton *button2 = nil;
    
    if (self.actionButtonArray.count > 1) {
        
        button2 = [self.actionButtonArray objectAtIndex:1];
    }
    
    if (!button2 || ![button2 isKindOfClass:[JKAlertPlainActionButton class]]) {
        
        button2 = [JKAlertPlainActionButton buttonWithType:(UIButtonTypeCustom)];
        
        [self.actionButtonArray addObject:button2];
        
        [button2 addTarget:self action:@selector(plainButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    frame.origin.x = self.contentWidth * 0.5;
    
    button2.frame = frame;
    
    [self.actionContainerView addSubview:button2];
    
    button2.action = action2;
    
    button2.topSeparatorLineView.hidden = YES;
    
    // 第二个按钮的高度跟随第一个按钮
    if (action2.customView) {
        
        action2.customView.frame = button2.bounds;
    }
    
    self.verticalSeparatorLineView.hidden = action2.separatorLineHidden;
    
    rect.size.height = CGRectGetMaxY(button1.frame);
    
    self.actionContainerView.frame = rect;
}

#pragma mark
#pragma mark - Private Selector

- (void)plainButtonClick:(JKAlertPlainActionButton *)button {
    
    JKAlertAction *action = button.action;
    
    if (action.autoDismiss) {
        
        [self.alertView dismiss];
    }
    
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
    
    _cornerRadius = 8;
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
    
    UIView *textFieldContainerView = [[UIView alloc] init];
    textFieldContainerView.hidden = YES;
    [self.textScrollView addSubview:textFieldContainerView];
    _textFieldContainerView = textFieldContainerView;
    
    UIView *actionContainerView = [[UIView alloc] init];
    [self.actionScrollView addSubview:actionContainerView];
    _actionContainerView = actionContainerView;
    
    UIView *horizontalSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentWidth, JKAlertGlobalSeparatorLineThickness())];
    // TODO: JKTODO <#注释#>
    horizontalSeparatorLineView.backgroundColor = JKAlertGlobalSeparatorLineColor();
    horizontalSeparatorLineView.hidden = YES;
    [self.contentView addSubview:horizontalSeparatorLineView];
    _horizontalSeparatorLineView = horizontalSeparatorLineView;
    
    UIView *verticalSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JKAlertGlobalSeparatorLineThickness(), 0)];
    // TODO: JKTODO <#注释#>
    verticalSeparatorLineView.backgroundColor = JKAlertGlobalSeparatorLineColor();
    verticalSeparatorLineView.hidden = YES;
    [self.contentView addSubview:verticalSeparatorLineView];
    _verticalSeparatorLineView = verticalSeparatorLineView;
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

- (NSMutableArray *)actionButtonArray {
    if (!_actionButtonArray) {
        _actionButtonArray = [NSMutableArray array];
    }
    return _actionButtonArray;
}

@end
