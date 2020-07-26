//
//  JKAlertView+Public.m
//  JKAlertX
//
//  Created by albertcc on 2020/5/31.
//

#import "JKAlertView+Public.h"
#import "JKAlertView+PrivateProperty.h"
#import "JKAlertThemeManager.h"
#import "JKAlertTheme.h"

@implementation JKAlertView (Public)

/**
 * 深色/浅色模式
 */
+ (JKAlertView *(^)(JKAlertThemeStyle themeStyle))makeThemeStyle {
    
    return ^(JKAlertThemeStyle themeStyle) {
        
        [JKAlertThemeManager sharedManager].themeStyle = themeStyle;
        
        return self;
    };
}

/**
 * 可以在这个block内自定义其它属性
 */
- (JKAlertView *(^)(void (^handler)(JKAlertView *innerView)))makeCustomizationHandler {
    
    return ^(void(^handler)(JKAlertView *innerView)) {
        
        !handler ? : handler(self);
        
        return self;
    };
}

/**
 * 设置自定义的父控件
 * 默认添加到keywindow上
 * customSuperView在show之前有效
 * customSuperViewsize最好和屏幕大小一致，否则可能出现问题
 */
- (JKAlertView *(^)(UIView *customSuperView))makeCustomSuperView {
    
    return ^(UIView *customSuperView) {
        
        self.customSuperView = customSuperView;
        
        if (customSuperView) {
            
            CGFloat rotation = [[self.customSuperView.layer valueForKeyPath:@"transform.rotation.z"] floatValue];
            
            if ((rotation > 1.57 && rotation < 1.58) ||
                (rotation > -1.58 && rotation < -1.57)) {
                
                self.superWidth =  self.customSuperView.frame.size.height;//MAX(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
                self.superHeight =  self.customSuperView.frame.size.width;//MIN(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
                
                [self updateMaxHeight];
                
            } else  {
                
                //self.superWidth =  MIN(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
                //self.superHeight =  MAX(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
                
                [self updateWidthHeight];
            }
        }
        
        return self;
    };
}

/**
 * 全屏背景颜色
 * 默认 black 0.4
 */
- (JKAlertView *(^)(UIColor *color))makeFullBackgroundColor {
    
    return ^(UIColor *color) {
        
        [self.backgroundView.jkalert_themeProvider removeProvideHandlerForKey:NSStringFromSelector(@selector(backgroundColor))];
        
        self.backgroundView.backgroundColor = color;
        
        return self;
    };
}

/**
 * 全屏背景view
 * 默认nil
 */
- (JKAlertView *(^)(UIView *(^backgroundView)(void)))makeFullBackgroundView {
    
    return ^(UIView *(^backgroundView)(void)) {
        
        if (backgroundView) {
            
            self.fullBackgroundView = backgroundView();
        }
        
        return self;
    };
}

/**
 * 设置点击空白处是否消失，plain默认NO，其它YES
 */
- (JKAlertView *(^)(BOOL shouldDismiss))makeTapBlankDismiss {
    
    return ^(BOOL shouldDismiss) {
        
        self.tapBlankDismiss = shouldDismiss;
        
        return self;
    };
}

/**
 * 监听点击空白处的block
 */
- (JKAlertView *(^)(void (^handler)(JKAlertView *innerView)))makeTapBlankHandler {
    
    return ^(void (^handler)(JKAlertView *innerView)) {
        
        self.tapBlankHandler = handler;
        
        return self;
    };
}

/**
 * 圆角
 * 默认 10
 */
- (JKAlertView *(^)(CGFloat cornerRadius))makeCornerRadius {
    
    return ^(CGFloat cornerRadius) {
        
        self.currentAlertContentView.cornerRadius = cornerRadius;
        
        return self;
    };
}

/**
 * 配置弹出视图的容器view，加圆角等
 */
- (JKAlertView *(^)(void (^configuration)(UIView *containerView)))makeAlertContentViewConfiguration {
    
    return ^(void (^configuration)(UIView *alertContentView)) {
        
        self.alertContentViewConfiguration = configuration;
        
        return self;
    };
}

/**
 * 背景颜色
 */
- (JKAlertView *(^)(UIColor *backgroundColor))makeAlertBackgroundColor {
    
    return ^(UIColor *backgroundColor) {
        
        [self.currentAlertContentView.backgroundView.jkalert_themeProvider removeProvideHandlerForKey:NSStringFromSelector(@selector(backgroundColor))];
        
        self.currentAlertContentView.backgroundView.backgroundColor = backgroundColor;
        
        return self;
    };
}

