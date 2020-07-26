//
//  JKAlertView.m
//  TestVideoAndPicture
//
//  Created by albert on 2017/4/18.
//  Copyright © 2017年 安永博. All rights reserved.
//

#import "JKAlertView.h"
#import "JKAlertCollectionViewCell.h"
#import "JKAlertTableViewCell.h"
#import "UIView+JKAlertX.h"
#import "JKAlertPlainActionButton.h"
#import "JKAlertView+PrivateProperty.h"
#import "JKAlertVisualFormatConstraintManager.h"
#import "JKAlertView+Public.h"
#import "JKAlertView+HUD.h"
#import "JKAlertTheme.h"
#import "JKAlertThemeManager.h"

@interface JKAlertView () <JKAlertBaseAlertContentViewDelegate>

/** isSheetDismissHorizontal */
@property (nonatomic, assign) BOOL isSheetDismissHorizontal;
@end

@implementation JKAlertView

#pragma mark
#pragma mark - 类方法

+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                             style:(JKAlertStyle)style {
    
    JKAlertView *alertView = [self alertViewWithStyle:style];
    
    alertView.currentTextContentView.alertTitle = [title copy];
    alertView.currentTextContentView.alertMessage = [message copy];
    
    return alertView;
}

/** 链式实例化 */
+ (JKAlertView *(^)(NSString *title, NSString *message, JKAlertStyle style))alertView {
    
    return ^(NSString *title, NSString *message, JKAlertStyle style) {
        
        return [JKAlertView alertViewWithTitle:title message:message style:style];
    };
}

+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)attributedTitle
                           attributedMessage:(NSAttributedString *)attributedMessage
                                       style:(JKAlertStyle)style {
    
    JKAlertView *alertView = [self alertViewWithStyle:style];
    
    alertView.currentTextContentView.alertAttributedTitle = [attributedTitle copy];
    alertView.currentTextContentView.attributedMessage = [attributedMessage copy];
    
    return alertView;
}

/** 函数式类方法 */
+ (JKAlertView *(^)(NSString *title, NSString *message, JKAlertStyle style, void (^)(JKAlertView *alertView)))show {
    
    return ^(NSString *title, NSString *message, JKAlertStyle style, void(^configuration)(JKAlertView *alertView)) {
        
        JKAlertView *view = [self alertViewWithTitle:title message:message style:style];
        
        !configuration ? : configuration(view);
        
        [view show];
        
        return view;
    };
}

/** 链式实例化 */
+ (JKAlertView *(^)(NSAttributedString *attributedTitle, NSAttributedString *attributedMessage, JKAlertStyle style))alertViewAttributed {
    
    return ^(NSAttributedString *attributedTitle, NSAttributedString *attributedMessage, JKAlertStyle style) {
        
        return [JKAlertView alertViewWithAttributedTitle:attributedTitle attributedMessage:attributedMessage style:style];
    };
}

/** 显示文字HUD */
+ (void (^)(NSString *title, void(^configuration)(JKAlertView *alertView)))showHUDWithTitle {
    
    return ^(NSString *title, void(^configuration)(JKAlertView *alertView)) {
        
        JKAlertView *alertView = [JKAlertView alertViewWithTitle:title message:nil style:(JKAlertStyleHUD)];
        
        !configuration ? : configuration(alertView);
        
        [alertView show];
    };
}

/** 显示富文本HUD */
+ (void (^)(NSAttributedString *attributedTitle, void(^configuration)(JKAlertView *alertView)))showHUDWithAttributedTitle {
    
    return ^(NSAttributedString *attributedTitle, void(^configuration)(JKAlertView *alertView)) {
        
        JKAlertView *alertView = [JKAlertView alertViewWithAttributedTitle:attributedTitle attributedMessage:nil style:(JKAlertStyleHUD)];
        
        !configuration ? : configuration(alertView);
        
        [alertView show];
    };
}

/**
 * 显示自定义HUD
 * 注意使用点语法调用，否则莫名报错 JKAlertView.showCustomHUD
 * customHUD尺寸将完全由自定义控制，默认显示在屏幕中间
 * 注意自己计算好自定义HUD的size，以避免横竖屏出现问题
 */
+ (void (^)(UIView *(^customHUD)(void), void(^configuration)(JKAlertView *alertView)))showCustomHUD {
    
    return ^(UIView *(^customHUD)(void), void(^configuration)(JKAlertView *alertView)) {
        
        JKAlertView *alertView = [JKAlertView alertViewWithTitle:nil message:nil style:(JKAlertStyleHUD)];
        
        UIView *customView = !customHUD ? nil : customHUD();
        
        !configuration ? : configuration(alertView);
        
        alertView.customHUD = customView;
        
        [alertView show];
    };
}

#pragma mark
#pragma mark - Private Initialization

+ (instancetype)alertViewWithStyle:(JKAlertStyle)style {
    
    JKAlertView *alertView = [[JKAlertView alloc] init];
    
    alertView.alertStyle = style;
    
    return alertView;
}

