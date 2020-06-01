//
//  JKAlertView+Deprecated.m
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertView+Deprecated.h"
#import "JKAlertView+PrivateProperty.h"
#import "JKAlertView+Public.h"

@implementation JKAlertView (Deprecated)

/** 设置title和message是否可以选择文字，默认NO */
- (JKAlertView *(^)(BOOL canselectText))setTextViewCanSelectText {
    
    return ^(BOOL canSelectText) {
        
        self.makeTitleMessageShouldSelectText(canSelectText);
        
        return self;
    };
}

- (JKAlertView * (^)(void(^willShowAnimation)(JKAlertView *view)))setWillShowAnimation {
    
    return ^(void(^willShowAnimation)(JKAlertView *view)) {
        
        self.willShowHandler = willShowAnimation;
        
        return self;
    };
}

- (JKAlertView * (^)(void(^showAnimationComplete)(JKAlertView *view)))setShowAnimationComplete {
    
    return ^(void(^showAnimationComplete)(JKAlertView *view)) {
        
        self.didShowHandler = showAnimationComplete;
        
        return self;
    };
}

- (JKAlertView * (^)(void(^willDismiss)(void)))setWillDismiss {
    
    return ^JKAlertView * (void(^willDismiss)(void)) {
        
        self.willDismissHandler = willDismiss;
        
        return self;
    };
}

- (JKAlertView * (^)(void(^dismissComplete)(void)))setDismissComplete {
    
    return ^(void(^dismissComplete)(void)) {
        
        self.didDismissHandler = dismissComplete;
        
        return self;
    };
}

/** 准备重新布局 */
- (JKAlertView * (^)(void))prepareToRelayout {
    
    return ^{ return self; };
}

/** 重新设置其它属性，调用该方法返回JKAlertView，设置好其它属性后，再调用relayout即可 */
- (JKAlertView * (^)(void))resetOther {
    
    return ^{
        
        return self;
    };
}


#pragma mark
#pragma mark - 公共部分

/** 在这个block内自定义其它属性 */
- (JKAlertView *(^)(void(^customizePropertyHandler)(JKAlertView *customizePropertyAlertView)))setCustomizePropertyHandler {
    
    return [self makeCustomizationHandler];
}

/**
 * 设置自定义的父控件
 * 默认添加到keywindow上
 * customSuperView在show之前有效
 * customSuperViewsize最好和屏幕大小一致，否则可能出现问题
 */
- (JKAlertView *(^)(UIView *customSuperView))setCustomSuperView {
    
    return [self makeCustomSuperView];
}

/**
 * 设置点击空白处是否消失，plain默认NO，其它YES
 */
- (JKAlertView *(^)(BOOL shouldDismiss))setClickBlankDismiss {
    
    return [self makeTapBlankDismiss];
}

/** 设置监听点击空白处的block */
- (JKAlertView * (^)(void(^blankClickBlock)(void)))setBlankClickBlock {
    
    return ^(void(^handler)(void)) {
        
        self.blankClickBlock = handler;
        
        return self;
    };
}

/**
 * 配置弹出视图的容器view，加圆角等
 */
- (JKAlertView *(^)(void (^containerViewConfig)(UIView *containerView)))setContainerViewConfig {
    
    return [self makeAlertContentViewConfiguration];
}

/** 设置title和message是否可以响应事件，默认YES 如无必要不建议设置为NO */
- (JKAlertView *(^)(BOOL userInteractionEnabled))setTextViewUserInteractionEnabled {

    return [self makeTitleMessageUserInteractionEnabled];
}

/** 设置title和message是否可以选择文字，默认NO */
- (JKAlertView *(^)(BOOL canselectText))setTextViewShouldSelectText {
    
    return [self makeTitleMessageShouldSelectText];
}

/**
 * 设置titleTextFont
 * plain默认 bold 17，其它17
 */
- (JKAlertView *(^)(UIFont *font))setTitleTextFont {
    
    return [self makeTitleFont];
}

/**
 * 设置titleTextColor
 * plain默认RGB都为0.1，其它0.35
 */
- (JKAlertView *(^)(UIColor *textColor))setTitleTextColor {
    
    return ^(UIColor *textColor) {
        
        self.makeTitleColor([JKAlertMultiColor colorWithColor:textColor]);
        
        return self;
    };
}

/** 设置titleTextViewDelegate */
- (JKAlertView *(^)(id<UITextViewDelegate> delegate))setTitleTextViewDelegate {
    
    return [self makeTitleDelegate];
}

/** 设置titleTextView的文字水平样式 */
- (JKAlertView *(^)(NSTextAlignment textAlignment))setTitleTextViewAlignment {
    
    return [self makeTitleAlignment];
}

/**
 * 设置messageTextFont
 * plain默认14，其它13
 * action样式在没有title的时候，自动改为15，设置该值后将始终为该值，不自动修改
 */
- (JKAlertView *(^)(UIFont *font))setMessageTextFont {
    
    return [self makeMessageFont];
}

/**
 * 设置messageTextColor
 * plain默认RGB都为0.55，其它0.3
 */
- (JKAlertView *(^)(UIColor *textColor))setMessageTextColor {
    
    return ^(UIColor *textColor) {
        
        self.makeMessageColor([JKAlertMultiColor colorWithColor:textColor]);
        
        return self;
    };
}

/** 设置messageTextView的文字水平样式 */
- (JKAlertView *(^)(NSTextAlignment textAlignment))setMessageTextViewAlignment {
    
    return [self makeMessageAlignment];
}

/** 设置messageTextViewDelegate */
- (JKAlertView *(^)(id<UITextViewDelegate> delegate))setMessageTextViewDelegate {
    
    return [self makeMessageDelegate];
}
@end