/**
 * 背景view
 */
- (JKAlertView *(^)(UIView *(^backgroundView)(void)))makeAlertBackgroundView {
    
    return ^(UIView *(^backgroundView)(void)) {
        
        if (backgroundView) {
            
            self.currentAlertContentView.customBackgroundView = backgroundView();
        }
        
        return self;
    };
}

/**
 * actionSheet和collectionSheet样式自定义cell类名
 * actionSheet必须是或继承自JKAlertTableViewCell
 * collectionSheet必须是或继承自JKAlertCollectionViewCell
 */
- (JKAlertView *(^)(NSString *cellClassName))makeCustomCellClassName {
    
    return ^(NSString *cellClassName) {
        
        return [[self checkActionSheetStyleHandler:^{
            
            self.actionsheetContentView.cellClassName = cellClassName;
            
        }] checkCollectionSheetStyleHandler:^{
            
            self.collectionsheetContentView.cellClassName = cellClassName;
        }];
    };
}

/**
 * title 和内容是否可以响应事件，
 * 默认YES 如无必要不建议设置为NO
 */
- (JKAlertView *(^)(BOOL userInteractionEnabled))makeTitleMessageUserInteractionEnabled {
    
    return ^(BOOL userInteractionEnabled) {
        
        self.currentTextContentView.userInteractionEnabled = userInteractionEnabled;
        //self.currentTextContentView.messageTextView.userInteractionEnabled = userInteractionEnabled;
        
        return self;
    };
}

/**
 * title 和内容是否可以选择文字
 * 默认NO
 */
- (JKAlertView *(^)(BOOL canselectText))makeTitleMessageShouldSelectText {
    
    return ^(BOOL shouldSelectText) {
        
        self.currentTextContentView.titleTextView.textView.shouldSelectText = shouldSelectText;
        
        if ([self checkHasMessageTextView]) {
            
            self.currentTextContentView.messageTextView.textView.shouldSelectText = shouldSelectText;
        }
        
        return self;
    };
}

/**
 * title 字体
 * plain默认 bold 17，其它17
 */
- (JKAlertView *(^)(UIFont *font))makeTitleFont {
    
    return ^(UIFont *font) {
        
        self.currentTextContentView.titleTextView.textView.font = font;
        
        return self;
    };
}

/**
 * title 字体颜色
 * plain默认RGB都为0.1，其它0.35
 */
- (JKAlertView *(^)(UIColor *textColor))makeTitleColor {
    
    return ^(UIColor *textColor) {
        
        [self.currentTextContentView.titleTextView.textView.jkalert_themeProvider removeProvideHandlerForKey:NSStringFromSelector(@selector(textColor))];
        
        self.currentTextContentView.titleTextView.textView.textColor = textColor;
        
        return self;
    };
}

/**
 * title 文字水平样式
 * 默认NSTextAlignmentCenter
 */
- (JKAlertView *(^)(NSTextAlignment textAlignment))makeTitleAlignment {
    
    return ^(NSTextAlignment textAlignment) {
        
        self.currentTextContentView.titleTextView.textView.textAlignment = textAlignment;
        
        return self;
    };
}

/**
 * title textView的代理
 */
- (JKAlertView *(^)(id <UITextViewDelegate> delegate))makeTitleDelegate {
    
    return ^(id <UITextViewDelegate> delegate) {
        
        self.currentTextContentView.titleTextView.textView.delegate = delegate;
        
        return self;
    };
}

/**
 * message字体
 * plain默认14，其它13
 * action样式在没有title的时候，自动改为15，设置该值后将始终为该值，不自动修改
 */
- (JKAlertView *(^)(UIFont *font))makeMessageFont {
    
    return ^(UIFont *font) {
        
        if ([self checkHasMessageTextView]) {
            
            self.currentTextContentView.messageTextView.textView.font = font;
        }
        
        return self;
    };
}

/**
 * message字体颜色
 * plain默认RGB都为0.55，其它0.3
 */
- (JKAlertView *(^)(UIColor *textColor))makeMessageColor {
    
    return ^(UIColor *textColor) {
        
        if ([self checkHasMessageTextView]) {
            
            [self.currentTextContentView.messageTextView.textView.jkalert_themeProvider removeProvideHandlerForKey:NSStringFromSelector(@selector(textColor))];
            
            self.currentTextContentView.messageTextView.textView.textColor = textColor;
        }
        
        return self;
    };
}

