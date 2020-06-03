//
//  JKAlertView+Deprecated.m
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertView+Deprecated.h"
#import "JKAlertView+PrivateProperty.h"
#import "JKAlertView+Public.h"
#import "JKAlertView+Plain.h"
#import "JKAlertView+HUD.h"

@implementation JKAlertView (Deprecated)

/** 设置title和message是否可以选择文字，默认NO */
- (JKAlertView *(^)(BOOL canselectText))setTextViewCanSelectText {
    
    return ^(BOOL canSelectText) {
        
        self.makeTitleMessageShouldSelectText(canSelectText);
        
        return self;
    };
}

- (JKAlertView *(^)(void(^willShowAnimation)(JKAlertView *view)))setWillShowAnimation {
    
    return ^(void(^willShowAnimation)(JKAlertView *view)) {
        
        self.willShowHandler = willShowAnimation;
        
        return self;
    };
}

- (JKAlertView *(^)(void(^showAnimationComplete)(JKAlertView *view)))setShowAnimationComplete {
    
    return ^(void(^showAnimationComplete)(JKAlertView *view)) {
        
        self.didShowHandler = showAnimationComplete;
        
        return self;
    };
}

- (JKAlertView *(^)(void(^willDismiss)(void)))setWillDismiss {
    
    return ^JKAlertView * (void(^willDismiss)(void)) {
        
        self.willDismissHandler = willDismiss;
        
        return self;
    };
}

- (JKAlertView *(^)(void(^dismissComplete)(void)))setDismissComplete {
    
    return ^(void(^dismissComplete)(void)) {
        
        self.didDismissHandler = dismissComplete;
        
        return self;
    };
}

/** 准备重新布局 */
- (JKAlertView *(^)(void))prepareToRelayout {
    
    return ^{ return self; };
}

/** 重新设置其它属性，调用该方法返回JKAlertView，设置好其它属性后，再调用relayout即可 */
- (JKAlertView *(^)(void))resetOther {
    
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
- (JKAlertView *(^)(void(^blankClickBlock)(void)))setBlankClickBlock {
    
    return ^(void(^handler)(void)) {
        
        self.blankClickBlock = handler;
        
        return self;
    };
}

/** 设置全屏背景是否透明，默认黑色 0.4 alpha */
- (JKAlertView *(^)(BOOL isClearFullScreenBackgroundColor))setClearFullScreenBackgroundColor {
    
    return ^(BOOL isClearFullScreenBackgroundColor) {
        
        if (isClearFullScreenBackgroundColor) {
            
            self.makeFullBackgroundColor([JKAlertMultiColor colorWithNoColor]);
            
        } else {
            
            [self restoreMultiBackgroundColor];
        }
        
        return self;
    };
}

/**
 * 设置全屏背景view 默认无
 */
- (JKAlertView *(^)(UIView *(^backGroundView)(void)))setFullScreenBackGroundView {
    
    return [self makeFullBackgroundView];
}

/**
 * 配置弹出视图的容器view，加圆角等
 */
- (JKAlertView *(^)(void (^containerViewConfig)(UIView *containerView)))setContainerViewConfig {
    
    return [self makeAlertContentViewConfiguration];
}

/**
 * 设置背景view
 * 默认是一个UIVisualEffectView的UIBlurEffectStyleExtraLight效果
 */
- (JKAlertView *(^)(UIView *(^backGroundView)(void)))setBackGroundView{
    
    return ^(UIView *(^backGroundView)(void)) {
        
        self.makeAlertBackgroundView(backGroundView);
        
        // TODO: JKTODO <#注释#>
        
        self.alertBackGroundView = !backGroundView ? nil : backGroundView();
        
        if (self.alertStyle == JKAlertStyleCollectionSheet) {
            
            self.collectionTopContainerView.backgroundColor = (self.alertBackGroundView ? nil : JKAlertGlobalBackgroundColor());
        }
        
        return self;
    };
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
        
        return self.makeTitleColor([JKAlertMultiColor colorWithDynamicColor:textColor]);
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
        
        return self.makeMessageColor([JKAlertMultiColor colorWithDynamicColor:textColor]);
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

/** 设置title和message的左右间距 默认15 */
- (JKAlertView *(^)(CGFloat margin))setTextViewLeftRightMargin {
    
    return ^(CGFloat margin) {
        
        return self.makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
            
            UIEdgeInsets insets = originalInsets;
            
            insets.left = margin;
            insets.right = margin;
            
            return insets;
            
        }).makeMessageInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
            
            UIEdgeInsets insets = originalInsets;
            
            insets.left = margin;
            insets.right = margin;
            
            return insets;
        });
    };
}

