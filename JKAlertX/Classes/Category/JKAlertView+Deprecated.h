//
//  JKAlertView+Deprecated.h
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertView.h"

@interface JKAlertView (Deprecated)

/** 显示并监听JKAlertView消失动画完成 */
@property (nonatomic, copy, readonly) void (^showWithDismissComplete)(void(^dismissComplete)(void)) JKAlertXDeprecated("use showWithDidDismissHandler");

@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewCanSelectText)(BOOL canSelectText) JKAlertXDeprecated("use setTextViewShouldSelectText");

@property (nonatomic, copy, readonly) JKAlertView *(^setWillShowAnimation)(void(^willShowAnimation)(JKAlertView *view)) JKAlertXDeprecated("use setWillShowHandler");

@property (nonatomic, copy, readonly) JKAlertView *(^setShowAnimationComplete)(void(^showAnimationComplete)(JKAlertView *view)) JKAlertXDeprecated("use setDidShowHandler");

@property (nonatomic, copy, readonly) JKAlertView *(^setWillDismiss)(void(^willDismiss)(void)) JKAlertXDeprecated("use setWillDismissHandler");

@property (nonatomic, copy, readonly) JKAlertView *(^setDismissComplete)(void(^dismissComplete)(void)) JKAlertXDeprecated("use setDidDismissHandler");

/** 准备重新布局 */
@property (nonatomic, copy, readonly) JKAlertView *(^prepareToRelayout)(void) JKAlertXDeprecated("JKAlertViewProtocol已移除，无需调用该方法");

/** 重新设置其它属性，调用该方法返回JKAlertView，设置好其它属性后，再调用relayout即可 */
@property (nonatomic, copy, readonly) JKAlertView *(^resetOther)(void) JKAlertXDeprecated("JKAlertViewProtocol已移除，无需调用该方法");


#pragma mark
#pragma mark - 公共部分

/** 可以在这个block内自定义其它属性 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomizePropertyHandler)(void(^customizePropertyHandler)(JKAlertView *customizePropertyAlertView)) JKAlertXDeprecated("use makeCustomizationHandler");

/**
 * 设置点击空白处是否消失，plain默认NO，其它YES
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setClickBlankDismiss)(BOOL shouldDismiss) JKAlertXDeprecated("use makeTapBlankDismiss");

/** 设置监听点击空白处的block */
@property (nonatomic, copy, readonly) JKAlertView *(^setBlankClickBlock)(void(^blankClickBlock)(void)) JKAlertXDeprecated("use makeTapBlankHandler");

/** 设置全屏背景是否透明，默认黑色 0.4 alpha */
@property (nonatomic, copy, readonly) JKAlertView *(^setClearFullScreenBackgroundColor)(BOOL isClearFullScreenBackgroundColor) JKAlertXDeprecated("use makeFullBackgroundColor");
/**
 * 设置全屏背景view 默认无
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setFullScreenBackGroundView)(UIView *(^backGroundView)(void)) JKAlertXDeprecated("use makeFullBackgroundView");
/**
 * 配置弹出视图的容器view，加圆角等
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setContainerViewConfig)(void (^containerViewConfig)(UIView *containerView)) JKAlertXDeprecated("use makeAlertContentViewConfiguration");

/**
 * 设置自定义的父控件
 * 默认添加到keywindow上
 * customSuperView在show之前有效
 * customSuperViewsize最好和屏幕大小一致，否则可能出现问题
 * 请务必保证customSuperView.frame有值！
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomSuperView)(UIView *customSuperView) JKAlertXDeprecated("use makeCustomSuperView");

/**
 * 设置背景view
 * 默认是一个UIVisualEffectView的UIBlurEffectStyleExtraLight效果
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setBackGroundView)(UIView *(^backGroundView)(void)) JKAlertXDeprecated("use makeAlertBackgroundView");

/** 设置是否允许手势退出 默认NO NO 仅限sheet样式 */
@property (nonatomic, copy, readonly) JKAlertView *(^setEnableGestureDismiss)(BOOL enableVerticalGesture, BOOL enableHorizontalGesture, BOOL showGestureIndicator) JKAlertXDeprecated("use makeGestureDismissEnabled & makeGestureIndicatorHidden");