/**
 * message 文字水平样式
 * 默认NSTextAlignmentCenter
 */
- (JKAlertView *(^)(NSTextAlignment textAlignment))makeMessageAlignment {
    
    return ^(NSTextAlignment textAlignment) {
        
        if ([self checkHasMessageTextView]) {
            
            self.currentTextContentView.messageTextView.textView.textAlignment = textAlignment;
        }
        
        return self;
    };
}

/**
 * message的textView的代理
 */
- (JKAlertView *(^)(id <UITextViewDelegate> delegate))makeMessageDelegate {
    
    return ^(id <UITextViewDelegate> delegate) {
        
        if ([self checkHasMessageTextView]) {
            
            self.currentTextContentView.messageTextView.textView.delegate = delegate;
        }
        
        return self;
    };
}

/**
 * title 四周间距
 * 默认(20, 20, 20, 3.5)
 * 当无message或message隐藏时，bottom将自动使用messageInsets.bottom来计算
 */
- (JKAlertView *(^)(UIEdgeInsets (^)(UIEdgeInsets originalInsets)))makeTitleInsets {
    
    return ^(UIEdgeInsets (^handler)(UIEdgeInsets originalInsets)) {
        
        if (handler) {
            
            self.currentTextContentView.titleInsets = handler(self.currentTextContentView.titleInsets);
        }
        
        return self;
    };
}

/**
 * message 四周间距
 * 默认(3.5, 20, 20, 20)
 * 当无title或title隐藏时，top将自动使用titleInsets.top来计算
 */
- (JKAlertView *(^)(UIEdgeInsets (^)(UIEdgeInsets originalInsets)))makeMessageInsets {
    
    return ^(UIEdgeInsets (^handler)(UIEdgeInsets originalInsets)) {
        
        if (handler) {
            
            self.currentTextContentView.messageInsets = handler(self.currentTextContentView.messageInsets);
        }
        
        return self;
    };
}

/**
 * title和message直接的分隔线是否隐藏
 * 默认YES
 */
- (JKAlertView *(^)(BOOL hidden))makeTitleMessageSeparatorLineHidden {
    
    return ^(BOOL hidden) {
        
        self.currentTextContentView.separatorLineHidden = hidden;
        
        return self;
    };
}

/**
 * title和message直接的分隔线四周间距
 * 默认(0, 0, 0, 0)
 */
- (JKAlertView *(^)(UIEdgeInsets insets))makeTitleMessageSeparatorLineInsets {
    
    return ^(UIEdgeInsets insets) {
        
        self.currentTextContentView.separatorLineInsets = insets;
        
        return self;
    };
}

/**
 * 自定义整体title和message
 * 赋值后此时title和message及对应的自定义view将会隐藏 仅展示该自定义view
 */
- (JKAlertView *(^)(UIView *(^)(void)))makeCustomTextContentView {
    
    return ^(UIView *(^handler)(void)) {
        
        if (handler) {
            
            self.currentTextContentView.customContentView = handler();
        }
        
        return self;
    };
}

/**
 * 自定义title
 * 赋值后 title将隐藏 仅展示自定义view
 */
- (JKAlertView *(^)(UIView *(^)(void)))makeCustomTitleView {
    
    return ^(UIView *(^handler)(void)) {
        
        if (handler) {
            
            self.currentTextContentView.customTitleView = handler();
        }
        
        return self;
    };
}

/**
 * 自定义message
 * 赋值后 message将隐藏 仅展示自定义view
 */
- (JKAlertView *(^)(UIView *(^)(void)))makeCustomMessageView {
    
    return ^(UIView *(^handler)(void)) {
        
        if (handler) {
            
            self.currentTextContentView.customMessageView = handler();
        }
        
        return self;
    };
}

/**
 * message最小高度 默认0
 * 仅限有message且没有自定义makeCustomMessageView和makeCustomTextContentView
 * 该高度不包括message的上下间距
 */
- (JKAlertView *(^)(CGFloat minHeight))makeMessageMinHeight {
    
    return ^(CGFloat minHeight) {
        
        self.currentTextContentView.messageMinHeight = minHeight;
        
        return self;
    };
}

/**
 * 仅有title或message时且没有自定义view时最小高度 默认0
 * 该高度不包括上下间距
 * 优先级 > makeMessageMinHeight
 */
- (JKAlertView *(^)(CGFloat minHeight))makeSingleTextMinHeight {
    
    return ^(CGFloat minHeight) {
        
        self.currentTextContentView.singleMinHeight = minHeight;
        
        return self;
    };
}