- (void)setAlertStyle:(JKAlertStyle)alertStyle {
    _alertStyle = alertStyle;
    
    _tapBlankDismiss = NO;
    
    switch (_alertStyle) {
        case JKAlertStyleHUD:
        {
            _currentAlertContentView = self.hudContentView;
            _currentTextContentView = self.hudContentView.textContentView;
            
            self.makeFullBackgroundColor(nil);
        }
            break;
            
        case JKAlertStyleActionSheet:
        {
            _tapBlankDismiss = YES;
            
            _currentAlertContentView = self.actionsheetContentView;
            _currentTextContentView = self.actionsheetContentView.textContentView;
        }
            break;
            
        case JKAlertStyleCollectionSheet:
        {
            _tapBlankDismiss = YES;
            
            _currentAlertContentView = self.collectionsheetContentView;
            _currentTextContentView = self.collectionsheetContentView.textContentView;
        }
            break;
            
        default: // 默认为JKAlertStylePlain样式
        {
            _alertStyle = JKAlertStylePlain;
            
            _autoAdaptKeyboard = YES;
            
            _currentAlertContentView = self.plainContentView;
            _currentTextContentView = self.plainContentView.textContentView;
            
            [self addKeyboardWillChangeFrameNotification];
        }
            break;
    }
}

#pragma mark
#pragma mark - 显示

/** 显示 */
- (JKAlertView *(^)(void))show {
    
    if (!self.customSuperView) { return ^{ return self; }; }
    
    [JKAlertUtility.keyWindow endEditing:YES];
    
    if (self.isShowed) { return ^{ return self; }; }
    
    self.isShowed = YES;
    
    [self calculateUI];
    
    !self.alertContentViewConfiguration ? : self.alertContentViewConfiguration(self.alertContentView);
    
    // customSuperView没有则默认keyWindow
    [self.customSuperView addSubview:self];
    
    return ^{ return self; };
}

#pragma mark
#pragma mark - 计算布局

- (void)calculateUI {
    
    self.frame = CGRectMake(0, 0, self.superWidth, self.superHeight);
    
    switch (self.alertStyle) {
        case JKAlertStylePlain:
        {
            [self calculatePlainUI];
        }
            break;
            
        case JKAlertStyleActionSheet:
        {
            [self calculateActionSheetUI];
        }
            break;
            
        case JKAlertStyleCollectionSheet:
        {
            [self calculateCollectionSheetUI];
        }
            break;
            
        case JKAlertStyleHUD:
        {
            [self calculateHudUI];
        }
            break;
            
        default:
            break;
    }
}

- (void)calculatePlainUI {
    
    [self updatePlainWidth];
    
    self.plainContentView.textFieldArray = self.textFieldArr;
    
    self.plainContentView.contentWidth = self.plainWidth;
    self.plainContentView.maxHeight = self.maxPlainHeight;
    [self.plainContentView calculateUI];
    
    self.plainContentView.center = CGPointMake(self.superWidth * 0.5 + self.plainCenterOffset.x, self.superHeight * 0.5 + self.plainCenterOffset.y);
}

- (void)calculateHudUI {
    
    if (self.customHUD) {
        
        self.hudContentView.textContentView.customContentView = self.customHUD;
    }
    
    [self updatePlainWidth];
    
    self.hudContentView.contentWidth = self.plainWidth;
    self.hudContentView.maxHeight = self.maxPlainHeight;
    [self.hudContentView calculateUI];
    
    self.hudContentView.center = CGPointMake(self.superWidth * 0.5 + self.plainCenterOffset.x, self.superHeight * 0.5 + self.plainCenterOffset.y);
}

- (void)calculateActionSheetUI {
    
    [self.actionsheetContentView.actionArray.lastObject setSeparatorLineHidden:YES];
    
    self.actionsheetContentView.tapBlankDismiss = self.tapBlankDismiss;
    
    UIEdgeInsets safeAreaInsets = [self checkSuperViewSafeAreaInsets];
    
    safeAreaInsets.top = 0;
    
    self.actionsheetContentView.screenSafeInsets = safeAreaInsets;
    
    CGFloat contentWidth = self.superWidth;
    
    if (self.actionsheetContentView.isPierced) {
        
        contentWidth -= (self.actionsheetContentView.piercedInsets.left + self.actionsheetContentView.piercedInsets.right + self.actionsheetContentView.screenSafeInsets.left + self.actionsheetContentView.screenSafeInsets.right);
    }
    
    self.actionsheetContentView.contentWidth = contentWidth;
    self.actionsheetContentView.maxHeight = self.maxSheetHeight;
    [self.actionsheetContentView calculateUI];
    
    CGRect frame = self.actionsheetContentView.frame;
    frame.origin.x = self.actionsheetContentView.isPierced ? self.actionsheetContentView.screenSafeInsets.left + self.actionsheetContentView.piercedInsets.left : 0;
    frame.origin.y = self.superHeight - frame.size.height;
    self.actionsheetContentView.frame = frame;
    
    self.actionsheetContentView.correctFrame = frame;
}

- (void)calculateCollectionSheetUI {
    
    self.collectionsheetContentView.tapBlankDismiss = self.tapBlankDismiss;
    
    UIEdgeInsets safeAreaInsets = [self checkSuperViewSafeAreaInsets];
    
    safeAreaInsets.top = 0;
    
    self.collectionsheetContentView.screenSafeInsets = safeAreaInsets;
    
    CGFloat contentWidth = self.superWidth;
    
    if (self.collectionsheetContentView.isPierced) {
        
        contentWidth -= (self.collectionsheetContentView.piercedInsets.left + self.collectionsheetContentView.piercedInsets.right + self.collectionsheetContentView.screenSafeInsets.left + self.collectionsheetContentView.screenSafeInsets.right);
    }
    
    self.collectionsheetContentView.contentWidth = contentWidth;
    self.collectionsheetContentView.maxHeight = self.maxSheetHeight;
    
    [self.collectionsheetContentView calculateUI];
    
    CGRect frame = self.collectionsheetContentView.frame;
    frame.origin.x = self.collectionsheetContentView.isPierced ? self.collectionsheetContentView.screenSafeInsets.left + self.collectionsheetContentView.piercedInsets.left : 0;
    frame.origin.y = self.superHeight - frame.size.height;
    self.collectionsheetContentView.frame = frame;
    
    self.collectionsheetContentView.correctFrame = frame;
}

