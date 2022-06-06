//
//  JKAlertView+Deprecated.m
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertView+Deprecated.h"
#import "JKAlertView+PrivateProperty.h"
#import "JKAlertView+LifeCycle.h"
#import "JKAlertView+Public.h"
#import "JKAlertView+Plain.h"
#import "JKAlertView+HUD.h"
#import "JKAlertView+ActionSheet.h"
#import "JKAlertView+CollectionSheet.h"
#import "JKAlertTheme.h"

@implementation JKAlertView (Deprecated)

/** 显示并监听JKAlertView消失动画完成 */
- (void (^)(void (^dismissComplete)(void)))showWithDismissComplete {
    
    return [self showWithDidDismissHandler];
}

/** 设置title和message是否可以选择文字，默认NO */
- (JKAlertView *(^)(BOOL canselectText))setTextViewCanSelectText {
    
    return [self makeTitleMessageShouldSelectText];
}

- (JKAlertView *(^)(void (^willShowAnimation)(JKAlertView *view)))setWillShowAnimation {
    
    return [self makeWillShowHandler];
}

- (JKAlertView *(^)(void (^showAnimationComplete)(JKAlertView *view)))setShowAnimationComplete {
    
    return [self makeDidShowHandler];
}

- (JKAlertView *(^)(void (^willDismiss)(void)))setWillDismiss {
    
    return [self makeWillDismissHandler];
}

