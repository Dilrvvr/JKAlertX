//
//  JKAlertView+Deprecated.h
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertView.h"

@interface JKAlertView (Deprecated)

@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewCanSelectText)(BOOL canSelectText) JKAlertXDeprecated("use setTextViewShouldSelectText");

@property (nonatomic, copy, readonly) JKAlertView * (^setWillShowAnimation)(void(^willShowAnimation)(JKAlertView *view)) JKAlertXDeprecated("use setWillShowHandler");

@property (nonatomic, copy, readonly) JKAlertView * (^setShowAnimationComplete)(void(^showAnimationComplete)(JKAlertView *view)) JKAlertXDeprecated("use setDidShowHandler");

@property (nonatomic, copy, readonly) JKAlertView * (^setWillDismiss)(void(^willDismiss)(void)) JKAlertXDeprecated("use setWillDismissHandler");

@property (nonatomic, copy, readonly) JKAlertView * (^setDismissComplete)(void(^dismissComplete)(void)) JKAlertXDeprecated("use setDidDismissHandler");

/** 准备重新布局 */
@property (nonatomic, copy, readonly) JKAlertView * (^prepareToRelayout)(void) JKAlertXDeprecated("JKAlertViewProtocol已移除，无需调用该方法");

/** 重新设置其它属性，调用该方法返回JKAlertView，设置好其它属性后，再调用relayout即可 */
@property (nonatomic, copy, readonly) JKAlertView * (^resetOther)(void) JKAlertXDeprecated("JKAlertViewProtocol已移除，无需调用该方法");


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
@end