/**
 * 默认的取消action，不需要自带的可以自己设置，不可置为nil
 * plain样式不再需要该属性
 */
- (JKAlertView *(^)(JKAlertAction *action))makeCancelAction {
    
    return ^(JKAlertAction *action) {
        
        if (!action || (JKAlertStylePlain == self.alertStyle)) { return self; }
        
        self.currentAlertContentView.cancelAction = action;
        
        [self setAlertViewToAction:self.currentAlertContentView.cancelAction];
        
        return self;
    };
}

#pragma mark
#pragma mark - 自定义动画

/**
 * 自定义展示动画，动画完成一定要调用showAnimationDidComplete
 * 此时所有frame已经计算好，plain样式animationView在中间，sheet样式animationView在底部
 */
- (JKAlertView *(^)(void (^)(JKAlertView *innerView, UIView *animationView)))makeCustomShowAnimationHandler {
    
    return ^(void (^handler)(JKAlertView *innerView, UIView *animationView)) {
        
        self.customShowAnimationBlock = handler;
        
        return self;
    };
}

/**
 * 自定义消失动画，动画完成一定要调用dismissAnimationDidComplete
 */
- (JKAlertView *(^)(void (^)(JKAlertView *innerView, UIView *animationView)))makeCustomDismissAnimationHandler {
    
    return ^(void (^handler)(JKAlertView *innerView, UIView *animationView)) {
        
        self.customDismissAnimationBlock = handler;
        
        return self;
    };
}

#pragma mark
#pragma mark - 手势退出

/**
 * 是否允许手势退出
 * 默认NO 仅限以下样式
 * JKAlertStyleActionSheet
 * JKAlertStyleCollectionSheet
 * JKAlertStyleNotification(: - JKTODO)
 */
- (JKAlertView *(^)(BOOL verticalEnabled, BOOL horizontalEnabled))makeGestureDismissEnabled {
    
    return ^(BOOL verticalEnabled, BOOL horizontalEnabled) {
        
        JKAlertBaseSheetContentView *sheetContentView = [self checkSheetContentView];
        
        if (!sheetContentView) { return self; }
        
        sheetContentView.verticalGestureDismissEnabled = verticalEnabled;
        sheetContentView.horizontalGestureDismissEnabled = horizontalEnabled;
        
        return self;
    };
}

/**
 * 是否隐藏手势指示器(在顶部一个横条)
 * 默认YES，允许垂直手势退出时有效
 */
- (JKAlertView *(^)(BOOL gestureIndicatorHidden))makeGestureIndicatorHidden {
    
    return ^(BOOL gestureIndicatorHidden) {
        
        JKAlertBaseSheetContentView *sheetContentView = [self checkSheetContentView];
        
        if (!sheetContentView) { return self; }
        
        sheetContentView.gestureIndicatorHidden = gestureIndicatorHidden;
        
        return self;
        
        return self;
    };
}

/**
 * 展示时是否进行缩放动画
 * 默认NO 限sheet样式
 */
- (JKAlertView *(^)(BOOL scaleAnimated))makeShowScaleAnimated {
    
    return ^(BOOL scaleAnimated) {
        
        JKAlertBaseSheetContentView *sheetContentView = [self checkSheetContentView];
        
        if (!sheetContentView) { return self; }
        
        sheetContentView.showScaleAnimated = scaleAnimated;
        
        return self;
    };
}

#pragma mark
#pragma mark - 状态监听

/**
 * 监听屏幕旋转
 */
- (JKAlertView *(^)(void (^handler)(JKAlertView *innerView, UIInterfaceOrientation orientation)))makeOrientationDidChangeHandler {
    
    return ^(void(^handler)(JKAlertView *innerView, UIInterfaceOrientation orientation)) {
        
        self.orientationDidChangeHandler = handler;
        
        return self;
    };
}

/**
 * 监听即将重新布局
 * 尽量避免在此block中再次执行重新布局
 * 如有必要执行重新布局，请在重新布局前将此block销毁
 */
- (JKAlertView *(^)(void (^handler)(JKAlertView *innerView, UIView *containerView)))makeWillRelayoutHandler {
    
    return ^JKAlertView *(void(^handler)(JKAlertView *innerView, UIView *containerView)) {
        
        self.willRelayoutHandler = handler;
        
        return self;
    };
}