/// 检查获取superView的安全区域
- (UIEdgeInsets)checkSuperViewSafeAreaInsets {
    
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    
    if (@available(iOS 11.0, *)) {
        
        safeAreaInsets = self.customSuperView.safeAreaInsets;
        
        UIWindow *keyWindow = JKAlertUtility.keyWindow;
        
        UIEdgeInsets windowSafeAreaInsets = keyWindow.safeAreaInsets;
        
        CGFloat safeWidth = keyWindow.frame.size.width - windowSafeAreaInsets.left - windowSafeAreaInsets.right;
        
        if (self.customSuperView.frame.size.width > safeWidth - 1) {
            
            safeAreaInsets.left = windowSafeAreaInsets.left;
            safeAreaInsets.right = windowSafeAreaInsets.right;
        }
    }
    
    return safeAreaInsets;
}

- (void)updatePlainWidth {
    
    if (!self.autoReducePlainWidth) { return; }
    
    CGFloat safeAreaInset = 0;
    
    if (@available(iOS 11.0, *)) {
        
        safeAreaInset = MAX(self.customSuperView.safeAreaInsets.left, self.customSuperView.safeAreaInsets.right);
    }
    
    self.plainWidth = MIN(self.originalPlainWidth, self.superWidth - safeAreaInset * 2);
}

/**
 * 更新plain样式Y值
 */
- (void)updatePlainFrameY:(CGFloat)frameY animated:(BOOL)animated {
    
    CGRect frame = self.alertContentView.frame;
    
    frame.origin.y = frameY;
    
    if (!animated) {
        
        self.alertContentView.frame = frame;
        
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alertContentView.frame = frame;
    }];
}

#pragma mark
#pragma mark - Setter

- (void)setAlertViewToAction:(JKAlertAction *)action {
    
    action.alertView = self;
}

- (void)setCustomHUD:(UIView *)customHUD {
    
    if (self.alertStyle != JKAlertStyleHUD) { return; }
    
    _customHUD = customHUD;
    
    if (self.customHUD.frame.size.width <= 0) { return; }
    
    self.plainWidth = self.customHUD.frame.size.width;
    
    self.originalPlainWidth = self.plainWidth;
}

#pragma mark
#pragma mark - 监听屏幕旋转

- (void)orientationChanged:(NSNotification *)note {
    
    !self.orientationDidChangeHandler ? : self.orientationDidChangeHandler(self, [UIApplication sharedApplication].statusBarOrientation);
    
    [self updateWidthHeight];
    
    self.relayout(NO);
}

#pragma mark
#pragma mark - 添加action

