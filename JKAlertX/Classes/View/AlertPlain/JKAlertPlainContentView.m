//
//  JKAlertPlainContentView.m
//  JKAlertX
//
//  Created by albert on 2020/5/29.
//

#import "JKAlertPlainContentView.h"
#import "JKAlertPlainActionButton.h"
#import "JKAlertAction.h"
#import "JKAlertUtility.h"
#import "JKAlertTheme.h"

@interface JKAlertPlainContentView ()
{
    NSMutableArray *_textFieldArray;
}

/** actionContainerView */
@property (nonatomic, weak) UIView *actionContainerView;

/** horizontalSeparatorLineView */
@property (nonatomic, weak) UIView *horizontalSeparatorLineView;

/** verticalSeparatorLineView */
@property (nonatomic, weak) UIView *verticalSeparatorLineView;

/** actionButtonArray */
@property (nonatomic, strong) NSMutableArray *actionButtonArray;

/** currentTextField */
@property (nonatomic, weak) UITextField *currentTextField;
@end

@implementation JKAlertPlainContentView

#pragma mark
#pragma mark - Public Methods

- (void)setCornerRadius:(CGFloat)cornerRadius {
    [super setCornerRadius:cornerRadius];
    
    self.layer.cornerRadius = cornerRadius;
}

- (void)calculateUI {
    [super calculateUI];
    
    self.textContentView.contentWidth = self.alertWidth;
    
    [self.textContentView calculateUI];
    
    [self layoutTextFieldContainer];
    
    [self layoutPlainButtons];
    
    [self adjustPlainFrame];
    
    [self.topContentView updateScrollContentViewFrame];
    [self.bottomContentView updateScrollContentViewFrame];
    
    [self checkScrollToTextField];
}

- (void)checkScrollToTextField {
    
    if (!self.topContentView.scrollView.scrollEnabled ||
        !_currentTextField ||
        !_currentTextField.isFirstResponder) {
        
        _currentTextField = nil;
        
        return;
    }
    
    CGFloat offsetY = self.topContentView.scrollView.contentOffset.y;
    
    CGRect rect = [self.textFieldContainerView convertRect:_currentTextField.frame  toView:self.topContentView.scrollView];
    
    // textField在可见位置
    if (rect.origin.y >= offsetY &&
        rect.origin.y + rect.size.height < self.topContentView.frame.size.height + offsetY) {
        
        return;
    }
    
    // textField高度大于scrollView
    if (self.topContentView.frame.size.height < rect.size.height) {
        
        offsetY = rect.origin.y - self.topContentView.frame.size.height;
        
    } else {

        offsetY = rect.origin.y + rect.size.height - self.topContentView.frame.size.height;
    }
    
    [self.topContentView.scrollView setContentOffset:CGPointMake(0, offsetY) animated:YES];
    
}

#pragma mark
#pragma mark - Override

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark
#pragma mark - Private Methods

- (void)layoutTextFieldContainer {
    
    CGRect frame = CGRectMake(0.0, 0.0, self.alertWidth, 0.0);
    
    if (self.textFieldArray.count <= 0) {
        
        self.textFieldContainerView.hidden = YES;
        
        self.textFieldContainerView.frame = CGRectZero;
        
        frame.size.width = self.alertWidth;
        frame.size.height = CGRectGetMaxY(self.textContentView.frame);
        self.topContentView.frame = frame;
        
        return;
    }
    
    self.textFieldContainerView.hidden = NO;
    
    CGFloat borderWidth = JKAlertUtility.separatorLineThickness;
    
    CGFloat containerWidth = self.alertWidth - self.textFieldContainerInset.left - self.textFieldContainerInset.right;
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
    frame.origin.x = self.screenSafeInsets.left + self.textFieldContainerInset.left;
    frame.origin.y = CGRectGetMaxY(self.textContentView.frame) + self.textFieldContainerInset.top;
    frame.size.width = self.alertWidth - self.screenSafeInsets.left - self.textFieldContainerInset.left - self.screenSafeInsets.right - self.textFieldContainerInset.right;
    frame.size.height = containerHeight;
    
    self.textFieldContainerView.frame = frame;
    
    frame = CGRectZero;
    
    frame.size.width = self.alertWidth;
    frame.size.height = CGRectGetMaxY(self.textFieldContainerView.frame) + self.textFieldContainerInset.bottom;
    self.topContentView.frame = frame;
}