/**
 * 监听重新布局完成的block
 * 尽量避免在此block中再次执行重新布局
 * 如有必要执行重新布局，请在重新布局前将此block销毁
 */
- (JKAlertView *(^)(void (^handler)(JKAlertView *innerView, UIView *containerView)))makeDidRelayoutHandler {
    
    return ^JKAlertView *(void(^handler)(JKAlertView *innerView, UIView *containerView)) {
        
        self.didRelayoutHandler = handler;
        
        return self;
    };
}

#pragma mark
#pragma mark - 显示之后更新UI

/** 重新设置alertTitle */
- (JKAlertView *(^)(NSString *alertTitle))resetAlertTitle {
    
    return ^(NSString *alertTitle) {
        
        self.currentAlertContentView.alertTitle = alertTitle;
        
        return self;
    };
}

/** 重新设置alertAttributedTitle */
- (JKAlertView *(^)(NSAttributedString *alertAttributedTitle))resetAlertAttributedTitle {
    
    return ^(NSAttributedString *alertAttributedTitle) {
        
        self.currentAlertContentView.alertAttributedTitle = alertAttributedTitle;
        
        return self;
    };
}

/** 重新设置message */
- (JKAlertView *(^)(NSString *message))resetMessage {
    
    return ^(NSString *message) {
        
        self.currentAlertContentView.alertMessage = message;
        
        return self;
    };
}

/** 重新设置attributedMessage */
- (JKAlertView *(^)(NSAttributedString *attributedMessage))resetAttributedMessage {
    
    return ^(NSAttributedString *attributedMessage) {
        
        self.currentAlertContentView.attributedMessage = attributedMessage;
        
        return self;
    };
}

/** 重新布局 */
- (JKAlertView *(^)(BOOL animated))relayout {
    
    return ^(BOOL animated) {
        
        !self.willRelayoutHandler ? : self.willRelayoutHandler(self, self.alertContentView);
        
        if (animated) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                [self calculateUI];
                
            } completion:^(BOOL finished) {
                
                !self.relayoutComplete ? : self.relayoutComplete(self);
                
                !self.didRelayoutHandler ? : self.didRelayoutHandler(self, self.alertContentView);
            }];
            
        } else {
            
            [self calculateUI];
            
            !self.relayoutComplete ? : self.relayoutComplete(self);
            
            !self.didRelayoutHandler ? : self.didRelayoutHandler(self, self.alertContentView);
        }
        
        return self;
    };
}

#pragma mark
#pragma mark - 其它适配

/**
 * show的时候是否振动 默认NO
 */
- (JKAlertView *(^)(BOOL enabled))makeVibrateEnabled {
    
    return ^(BOOL enabled) {
        
        self.vibrateEnabled = enabled;
        
        return self;
    };
}

/**
 * 是否自动适配 iPhone X 底部 homeIndicator
 * 默认YES
 */
- (JKAlertView *(^)(BOOL adapted))makeHomeIndicatorAdapted {
    
    return ^(BOOL adapted) {
        
        return [[self checkActionSheetStyleHandler:^{
            
            self.actionsheetContentView.autoAdjustHomeIndicator = adapted;
            
        }] checkCollectionSheetStyleHandler:^{
            
            self.collectionsheetContentView.autoAdjustHomeIndicator = adapted;
        }];
    };
}

/**
 * 是否填充底部 iPhone X homeIndicator
 * 默认YES
 */
- (JKAlertView *(^)(BOOL filled))makeHomeIndicatorFilled {
    
    return ^(BOOL filled) {
        
        return [[self checkActionSheetStyleHandler:^{
            
            self.actionsheetContentView.fillHomeIndicator = filled;
            
        }] checkCollectionSheetStyleHandler:^{
            
            self.collectionsheetContentView.fillHomeIndicator = filled;
        }];
    };
}

/**
 * action和colletion样式的底部按钮上下间距
 * 默认4寸屏5 4寸以上7 不可小于0
 */
- (JKAlertView *(^)(CGFloat margin))makeBottomButtonMargin {
    
    return ^(CGFloat margin) {
        
        return [[self checkActionSheetStyleHandler:^{
            
            self.actionsheetContentView.cancelMargin = margin;
            
        }] checkCollectionSheetStyleHandler:^{
            
            self.collectionsheetContentView.cancelMargin = margin;
        }];
    };
}







- (BOOL)checkHasMessageTextView {
    
    return (JKAlertStylePlain == self.alertStyle ||
            JKAlertStyleActionSheet == self.alertStyle);
}
@end