/**
 * 设置title上间距和message下间距 默认20
 * HUD/collection样式title上下间距
 * plain样式下setPlainTitleMessageSeparatorHidden为NO时，该值为title上下间距
 * plain样式下setCustomPlainTitleView onlyForMessage为YES时，该值为title上下间距
 */
- (JKAlertView *(^)(CGFloat margin))setTextViewTopBottomMargin {
    
    return ^(CGFloat margin) {
        
        switch (self.alertStyle) {
            case JKAlertStylePlain:
            {
                if (!self.plainContentView.textContentView.customMessageView.hidden ||
                    !self.plainContentView.textContentView.separatorLineView.hidden) {
                    
                    self.makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
                        
                        UIEdgeInsets insets = originalInsets;
                        
                        insets.top = margin;
                        insets.bottom = margin;
                        
                        return insets;
                    });
                    
                } else {
                    
                    self.makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
                        
                        UIEdgeInsets insets = originalInsets;
                        
                        insets.top = margin;
                        
                        return insets;
                        
                    }).makeMessageInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
                        
                        UIEdgeInsets insets = originalInsets;
                        
                        insets.bottom = margin;
                        
                        return insets;
                        
                    });
                }
            }
                break;
            case JKAlertStyleHUD:
            case JKAlertStyleCollectionSheet:
            {
                self.makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
                    
                    UIEdgeInsets insets = originalInsets;
                    
                    insets.top = margin;
                    insets.bottom = margin;
                    
                    return insets;
                });
            }
                break;
                
            default:
            {
                
                self.makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
                    
                    UIEdgeInsets insets = originalInsets;
                    
                    insets.top = margin;
                    
                    return insets;
                    
                }).makeMessageInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
                    
                    UIEdgeInsets insets = originalInsets;
                    
                    insets.bottom = margin;
                    
                    return insets;
                    
                });
            }
                break;
        }
        
        return self;
    };
}

#pragma mark
#pragma mark - plain样式

/**
 * 设置plain样式的宽度
 * 默认290
 * 不可小于0，不可大于屏幕宽度
 */
- (JKAlertView *(^)(CGFloat width))setPlainWidth {
    
    if (JKAlertStylePlain == self.alertStyle) {
        
        return [self makePlainWidth];
    }
    
    if (JKAlertStyleHUD == self.alertStyle) {
        
        return [self makeHudWidth];
    }
    
    return ^(CGFloat width) { return self; };
}

/**
 * 是否自动缩小plain样式的宽度以适应屏幕宽度 默认NO
 */
- (JKAlertView *(^)(BOOL autoReducePlainWidth))setAutoReducePlainWidth {
    
    if (JKAlertStylePlain == self.alertStyle) {
        
        return [self makePlainAutoReduceWidth];
    }
    
    if (JKAlertStyleHUD == self.alertStyle) {
        
        return [self makeHudAutoReduceWidth];
    }
    
    return ^(BOOL autoReducePlainWidth) { return self; };
}

/**
 * 设置plain样式的圆角
 * 默认8 不可小于0
 */
- (JKAlertView *(^)(CGFloat cornerRadius))setPlainCornerRadius {
    
    if (JKAlertStylePlain == self.alertStyle) {
        
        return [self makePlainCornerRadius];
    }
    
    if (JKAlertStyleHUD == self.alertStyle) {
        
        return [self makeHudCornerRadius];
    }
    
    return ^(CGFloat cornerRadius) { return self; };
}

/**
 * 设置是否自动弹出键盘 默认YES
 */
- (JKAlertView *(^)(BOOL autoShowKeyboard))setAutoShowKeyboard {
    
    return [self makePlainAutoShowKeyboard];
}

/**
 * 设置是否自动适配键盘
 */
- (JKAlertView *(^)(BOOL autoAdaptKeyboard))setAutoAdaptKeyboard {
    
    return [self makePlainAutoAdaptKeyboard];
}

/**
 * 设置弹框底部与键盘间距
 */
- (JKAlertView *(^)(CGFloat plainKeyboardMargin))setPlainKeyboardMargin {
    
    return [self makePlainKeyboardMargin];
}


/**
 * 设置plain样式title和messagex上下之间的分隔线是否隐藏，默认YES
 * 当设置为NO时:
 1、setTextViewTopBottomMargin将自动改为title上下间距
 2、setTitleMessageMargin将自动改为message的上下间距
 * leftRightMargin : 分隔线的左右间距
 */