/** 设置title和message是否可以响应事件，默认YES 如无必要不建议设置为NO */
@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewUserInteractionEnabled)(BOOL userInteractionEnabled) JKAlertXDeprecated("use makeTitleMessageUserInteractionEnabled");

/** 设置title和message是否可以选择文字，默认NO */
@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewShouldSelectText)(BOOL shouldSelectText) JKAlertXDeprecated("use makeTitleMessageShouldSelectText");

/**
 * 设置titleTextFont
 * plain默认 bold 17，其它17
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleTextFont)(UIFont *font) JKAlertXDeprecated("use makeTitleFont");

/**
 * 设置titleTextColor
 * plain默认RGB都为0.1，其它0.35
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleTextColor)(UIColor *textColor) JKAlertXDeprecated("use makeTitleColor");

/** 设置titleTextViewDelegate */
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleTextViewDelegate)(id<UITextViewDelegate> delegate) JKAlertXDeprecated("use makeTitleDelegate");

/** 设置titleTextView的文字水平样式 默认NSTextAlignmentCenter */
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleTextViewAlignment)(NSTextAlignment textAlignment) JKAlertXDeprecated("use makeTitleAlignment");
/**
 * 设置messageTextFont
 * plain默认14，其它13
 * action样式在没有title的时候，自动改为15，设置该值后将始终为该值，不自动修改
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setMessageTextFont)(UIFont *font) JKAlertXDeprecated("use makeMessageFont");

/**
 * 设置messageTextColor
 * plain默认RGB都为0.55，其它0.3
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setMessageTextColor)(UIColor *textColor) JKAlertXDeprecated("use makeMessageColor");

/** 设置messageTextView的文字水平样式 默认NSTextAlignmentCenter */
@property (nonatomic, copy, readonly) JKAlertView *(^setMessageTextViewAlignment)(NSTextAlignment textAlignment) JKAlertXDeprecated("use makeMessageAlignment");

/** 设置messageTextViewDelegate */
@property (nonatomic, copy, readonly) JKAlertView *(^setMessageTextViewDelegate)(id<UITextViewDelegate> delegate) JKAlertXDeprecated("use makeMessageDelegate");

/** 设置title和message的左右间距 默认20 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewLeftRightMargin)(CGFloat margin) JKAlertXDeprecated("use makeTitleInsets & makeMessageInsets");

/**
 * 设置title上间距和message下间距 默认20
 * HUD/collection样式title上下间距 
 * plain样式下setPlainTitleMessageSeparatorHidden为NO时，该值为title上下间距
 * plain样式下setCustomPlainTitleView onlyForMessage为YES时，该值为title上下间距
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewTopBottomMargin)(CGFloat margin) JKAlertXDeprecated("use makeTitleInsets & makeMessageInsets");

/** 监听屏幕旋转 */
@property (nonatomic, copy, readonly) JKAlertView *(^setOrientationChangeBlock)(void(^orientationChangeBlock)(JKAlertView *view, UIInterfaceOrientation orientation)) JKAlertXDeprecated("use makeOrientationDidChangeHandler");

/** 设置监听superView尺寸改变时将要自适应的block */
@property (nonatomic, copy, readonly) JKAlertView *(^setWillAutoAdaptSuperViewBlock)(void(^willAdaptBlock)(JKAlertView *view, UIView *containerView)) JKAlertXDeprecated("use makeWillRelayoutHandler");

/** 设置监听superView尺寸改变时自适应完成的block */
@property (nonatomic, copy, readonly) JKAlertView *(^setDidAutoAdaptSuperViewBlock)(void(^didAdaptBlock)(JKAlertView *view, UIView *containerView)) JKAlertXDeprecated("use makeDidRelayoutHandler");

#pragma mark
#pragma mark - plain样式