- (JKAlertView *(^)(void (^dismissComplete)(void)))setDismissComplete {
    
    return [self makeDidDismissHandler];
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
- (JKAlertView *(^)(void (^customizePropertyHandler)(JKAlertView *customizePropertyAlertView)))setCustomizePropertyHandler {
    
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
- (JKAlertView *(^)(void (^blankClickBlock)(void)))setBlankClickBlock {
    
    return ^(void(^handler)(void)) {
        
        self.blankClickBlock = handler;
        
        return self;
    };
}

/** 设置全屏背景是否透明，默认黑色 0.4 alpha */
- (JKAlertView *(^)(BOOL isClearFullScreenBackgroundColor))setClearFullScreenBackgroundColor {
    
    return ^(BOOL isClearFullScreenBackgroundColor) {
        
        if (isClearFullScreenBackgroundColor) {
            
            self.makeFullBackgroundColor(nil);
            
        } else {
            
            [self restoreFullBackgroundColor];
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
- (JKAlertView *(^)(UIView *(^backGroundView)(void)))setBackGroundView {
    
    return [self makeAlertBackgroundView];
}

/** 设置是否允许手势退出 仅限sheet样式 */
- (JKAlertView *(^)(BOOL enableVerticalGesture, BOOL enableHorizontalGesture, BOOL showGestureIndicator))setEnableGestureDismiss{
    
    return ^(BOOL enableVerticalGesture, BOOL enableHorizontalGesture, BOOL showGestureIndicator) {
        
        self.makeGestureDismissEnabled(enableVerticalGesture, enableHorizontalGesture);
        
        self.makeGestureIndicatorHidden(!showGestureIndicator);
        
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
    
    return [self makeTitleColor];
}

/** 设置titleTextViewDelegate */
- (JKAlertView *(^)(id <UITextViewDelegate> delegate))setTitleTextViewDelegate {
    
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
    
    return [self makeMessageColor];
}

/** 设置messageTextView的文字水平样式 */
- (JKAlertView *(^)(NSTextAlignment textAlignment))setMessageTextViewAlignment {
    
    return [self makeMessageAlignment];
}

/** 设置messageTextViewDelegate */
- (JKAlertView *(^)(id <UITextViewDelegate> delegate))setMessageTextViewDelegate {
    
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

/** 设置默认的取消action，不需要自带的可以自己设置，不可置为nil */
- (JKAlertView *(^)(JKAlertAction *action))setCancelAction {
    
    return [self makeCancelAction];
}

/// 监听屏幕旋转
/// 考虑到通知执行的顺序问题，不再监听屏幕旋转，统一使用makeWillRelayoutHandler执行一些布局前操作
- (JKAlertView *(^)(void (^orientationChangeBlock)(JKAlertView *view, UIInterfaceOrientation orientation)))setOrientationChangeBlock {
    
    return ^(void(^orientationChangeBlock)(JKAlertView *view, UIInterfaceOrientation orientation)) {
        
        self.orientationDidChangeHandler = orientationChangeBlock;
        
        return self;
    };
}

/// 监听屏幕旋转
/// 考虑到通知执行的顺序问题，不再监听屏幕旋转，统一使用makeWillRelayoutHandler执行一些布局前操作
- (JKAlertView *(^)(void (^handler)(JKAlertView *innerAlertView, UIInterfaceOrientation orientation)))makeOrientationDidChangeHandler {
    
    return ^(void(^handler)(JKAlertView *innerAlertView, UIInterfaceOrientation orientation)) {
        
        self.orientationDidChangeHandler = handler;
        
        return self;
    };
}

/** 设置监听superView尺寸改变时将要自适应的block */
- (JKAlertView *(^)(void (^willAdaptBlock)(JKAlertView *view, UIView *containerView)))setWillAutoAdaptSuperViewBlock {
    
    return [self makeWillRelayoutHandler];
}

/** 设置监听superView尺寸改变时自适应完成的block */
- (JKAlertView *(^)(void (^didAdaptBlock)(JKAlertView *view, UIView *containerView)))setDidAutoAdaptSuperViewBlock {
    
    return [self makeDidRelayoutHandler];
}

/** 监听重新布局完成 */
- (JKAlertView *(^)(void (^relayoutComplete)(JKAlertView *view)))setRelayoutComplete {
    
    return ^(void(^relayoutComplete)(JKAlertView *view)) {
        
        self.relayoutComplete = relayoutComplete;
        
        return self;
    };
}

/** 设置show的时候是否振动 默认NO */
- (JKAlertView *(^)(BOOL shouldVibrate))setShouldVibrate {
    
    return [self makeVibrateEnabled];
}

/** 设置是否自动适配 iPhone X homeIndicator 默认YES */
- (JKAlertView *(^)(BOOL autoAdjust))setAutoAdjustHomeIndicator {
    
    return [self makeHomeIndicatorAdapted];
}

/** 设置是否填充底部 iPhone X homeIndicator 默认YES */
- (JKAlertView *(^)(BOOL fillHomeIndicator))setFillHomeIndicator {
    
    return [self makeHomeIndicatorFilled];
}

/** 设置action和colletion样式的底部按钮上下间距 不可小于0 */
- (JKAlertView *(^)(CGFloat margin))setBottomButtonMargin {
    
    return [self makeBottomButtonMargin];
}

/** 监听即将开始显示动画 */
- (JKAlertView *(^)(void (^willShowHandler)(JKAlertView *view)))setWillShowHandler {
    
    return [self makeWillShowHandler];
}

/** 监听JKAlertView显示动画完成 */
- (JKAlertView *(^)(void (^didShowHandler)(JKAlertView *view)))setDidShowHandler {
    
    return [self makeDidShowHandler];
}

/** 监听JKAlertView即将消失 */
- (JKAlertView *(^)(void (^willDismissHandler)(void)))setWillDismissHandler {
    
    return [self makeWillDismissHandler];
}

/** 监听JKAlertView消失动画完成 */
- (JKAlertView *(^)(void (^didDismissHandler)(void)))setDidDismissHandler {
    
    return [self makeDidDismissHandler];
}

/** 允许dealloc打印，用于检查循环引用 */
- (JKAlertView *(^)(BOOL enable))enableDeallocLog {
    
    return [self makeDeallocLogEnabled];
}

/** 设置dealloc时会调用的block */
- (void (^)(void (^deallocBlock)(void)))setDeallocBlock {
    
    return [self makeDeallocHandler];
}

/**
 * 设置用于通知消失的key
 * 设置该值后可以使用类方法 JKAlertView.DismissForKey(dismissKey); 来手动消失
 */
- (JKAlertView *(^)(NSString *dismissKey))setDismissKey {
    
    return [self makeDismissKey];
}

/**
 * 设置是否使JKAlertView.dismissAll(); 对当前JKAlertView无效
 * 请谨慎使用，若设置为YES 调用JKAlertView.dismissAll(); 将对当前JKAlertView无效
 */
- (JKAlertView *(^)(BOOL isNoneffective))setDismissAllNoneffective {
    
    return [self makeDismissAllNoneffective];
}

/**
 * 设置用于通知消失的类别
 * 可以将多个弹框设置同一类别，方便移除同一类别的弹框
 * 设置该值后可以使用类方法 JKAlertView.dismissForCategory(dismissCategory); 来手动消失
 */
- (JKAlertView *(^)(NSString *dismissCategory))setDismissCategory {
    
    return [self makeDismissCategory];
}

/**
 * 是否允许手势退出
 * 默认NO 仅限以下样式
 * JKAlertStyleActionSheet
 * JKAlertStyleCollectionSheet
 * JKAlertStyleNotification(: - JKTODO)
 */
- (JKAlertView *(^)(BOOL verticalEnabled, BOOL horizontalEnabled))makeGestureDismissEnabled {
    
    return ^(BOOL verticalEnabled, BOOL horizontalEnabled) {
        
        return self.makeVerticalGestureDismissEnabled(verticalEnabled).self.makeHorizontalGestureDismissDirection(horizontalEnabled ? JKAlertSheetHorizontalGestureDismissDirectionHorizontal : JKAlertSheetHorizontalGestureDismissDirectionNone);
    };
}

#pragma mark
#pragma mark - 显示之后更新UI

/** 重新设置alertTitle */
- (JKAlertView *(^)(NSString *alertTitle))resetAlertTitle {
    
    return [self remakeAlertTitle];
}

/** 重新设置alertAttributedTitle */
- (JKAlertView *(^)(NSAttributedString *alertAttributedTitle))resetAlertAttributedTitle {
    
    return [self remakeAlertAttributedTitle];
}

/** 重新设置message */
- (JKAlertView *(^)(NSString *message))resetMessage {
    
    return [self remakeMessage];
}

/** 重新设置attributedMessage */
- (JKAlertView *(^)(NSAttributedString *attributedMessage))resetAttributedMessage {
    
    return [self remakeAttributedMessage];
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
 * 默认10 不可小于0
 */
- (JKAlertView *(^)(CGFloat cornerRadius))setPlainCornerRadius {
    
    return [self makeCornerRadius];
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
 * 默认0 不控制间距，如需紧挨着键盘，可设置一个非常小的数，如0.01 
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
- (JKAlertView *(^)(BOOL separatorHidden, CGFloat leftRightMargin))setPlainTitleMessageSeparatorHidden {
    
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

/** 设置plain样式关闭按钮 */
- (JKAlertView *(^)(void (^)(UIButton *button)))setPlainCloseButtonConfig {
    
    return ^(void (^closeButtonConfig)(UIButton *button)) {
        
        !closeButtonConfig ? : closeButtonConfig(self.closeButton);
        
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

#pragma mark
#pragma mark - action sheet样式
/**
 * 设置actionSheet样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 * isClearContainerBackgroundColor : 是否让其容器视图透明
 */
- (JKAlertView *(^)(BOOL isClearContainerBackgroundColor, UIView *(^customView)(void)))setCustomActionSheetTitleView {
    
    return ^(BOOL isClearContainerBackgroundColor, UIView *(^customView)(void)) {
        
        self.makeActionSheetCustomTitleView(customView);
        
        if (isClearContainerBackgroundColor) {
            
            self.makeActionSheetTopBackgroundColor(nil);
            
        } else {
            
            [self checkActionSheetStyleHandler:^{
               
                [self.actionsheetContentView restoreTopBackgroundColor];
            }];
        }
        
        return self;
    };
}

/** 设置sheet样式最大高度 默认屏幕高度 * 0.85 */
- (JKAlertView *(^)(CGFloat height))setSheetMaxHeight {
    
    return [self makeActionSheetMaxHeight];
}

/** 自定义配置tableView */
- (JKAlertView *(^)(void (^)(UITableView *tableView)))setTableViewConfiguration {
    
    return [self makeActionSheetTableViewConfiguration];
}

/** 设置UITableViewDataSource */
- (JKAlertView *(^)(id <UITableViewDataSource> dataSource))setCustomTableViewDataSource {
    
    return [self makeActionSheetTableViewDataSource];
}

/** 设置UITableViewDelegate */
- (JKAlertView *(^)(id <UITableViewDelegate> delegate))setCustomTableViewDelegate {
    
    return [self makeActionSheetTableViewDelegate];
}

/** 设置actionSheet底部取消按钮是否固定在底部 默认NO */
- (JKAlertView *(^)(BOOL pinCancelButton))setPinCancelButton {
    
    return [self makeActionSheetBottomButtonPinned];
}

/**
 * 设置actionSheet是否镂空
 * 类似UIAlertControllerStyleActionSheet效果
 * 设置为YES后，setPinCancelButton将强制为YES
 */
- (JKAlertView *(^)(BOOL isPierced, CGFloat cornerRadius, CGFloat horizontalMargin, CGFloat bottomMargin, UIColor *lightBackgroundColor, UIColor *darkBackgroundColor))setActionSheetPierced {
    
    return ^(BOOL isPierced, CGFloat cornerRadius, CGFloat horizontalMargin, CGFloat bottomMargin, UIColor *lightBackgroundColor, UIColor *darkBackgroundColor) {
        
        self.makeCornerRadius(cornerRadius).makeActionSheetPierced(isPierced, UIEdgeInsetsMake(0, horizontalMargin, bottomMargin, horizontalMargin));
        
        [JKAlertThemeProvider providerWithOwner:self handlerKey:NSStringFromSelector(@selector(makeActionSheetTopBackgroundColor)) provideHandler:^(JKAlertThemeProvider *provider, JKAlertView *providerOwner) {
            
            providerOwner.makeActionSheetTopBackgroundColor(JKAlertCheckDarkMode(lightBackgroundColor, darkBackgroundColor));
        }];
        
        return self;
    };
}

#pragma mark
#pragma mark - collection sheet样式

/**
 * 设置collection的itemSize的宽度
 * 最大不可超过屏幕宽度的一半
 * 注意图片的宽高是设置的宽度-30，即图片在cell中是左右各15的间距
 * 自动计算item之间间距，最小为0，可自己计算该值设置每屏显示个数
 * 默认的高度是宽度-6，暂不支持自定义高度
 */
- (JKAlertView *(^)(CGFloat width))setFlowlayoutItemWidth {
    
    return ^(CGFloat width) {
        
        return self.makeCollectionSheetItemSize(CGSizeMake(width, width - 6));
    };
}

/**
 * 设置collection列数（每行数量）
 * 默认0，自动设置，不得大于自动设置的数量
 */
- (JKAlertView *(^)(NSInteger columnCount))setCollectionColumnCount {
    
    return [self makeCollectionSheetColumnCount];
}

/**
 * 设置collection样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 */
- (JKAlertView *(^)(UIView *(^customView)(void)))setCustomCollectionTitleView {
    
    return [self makeCollectionSheetCustomTitleView];
}

/** 设置collection的title下分隔线是否隐藏 默认YES */
- (JKAlertView *(^)(BOOL hidden))setCollectionTitleSeparatorHidden {
    
    return [self makeCollectionSheetTitleSeparatorLineHidden];
}

/**
 * 设置collection的水平（左右方向）的sectionInset
 * 默认0，为0时自动设置为item间距的一半
 */
- (JKAlertView *(^)(CGFloat inset))setCollectionHorizontalInset {
    
    return ^(CGFloat inset) {
        
        return self.makeCollectionSheetSectionInset(UIEdgeInsetsMake(0, inset, 0, inset));
    };
}

/**
 * 设置两个collectionView之间的间距
 * 有第二个collectionView时有效 默认10, 最小为0
 */
- (JKAlertView *(^)(CGFloat margin))setCollectionViewMargin {
    
    return [self makeCollectionSheetCollectionViewMargin];
}

/**
 * 设置是否将两个collection合体
 * 设为YES可让两个collection同步滚动
 * 设置YES时会自动让两个collection的action数量保持一致，即向少的一方添加空的action
 */
- (JKAlertView *(^)(BOOL compoundCollection))setCompoundCollection {
    
    return [self makeCollectionSheetCombined];
}

/** 设置collection是否分页 */
- (JKAlertView *(^)(BOOL collectionPagingEnabled))setCollectionPagingEnabled {
    
    return [self makeCollectionSheetPagingEnabled];
}

/**
 * 设置是否显示pageControl
 * 如果只有一组collection，则必须设置分页为YES才有效
 * 如果有两组collection，则仅在分页和合体都为YES时才有效
 * 注意自己计算好每页显示的个数相等
 * 可以添加空的action来保证每页显示个数相等
 * JKAlertAction使用类方法初始化时每个参数传nil或者直接自己实例化一个即为空action
 */
- (JKAlertView *(^)(BOOL showPageControl))setShowPageControl {
    
    return ^(BOOL showPageControl) {
        
        return self.makeCollectionSheetPageControlHidden(!showPageControl);
    };
}

/**
 * 设置pageControl
 * 必须setShowPageControl为YES之后才会有值
 */
- (JKAlertView *(^)(void (^)(UIPageControl *pageControl)))setCollectionPageControlConfig {
    
    return [self makeCollectionSheetPageControlConfiguration];
}

/** 设置colletion样式的底部按钮左右间距 */
- (JKAlertView *(^)(CGFloat margin))setCollectionButtonLeftRightMargin {
    
    return ^(CGFloat margin) {
        
        return self.makeCollectionSheetButtonInsets(UIEdgeInsetsMake(0, margin, 0, margin));
    };
}

/** collection样式默认有一个取消按钮，设置这个可以在取消按钮的上面再添加一个按钮 */
- (JKAlertView *(^)(JKAlertAction *action))setCollectionAction {
    
    return [self makeCollectionSheetAction];
}

#pragma mark
#pragma mark - 自定义动画

/**
 * 设置自定义展示动画，动画完成一定要调用showAnimationDidComplete
 * 此时所有frame已经计算好，plain样式animationView在中间，sheet样式animationView在底部
 */
- (JKAlertView *(^)(void (^)(JKAlertView *view, UIView *animationView)))setCustomShowAnimationBlock {
    
    return [self makeCustomShowAnimationHandler];
}

/** 设置自定义消失动画 */
- (JKAlertView *(^)(void (^)(JKAlertView *view, UIView *animationView)))setCustomDismissAnimationBlock {
    
    return [self makeCustomDismissAnimationHandler];
}
@end