/** 添加action */
- (JKAlertView *(^)(JKAlertAction *action))addAction {
    
    return ^(JKAlertAction *action) {
        
        [self addAction:action];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(JKAlertAction *action))removeAction {
    
    return ^(JKAlertAction *action) {
        
        [self removeAction:action];
        
        return self;
    };
}

/** 链式添加action */
- (JKAlertView *(^)(JKAlertAction *action, NSUInteger atIndex))insertAction {
    
    return ^(JKAlertAction *action, NSUInteger atIndex) {
        
        [self insertAction:action atIndex:atIndex];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(NSUInteger index))removeActionAtIndex {
    
    return ^(NSUInteger index) {
        
        [self removeActionAtIndex:index];
        
        return self;
    };
}

/** 链式获取action */
- (JKAlertView *(^)(NSUInteger index, void (^)(JKAlertAction *action)))getActionAtIndex {
    
    return ^(NSUInteger index, void(^getAction)(JKAlertAction *action)) {
        
        JKAlertAction *action = [self getActionAtIndex:index];
        
        !getAction ? : getAction(action);
        
        return self;
    };
}

/** 添加action */
- (void)addAction:(JKAlertAction *)action {
    
    if (!action) { return; }
    
    [self setAlertViewToAction:action];
    
    [self.currentAlertContentView.actionArray addObject:action];
}

/** 移除action */
- (void)removeAction:(JKAlertAction *)action {
    
    if (!action || ![self.currentAlertContentView.actionArray containsObject:action]) { return; }
    
    [self.currentAlertContentView.actionArray removeObject:action];
}

/** 添加action */
- (void)insertAction:(JKAlertAction *)action atIndex:(NSUInteger)index {
    
    if (!action) { return; }
    
    [self setAlertViewToAction:action];
    
    [self.currentAlertContentView.actionArray insertObject:action atIndex:index];
}

/** 移除action */
- (void)removeActionAtIndex:(NSUInteger)index {
    
    if (index < 0 || index >= self.currentAlertContentView.actionArray.count) { return; }
    
    [self.currentAlertContentView.actionArray removeObjectAtIndex:index];
}

/** 获取action */
- (JKAlertAction *)getActionAtIndex:(NSUInteger)index {
    
    if (index < 0 || index >= self.currentAlertContentView.actionArray.count) { return nil; }
    
    JKAlertAction *action = [self.currentAlertContentView.actionArray objectAtIndex:index];
    
    return action;
}


#pragma mark
#pragma mark - action数组操作

/** 添加action */
- (JKAlertView *(^)(JKAlertAction *action, BOOL isSecondCollection))addActionTo {
    
    return ^(JKAlertAction *action, BOOL isSecondCollection) {
        
        [self addAction:action isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(JKAlertAction *action, BOOL isSecondCollection))removeActionFrom {
    
    return ^(JKAlertAction *action, BOOL isSecondCollection) {
        
        [self removeAction:action isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式添加action */
- (JKAlertView *(^)(JKAlertAction *action, NSUInteger atIndex, BOOL isSecondCollection))insertActionTo {
    
    return ^(JKAlertAction *action, NSUInteger atIndex, BOOL isSecondCollection) {
        
        [self insertAction:action atIndex:atIndex isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(NSUInteger index, BOOL isSecondCollection))removeActionAtIndexFrom {
    
    return ^(NSUInteger index, BOOL isSecondCollection) {
        
        [self removeActionAtIndex:index isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式获取action */
- (JKAlertView *(^)(NSUInteger index, BOOL isSecondCollection, void (^)(JKAlertAction *action)))getActionAtIndexFrom {
    
    return ^(NSUInteger index, BOOL isSecondCollection, void(^getAction)(JKAlertAction *action)) {
        
        JKAlertAction *action = [self getActionAtIndex:index isSecondCollection:isSecondCollection];
        
        !getAction ? : getAction(action);
        
        return self;
    };
}

/** 链式获取cancelAction或collectionAction */
- (JKAlertView *(^)(BOOL isCancelAction, void (^)(JKAlertAction *action)))getCancelOrCollectionAction {
    
    return ^(BOOL isCancelAction, void(^getAction)(JKAlertAction *action)) {
        
        JKAlertAction *action = isCancelAction ? [self getCancelAction] : [self getCollectionAction];
        
        !getAction ? : getAction(action);
        
        return self;
    };
}

/** 链式获取action数组 */
- (JKAlertView *(^)(BOOL isSecondCollection, void (^)(NSArray *actionArray)))getActionArrayFrom {
    
    return ^(BOOL isSecondCollection, void(^getActionArray)(NSArray *actionArray)) {
        
        !getActionArray ? : getActionArray([self getActionArrayIsSecondCollection:isSecondCollection]);
        
        return self;
    };
}

/** 链式清空action数组 */
- (JKAlertView *(^)(BOOL isSecondCollection))clearActionArrayFrom {
    
    return ^(BOOL isSecondCollection) {
        
        [self clearActionArrayIsSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 添加action */
- (void)addAction:(JKAlertAction *)action isSecondCollection:(BOOL)isSecondCollection {
    
    if (!action) { return; }
    
    [self setAlertViewToAction:action];
    
    if (isSecondCollection) {
        
        [self checkCollectionSheetStyleHandler:^{
            
            [self.collectionsheetContentView.secondActionArray addObject:action];
        }];
        
    } else {
        
        [self.currentAlertContentView.actionArray addObject:action];
    }
}

/** 移除action */
- (void)removeAction:(JKAlertAction *)action isSecondCollection:(BOOL)isSecondCollection {
    
    if (!action) { return; }
    
    if (isSecondCollection) {
        
        [self checkCollectionSheetStyleHandler:^{
            
            if ([self.collectionsheetContentView.secondActionArray containsObject:action]) {
                
                [self.collectionsheetContentView.secondActionArray removeObject:action];
            }
        }];
        
    } else {
        
        if ([self.currentAlertContentView.actionArray containsObject:action]) {
            
            [self.currentAlertContentView.actionArray removeObject:action];
        }
    }
}

/** 添加action */
- (void)insertAction:(JKAlertAction *)action atIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection {
    
    if (!action) { return; }
    
    [self setAlertViewToAction:action];
    
    if (isSecondCollection) {
        
        [self checkCollectionSheetStyleHandler:^{
            
            [self.collectionsheetContentView.secondActionArray insertObject:action atIndex:index];
        }];
        
    } else {
        
        [self.currentAlertContentView.actionArray insertObject:action atIndex:index];
    }
}

/** 移除action */
- (void)removeActionAtIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection {
    
    if (index < 0) { return; }
    
    if (isSecondCollection) {
        
        [self checkCollectionSheetStyleHandler:^{
            
            if (index >= self.collectionsheetContentView.secondActionArray.count) { return; }
            
            [self.collectionsheetContentView.secondActionArray removeObjectAtIndex:index];
        }];
        
    } else {
        
        if (index >= self.currentAlertContentView.actionArray.count) { return; }
        
        [self.currentAlertContentView.actionArray removeObjectAtIndex:index];
    }
}

/** 获取action */
- (JKAlertAction *)getActionAtIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection {
    
    if (index < 0) { return nil; }
    
    JKAlertAction *action = nil;
    
    if (isSecondCollection) {
        
        if (JKAlertStyleCollectionSheet != self.alertStyle) {
            
            return nil;
        }
        
        if (index >= self.collectionsheetContentView.secondActionArray.count) { return nil; }
        
        action = [self.collectionsheetContentView.secondActionArray objectAtIndex:index];
        
    } else {
        
        if (index >= self.currentAlertContentView.actionArray.count) { return nil; }
        
        action = [self.currentAlertContentView.actionArray objectAtIndex:index];
    }
    
    return action;
}

/** 获取cancelAction */
- (JKAlertAction *)getCancelAction {
    
    return self.currentAlertContentView.cancelAction;
}

/** 获取collectionAction */
- (JKAlertAction *)getCollectionAction {
    
    __block JKAlertAction *action = nil;
    
    [self checkCollectionSheetStyleHandler:^{
        
        action = self.collectionsheetContentView.collectionAction;
    }];
    
    return action;
}

/** 获取action数组 */
- (NSArray *)getActionArrayIsSecondCollection:(BOOL)isSecondCollection {
    
    if (isSecondCollection) {
        
        return (JKAlertStyleCollectionSheet == self.alertStyle) ? [self.collectionsheetContentView.secondActionArray copy] : nil;
        
    } else {
        
        return [self.currentAlertContentView.actionArray copy];
    }
}

/** 清空action数组 */
- (void)clearActionArrayIsSecondCollection:(BOOL)isSecondCollection {
    
    if (isSecondCollection) {
        
        [self checkCollectionSheetStyleHandler:^{
            
            [self.collectionsheetContentView.secondActionArray removeAllObjects];
        }];
        
    } else {
        
        [self.currentAlertContentView.actionArray removeAllObjects];
    }
}



#pragma mark
#pragma mark - 添加textField

/**
 * 添加textField 默认高度30
 * textField之间的间距是1，和其superView的上下左右间距也是1
 * textField可以直接对其superView进行一些属性修改，如背景色
 * block中的参数view用于调用dismiss()来移除当前弹框
 */
- (void)addTextFieldWithConfigurationHandler:(void (^)(JKAlertView *view, UITextField *textField))configurationHandler {
    
    UITextField *tf = [[UITextField alloc] init];
    
    tf.font = [UIFont systemFontOfSize:13];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 1)];
    tf.leftView = leftView;
    tf.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 1)];
    tf.rightView = rightView;
    tf.rightViewMode = UITextFieldViewModeAlways;
    
    [JKAlertThemeProvider providerWithOwner:tf handlerKey:NSStringFromSelector(@selector(backgroundColor)) provideHandler:^(JKAlertThemeProvider *provider, UITextField *providerOwner) {

        providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertLightBackgroundColor(), JKAlertDarkBackgroundColor());
    }];
    
    [self.textFieldArr addObject:tf];
    
    if (self.currentTextField == nil) {
        
        self.currentTextField = tf;
    }
    
    !configurationHandler ? : configurationHandler(self, tf);
}

/**
 * 链式添加textField 默认高度30
 * textField之间的间距是1，和其superView的上下左右间距也是1
 * textField可以直接对其superView进行一些属性修改，如背景色
 * block中的参数view用于调用dismiss()来移除当前弹框
 */
- (JKAlertView *(^)(void (^)(JKAlertView *view, UITextField *textField)))addTextFieldWithConfigurationHandler {
    
    return ^(void (^configurationHandler)(JKAlertView *view, UITextField *textField)) {
        
        [self addTextFieldWithConfigurationHandler:configurationHandler];
        
        return self;
    };
}

/** 显示并监听JKAlertView消失动画完成 */
- (void (^)(void (^handler)(void)))showWithDidDismissHandler {
    
    return ^(void(^handler)(void)) {
        
        [self show];
        
        self.didDismissHandler = handler;
    };
}

#pragma mark
#pragma mark - KVO

- (void)checkObserver {
    
    if (self.observerSuperView &&
        self.observerSuperView != self.superview) {
        
        [self removeAllOberserver];
    }
    
    [self addAllObserver];
}

- (void)addAllObserver {
    
    if (self.observerAdded) { return; }
    
    self.observerSuperView = self.superview;
    
    [self.superview addObserver:self forKeyPath:@"frame" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:nil];
    
    self.observerAdded = YES;
}

- (void)removeAllOberserver {
    
    if (self.observerAdded) {
        
        [self.observerSuperView removeObserver:self forKeyPath:@"frame"];
    }
    
    self.observerAdded = NO;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    if (object == self.superview && [keyPath isEqualToString:@"frame"]) {
        
        CGRect oldFrame = [[change objectForKey:NSKeyValueChangeOldKey] CGRectValue];
        CGRect currentFrame = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue];
        
        if (CGSizeEqualToSize(oldFrame.size, currentFrame.size) ||
            (oldFrame.size.width == currentFrame.size.height &&
             oldFrame.size.height == currentFrame.size.width)) {
            
            // 屏幕旋转由屏幕旋转处理
            
            return;
        }
        
        [self updateWidthHeight];
        
        self.relayout(YES);
    }
}

#pragma mark
#pragma mark - 动画弹出来

- (void)solveDidMoveToSuperview {
    
    if (!self.superview) { return; }
    
    self.frame = self.superview.bounds;
    
    if (self.vibrateEnabled) {
        
        [JKAlertUtility vibrateDevice];
    }
    
    [self startShowAnimation];
    
    [self checkObserver];
}

- (void)startShowAnimation{
    
    self.window.userInteractionEnabled = NO;
    
    !self.willShowHandler ? : self.willShowHandler(self);
    
    JKAlertBaseSheetContentView *sheetContentView = nil;
    
    if (self.customShowAnimationBlock) {
        
        self.customShowAnimationBlock(self, self.alertContentView);
        
    } else {
        
        switch (self.alertStyle) {
            case JKAlertStyleHUD:
            case JKAlertStylePlain:
            {
                self.alertContentView.alpha = 0;
                self.alertContentView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            }
                break;
            case JKAlertStyleActionSheet:
            {
                sheetContentView = self.actionsheetContentView;
            }
                break;
            case JKAlertStyleCollectionSheet:
            {
                sheetContentView = self.collectionsheetContentView;
            }
                break;
                
            default:
                break;
        }
        
        if (sheetContentView) {
            
            CGRect frame = sheetContentView.frame;
            frame.origin.y = self.superHeight;
            sheetContentView.frame = frame;
            
            if (sheetContentView.showScaleAnimated) {
                
                sheetContentView.layer.anchorPoint = CGPointMake(0.5, 1);
            }
        }
    }
    
    self.backgroundView.alpha = 0;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        self.backgroundView.alpha = 1;
        
        [self showAnimationOperation];
        
    } completion:^(BOOL finished) {
        
        if (self.customShowAnimationBlock) { return; }
        
        if (sheetContentView &&
            sheetContentView.showScaleAnimated) {
            
            sheetContentView.verticalDismissPanGesture.enabled = NO;
            
            self.window.userInteractionEnabled = YES;
            
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowUserInteraction  animations:^{
                [UIView setAnimationCurve:(UIViewAnimationCurveEaseInOut)];
                
                sheetContentView.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                
                sheetContentView.verticalDismissPanGesture.enabled = YES;
                
                self.showAnimationDidComplete();
            }];
            
        } else {
            
            self.showAnimationDidComplete();
        }
    }];
}

- (void)showAnimationOperation {
    
    if (self.customShowAnimationBlock) { return; }
    
    JKAlertBaseSheetContentView *sheetContentView = nil;
    
    switch (self.alertStyle) {
        case JKAlertStyleHUD:
        case JKAlertStylePlain:
        {
            self.alertContentView.transform = CGAffineTransformIdentity;
            self.alertContentView.alpha = 1;
        }
            break;
        case JKAlertStyleActionSheet:
        {
            sheetContentView = self.actionsheetContentView;
            
        }
            break;
        case JKAlertStyleCollectionSheet:
        {
            sheetContentView = self.collectionsheetContentView;
        }
            
        default:
            break;
    }
    
    if (!sheetContentView) { return; }
    
    CGRect frame = sheetContentView.frame;
    frame.origin.y = self.superHeight - frame.size.height;
    sheetContentView.frame = frame;
    
    if (sheetContentView.showScaleAnimated) {
        
        [UIView setAnimationCurve:(UIViewAnimationCurveEaseOut)];
        
        sheetContentView.transform = CGAffineTransformMakeScale(1, (sheetContentView.frame.size.height + JKAlertSheetSpringHeight) / sheetContentView.frame.size.height);
    }
}

- (JKAlertBaseSheetContentView *)checkSheetContentView {
    
    if ((JKAlertStyleActionSheet != self.alertStyle) &&
        (JKAlertStyleCollectionSheet != self.alertStyle)) {
        
        return nil;
    }
    
    if ([self.currentAlertContentView isKindOfClass:[JKAlertBaseSheetContentView class]]) {
        
        return (JKAlertBaseSheetContentView *)self.currentAlertContentView;
    }
    
    switch (self.alertStyle) {
        case JKAlertStyleActionSheet:
            
            return self.actionsheetContentView;
            
            break;
            
        case JKAlertStyleCollectionSheet:
            
            return self.collectionsheetContentView;
            
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (void (^)(void))showAnimationDidComplete {
    
    self.window.userInteractionEnabled = YES;
    
    !self.didShowHandler ? : self.didShowHandler(self);
    
    if (_plainContentView.autoShowKeyboard && self.currentTextField) {
        
        if (!self.currentTextField.hidden) {
            
            if (!self.currentTextField.isFirstResponder) {
                
                [self.currentTextField becomeFirstResponder];
            }
            
        } else {
            
            for (UITextField *tf in _textFieldArr) {
                
                if (tf.hidden) { continue; }
                
                if (!tf.isFirstResponder) {
                    
                    [tf becomeFirstResponder];
                }
                
                break;
            }
        }
    }
    
    if (self.dismissTimeInterval > 0 &&
        (JKAlertStyleHUD == self.alertStyle ||
         nil != self.customHUD)) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.dismissTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismiss];
        });
    }
    
    return ^{};
}

#pragma mark
#pragma mark - 监听键盘

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    
    if (JKAlertStylePlain != self.alertStyle) { return; }
    
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect frame = self.alertContentView.frame;
    
    NSNumber *curve = notification.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    
    NSInteger animationCurve = ((curve != nil) ? [curve integerValue] : 7);
    
    if (keyboardFrame.origin.y >= self.superHeight) { // 退出键盘
        
        self.maxPlainHeight = self.superHeight - 100;
        
        [self calculateUI];
        
        [UIView animateWithDuration:0.25 animations:^{
            [UIView setAnimationCurve:animationCurve];
            
            [self layoutIfNeeded];
        }];
        
    } else { // 弹出键盘
        
        CGFloat maxH = self.superHeight - (JKAlertUtility.isDeviceX ? 44 : 20) - keyboardFrame.size.height - 40;
        
        BOOL lockKeyboardMargin = (self.plainKeyboardMargin > 0);
        
        if ([self isLandScape]) {
            
            maxH = self.superHeight - 5 - keyboardFrame.size.height - 5;
            
        } else if (lockKeyboardMargin) {
            
            maxH = maxH + 20 - self.plainKeyboardMargin;
        }
        
        if (frame.size.height <= maxH) {
            
            frame.origin.y = (JKAlertUtility.isDeviceX ? 44 : 20) + (maxH - frame.size.height) * 0.5;
            
            if (lockKeyboardMargin) {
                
                frame.origin.y = keyboardFrame.origin.y - self.plainKeyboardMargin - frame.size.height;
            }
            
            if ([self isLandScape]) {
                
                frame.origin.y = 5 + (maxH - frame.size.height) * 0.5;
            }
            
            [self updatePlainFrameY:frame.origin.y animated:YES];
            
            return;
        }
        
        self.maxPlainHeight = maxH;
        
        [self calculateUI];
        
        frame = self.alertContentView.frame;
        
        if ([self isLandScape]) {
            
            frame.origin.y = 5;
            
        } else if (lockKeyboardMargin) {
            
            frame.origin.y = keyboardFrame.origin.y - self.plainKeyboardMargin - frame.size.height;
            
            frame.origin.y = MAX(frame.origin.y, (JKAlertUtility.isDeviceX ? 44 : 20));
            
        } else {
            
            frame.origin.y = (JKAlertUtility.isDeviceX ? 44 : 20);
        }
        
        self.alertContentView.frame = frame;
        
        [UIView animateWithDuration:0.25 animations:^{
            [UIView setAnimationCurve:animationCurve];
            
            [self layoutIfNeeded];
        }];
    }
}

#pragma mark
#pragma mark - 退出

- (void)dismissButtonClick:(UIButton *)button {
    
    [JKAlertUtility.keyWindow endEditing:YES];
    
    !self.blankClickBlock ? : self.blankClickBlock();
    
    !self.tapBlankHandler ? : self.tapBlankHandler(self);
    
    if (_tapBlankDismiss) {
        
        self.dismiss();
        
        return;
    }
    
    JKAlertBaseSheetContentView *sheetContentView = [self checkSheetContentView];
    
    if (!sheetContentView) { return; }
    
    if (!sheetContentView.verticalGestureDismissEnabled &&
        !sheetContentView.horizontalGestureDismissEnabled) {
        
        return;
    }
    
    if ([sheetContentView.layer animationForKey:JKAlertDismissFailedShakeAnimationKey]) { return; }
    
    // 动画抖一下
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.repeatCount = 1;
    animation.values = @[@(-2), @(-4), @(-6), @(3), @0];
    animation.duration = 0.5;
    [sheetContentView.layer addAnimation:animation forKey:JKAlertDismissFailedShakeAnimationKey];
}

// 通过通知来dismiss
- (void)dismissAllNotification:(NSNotification *)note {
    
    if (self.isDismissAllNoneffective) { return; }
    
    self.dismiss();
}

// 通过key通知来dismiss
- (void)dismissForKeyNotification:(NSNotification *)note {
    
    if (!self.dismissKey) { return; }
    
    if ([note.object isKindOfClass:[NSString class]] &&
        [note.object isEqualToString:self.dismissKey]) {
        
        self.dismiss();
    }
}

// 通过category通知来dismiss
- (void)dismissForCategoryNotification:(NSNotification *)note {
    
    if (!self.dismissCategory) { return; }
    
    if ([note.object isKindOfClass:[NSString class]] &&
        [note.object isEqualToString:self.dismissCategory]) {
        
        self.dismiss();
    }
}

// 通过通知来dismiss
- (void)clearAllNotification:(NSNotification *)note {
    
    self.dismiss();
}

- (void (^)(void))dismiss {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self startDismissAnimation];
    
    return ^{};
}

- (void)startDismissAnimation {
    
    self.window.userInteractionEnabled = NO;
    
    // 即将消失
    !self.willDismissHandler ? : self.willDismissHandler();
    
    if (!self.isSheetDismissHorizontal) {
        
        // 自定义消失动画
        !self.customDismissAnimationBlock ? : self.customDismissAnimationBlock(self, self.alertContentView);
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backgroundView.alpha = 0;
        
        [self dismissAnimationOperation];
        
    } completion:^(BOOL finished) {
        
        if (self.customDismissAnimationBlock && !self.isSheetDismissHorizontal) { return; }
        
        self.dismissAnimationDidComplete();
    }];
}

- (void)dismissAnimationOperation {
    
    if (self.customDismissAnimationBlock &&
        !self.isSheetDismissHorizontal) {
        
        return;
    }
    
    CGRect frame = self.currentAlertContentView.frame;
    
    if (self.isSheetDismissHorizontal) {
        
        frame.origin.x = self.superWidth;
        
        self.currentAlertContentView.frame = frame;
        
        return;
    }
    
    switch (self.alertStyle) {
        case JKAlertStyleHUD:
        case JKAlertStylePlain:
        {
            self.alertContentView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            self.alertContentView.alpha = 0;
        }
            break;
        case JKAlertStyleActionSheet:
        case JKAlertStyleCollectionSheet:
        {
            frame.origin.y = self.superHeight;
            self.currentAlertContentView.frame = frame;
        }
            break;
            
        default:
            break;
    }
}

- (void (^)(void))dismissAnimationDidComplete {
    
    self.window.userInteractionEnabled = YES;
    
    // 消失完成
    !self.didDismissHandler ? : self.didDismissHandler();
    
    [self.currentAlertContentView.actionArray removeAllObjects];
    self.currentAlertContentView.actionArray = nil;
    
    if (JKAlertStyleCollectionSheet == self.alertStyle) {
        
        [self.collectionsheetContentView.secondActionArray removeAllObjects];
        self.collectionsheetContentView.secondActionArray = nil;
    }
    
    [self removeFromSuperview];
    
    return ^{};
}

#pragma mark
#pragma mark - JKAlertBaseAlertContentViewDelegate

/// 执行action的handler操作
- (void)alertContentView:(JKAlertBaseAlertContentView *)alertContentView executeHandlerOfAction:(JKAlertAction *)action {
    
    if (action.autoDismiss && ![action isEmpty]) {
        
        self.isSheetDismissHorizontal = NO;
        
        [self dismiss];
    }
    
    !action.handler ? : action.handler(action);
}

/// 执行dismiss操作
- (void)alertContentViewExecuteDismiss:(JKAlertBaseAlertContentView *)alertContentView isHorizontal:(BOOL)isHorizontal {

    self.isSheetDismissHorizontal = isHorizontal;
    
    [self dismiss];
}

#pragma mark
#pragma mark - Override

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    [self solveDidMoveToSuperview];
}