- (void)adjustPlainFrame {
    
    CGRect frame = self.topContentView.bounds;
    
    self.topContentView.frame = frame;
    
    [self.topContentView updateContentSize];
    
    frame = self.bottomContentView.bounds;
    frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
    self.bottomContentView.frame = frame;
    
    [self.bottomContentView updateContentSize];
    
    CGFloat totalHeight = self.topContentView.frame.size.height + self.bottomContentView.frame.size.height;
    
    CGFloat halfHeight = self.maxHeight * 0.5;
    
    // 总高度未超过最大高度
    if (self.maxHeight <= 0 ||
        totalHeight <= self.maxHeight) {
        
        self.topContentView.scrollView.scrollEnabled = NO;
        self.bottomContentView.scrollView.scrollEnabled = NO;
        
    } else if (self.topContentView.frame.size.height > halfHeight &&
        self.bottomContentView.frame.size.height > halfHeight) {
        
        // 二者都超过最大高度的一半
        
        self.topContentView.scrollView.scrollEnabled = YES;
        self.bottomContentView.scrollView.scrollEnabled = YES;
        
        frame.origin.y = 0;
        frame.size.height = halfHeight;
        
        self.topContentView.frame = frame;
        
        frame.origin.y = CGRectGetMaxY(frame);
        
        self.bottomContentView.frame = frame;
        
    } else if (self.topContentView.frame.size.height > halfHeight) {
        
        // text高度更高
        
        self.topContentView.scrollView.scrollEnabled = YES;
        
        frame.size.height = self.maxHeight - self.bottomContentView.frame.size.height;
        frame.origin.y = 0;
        self.topContentView.frame = frame;
        
        frame.origin.y = CGRectGetMaxY(frame);
        frame.size.height = self.bottomContentView.frame.size.height;
        self.bottomContentView.frame = frame;
        
    } else if (self.bottomContentView.frame.size.height > halfHeight) {
        
        // action高度更高
        
        self.bottomContentView.scrollView.scrollEnabled = YES;
        
        frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
        frame.size.height = self.maxHeight - self.topContentView.frame.size.height;
        self.bottomContentView.frame = frame;
    }
    
    if (!self.horizontalSeparatorLineView.hidden) {
        
        frame = self.horizontalSeparatorLineView.frame;
        
        JKAlertAction *firstAction = self.actionArray.firstObject;
        frame.origin.x = firstAction.separatorLineInset.left;
        frame.size.width = self.alertWidth - firstAction.separatorLineInset.left - firstAction.separatorLineInset.right;
        frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
        
        self.horizontalSeparatorLineView.frame = frame;
        
        [self.contentView bringSubviewToFront:self.horizontalSeparatorLineView];
    }
    
    if (!self.verticalSeparatorLineView.hidden) {
        
        frame = self.verticalSeparatorLineView.frame;
        frame.size.height = self.bottomContentView.frame.size.height;
        frame.origin.x = (self.alertWidth - frame.size.width) * 0.5;
        frame.origin.y = CGRectGetMaxY(self.topContentView.frame);
        
        self.verticalSeparatorLineView.frame = frame;
        
        [self.contentView bringSubviewToFront:self.verticalSeparatorLineView];
    }
    
    self.frame = CGRectMake(0, 0, self.alertWidth, self.topContentView.frame.size.height + self.bottomContentView.frame.size.height);
}

