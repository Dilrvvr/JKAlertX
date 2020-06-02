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

/** currentTextField */
@property (nonatomic, weak) UITextField *currentTextField;
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
    
    [self layoutTextFieldContainer];
    
    [self layoutPlainButtons];
    
    [self adjustPlainFrame];
    
    [self checkScrollToTextField];
}

- (void)checkScrollToTextField {
    
    if (!self.textScrollView.scrollEnabled ||
        !_currentTextField ||
        !_currentTextField.isFirstResponder) {
        
        _currentTextField = nil;
        
        return;
    }
    
    CGFloat offsetY = self.textScrollView.contentOffset.y;
    
    CGRect rect = [self.textFieldContainerView convertRect:_currentTextField.frame  toView:self.textScrollView];
    
    // textField在可见位置
    if (rect.origin.y >= offsetY &&
        rect.origin.y + rect.size.height < self.textScrollView.frame.size.height + offsetY) {
        
        return;
    }
    
    // textField高度大于scrollView
    if (self.textScrollView.frame.size.height < rect.size.height) {
        
        offsetY = rect.origin.y - self.textScrollView.frame.size.height;
        
    } else {

        offsetY = rect.origin.y + rect.size.height - self.textScrollView.frame.size.height;
    }
    
    [self.textScrollView setContentOffset:CGPointMake(0, offsetY) animated:YES];
    
}

#pragma mark
#pragma mark - Override



#pragma mark
#pragma mark - Private Methods

- (void)layoutTextFieldContainer {
    
    CGRect frame = CGRectZero;
    
    if (self.textFieldArray.count <= 0) {
        
        self.textFieldContainerView.hidden = YES;
        
        self.textFieldContainerView.frame = CGRectZero;
        
        frame.size.width = self.contentWidth;
        frame.size.height = CGRectGetMaxY(self.textContentView.frame);
        self.textScrollView.frame = frame;
        
        return;
    }
    
    self.textFieldContainerView.hidden = NO;
    
    CGFloat borderWidth = JKAlertGlobalSeparatorLineThickness();
    
    CGFloat containerWidth = self.contentWidth - self.textFieldContainerInset.left - self.textFieldContainerInset.right;
    CGFloat containerHeight = 0;
    
    frame = CGRectMake(borderWidth, 0, containerWidth - borderWidth * 2, self.textFieldHeight);
    
    for (UITextField *tf in self.textFieldArray) {
        
        containerHeight += borderWidth;
        
        frame.origin.y = containerHeight;
        frame.size.height = tf.frame.size.height > 0 ? tf.frame.size.height : self.textFieldHeight;
        
        tf.frame = frame;
        
        containerHeight += (tf.frame.size.height);
        
        [self.textFieldContainerView addSubview:tf];
    }
    
    containerHeight += borderWidth;
    
    frame = CGRectZero;
    frame.origin.x = self.safeInsets.left + self.textFieldContainerInset.left;
    frame.origin.y = CGRectGetMaxY(self.textContentView.frame) + self.textFieldContainerInset.top;
    frame.size.width = self.contentWidth - self.safeInsets.left - self.textFieldContainerInset.left - self.safeInsets.right - self.textFieldContainerInset.right;
    frame.size.height = containerHeight;
    
    self.textFieldContainerView.frame = frame;
    
    frame = CGRectZero;
    
    frame.size.width = self.contentWidth;
    frame.size.height = CGRectGetMaxY(self.textFieldContainerView.frame) + self.textFieldContainerInset.bottom;
    self.textScrollView.frame = frame;
}

- (void)adjustPlainFrame {
    
    CGRect frame = CGRectZero;
    
    CGFloat totalHeight = self.textScrollView.frame.size.height + self.actionScrollView.frame.size.height;
    
    frame = self.textScrollView.bounds;
    
    self.textScrollView.frame = frame;
    
    self.textScrollView.contentSize = CGSizeMake(0, frame.size.height);
    
    frame = self.actionScrollView.bounds;
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
        self.actionScrollView.frame = CGRectZero;
        
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
        
        self.actionScrollView.frame = CGRectMake(0, 0, self.contentWidth, self.actionContainerView.frame.size.height);
        
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
    
    self.actionScrollView.frame = self.actionContainerView.bounds;
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

- (void)updateLightModetUI {
    [super updateLightModetUI];
    
    self.horizontalSeparatorLineView.backgroundColor = JKAlertGlobalSeparatorLineMultiColor().lightColor;
    self.verticalSeparatorLineView.backgroundColor = JKAlertGlobalSeparatorLineMultiColor().lightColor;
    
    self.textFieldContainerView.backgroundColor = JKAlertGlobalSeparatorLineMultiColor().lightColor;
    
    //self.textFieldContainerView.layer.borderColor = [JKAlertGlobalSeparatorLineMultiColor().lightColor CGColor];
}

- (void)updateDarkModeUI {
    [super updateDarkModeUI];
    
    self.horizontalSeparatorLineView.backgroundColor = JKAlertGlobalSeparatorLineMultiColor().darkColor;
    self.verticalSeparatorLineView.backgroundColor = JKAlertGlobalSeparatorLineMultiColor().darkColor;
    
    self.textFieldContainerView.backgroundColor = JKAlertGlobalSeparatorLineMultiColor().darkColor;
    
    //self.textFieldContainerView.layer.borderColor = [JKAlertGlobalSeparatorLineMultiColor().darkColor CGColor];
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
    
    _textFieldHeight = 30;
    
    _autoShowKeyboard = YES;
    
    _textFieldContainerCornerRadius = 8;
    
    _textFieldContainerInset = UIEdgeInsetsMake(0, 20, 20, 20);
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidBeginEditingNotification:) name:UITextFieldTextDidBeginEditingNotification object:nil];
}

- (void)textFieldTextDidBeginEditingNotification:(NSNotification *)notification {
    
    if (self.textFieldArray.count <= 0 ||
        ![self.textFieldArray containsObject:notification.object]) {
        
        return;
    }
    
    _currentTextField = (UITextField *)notification.object;
}

/** 创建UI */
- (void)createUI {
    [super createUI];
    
    JKAlertPlainTextContentView *textContentView = [[JKAlertPlainTextContentView alloc] init];
    [self.textScrollView addSubview:textContentView];
    _textContentView = textContentView;
    
    UIView *textFieldContainerView = [[UIView alloc] init];
    //textFieldContainerView.layer.borderWidth = 1;
    //textFieldContainerView.layer.cornerRadius = 8;
    textFieldContainerView.clipsToBounds = YES;
    textFieldContainerView.hidden = YES;
    [self.textScrollView addSubview:textFieldContainerView];
    _textFieldContainerView = textFieldContainerView;
    
    UIView *actionContainerView = [[UIView alloc] init];
    [self.actionScrollView addSubview:actionContainerView];
    _actionContainerView = actionContainerView;
    
    UIView *horizontalSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentWidth, JKAlertGlobalSeparatorLineThickness())];
    horizontalSeparatorLineView.hidden = YES;
    [self.contentView addSubview:horizontalSeparatorLineView];
    _horizontalSeparatorLineView = horizontalSeparatorLineView;
    
    UIView *verticalSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JKAlertGlobalSeparatorLineThickness(), 0)];
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