/**
 * 设置plain样式的宽度
 * 默认290
 * 不可小于0，不可大于屏幕宽度
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainWidth)(CGFloat width) JKAlertXDeprecated("use makePlainWidth");

/**
 * 是否自动缩小plain样式的宽度以适应屏幕宽度 默认NO
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setAutoReducePlainWidth)(BOOL autoReducePlainWidth) JKAlertXDeprecated("use makeAutoReducePlainWidth");

/**
 * 设置plain样式的圆角
 * 默认8 不可小于0
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainCornerRadius)(CGFloat cornerRadius) JKAlertXDeprecated("use makePlainCornerRadius");

/**
 * 设置是否自动弹出键盘 默认YES
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setAutoShowKeyboard)(BOOL autoShowKeyboard) JKAlertXDeprecated("use makePlainAutoShowKeyboard");

/**
 * 是否自动适配键盘
 * 默认YES
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setAutoAdaptKeyboard)(BOOL autoAdaptKeyboard) JKAlertXDeprecated("use makePlainAutoAdaptKeyboard");

/**
 * 设置弹框底部与键盘间距
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainKeyboardMargin)(CGFloat plainKeyboardMargin) JKAlertXDeprecated("use makePlainKeyboardMargin");

/**
 * 设置plain样式title和message上下之间的分隔线是否隐藏，默认YES
 * 当设置为NO时:
 1、setTextViewTopBottomMargin将自动改为title上下间距
 2、setTitleMessageMargin将自动改为message的上下间距
 * leftRightMargin : 分隔线的左右间距
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainTitleMessageSeparatorHidden)(BOOL separatorHidden, CGFloat leftRightMargin) JKAlertXDeprecated("use makeTitleMessageSeparatorLineHidden & makeTitleMessageSeparatorLineInsets");

/**
 * 设置plain样式title和message之间的间距 默认7
 * setPlainTitleMessageSeparatorHidden为NO时，该值表示message的上下间距
 * plain样式下setCustomPlainTitleView onlyForMessage为YES时，该值无影响
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleMessageMargin)(CGFloat margin) JKAlertXDeprecated("use makeTitleInsets & makeMessageInsets");

/**
 * 设置plain样式添加自定义的titleView
 * frame给出高度即可，宽度自适应plain宽度
 * 请将自定义view视为容器view，推荐使用自动布局约束其子控件
 * onlyForMessage : 是否仅放在message位置
 * onlyForMessage如果为YES，有title时，title的上下间距则变为setTextViewTopBottomMargin的值
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomPlainTitleView)(BOOL onlyForMessage, UIView *(^customView)(JKAlertView *view)) JKAlertXDeprecated("use makeCustomTextContentView & makeCustomMessageView");

/** 设置plain样式关闭按钮 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainCloseButtonConfig)(void(^)(UIButton *closeButton)) JKAlertXDeprecated("use makePlainCloseButtonConfiguration");

/**
 * 设置plain样式message最小高度 默认0
 * 仅在message != nil时有效
 * 该高度不包括message的上下间距
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setMessageMinHeight)(CGFloat minHeight) JKAlertXDeprecated("use makeMessageMinHeight");

/**
 * 设置plain和HUD样式centerY的偏移
 * 正数表示向下偏移，负数表示向上偏移
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainCenterOffsetY)(CGFloat centerOffsetY) JKAlertXDeprecated("use makePlainCenterOffsetY or makeHudCenterOffsetY");

/**
 * 展示完成后 移动plain和HUD样式centerY
 * 正数表示向下偏移，负数表示向上偏移
 */
@property (nonatomic, copy, readonly) JKAlertView *(^movePlainCenterOffsetY)(CGFloat centerOffsetY, BOOL animated) JKAlertXDeprecated("use makePlainMoveCenterOffset or makeHudMoveCenterOffset");


#pragma mark
#pragma mark - HUD样式

/**
 * 设置HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setDismissTimeInterval)(NSTimeInterval dismissTimeInterval) JKAlertXDeprecated("use makeHudDismissTimeInterval");

/**
 * 设置HUD样式高度，不包含customHUD
 * 小于等于0将没有效果，默认0
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setHUDHeight)(CGFloat height) JKAlertXDeprecated("use makeHudHeight");

#pragma mark
#pragma mark - action sheet样式

#pragma mark
#pragma mark - collection sheet样式
@end
