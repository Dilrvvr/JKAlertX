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

@interface JKAlertView ()

@end

@implementation JKAlertView

#pragma mark
#pragma mark - 类方法

+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                             style:(JKAlertStyle)style {
    
    JKAlertView *alertView = [[JKAlertView alloc] init];
    
    alertView.alertStyle = style;
    alertView.alertTitle = [title copy];
    alertView.alertMessage = [message copy];
    
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
    
    JKAlertView *alertView = [[JKAlertView alloc] init];
    
    alertView.alertStyle = style;
    alertView.alertAttributedTitle = [attributedTitle copy];
    alertView.attributedMessage = [attributedMessage copy];
    
    return alertView;
}

/** 函数式类方法 */
+ (JKAlertView *(^)(NSString *title, NSString *message, JKAlertStyle style, void(^)(JKAlertView *alertView)))show {
    
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
#pragma mark - 显示

/** 显示 */
- (JKAlertView *(^)(void))show {
    
    [JKAlertKeyWindow() endEditing:YES];
    
    if (self.isShowed) { return ^{ return self; }; }
    
    self.isShowed = YES;
    
    switch (self.alertStyle) {
        case JKAlertStyleCollectionSheet:
        {
            [self calculateUI];//[self showCollectionSheet];
        }
            break;
            
        default:
            [self calculateUI];
            break;
    }
    
    !self.alertContentViewConfiguration ? : self.alertContentViewConfiguration(self.alertContentView);
    
    // customSuperView没有则默认keyWindow
    [self.customSuperView addSubview:self];
    
    return ^{ return self; };
}

// sheet样式
- (void)showAcitonSheet{
    
    if (!self.cancelAction) {
        
        self.cancelAction = [JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {}];
        self.cancelAction.setTitleFont([UIFont systemFontOfSize:17]);
        self.cancelAction.setTitleColor(JKAlertAdaptColor(JKAlertSameRGBColor(51), JKAlertSameRGBColor(204)));
    }
    
    self.cancelAction.setSeparatorLineHidden(YES);
    [self.actions.lastObject setSeparatorLineHidden:YES];
    
    [self calculateUI];
}

// collectionSheet样式
- (void)showCollectionSheet{
    
    if (!self.cancelAction) {
        
        self.cancelAction = [JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {}];
        self.cancelAction.setTitleFont([UIFont systemFontOfSize:17]);
        self.cancelAction.setTitleColor(JKAlertAdaptColor(JKAlertSameRGBColor(51), JKAlertSameRGBColor(204)));
    }
    
    [self calculateUI];
}

#pragma mark
#pragma mark - 计算布局

- (void)updatePlainWidth {
    
    if (!self.autoReducePlainWidth) { return; }
    
    CGFloat safeAreaInset = 0;
    
    if (@available(iOS 11.0, *)) {
        
        safeAreaInset = MAX(self.customSuperView.safeAreaInsets.left, self.customSuperView.safeAreaInsets.right);
    }
    
    PlainViewWidth = MIN(OriginalPlainWidth, JKAlertScreenW - safeAreaInset * 2);
}

- (UIEdgeInsets)getSuperViewSafeAreaInsets {
    
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    
    if (@available(iOS 11.0, *)) {
        
        safeAreaInsets = self.customSuperView.safeAreaInsets;
        
        UIWindow *keyWindow = JKAlertKeyWindow();
        
        UIEdgeInsets windowSafeAreaInsets = keyWindow.safeAreaInsets;
        
        CGFloat safeWidth = keyWindow.frame.size.width - windowSafeAreaInsets.left - windowSafeAreaInsets.right;
        
        if (self.customSuperView.frame.size.width > safeWidth) {
            
            safeAreaInsets.left = windowSafeAreaInsets.left;
            safeAreaInsets.right = windowSafeAreaInsets.right;
        }
    }
    
    return safeAreaInsets;
}

- (void)calculatePlainUI {
    
    [self updatePlainWidth];
    
    // TODO: JKTODO <#注释#>
    self.plainContentView.textContentView.alertTitle = self.alertTitle;
    self.plainContentView.textContentView.alertAttributedTitle = self.alertAttributedTitle;
    
    self.plainContentView.textContentView.alertMessage = self.alertMessage;
    self.plainContentView.textContentView.attributedMessage = self.attributedMessage;
    
    self.plainContentView.actionArray = self.actions;
    self.plainContentView.textFieldArray = self.textFieldArr;
    
    self.plainContentView.contentWidth = PlainViewWidth;
    self.plainContentView.maxHeight = JKAlertPlainViewMaxH;
    [self.plainContentView calculateUI];
    
    self.plainContentView.center = CGPointMake(JKAlertScreenW * 0.5 + self.plainCenterOffset.x, JKAlertScreenH * 0.5 + self.plainCenterOffset.y);
}

- (void)calculateHudUI {
    
    if (self.customHUD) {
        
        self.hudContentView.textContentView.customContentView = self.customHUD;
        
    } else {
        
        self.hudContentView.textContentView.alertTitle = self.alertTitle;
        self.hudContentView.textContentView.alertAttributedTitle = self.alertAttributedTitle;
    }
    
    [self updatePlainWidth];
    
    
    // TODO: JKTODO <#注释#>
    self.hudContentView.contentWidth = PlainViewWidth;
    self.hudContentView.maxHeight = JKAlertPlainViewMaxH;
    [self.hudContentView calculateUI];
    
    self.hudContentView.center = CGPointMake(JKAlertScreenW * 0.5 + self.plainCenterOffset.x, JKAlertScreenH * 0.5 + self.plainCenterOffset.y);
}

- (void)calculateActionSheetUI {
    
    if (!self.cancelAction) {
        
        self.cancelAction = [JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {}];
        self.cancelAction.setTitleFont([UIFont systemFontOfSize:17]);
        self.cancelAction.setTitleColor(JKAlertAdaptColor(JKAlertSameRGBColor(51), JKAlertSameRGBColor(204)));
    }
    
    self.cancelAction.setSeparatorLineHidden(YES);
    [self.actions.lastObject setSeparatorLineHidden:YES];
    
    self.actionsheetContentView.textContentView.alertTitle = self.alertTitle;
    self.actionsheetContentView.textContentView.alertAttributedTitle = self.alertAttributedTitle;
    
    self.actionsheetContentView.textContentView.alertMessage = self.alertMessage;
    self.actionsheetContentView.textContentView.attributedMessage = self.attributedMessage;
    
    self.actionsheetContentView.actionArray = self.actions;
    self.actionsheetContentView.cancelAction = self.cancelAction;
    
    UIEdgeInsets safeAreaInsets = [self getSuperViewSafeAreaInsets];
    
    safeAreaInsets.top = 0;
    
    self.actionsheetContentView.screenSafeInsets = safeAreaInsets;
    
    CGFloat contentWidth = JKAlertScreenW;
    
    if (self.actionsheetContentView.isPierced) {
        
        contentWidth -= (self.actionsheetContentView.piercedInsets.left + self.actionsheetContentView.piercedInsets.right + self.actionsheetContentView.screenSafeInsets.left + self.actionsheetContentView.screenSafeInsets.right);
    }
    
    // TODO: JKTODO <#注释#>
    self.actionsheetContentView.contentWidth = contentWidth;
    self.actionsheetContentView.maxHeight = JKAlertSheetMaxH;
    [self.actionsheetContentView calculateUI];
    
    CGRect frame = self.actionsheetContentView.frame;
    frame.origin.x = self.actionsheetContentView.isPierced ? self.actionsheetContentView.screenSafeInsets.left + self.actionsheetContentView.piercedInsets.left : 0;
    frame.origin.y = JKAlertScreenH - frame.size.height;
    self.actionsheetContentView.frame = frame;
}

- (void)calculateCollectionSheetUI {
    
    if (!self.cancelAction) {
        
        self.cancelAction = [JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {}];
        self.cancelAction.setTitleFont([UIFont systemFontOfSize:17]);
        self.cancelAction.setTitleColor(JKAlertAdaptColor(JKAlertSameRGBColor(51), JKAlertSameRGBColor(204)));
    }
    
    self.cancelAction.setSeparatorLineHidden(YES);
    
    self.collectionsheetContentView.textContentView.alertTitle = self.alertTitle;
    self.collectionsheetContentView.textContentView.alertAttributedTitle = self.alertAttributedTitle;
    
    self.collectionsheetContentView.actionArray = self.actions;
    self.collectionsheetContentView.actionArray2 = self.actions2;
    self.collectionsheetContentView.cancelAction = self.cancelAction;
    self.collectionsheetContentView.collectionAction = self.collectionAction;
    
    UIEdgeInsets safeAreaInsets = [self getSuperViewSafeAreaInsets];
    
    safeAreaInsets.top = 0;
    
    self.collectionsheetContentView.screenSafeInsets = safeAreaInsets;
    
    CGFloat contentWidth = JKAlertScreenW;
    
    // TODO: JKTODO <#注释#>
    self.collectionsheetContentView.contentWidth = contentWidth;
    self.collectionsheetContentView.maxHeight = JKAlertSheetMaxH;
    
    [self.collectionsheetContentView calculateUI];
    
    CGRect frame = self.collectionsheetContentView.frame;
    frame.origin.x = 0;
    frame.origin.y = JKAlertScreenH - frame.size.height;
    self.collectionsheetContentView.frame = frame;
}

#pragma mark
#pragma mark - Setter

- (void)setAlertStyle:(JKAlertStyle)alertStyle {
    _alertStyle = alertStyle;
    
    _tapBlankDismiss = NO;
    
    switch (_alertStyle) {
        case JKAlertStyleHUD:
        {
            _currentAlertContentView = self.hudContentView;
            _currentTextContentView = self.hudContentView.textContentView;
            
            self.multiBackgroundColor = [JKAlertMultiColor colorWithNoColor];
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
            // TODO: JKTODO <#注释#>
            //CancelMargin = 10;
            
            _tapBlankDismiss = YES;
            
            //[self collectionView];
            
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

/** 设置默认的取消action，不需要自带的可以自己设置，不可置为nil */
- (void)setCancelAction:(JKAlertAction *)cancelAction{
    
    if (cancelAction == nil) {
        return;
    }
    
    _cancelAction = cancelAction;
    
    [self setAlertViewToAction:_cancelAction];
}

- (void)setAlertViewToAction:(JKAlertAction *)action {
    
    action.alertView = self;
    
    if (JKAlertStyleActionSheet == self.alertStyle) {

        action.isPierced = self.actionsheetContentView.isPierced;
        action.multiPiercedBackgroundColor = self.actionsheetContentView.piercedBackgroundColor;
        
    } else if (JKAlertStyleCollectionSheet == self.alertStyle) {

        action.isPierced = self.collectionsheetContentView.isPierced;
        action.multiPiercedBackgroundColor = self.collectionsheetContentView.piercedBackgroundColor;
    }
}

/**
 * 设置collection的itemSize的宽度
 * 最大不可超过屏幕宽度的一半
 * 注意图片的宽高是设置的宽度-30，即图片在cell中是左右各15的间距
 * 自动计算item之间间距，最小为0，可自己计算该值设置每屏显示个数
 * 默认的高度是宽度-6，暂不支持自定义高度
 */
- (void)setFlowlayoutItemWidth:(CGFloat)flowlayoutItemWidth{
    
    _flowlayoutItemWidth = flowlayoutItemWidth > JKAlertScreenW * 0.5 ? JKAlertScreenW * 0.5 : flowlayoutItemWidth;
}

- (void)setCustomHUD:(UIView *)customHUD {
    
    if (self.alertStyle != JKAlertStyleHUD) { return; }
    
    _customHUD = customHUD;
    
    // TODO: JKTODO <#注释#>
    if (self.customHUD.frame.size.width <= 0) { return; }
    
    PlainViewWidth = self.customHUD.frame.size.width;
    
    OriginalPlainWidth = PlainViewWidth;
}

#pragma mark
#pragma mark - 链式Setter

/** 设置默认的取消action，不需要自带的可以自己设置，不可置为nil */
- (JKAlertView *(^)(JKAlertAction *action))setCancelAction{
    
    return ^(JKAlertAction *action) {
        
        self.cancelAction = action;
        
        return self;
    };
}

/**
 * 设置plain样式Y值
 */
- (JKAlertView *(^)(CGFloat Y, BOOL animated))setPlainY{
    
    return ^(CGFloat Y, BOOL animated) {
        
        CGRect frame = self.alertContentView.frame;
        frame.origin.y = Y;
        
        if (animated) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.alertContentView.frame = frame;
            }];
            
        } else {
            
            self.alertContentView.frame = frame;
        }
        
        return self;
    };
}

/**
 * 设置自定义展示动画，动画完成一定要调用showAnimationDidComplete
 * 此时所有frame已经计算好，plain样式animationView在中间，sheet样式animationView在底部
 */
- (JKAlertView *(^)(void (^)(JKAlertView *view, UIView *animationView)))setCustomShowAnimationBlock{
    
    return ^(void (^showAnimationBlock)(JKAlertView *view, UIView *animationView)) {
        
        self.customShowAnimationBlock = showAnimationBlock;
        
        return self;
    };
}

/** 设置自定义消失动画 */
- (JKAlertView *(^)(void (^)(JKAlertView *view, UIView *animationView)))setCustomDismissAnimationBlock{
    
    return ^(void (^dismissAnimationBlock)(JKAlertView *view, UIView *animationView)) {
        
        self.customDismissAnimationBlock = dismissAnimationBlock;
        
        return self;
    };
}

#pragma mark
#pragma mark - 监听屏幕旋转

- (void)orientationChanged:(NSNotification *)noti{
    
    !self.orientationDidChangeHandler ? : self.orientationDidChangeHandler(self, [UIApplication sharedApplication].statusBarOrientation);
    
    [self updateWidthHeight];
    
    self.relayout(NO);
}

#pragma mark
#pragma mark - 添加action

/** 添加action */
- (JKAlertView *(^)(JKAlertAction *action))addAction{
    
    return ^(JKAlertAction *action) {
        
        [self addAction:action];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(JKAlertAction *action))removeAction{
    
    return ^(JKAlertAction *action) {
        
        [self removeAction:action];
        
        return self;
    };
}

/** 链式添加action */
- (JKAlertView *(^)(JKAlertAction *action, NSUInteger atIndex))insertAction{
    
    return ^(JKAlertAction *action, NSUInteger atIndex) {
        
        [self insertAction:action atIndex:atIndex];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(NSUInteger index))removeActionAtIndex{
    
    return ^(NSUInteger index) {
        
        [self removeActionAtIndex:index];
        
        return self;
    };
}

/** 链式获取action */
- (JKAlertView *(^)(NSUInteger index, void(^)(JKAlertAction *action)))getActionAtIndex{
    
    return ^(NSUInteger index, void(^getAction)(JKAlertAction *action)) {
        
        JKAlertAction *action = [self getActionAtIndex:index];
        
        !getAction ? : getAction(action);
        
        return self;
    };
}

/** 添加action */
- (void)addAction:(JKAlertAction *)action{
    
    if (!action) { return; }
    
    [self setAlertViewToAction:action];
    
    [self.actions addObject:action];
}

/** 移除action */
- (void)removeAction:(JKAlertAction *)action{
    
    if (!action || ![self.actions containsObject:action]) { return; }
    
    [self.actions removeObject:action];
}

/** 添加action */
- (void)insertAction:(JKAlertAction *)action atIndex:(NSUInteger)index{
    
    if (!action) { return; }
    
    [self setAlertViewToAction:action];
    
    [self.actions insertObject:action atIndex:index];
}

/** 移除action */
- (void)removeActionAtIndex:(NSUInteger)index{
    
    if (index < 0 || index >= self.actions.count) { return; }
    
    [self.actions removeObjectAtIndex:index];
}

/** 获取action */
- (JKAlertAction *)getActionAtIndex:(NSUInteger)index{
    
    if (index < 0 || index >= self.actions.count) { return nil; }
    
    JKAlertAction *action = [self.actions objectAtIndex:index];
    
    return action;
}


#pragma mark
#pragma mark - action数组操作

/** 添加action */
- (JKAlertView *(^)(JKAlertAction *action, BOOL isSecondCollection))addActionTo{
    
    return ^(JKAlertAction *action, BOOL isSecondCollection) {
        
        [self addAction:action isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(JKAlertAction *action, BOOL isSecondCollection))removeActionFrom{
    
    return ^(JKAlertAction *action, BOOL isSecondCollection) {
        
        [self removeAction:action isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式添加action */
- (JKAlertView *(^)(JKAlertAction *action, NSUInteger atIndex, BOOL isSecondCollection))insertActionTo{
    
    return ^(JKAlertAction *action, NSUInteger atIndex, BOOL isSecondCollection) {
        
        [self insertAction:action atIndex:atIndex isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(NSUInteger index, BOOL isSecondCollection))removeActionAtIndexFrom{
    
    return ^(NSUInteger index, BOOL isSecondCollection) {
        
        [self removeActionAtIndex:index isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式获取action */
- (JKAlertView *(^)(NSUInteger index, BOOL isSecondCollection, void(^)(JKAlertAction *action)))getActionAtIndexFrom{
    
    return ^(NSUInteger index, BOOL isSecondCollection, void(^getAction)(JKAlertAction *action)) {
        
        JKAlertAction *action = [self getActionAtIndex:index isSecondCollection:isSecondCollection];
        
        !getAction ? : getAction(action);
        
        return self;
    };
}

/** 链式获取cancelAction或collectionAction */
- (JKAlertView *(^)(BOOL isCancelAction, void(^)(JKAlertAction *action)))getCancelOrCollectionAction{
    
    return ^(BOOL isCancelAction, void(^getAction)(JKAlertAction *action)) {
        
        JKAlertAction *action = isCancelAction ? [self getCancelAction] : [self getCollectionAction];
        
        !getAction ? : getAction(action);
        
        return self;
    };
}

/** 链式获取action数组 */
- (JKAlertView *(^)(BOOL isSecondCollection, void(^)(NSArray *actionArray)))getActionArrayFrom{
    
    return ^(BOOL isSecondCollection, void(^getActionArray)(NSArray *actionArray)) {
        
        !getActionArray ? : getActionArray([self getActionArrayIsSecondCollection:isSecondCollection]);
        
        return self;
    };
}

/** 链式清空action数组 */
- (JKAlertView *(^)(BOOL isSecondCollection))clearActionArrayFrom{
    
    return ^(BOOL isSecondCollection) {
        
        [self clearActionArrayIsSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 添加action */
- (void)addAction:(JKAlertAction *)action isSecondCollection:(BOOL)isSecondCollection{
    
    if (!action) { return; }
    
    [self setAlertViewToAction:action];
    
    if (isSecondCollection) {
        
        [self.actions2 addObject:action];
        
    } else {
        
        [self.actions addObject:action];
    }
}

/** 移除action */
- (void)removeAction:(JKAlertAction *)action isSecondCollection:(BOOL)isSecondCollection{
    
    if (!action) { return; }
    
    if (isSecondCollection) {
        
        if ([self.actions2 containsObject:action]) {
            
            [self.actions2 removeObject:action];
        }
        
    } else {
        
        if ([self.actions containsObject:action]) {
            
            [self.actions removeObject:action];
        }
    }
}

/** 添加action */
- (void)insertAction:(JKAlertAction *)action atIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection{
    
    if (!action) { return; }
    
    [self setAlertViewToAction:action];
    
    if (isSecondCollection) {
        
        [self.actions2 insertObject:action atIndex:index];
        
    } else {
        
        [self.actions insertObject:action atIndex:index];
    }
}

/** 移除action */
- (void)removeActionAtIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection{
    
    if (index < 0) { return; }
    
    if (isSecondCollection) {
        
        if (index >= self.actions2.count) { return; }
        
        [self.actions2 removeObjectAtIndex:index];
        
    } else {
        
        if (index >= self.actions.count) { return; }
        
        [self.actions removeObjectAtIndex:index];
    }
}

/** 获取action */
- (JKAlertAction *)getActionAtIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection{
    
    if (index < 0) { return nil; }
    
    JKAlertAction *action = nil;
    
    if (isSecondCollection) {
        
        if (index >= self.actions2.count) { return nil; }
        
        action = [self.actions2 objectAtIndex:index];
        
    } else {
        
        if (index >= self.actions.count) { return nil; }
        
        action = [self.actions objectAtIndex:index];
    }
    
    return action;
}

/** 获取cancelAction */
- (JKAlertAction *)getCancelAction{
    
    return _cancelAction;
}

/** 获取collectionAction */
- (JKAlertAction *)getCollectionAction{
    
    return _collectionAction;
}

/** 获取action数组 */
- (NSArray *)getActionArrayIsSecondCollection:(BOOL)isSecondCollection{
    
    if (isSecondCollection) {
        
        return [self.actions2 copy];
        
    } else {
        
        return [self.actions copy];
    }
}

/** 清空action数组 */
- (void)clearActionArrayIsSecondCollection:(BOOL)isSecondCollection{
    
    if (isSecondCollection) {
        
        [_actions2 removeAllObjects];
        
    } else {
        
        [_actions removeAllObjects];
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
- (void)addTextFieldWithConfigurationHandler:(void (^)(JKAlertView *view, UITextField *textField))configurationHandler{
    
    UITextField *tf = [[UITextField alloc] init];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 1)];
    tf.leftView = leftView;
    tf.leftViewMode = UITextFieldViewModeAlways;
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 1)];
    tf.rightView = rightView;
    tf.rightViewMode = UITextFieldViewModeAlways;
    tf.font = [UIFont systemFontOfSize:13];
    tf.backgroundColor = JKAlertGlobalBackgroundColor();
    
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
- (JKAlertView *(^)(void (^)(JKAlertView *view, UITextField *textField)))addTextFieldWithConfigurationHandler{
    
    return ^(void (^configurationHandler)(JKAlertView *view, UITextField *textField)) {
        
        [self addTextFieldWithConfigurationHandler:configurationHandler];
        
        return self;
    };
}

/** 显示并监听JKAlertView消失动画完成 */
- (void(^)(void(^handler)(void)))showWithDidDismissHandler {
    
    return ^(void(^handler)(void)) {
        
        [self show];
        
        self.didDismissHandler = handler;
    };
}

#pragma mark
#pragma mark - 计算frame

- (void)calculateUI {
    
    self.frame = CGRectMake(0, 0, JKAlertScreenW, JKAlertScreenH);
    
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
    
    [self calculateUIFinish];
}

- (void)calculateUIFinish {
    
    correctContainerY = JKAlertScreenH - _sheetContainerView.frame.size.height;
}

#pragma mark
#pragma mark - 动画弹出来

- (void)solveDidMoveToSuperview {
    
    if (!self.superview) { return; }
    
    self.frame = self.superview.bounds;
    
    if (self.vibrateEnabled) {
        
        JKAlertVibrateDevice();
    }
    
    [self startShowAnimation];
    
    if (self.observerSuperView && self.observerSuperView != self.superview) {
        
        [self removeAllOberserver];
    }
    
    if (ObserverAdded) { return; }
    
    self.observerSuperView = self.superview;
    
    [self.superview addObserver:self forKeyPath:@"frame" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:nil];
    
    ObserverAdded = YES;
}

- (void)removeAllOberserver{
    
    if (ObserverAdded) {
        
        [self.observerSuperView removeObserver:self forKeyPath:@"frame"];
    }
    
    ObserverAdded = NO;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
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

- (void)startShowAnimation{
    
    self.window.userInteractionEnabled = NO;
    
    !self.willShowHandler ? : self.willShowHandler(self);
    
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
                CGRect frame = self.actionsheetContentView.frame;
                frame.origin.y = JKAlertScreenHeight;
                self.actionsheetContentView.frame = frame;
            }
                break;
            case JKAlertStyleCollectionSheet:
            {
                CGRect frame = self.collectionsheetContentView.frame;
                frame.origin.y = JKAlertScreenHeight;
                self.collectionsheetContentView.frame = frame;
                // TODO: JKTODO <#注释#>
                /*
                _sheetContainerView.frame = CGRectMake(_sheetContainerView.frame.origin.x, JKAlertScreenH, _sheetContainerView.frame.size.width, _sheetContainerView.frame.size.height);
                
                if (_enableVerticalGestureDismiss &&
                    (_sheetContainerView != nil)) {
                    _sheetContainerView.layer.anchorPoint = CGPointMake(0.5, 1);
                } //*/
            }
                break;
                
            default:
                break;
        }
        
        
    }
    
    self.backgroundView.alpha = 0;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        self.backgroundView.alpha = 1;
        
        [self showAnimationOperation];
        
    } completion:^(BOOL finished) {
        
        if (self.customShowAnimationBlock) { return; }
        
        if (self.enableVerticalGestureDismiss &&
            (self->_sheetContainerView != nil)) {
            
            self.verticalDismissPanGesture.enabled = NO;
            
            self.window.userInteractionEnabled = YES;
            
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowUserInteraction  animations:^{
                [UIView setAnimationCurve:(UIViewAnimationCurveEaseInOut)];
                
                self->_sheetContainerView.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                
                self.verticalDismissPanGesture.enabled = YES;

                self.showAnimationDidComplete();
            }];
            
        } else {
            
            self.showAnimationDidComplete();
        }
    }];
}

- (void)showAnimationOperation{
    
    if (self.customShowAnimationBlock) { return; }
    
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
            CGRect frame = self.actionsheetContentView.frame;
            frame.origin.y = JKAlertScreenH - frame.size.height;
            self.actionsheetContentView.frame = frame;
            
            // TODO: JKTODO <#注释#>
            
            return;
        }
            break;
        case JKAlertStyleCollectionSheet:
        {
            CGRect frame = self.collectionsheetContentView.frame;
            frame.origin.y = JKAlertScreenH - frame.size.height;
            self.collectionsheetContentView.frame = frame;
            
            // TODO: JKTODO <#注释#>
            
            return;
        }
            
        default:
            break;
    }
    
    if (_enableVerticalGestureDismiss &&
        (_sheetContainerView != nil)) {
        
        [UIView setAnimationCurve:(UIViewAnimationCurveEaseOut)];
        
        CGRect rect = _sheetContainerView.frame;
        
        rect.origin.y = JKAlertScreenH - rect.size.height;
        _sheetContainerView.frame = rect;
        
        _sheetContainerView.transform = CGAffineTransformMakeScale(1, (_sheetContainerView.frame.size.height + JKAlertSheetSpringHeight) / _sheetContainerView.frame.size.height);
        
    } else {
        
        CGRect rect = _sheetContainerView.frame;
        rect.origin.y = JKAlertScreenH - _sheetContainerView.frame.size.height;
        _sheetContainerView.frame = rect;
    }
}

- (void(^)(void))showAnimationDidComplete{
    
    self.window.userInteractionEnabled = YES;
    
    //self->_titleTextView.delegate = self.titleTextViewDelegate;
    //self->_messageTextView.delegate = self.messageTextViewDelegate;
    
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
    
    if (self.dismissTimeInterval > 0 && (self.alertStyle == JKAlertStyleHUD || self.customHUD)) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.dismissTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismiss];
        });
    }
    
    return ^{};
}

#pragma mark
#pragma mark - 监听键盘

//- (BOOL)isLandScape{
//
//    return JKAlertScreenW > JKAlertScreenH;
//}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    
    if (JKAlertStylePlain != self.alertStyle) { return; }
    
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect frame = self.alertContentView.frame;
    
    NSNumber *curve = notification.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    
    NSInteger animationCurve = (curve ? [curve integerValue] : 7);
    
    if (keyboardFrame.origin.y >= JKAlertScreenH) { // 退出键盘
        
        JKAlertPlainViewMaxH = JKAlertScreenH - 100;
        
        [self calculateUI];
        
        [UIView animateWithDuration:0.25 animations:^{
            [UIView setAnimationCurve:animationCurve];
            
            [self layoutIfNeeded];
        }];
        
    } else { // 弹出键盘
        
        CGFloat maxH = JKAlertScreenH - (JKAlertIsDeviceX() ? 44 : 20) - keyboardFrame.size.height - 40;
        
        BOOL lockKeyboardMargin = (self.plainKeyboardMargin > 0);
        
        if ([self isLandScape]) {
            
            maxH = JKAlertScreenH - 5 - keyboardFrame.size.height - 5;
            
        } else if (lockKeyboardMargin) {
            
            maxH = maxH + 20 - self.plainKeyboardMargin;
        }
        
        if (frame.size.height <= maxH) {
            
            frame.origin.y = (JKAlertIsDeviceX() ? 44 : 20) + (maxH - frame.size.height) * 0.5;
            
            if (lockKeyboardMargin) {
                
                frame.origin.y = keyboardFrame.origin.y - self.plainKeyboardMargin - frame.size.height;
            }
            
            if ([self isLandScape]) {
                
                frame.origin.y = 5 + (maxH - frame.size.height) * 0.5;
            }
            
            self.setPlainY(frame.origin.y, YES);
            
            return;
        }
        
        JKAlertPlainViewMaxH = maxH;
        
        [self calculateUI];
        
        frame = self.alertContentView.frame;
        
        if ([self isLandScape]) {
            
            frame.origin.y = 5;
            
        } else if (lockKeyboardMargin) {
            
            frame.origin.y = keyboardFrame.origin.y - self.plainKeyboardMargin - frame.size.height;
            
            frame.origin.y = MAX(frame.origin.y, (JKAlertIsDeviceX() ? 44 : 20));
            
        } else {
            
            frame.origin.y = (JKAlertIsDeviceX() ? 44 : 20);
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

- (void)dismissButtonClick:(UIButton *)button{
    
    [JKAlertKeyWindow() endEditing:YES];
    
    !self.blankClickBlock ? : self.blankClickBlock();
    
    !self.tapBlankHandler ? : self.tapBlankHandler(self);
    
    if (_tapBlankDismiss) {
        
        self.dismiss();
        
    } else {
        
        if ((self.enableVerticalGestureDismiss ||
             self.enableHorizontalGestureDismiss) &&
            (self.alertStyle == JKAlertStyleActionSheet ||
             self.alertStyle == JKAlertStyleCollectionSheet)) {
            
            if ([self.sheetContainerView.layer animationForKey:JKAlertDismissFailedShakeAnimationKey]) { return; }
            
            // 动画抖一下
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            animation.repeatCount = 1;
            animation.values = @[@(-2), @(-4), @(-6), @(3), @0];
            animation.duration = 0.5;
            [self.sheetContainerView.layer addAnimation:animation forKey:JKAlertDismissFailedShakeAnimationKey];
        }
    }
}

// 通过通知来dismiss
- (void)dismissAllNotification:(NSNotification *)noti{
    
    if (self.isDismissAllNoneffective) { return; }
    
    self.dismiss();
}

// 通过key通知来dismiss
- (void)dismissForKeyNotification:(NSNotification *)noti{
    
    if (!self.dismissKey) { return; }
    
    if ([noti.object isKindOfClass:[NSString class]] &&
        [noti.object isEqualToString:self.dismissKey]) {
        
        self.dismiss();
    }
}

// 通过category通知来dismiss
- (void)dismissForCategoryNotification:(NSNotification *)noti{
    
    if (!self.dismissCategory) { return; }
    
    if ([noti.object isKindOfClass:[NSString class]] &&
        [noti.object isEqualToString:self.dismissCategory]) {
        
        self.dismiss();
    }
}

// 通过通知来dismiss
- (void)clearAllNotification:(NSNotification *)noti{
    
    self.dismiss();
}

- (void(^)(void))dismiss{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self startDismissAnimation];
    
    return ^{};
}

- (void)startDismissAnimation{
    
    self.window.userInteractionEnabled = NO;
    
    // 即将消失
    !self.willDismissHandler ? : self.willDismissHandler();
    
    if (!isSheetDismissHorizontal || (self.alertStyle != JKAlertStyleActionSheet && self.alertStyle != JKAlertStyleCollectionSheet)) {
        
        // 自定义消失动画
        !self.customDismissAnimationBlock ? : self.customDismissAnimationBlock(self, self.alertContentView);
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backgroundView.alpha = 0;
        
        [self dismissAnimationOperation];
        
    } completion:^(BOOL finished) {
        
        if (self.customDismissAnimationBlock) { return; }
        
        self.dismissAnimationDidComplete();
    }];
}

- (void)dismissAnimationOperation{
    
    if (self.customDismissAnimationBlock) {
        
        if (isSheetDismissHorizontal) {
            
            CGRect rect = _sheetContainerView.frame;
            rect.origin.x = JKAlertScreenW;
            _sheetContainerView.frame = rect;
        }
        
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
        {
            CGRect frame = self.actionsheetContentView.frame;
            frame.origin.y = JKAlertScreenH;
            self.actionsheetContentView.frame = frame;
            
            return;
        }
            break;
        case JKAlertStyleCollectionSheet:
        {
            CGRect frame = self.collectionsheetContentView.frame;
            frame.origin.y = JKAlertScreenH;
            self.collectionsheetContentView.frame = frame;
            
            return;
        }
            
        default:
            break;
    }
    
    CGRect rect = _sheetContainerView.frame;
    
    if (isSheetDismissHorizontal) {
        
        rect.origin.x = JKAlertScreenW;
        
    } else {
        
        rect.origin.y = JKAlertScreenH;
    }
    
    _sheetContainerView.frame = rect;
}

- (void(^)(void))dismissAnimationDidComplete{
    
    self.window.userInteractionEnabled = YES;
    
    // 消失完成
    !self.didDismissHandler ? : self.didDismissHandler();
    
    [self.actions removeAllObjects];
    self.actions = nil;
    
    [self.actions2 removeAllObjects];
    self.actions2 = nil;
    
    _cancelAction = nil;
    _collectionAction = nil;
    
    [self removeFromSuperview];
    
    return ^{};
}

#pragma mark
#pragma mark - UIScrollViewDelegate
#if 0
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!self.enableVerticalGestureDismiss) { return; }
    
    switch (self.alertStyle) {
        case JKAlertStyleActionSheet:
        {
            if ((scrollView == self.scrollView &&
                _tableView.isDecelerating) ||
                (scrollView == _tableView &&
                self.scrollView.isDecelerating)) {
                    return;
            }
            
            [self solveVerticalScroll:scrollView];
        }
            break;
        case JKAlertStyleCollectionSheet:
        {
            if (scrollView == self.scrollView) {
                
                if (scrollView.isDecelerating) { return; }
                
                [self solveVerticalScroll:scrollView];
                
            } else {
                
                [self solveHorizontalScroll:scrollView];
                
                if (self.compoundCollection) {
                    
                    _collectionView.contentOffset = scrollView.contentOffset;
                    
                    _collectionView2.contentOffset = scrollView.contentOffset;
                }
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    switch (self.alertStyle) {
        case JKAlertStyleActionSheet:
        {
            if (!self.enableVerticalGestureDismiss) { return; }
            
            beginScrollDirection = JKAlertScrollDirectionNone;
            endScrollDirection = JKAlertScrollDirectionNone;
            
            lastContainerY = self.sheetContainerView.frame.origin.y;
            
            if (scrollView.contentOffset.y + scrollView.contentInset.top < 0) {
                
                disableScrollToDismiss = YES;
            }
        }
            break;
        case JKAlertStyleCollectionSheet:
        {
            if (scrollView == self.scrollView) {
                
                if (!self.enableVerticalGestureDismiss) { return; }
                
                beginScrollDirection = JKAlertScrollDirectionNone;
                endScrollDirection = JKAlertScrollDirectionNone;
                
                lastContainerY = self.sheetContainerView.frame.origin.y;
                
                if (scrollView.contentOffset.y + scrollView.contentInset.top < 0) {
                    
                    disableScrollToDismiss = YES;
                }
                
            } else {
                
                if (!self.enableHorizontalGestureDismiss) { return; }
                
                isBeginDragging = YES;
                beginScrollDirection = JKAlertScrollDirectionNone;
                endScrollDirection = JKAlertScrollDirectionNone;
                
                lastContainerX = self.sheetContainerView.frame.origin.x;
                
                if (scrollView.contentOffset.x + scrollView.contentInset.left < 0) {
                    
                    disableScrollToDismiss = YES;
                }
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    switch (self.alertStyle) {
        case JKAlertStyleActionSheet:
        {
            [self solveWillEndDraggingVertically:scrollView withVelocity:velocity];
        }
            break;
        case JKAlertStyleCollectionSheet:
        {
            if (scrollView == self.scrollView) {
                
                [self solveWillEndDraggingVertically:scrollView withVelocity:velocity];
                
            } else {
                
                [self solveWillEndDraggingHorizontally:scrollView withVelocity:velocity];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if (self.alertStyle == JKAlertStyleCollectionSheet &&
        [scrollView isKindOfClass:[UICollectionView class]]) {
        
        _pageControl.currentPage = ceil((scrollView.contentOffset.x - 5) / JKAlertScreenW);
    }
}
///*
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    switch (self.alertStyle) {
        case JKAlertStyleActionSheet:
        {
            if (!self.enableVerticalGestureDismiss) { return; }
            
            if (self.scrollView.isDecelerating ||
                _tableView.isDecelerating) {
                return;
            }
            
            disableScrollToDismiss = NO;
            
            //[self checkVerticalSlideShouldDismiss];
        }
            break;
        case JKAlertStyleCollectionSheet:
        {
            if (scrollView == self.scrollView) {
                
                if (!self.enableVerticalGestureDismiss) { return; }
                
                disableScrollToDismiss = NO;
                
                //[self checkVerticalSlideShouldDismiss];
                
            } else {
                
                _pageControl.currentPage = ceil((scrollView.contentOffset.x - 5) / JKAlertScreenW);
                
                if (!self.enableHorizontalGestureDismiss) { return; }
                
                if (self.collectionView.isDecelerating ||
                    self.collectionView2.isDecelerating) {
                    return;
                }
                
                disableScrollToDismiss = NO;
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)solveVerticalScroll:(UIScrollView *)scrollView{
    
    if (!self.enableVerticalGestureDismiss ||
        !self.tapBlankDismiss ||
        !scrollView.isDragging ||
        disableScrollToDismiss) { return; }
    
    //NSLog(@"contentOffset-->%@", NSStringFromCGPoint(scrollView.contentOffset));
    
    if (scrollView.contentOffset.y + scrollView.contentInset.top < 0) {
        
        CGRect frame = self.sheetContainerView.frame;
        
        frame.origin.y -= (scrollView.contentOffset.y + scrollView.contentInset.top);
        
        frame.origin.y = (frame.origin.y < correctContainerY) ? correctContainerY : frame.origin.y;
        
        self.sheetContainerView.frame = frame;
        
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -scrollView.contentInset.top);
        
        //NSLog(@"1");
        
    } else if (self.sheetContainerView.frame.origin.y > correctContainerY + 0.1) {
        
        CGRect frame = self.sheetContainerView.frame;
        
        frame.origin.y -= (scrollView.contentOffset.y + scrollView.contentInset.top);
        
        frame.origin.y = (frame.origin.y < correctContainerY) ? correctContainerY : frame.origin.y;
        
        self.sheetContainerView.frame = frame;
        
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -scrollView.contentInset.top);
        
        //NSLog(@"2");
    }
    
    if (scrollView.isDragging) {
        
        [self checkVerticalSlideDirection];
    }
}

- (void)solveHorizontalScroll:(UIScrollView *)scrollView{
    
    if (!self.enableHorizontalGestureDismiss || !self.tapBlankDismiss) { return; }
    
    if ((scrollView == self.collectionView &&
        self.collectionView2.isDecelerating) ||
        (scrollView == self.collectionView2 &&
        self.collectionView.isDecelerating)) {
            return;
    }
    
    if (!scrollView.isDragging || disableScrollToDismiss) { return; }
    
    //NSLog(@"contentOffset-->%@", NSStringFromCGPoint(scrollView.contentOffset));
    
    if (scrollView.contentOffset.x + scrollView.contentInset.left < 0) {
        
        CGRect frame = self.sheetContainerView.frame;
        
        frame.origin.x -= (scrollView.contentOffset.x + scrollView.contentInset.left);
        
        self.sheetContainerView.frame = frame;
        
        scrollView.contentOffset = CGPointMake(-scrollView.contentInset.left, scrollView.contentOffset.y);
        
    } else if (self.sheetContainerView.frame.origin.x > JKAlertScreenW - self.sheetContainerView.frame.size.width) {
        
        CGRect frame = self.sheetContainerView.frame;
        
        frame.origin.x -= (scrollView.contentOffset.x + scrollView.contentInset.left);
        
        self.sheetContainerView.frame = frame;
        
        scrollView.contentOffset = CGPointMake(-scrollView.contentInset.left, scrollView.contentOffset.y);
    }
    
    if (scrollView.isDragging) {
        
        [self checkHorizontalSlideDirection];
    }
}

- (void)solveWillEndDraggingVertically:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity{
    
    if (!self.enableVerticalGestureDismiss || !self.tapBlankDismiss || disableScrollToDismiss) { return; }
    
    if (scrollView.contentOffset.y + scrollView.contentInset.top > 0) {
        
        disableScrollToDismiss = YES;
        
        return;
    }
    
    if (velocity.y < -1.5 && beginScrollDirection == endScrollDirection) {
        
        [self dismiss];
        
    } else {
        
        [self checkVerticalSlideShouldDismiss];
    }
}

- (void)solveWillEndDraggingHorizontally:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity{
    
    if (!self.enableHorizontalGestureDismiss || !self.tapBlankDismiss || disableScrollToDismiss) { return; }
    
    if (scrollView.contentOffset.x + scrollView.contentInset.left > 0) {
        
        disableScrollToDismiss = YES;
        
        return;
    }
    
    if (velocity.x < -1.5 && beginScrollDirection == endScrollDirection) {
        
        isSheetDismissHorizontal = YES;
        
        [self dismiss];
        
    } else {
        
        [self checkHorizontalSlideShouldDismiss];
    }
}

- (void)checkVerticalSlideDirection{

    currentContainerY = self.sheetContainerView.frame.origin.y;
    
    if (currentContainerY < lastContainerY) {
        
        if (beginScrollDirection == JKAlertScrollDirectionNone) {
            
            beginScrollDirection = JKAlertScrollDirectionUp;
        }
        
        endScrollDirection = JKAlertScrollDirectionUp;
        
        //NSLog(@"上滑-------current:%.3f  last:%.3f", currentContainerY, lastContainerY);
    }
    
    if (currentContainerY > lastContainerY) {
        
        //NSLog(@"下滑-------current:%.3f  last:%.3f", currentContainerY, lastContainerY);
        
        if (beginScrollDirection == JKAlertScrollDirectionNone) {
            
            beginScrollDirection = JKAlertScrollDirectionDown;
        }
        
        endScrollDirection = JKAlertScrollDirectionDown;
    }
    
    lastContainerY = currentContainerY;
}

- (void)checkHorizontalSlideDirection{

    currentContainerX = self.sheetContainerView.frame.origin.x;
    
    if (currentContainerX < lastContainerX) {
        
        if (beginScrollDirection == JKAlertScrollDirectionNone) {
            
            beginScrollDirection = JKAlertScrollDirectionLeft;
        }
        
        endScrollDirection = JKAlertScrollDirectionLeft;
        
        //JKLog("左滑-------")
    }
    
    if (currentContainerX > lastContainerX) {
        
        //JKLog("右滑-------")
        
        if (beginScrollDirection == JKAlertScrollDirectionNone) {
            
            beginScrollDirection = JKAlertScrollDirectionRight;
        }
        
        endScrollDirection = JKAlertScrollDirectionRight;
    }
    
    lastContainerX = currentContainerX;
}

- (void)checkVerticalSlideShouldDismiss{
    
    CGFloat correctSheetContainerY = (correctContainerY);
    
    CGFloat currentSheetContainerY = self.sheetContainerView.frame.origin.y;
    
    CGFloat delta = currentSheetContainerY - correctSheetContainerY;
    
    if ((delta > self.sheetContainerView.frame.size.height * 0.5) &&
        beginScrollDirection == endScrollDirection) {
        
        [self dismiss];
        
    } else {
        
        //self.relayout(YES);
        
        [self relayoutSheetContainerView];
    }
}

- (void)checkHorizontalSlideShouldDismiss{
    
    CGFloat correctSheetContainerX = (JKAlertScreenW - self.sheetContainerView.frame.size.width);
    
    CGFloat currentSheetContainerX = self.sheetContainerView.frame.origin.x;
    
    CGFloat delta = currentSheetContainerX - correctSheetContainerX;
    
    if ((delta > self.sheetContainerView.frame.size.width * 0.5) &&
        beginScrollDirection == endScrollDirection) {
        
        isSheetDismissHorizontal = YES;
        
        [self dismiss];
        
    } else {
        
        //self.relayout(YES);
        
        [self relayoutSheetContainerView];
    }
}

- (void)relayoutSheetContainerView{
    
    CGRect frame = self.sheetContainerView.frame;
    frame.origin.y = JKAlertScreenH - frame.size.height;
    frame.origin.x = (JKAlertScreenW - frame.size.width) * 0.5;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.sheetContainerView.frame = frame;
        
    } completion:^(BOOL finished) {
        
    }];
}
#endif

#pragma mark
#pragma mark - 滑动手势
#if 0
- (void)verticalPanGestureAction:(UIPanGestureRecognizer *)panGesture{
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            beginScrollDirection = JKAlertScrollDirectionNone;
            endScrollDirection = JKAlertScrollDirectionNone;
            
            lastContainerY = self.sheetContainerView.frame.origin.y;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            // 获取偏移
            CGPoint point = [panGesture translationInView:self.sheetContainerView];
            
            CGRect frame = self.sheetContainerView.frame;
            
            if (point.y > 0) {
                
                if (!self.tapBlankDismiss) {
                    
                    frame.origin.y += (point.y * 0.01);
                    
                } else {
                    
                    frame.origin.y += point.y;
                }
                
            } else {
                
                if (!self.tapBlankDismiss ||
                    (frame.origin.y <= (correctContainerY))) {
                    
                    frame.origin.y += (point.y * 0.01);
                    
                } else {
                    
                    frame.origin.y += point.y;
                }
            }
            
            frame.origin.y = MAX(frame.origin.y, correctContainerY - 5);
            
            self.sheetContainerView.frame = frame;
            
            // 归零
            [panGesture setTranslation:CGPointZero inView:self.sheetContainerView];
            
            [self checkVerticalSlideDirection];
        }
            break;
            
        default:
        {
            if (!self.tapBlankDismiss) {
                
                [self relayoutSheetContainerView];
                
                return;
            }
            
            CGPoint velocity = [panGesture velocityInView:panGesture.view];
            CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
            CGFloat slideMult = magnitude / 200;
            
            float slideFactor = 0.1 * slideMult;
            CGPoint finalPoint = CGPointMake(0, self.sheetContainerView.frame.origin.y + (velocity.y * slideFactor));
            
            BOOL isSlideHalf = (finalPoint.y - correctContainerY > self.sheetContainerView.frame.size.height * 0.5);
            
            if (isSlideHalf &&
                self.tapBlankDismiss &&
                (endScrollDirection == JKAlertScrollDirectionDown)) {
                
                [self dismiss];
                
            } else {
                
                //self.relayout(YES);
                
                [self relayoutSheetContainerView];
            }
        }
            break;
    }
}

- (void)horizontalPanGestureAction:(UIPanGestureRecognizer *)panGesture{
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            beginScrollDirection = JKAlertScrollDirectionNone;
            endScrollDirection = JKAlertScrollDirectionNone;
            
            lastContainerX = self.sheetContainerView.frame.origin.x;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            // 获取偏移
            CGPoint point = [panGesture translationInView:self.contentView];
            
            CGPoint center = self.sheetContainerView.center;
            
            if (point.x > 0) {
                
                if (!self.tapBlankDismiss) {
                    
                    center.x += (point.x * 0.02);
                    
                } else {
                    
                    center.x += point.x;
                }
                
            } else {
                
                if (!self.tapBlankDismiss ||
                    (center.x <= (JKAlertScreenW * 0.5))) {
                    
                    center.x += (point.x * 0.02);
                    
                } else {
                    
                    center.x += point.x;
                }
            }
            
            self.sheetContainerView.center = center;
            
            // 归零
            [panGesture setTranslation:CGPointZero inView:self.contentView];
            
            [self checkHorizontalSlideDirection];
        }
            break;
            
        default:
        {
            if (!self.tapBlankDismiss) {
                
                [self relayoutSheetContainerView];
                
                return;
            }
            
            CGPoint velocity = [panGesture velocityInView:panGesture.view];
            CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
            CGFloat slideMult = magnitude / 200;
            
            float slideFactor = 0.1 * slideMult;
            CGPoint finalPoint = CGPointMake(self.sheetContainerView.center.x + (velocity.x * slideFactor), self.sheetContainerView.center.y + (velocity.y * slideFactor));
            BOOL isSlideHalf = ((finalPoint.x - self.sheetContainerView.frame.size.width * 0.5) - (JKAlertScreenW - self.sheetContainerView.frame.size.width) > self.sheetContainerView.frame.size.width * 0.5);
            if (isSlideHalf &&
                self.tapBlankDismiss &&
                beginScrollDirection == endScrollDirection) {
                
                isSheetDismissHorizontal = YES;
                
                [self dismiss];
                
            } else {
                
                //self.relayout(YES);
                
                [self relayoutSheetContainerView];
            }
        }
            break;
    }
}

#pragma mark
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (gestureRecognizer == self.verticalDismissPanGesture) {
        
        return self.enableVerticalGestureDismiss;
    }
    
    if (gestureRecognizer == self.horizontalDismissPanGesture) {
        
        return self.enableHorizontalGestureDismiss;
    }
    
    return YES;
}
#endif

#pragma mark
#pragma mark - Override

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    [self solveDidMoveToSuperview];
}

#pragma mark
#pragma mark - Private Methods

- (void)addNotifications {
    
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

#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 */
- (void)initializeProperty {
    [super initializeProperty];
    
    /** 屏幕宽度 */
    JKAlertScreenW = self.customSuperView.bounds.size.width;
    
    /** 屏幕高度 */
    JKAlertScreenH = self.customSuperView.bounds.size.height;
    
    _isLandScape = [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight;
    
    JKAlertPlainViewMaxH = (JKAlertScreenH - 100);
    
    JKAlertSheetMaxH = (JKAlertScreenH > JKAlertScreenW) ? JKAlertScreenH * 0.85 : JKAlertScreenH * 0.8;
    
    _deallocLogEnabled = NO;
    
    _dismissTimeInterval = 1;
    
    _collectionTitleSeparatorHidden = YES;
    
    PlainViewWidth = 290;
    OriginalPlainWidth = PlainViewWidth;
    _collectionViewMargin = 10;
    
    JKAlertSeparatorLineWH = (1 / [UIScreen mainScreen].scale);
    textContainerViewCurrentMaxH_ = (JKAlertScreenH - 100 - JKAlertActionButtonH * 4);
    
    self.flowlayoutItemWidth = 76;
    
    _enableVerticalGestureDismiss = NO;
    _enableHorizontalGestureDismiss = NO;
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
        
        _customSuperView = JKAlertKeyWindow();
    }
    
    return _customSuperView;
}

- (UIView *)alertContentView {
    
    if (self.currentAlertContentView) {
        
        return self.currentAlertContentView;
    }
    
    UIView *alertContentView = nil;
    
    // TODO: JKTODO <#注释#>
    
    switch (self.alertStyle) {
        case JKAlertStylePlain:
        {
            alertContentView = self.plainContentView;
        }
            break;
        case JKAlertStyleActionSheet:
        {
            alertContentView = self.sheetContainerView;
        }
            break;
        case JKAlertStyleCollectionSheet:
        {
            alertContentView = self.sheetContainerView;
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
    
    return self.currentAlertContentView;
}

- (JKAlertPlainContentView *)plainContentView {
    if (!_plainContentView) {
        JKAlertPlainContentView *plainContentView = [[JKAlertPlainContentView alloc] init];
        plainContentView.alertView = self;
        [self addSubview:plainContentView];
        _plainContentView = plainContentView;
    }
    return _plainContentView;
}

- (JKAlertHUDContentView *)hudContentView {
    if (!_hudContentView) {
        JKAlertHUDContentView *hudContentView = [[JKAlertHUDContentView alloc] init];
        hudContentView.alertView = self;
        [self addSubview:hudContentView];
        _hudContentView = hudContentView;
    }
    return _hudContentView;
}

- (JKAlerActionSheetContentView *)actionsheetContentView {
    if (!_actionsheetContentView) {
        JKAlerActionSheetContentView *actionsheetContentView = [[JKAlerActionSheetContentView alloc] init];
        actionsheetContentView.alertView = self;
        [self addSubview:actionsheetContentView];
        _actionsheetContentView = actionsheetContentView;
    }
    return _actionsheetContentView;
}

- (JKAlertCollectionSheetContentView *)collectionsheetContentView {
    if (!_collectionsheetContentView) {
        JKAlertCollectionSheetContentView *collectionsheetContentView = [[JKAlertCollectionSheetContentView alloc] init];
        collectionsheetContentView.alertView = self;
        [self addSubview:collectionsheetContentView];
        _collectionsheetContentView = collectionsheetContentView;
    }
    return _collectionsheetContentView;
}

- (NSMutableArray *)actions {
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    return _actions;
}

- (NSMutableArray *)actions2 {
    if (!_actions2) {
        _actions2 = [NSMutableArray array];
    }
    return _actions2;
}

- (NSMutableArray *)textFieldArr {
    if (!_textFieldArr) {
        _textFieldArr = [NSMutableArray array];
    }
    return _textFieldArr;
}

- (UIView *)sheetContainerView {
    if (!_sheetContainerView) {
        UIView *sheetContainerView = [[UIView alloc] init];
        [self.contentView addSubview:sheetContainerView];
        _sheetContainerView = sheetContainerView;
        
        // TODO: JKTODO <#注释#>
        /*
        _verticalDismissPanGesture = [[JKAlertPanGestureRecognizer alloc] initWithTarget:self action:@selector(verticalPanGestureAction:)];
        _verticalDismissPanGesture.direction = JKAlertPanGestureDirectionVertical;
        _verticalDismissPanGesture.delegate = self;
        
        _horizontalDismissPanGesture = [[JKAlertPanGestureRecognizer alloc] initWithTarget:self action:@selector(horizontalPanGestureAction:)];
        _horizontalDismissPanGesture.direction = JKAlertPanGestureDirectionToRight;
        _horizontalDismissPanGesture.delegate = self;
        
        [sheetContainerView addGestureRecognizer:_verticalDismissPanGesture];
        [sheetContainerView addGestureRecognizer:_horizontalDismissPanGesture]; //*/
    }
    return _sheetContainerView;
}

- (UIView *)topGestureIndicatorView {
    if (!_topGestureIndicatorView) {
        UIView *topGestureIndicatorView = [[UIView alloc] init];
        topGestureIndicatorView.hidden = YES;
        topGestureIndicatorView.userInteractionEnabled = NO;
        //topGestureIndicatorView.backgroundColor = JKAlertGlobalBackgroundColor();
        [self addSubview:topGestureIndicatorView];
        _topGestureIndicatorView = topGestureIndicatorView;
        
        UIView *topGestureLineView = [[UIView alloc] init];
        
        //UIToolbar *topGestureLineView = [[UIToolbar alloc] init];
        //topGestureLineView.alpha = 0.9;
        topGestureLineView.userInteractionEnabled = NO;
        topGestureLineView.layer.cornerRadius = 2;
        //topGestureLineView.layer.masksToBounds = YES;
        topGestureLineView.backgroundColor = JKAlertAdaptColor(JKAlertSameRGBColor(208), JKAlertSameRGBColor(47));
        [topGestureIndicatorView addSubview:topGestureLineView];
        
        _topGestureLineView = topGestureLineView;
    }
    return _topGestureIndicatorView;
}

- (UIButton *)closeButton {
    
    if (_alertStyle != JKAlertStylePlain) { return nil; }
    
    if (!_closeButton) {
        
        UIButton *closeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [closeButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        closeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        closeButton.frame = CGRectMake(PlainViewWidth - 30, 5, 25, 25);
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
        
        NSLog(@"%d, %s",__LINE__, __func__);
    }
    
    !self.deallocHandler ? : self.deallocHandler();
}
@end
