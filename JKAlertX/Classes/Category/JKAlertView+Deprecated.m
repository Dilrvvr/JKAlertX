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
                if (self.customPlainTitleViewOnlyForMessage ||
                    !self.plainTitleMessageSeparatorHidden) {
                    
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
    
    return [self makePlainWidth];
}

/**
 * 是否自动缩小plain样式的宽度以适应屏幕宽度 默认NO
 */
 - (JKAlertView *(^)(BOOL autoReducePlainWidth))setAutoReducePlainWidth {
     
     return [self makePlainAutoReduceWidth];
 }

 /**
  * 设置plain样式的圆角
  * 默认8 不可小于0
  */
 - (JKAlertView *(^)(CGFloat cornerRadius))setPlainCornerRadius {
     
     return [self makePlainCornerRadius];
 }

 /**
  * 设置是否自动弹出键盘 默认YES
  */
  - (JKAlertView *(^)(BOOL autoShowKeyboard))setAutoShowKeyboard {
      
      return [self makePlainAutoShowKeyboard];
  }
@end