- (void)layoutPlainButtons {
    
    NSInteger actionsCount = self.actionArray.count;
    
    if (actionsCount <= 0) {
        
        self.bottomContentView.hidden = YES;
        self.bottomContentView.frame = CGRectMake(0.0, 0.0, self.alertWidth, 0.0);
        
        return;
    }
    
    self.bottomContentView.hidden = NO;
    
    self.horizontalSeparatorLineView.hidden = YES;
    self.verticalSeparatorLineView.hidden = YES;
    
    NSInteger subviewsCount = self.actionButtonArray.count;
    
    [self.actionButtonArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonWidth = self.alertWidth;
    CGFloat buttonHeight = 0;
    
    JKAlertPlainActionButton *previousButton = nil;
    
    BOOL isTwoAction = (actionsCount == 2);
    
    // 布局仅有2个按钮的情况
    if (isTwoAction) {
        
        [self layoutTwoActionPlainButtons];
        
        self.bottomContentView.frame = CGRectMake(0, 0, self.alertWidth, self.actionContainerView.frame.size.height);
        
        return;
    }
    
    CGRect rect = CGRectMake(0, 0, self.alertWidth, 0);
    
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
            
            if (action.separatorLineColor) {
                
                self.horizontalSeparatorLineView.backgroundColor = action.separatorLineColor;
            }
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
    
    self.bottomContentView.frame = self.actionContainerView.bounds;
}

- (void)layoutTwoActionPlainButtons {
    
    CGRect rect = CGRectMake(0, 0, self.alertWidth, 0);
    
    CGRect frame = rect;
    
    JKAlertAction *action1 = self.actionArray.firstObject;
    
    JKAlertPlainActionButton *button1 = [self.actionButtonArray firstObject];
    
    if (!button1 || ![button1 isKindOfClass:[JKAlertPlainActionButton class]]) {
        
        button1 = [JKAlertPlainActionButton buttonWithType:(UIButtonTypeCustom)];
        
        [self.actionButtonArray addObject:button1];
        
        [button1 addTarget:self action:@selector(plainButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    frame.size.width = self.alertWidth * 0.5;
    
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
    
    if (action1.separatorLineColor) {
        
        self.horizontalSeparatorLineView.backgroundColor = action1.separatorLineColor;
    }
    
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
    
    frame.origin.x = self.alertWidth * 0.5;
    
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
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertContentView:executeHandlerOfAction:)]) {
        
        [self.delegate alertContentView:self executeHandlerOfAction:button.action];
    }
}

#pragma mark
#pragma mark - Custom Delegates



#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 */
- (void)initializeProperty {
    [super initializeProperty];
    
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
    [self.topContentView.scrollContentView addSubview:textContentView];
    _textContentView = textContentView;
    
    UIView *textFieldContainerView = [[UIView alloc] init];
    //textFieldContainerView.layer.borderWidth = 1;
    //textFieldContainerView.layer.cornerRadius = 8;
    textFieldContainerView.clipsToBounds = YES;
    textFieldContainerView.hidden = YES;
    [self.topContentView.scrollContentView addSubview:textFieldContainerView];
    _textFieldContainerView = textFieldContainerView;
    
    UIView *actionContainerView = [[UIView alloc] init];
    [self.bottomContentView.scrollContentView addSubview:actionContainerView];
    _actionContainerView = actionContainerView;
    
    UIView *horizontalSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.alertWidth, JKAlertUtility.separatorLineThickness)];
    horizontalSeparatorLineView.userInteractionEnabled = NO;
    horizontalSeparatorLineView.hidden = YES;
    [self.contentView addSubview:horizontalSeparatorLineView];
    _horizontalSeparatorLineView = horizontalSeparatorLineView;
    
    UIView *verticalSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JKAlertUtility.separatorLineThickness, 0)];
    verticalSeparatorLineView.userInteractionEnabled = NO;
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
    
    [JKAlertThemeProvider providerBackgroundColorWithOwner:self.backgroundView provideHandler:^(JKAlertThemeProvider *provider, UIView *providerOwner) {

        providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertUtility.lightBackgroundColor, JKAlertUtility.darkBackgroundColor);
    }];
    
    __weak typeof(self) weakSelf = self;
    
    [JKAlertThemeProvider providerBackgroundColorWithOwner:self.horizontalSeparatorLineView provideHandler:^(JKAlertThemeProvider *provider, UIView *providerOwner) {
        
        JKAlertAction *firstAction = weakSelf.actionArray.firstObject;
        
        if (firstAction.separatorLineColor) {
            
            providerOwner.backgroundColor = firstAction.separatorLineColor;
            
            return;
        }
        
        providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertUtility.separatorLineLightColor, JKAlertUtility.separatorLineDarkColor);
    }];
    
    [JKAlertThemeProvider providerBackgroundColorWithOwner:self.verticalSeparatorLineView provideHandler:^(JKAlertThemeProvider *provider, UIView *providerOwner) {
        
        providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertUtility.separatorLineLightColor, JKAlertUtility.separatorLineDarkColor);
    }];
    
    [JKAlertThemeProvider providerBackgroundColorWithOwner:self.textFieldContainerView provideHandler:^(JKAlertThemeProvider *provider, UIView *providerOwner) {
        
        providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertUtility.separatorLineLightColor, JKAlertUtility.separatorLineDarkColor);
    }];
}

#pragma mark
#pragma mark - Private Property

- (NSMutableArray *)actionButtonArray {
    if (!_actionButtonArray) {
        _actionButtonArray = [NSMutableArray array];
    }
    return _actionButtonArray;
}

- (NSMutableArray *)textFieldArray {
    if (!_textFieldArray) {
        _textFieldArray = [NSMutableArray array];
    }
    return _textFieldArray;
}
@end