#pragma mark
#pragma mark - Private Methods

- (void)addNotifications {
    
    if (@available(iOS 13.0, *)) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeStyleDidChangeNotification:) name:JKAlertThemeStyleDidChangeNotification object:nil];
    }
    
    // 屏幕旋转的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    // 移除全部的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissAllNotification:) name:JKAlertDismissAllNotification object:nil];
    
    // 根据key来移除的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissForKeyNotification:) name:JKAlertDismissForKeyNotification object:nil];
    
    // 根据category来移除的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissForCategoryNotification:) name:JKAlertDismissForCategoryNotification object:nil];
    
    // 清空全部的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearAllNotification:) name:JKAlertClearAllNotification object:nil];
}

- (void)addKeyboardWillChangeFrameNotification {
    
    // 键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)removeKeyboardWillChangeFrameNotification {
    
    // 键盘
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)themeStyleDidChangeNotification:(NSNotification *)note {
    
    if (@available(iOS 13.0, *)) {
        
        self.overrideUserInterfaceStyle = (UIUserInterfaceStyle)[note.object integerValue];
    }
}

#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 */
- (void)initializeProperty {
    [super initializeProperty];
    
    if (@available(iOS 13.0, *)) {
        
        self.overrideUserInterfaceStyle = (UIUserInterfaceStyle)[JKAlertThemeManager sharedManager].themeStyle;
    }
    
    _superWidth =  self.customSuperView.bounds.size.width;
    
    _superHeight =  self.customSuperView.bounds.size.height;
    
    _isLandScape = [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight;
    
    _maxPlainHeight = (self.superHeight - 100);
    
    _maxSheetHeight = (self.superHeight > self.superWidth) ? self.superHeight * 0.85 : self.superHeight * 0.8;
    
    _deallocLogEnabled = NO;
    
    _dismissTimeInterval = 1;
    
    _plainWidth = 290;
    
    _originalPlainWidth = _plainWidth;
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
    [self addNotifications];
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

- (UIView *)customSuperView {
    
    if (!_customSuperView) {
        
        _customSuperView = JKAlertUtility.keyWindow;
    }
    
    return _customSuperView;
}

- (UIView *)alertContentView {
    
    if (self.currentAlertContentView) {
        
        return self.currentAlertContentView;
    }
    
    UIView *alertContentView = nil;
    
    switch (self.alertStyle) {
        case JKAlertStylePlain:
        {
            alertContentView = self.plainContentView;
        }
            break;
        case JKAlertStyleActionSheet:
        {
            alertContentView = self.actionsheetContentView;
        }
            break;
        case JKAlertStyleCollectionSheet:
        {
            alertContentView = self.collectionsheetContentView;
        }
            break;
        case JKAlertStyleHUD:
        {
            alertContentView = self.hudContentView;
        }
            break;
            
        default:
            break;
    }
    
    return alertContentView;
}

- (JKAlertPlainContentView *)plainContentView {
    if (!_plainContentView) {
        JKAlertPlainContentView *plainContentView = [[JKAlertPlainContentView alloc] init];
        plainContentView.delegate = self;
        [self addSubview:plainContentView];
        _plainContentView = plainContentView;
    }
    return _plainContentView;
}

- (JKAlertHUDContentView *)hudContentView {
    if (!_hudContentView) {
        JKAlertHUDContentView *hudContentView = [[JKAlertHUDContentView alloc] init];
        hudContentView.delegate = self;
        [self addSubview:hudContentView];
        _hudContentView = hudContentView;
    }
    return _hudContentView;
}

- (JKAlerActionSheetContentView *)actionsheetContentView {
    if (!_actionsheetContentView) {
        JKAlerActionSheetContentView *actionsheetContentView = [[JKAlerActionSheetContentView alloc] init];
        actionsheetContentView.delegate = self;
        [self addSubview:actionsheetContentView];
        _actionsheetContentView = actionsheetContentView;
    }
    return _actionsheetContentView;
}

- (JKAlertCollectionSheetContentView *)collectionsheetContentView {
    if (!_collectionsheetContentView) {
        JKAlertCollectionSheetContentView *collectionsheetContentView = [[JKAlertCollectionSheetContentView alloc] init];
        collectionsheetContentView.delegate = self;
        [self addSubview:collectionsheetContentView];
        _collectionsheetContentView = collectionsheetContentView;
    }
    return _collectionsheetContentView;
}

- (NSMutableArray *)textFieldArr {
    if (!_textFieldArr) {
        _textFieldArr = [NSMutableArray array];
    }
    return _textFieldArr;
}

- (UIButton *)closeButton {
    
    if (_alertStyle != JKAlertStylePlain) { return nil; }
    
    if (!_closeButton) {
        
        UIButton *closeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [closeButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        closeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        closeButton.frame = CGRectMake(self.plainWidth - 30, 5, 25, 25);
        [self.alertContentView addSubview:closeButton];
        
        [closeButton addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
        
        _closeButton = closeButton;
    }
    return _closeButton;
}

#pragma mark
#pragma mark - dealloc

- (void)dealloc {
    
    [self removeAllOberserver];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.deallocLogEnabled) {
        
        NSLog(@"[ClassName: %@], %d, %s", NSStringFromClass([self class]), __LINE__, __func__);
    }
    
    !self.deallocHandler ? : self.deallocHandler();
}
@end
