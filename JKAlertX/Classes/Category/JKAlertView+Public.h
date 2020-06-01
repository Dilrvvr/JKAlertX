//
//  JKAlertView+Public.h
//  JKAlertX
//
//  Created by albertcc on 2020/5/31.
//

#import "JKAlertView.h"

@interface JKAlertView ()
{
    CGFloat JKAlertScreenW;
    CGFloat JKAlertScreenH;
    
    CGFloat JKAlertPlainViewMaxH;
}

/**
 * customSuperView
 */
@property (nonatomic, weak) UIView *customSuperView;

/**
 * tapBlankDismiss
 */
@property (nonatomic, assign) BOOL tapBlankDismiss;

/**
 * 监听点击空白处的block
 */
@property (nonatomic, copy) void (^tapBlankHandler)(JKAlertView *innerView);

/**
 * 配置弹出视图的容器view
 */
@property (nonatomic, copy) void (^alertContentViewConfiguration)(UIView *alertContentView);




/** 是否横屏 */
@property (nonatomic, assign) BOOL isLandScape;
@end






@interface JKAlertView (Public)

/**
 * 可以在这个block内自定义其它属性
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCustomizationHandler)(void(^handler)(JKAlertView *innerView));

/**
 * 设置自定义的父控件
 * 默认添加到keywindow上
 * customSuperView在show之前有效
 * customSuperViewsize最好和屏幕大小一致，否则可能出现问题
 * 请务必保证customSuperView.frame有值！
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCustomSuperView)(UIView *customSuperView);

/**
 * 点击空白处是否消失，plain/HUD默认NO，其它YES
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTapBlankDismiss)(BOOL shouldDismiss);

/**
 * 监听点击空白处的block
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTapBlankHandler)(void(^handler)(JKAlertView *innerView));

/**
 * 配置弹出视图的容器view，加圆角等
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeAlertContentViewConfiguration)(void (^configuration)(UIView *alertContentView));

/**
 * 设置背景view
 * 默认是一个UIVisualEffectView的UIBlurEffectStyleExtraLight效果
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeAlertBackgroundView)(UIView *(^backgroundView)(void));

#pragma mark
#pragma mark - 标题/内容相关

/**
 * 标题和内容是否可以响应事件，
 * 默认YES 如无必要不建议设置为NO
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleMessageUserInteractionEnabled)(BOOL userInteractionEnabled);

/**
 * 标题和内容是否可以选择文字
 * 默认NO
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleMessageShouldSelectText)(BOOL shouldSelectText);

/**
 * 标题字体
 * plain默认 bold 17
 * 其它 system 17
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleFont)(UIFont *font);

/**
 * 标题字体颜色
 * plain默认RGB都为0.1
 * HUD 默认 white color
 * 其它0.35
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleColor)(JKAlertMultiColor *textColor);

/**
 * 标题文字水平样式
 * 默认NSTextAlignmentCenter
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleAlignment)(NSTextAlignment textAlignment);

/**
 * 标题textView的代理
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleDelegate)(id <UITextViewDelegate> delegate);

/**
 * message字体
 * plain默认14，其它13
 * action样式在没有title的时候，自动改为15，设置该值后将始终为该值，不自动修改
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeMessageFont)(UIFont *font);

/**
 * message字体颜色
 * plain默认RGB都为0.55，其它0.3
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeMessageColor)(JKAlertMultiColor *textColor);

/**
 * message文字水平样式
 * 默认NSTextAlignmentCenter
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeMessageAlignment)(NSTextAlignment textAlignment);

/**
 * message的textView的代理
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeMessageDelegate)(id <UITextViewDelegate> delegate);
@end