- (JKAlertView *(^)(BOOL separatorHidden, CGFloat leftRightMargin))setPlainTitleMessageSeparatorHidden{
    
    return ^(BOOL separatorHidden, CGFloat leftRightMargin) {
        
        if (JKAlertStylePlain != self.alertStyle) { return self; }
        
        self.plainContentView.textContentView.separatorLineHidden = separatorHidden;
        
        self.plainContentView.textContentView.separatorLineInsets = UIEdgeInsetsMake(0, leftRightMargin, 0, leftRightMargin);
        
        return self;
    };
}

/**
 * 设置plain样式title和message之间的间距 默认7
 * setPlainTitleMessageSeparatorHidden为NO时，该值表示message的上下间距
 * plain样式下setCustomPlainTitleView onlyForMessage为YES时，该值无影响
 */
- (JKAlertView *(^)(CGFloat margin))setTitleMessageMargin {
    
    return ^(CGFloat margin) {
        
        if (JKAlertStylePlain != self.alertStyle) { return self; }
        
        if (!self.plainContentView.textContentView.customMessageView.hidden) { return self; }
        
        if (!self.plainContentView.textContentView.separatorLineHidden) {
            
            self.makeMessageInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
                
                UIEdgeInsets insets = originalInsets;
                
                insets.top = margin * 0.5;
                
                return insets;
            });
            
            return self;
        }
        
        self.makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
            
            UIEdgeInsets insets = originalInsets;
            
            insets.bottom = margin * 0.5;
            
            return insets;
            
        }).makeMessageInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
            
            UIEdgeInsets insets = originalInsets;
            
            insets.top = margin * 0.5;
            
            return insets;
        });
        
        return self;
    };
}

/**
 * 设置plain样式添加自定义的titleView
 * frame给出高度即可，宽度自适应plain宽度
 * 请将自定义view视为容器view，推荐使用自动布局约束其子控件
 * onlyForMessage : 是否仅放在message位置
 * onlyForMessage如果为YES，有title时，title的上下间距则变为setTextViewTopBottomMargin的值
 */
- (JKAlertView *(^)(BOOL onlyForMessage, UIView *(^customView)(JKAlertView *view)))setCustomPlainTitleView {
    
    return ^(BOOL onlyForMessage, UIView *(^customView)(JKAlertView *view)) {
        
        if (!customView) { return self; }
        
        if (JKAlertStylePlain == self.alertStyle ||
            JKAlertStyleHUD == self.alertStyle) {
            
            UIView *titleView = customView(self);
            
            if (onlyForMessage) {
                
                self.currentTextContentView.customMessageView = titleView;
                
            } else {
                
                self.currentTextContentView.customContentView = titleView;
            }
        }
        
        return self;
    };
}

/**
 * 设置plain样式message最小高度 默认0
 * 仅在message != nil时有效
 * 该高度不包括message的上下间距
 */
- (JKAlertView *(^)(CGFloat minHeight))setMessageMinHeight {
    
    return [self makeMessageMinHeight];
}

/**
 * 设置plain/HUD样式centerY的偏移
 * 正数表示向下偏移，负数表示向上偏移
 */
- (JKAlertView *(^)(CGFloat centerOffsetY))setPlainCenterOffsetY {
    
    return ^(CGFloat centerOffsetY) {
        
        CGPoint point = self.plainCenterOffset;
        
        point.y = centerOffsetY;
        
        self.plainCenterOffset = point;
        
        return self;
    };
}

/**
 * 展示完成后 移动plain和HUD样式centerY
 * 正数表示向下偏移，负数表示向上偏移
 */
- (JKAlertView *(^)(CGFloat centerOffsetY, BOOL animated))movePlainCenterOffsetY {
    
    return ^(CGFloat centerOffsetY, BOOL animated) {
        
        CGPoint point = CGPointMake(0, centerOffsetY);
        
        if (JKAlertStylePlain == self.alertStyle) {
            
            self.makePlainMoveCenterOffset(point, animated, NO);
            
            return self;
        }
        
        if (JKAlertStyleHUD == self.alertStyle) {
            
            self.makeHudMoveCenterOffset(point, animated, NO);
            
            return self;
        }
        
        return self;
    };
}


#pragma mark
#pragma mark - HUD样式

/**
 * 设置HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
- (JKAlertView *(^)(NSTimeInterval dismissTimeInterval))setDismissTimeInterval {
    
    return [self makeHudDismissTimeInterval];
}

/**
 * 设置HUD样式高度，不包含customHUD
 * 小于等于0将没有效果，默认0
 */
- (JKAlertView *(^)(CGFloat height))setHUDHeight {
    
    return [self makeHudHeight];
}
@end
