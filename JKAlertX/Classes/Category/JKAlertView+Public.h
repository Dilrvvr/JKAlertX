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

/** 是否已展示 */
@property (nonatomic, assign) BOOL isShowed;

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
 * 全屏背景颜色
 * 默认 black 0.4
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeFullBackgroundColor)(JKAlertMultiColor *color);

/**
 * 全屏背景view 默认无
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeFullBackgroundView)(UIView *(^backGroundView)(void));

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
#pragma mark - title /内容相关

/**
 * title 和内容是否可以响应事件，
 * 默认YES 如无必要不建议设置为NO
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleMessageUserInteractionEnabled)(BOOL userInteractionEnabled);

/**
 * title 和内容是否可以选择文字
 * 默认NO
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleMessageShouldSelectText)(BOOL shouldSelectText);

/**
 * title 字体
 * plain默认 bold 17
 * 其它 system 17
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleFont)(UIFont *font);

/**
 * title 字体颜色
 * plain默认RGB都为0.1
 * HUD 默认 white color
 * 其它0.35
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleColor)(JKAlertMultiColor *textColor);

/**
 * title 文字水平样式
 * 默认NSTextAlignmentCenter
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleAlignment)(NSTextAlignment textAlignment);

/**
 * title textView的代理
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleDelegate)(id <UITextViewDelegate> delegate);

/**
 * message 字体
 * plain默认14，其它13
 * action样式在没有title的时候，自动改为15，设置该值后将始终为该值，不自动修改
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeMessageFont)(UIFont *font);

/**
 * message 字体颜色
 * plain默认RGB都为0.55，其它0.3
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeMessageColor)(JKAlertMultiColor *textColor);

/**
 * message 文字水平样式
 * 默认NSTextAlignmentCenter
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeMessageAlignment)(NSTextAlignment textAlignment);

/**
 * message的textView的代理
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeMessageDelegate)(id <UITextViewDelegate> delegate);




/**
 * title 四周间距
 * 默认(20, 20, 20, 3.5)
 * 当无message或message隐藏时，bottom将自动使用messageInsets.bottom来计算
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleInsets)(UIEdgeInsets (^handler)(UIEdgeInsets originalInsets));

/**
 * message 四周间距
 * 默认(3.5, 20, 20, 20)
 * 当无title或title隐藏时，top将自动使用titleInsets.top来计算
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeMessageInsets)(UIEdgeInsets (^handler)(UIEdgeInsets originalInsets));

/**
 * title和message直接的分隔线是否隐藏
 * 默认YES
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleMessageSeparatorLineHidden)(BOOL hidden);

/**
 * title和message直接的分隔线四周间距
 * 默认(0, 0, 0, 0)
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleMessageSeparatorLineInsets)(UIEdgeInsets insets);

/**
 * 自定义整体title和message
 * 赋值后此时title和message及对应的自定义view将会隐藏 仅展示该自定义view
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCustomTextContentView)(UIView * (^handler)(void));

/**
 * 自定义title
 * 赋值后 title将隐藏 仅展示自定义view
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCustomTitleView)(UIView * (^handler)(void));

/**
 * 自定义message
 * 赋值后 message将隐藏 仅展示自定义view
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCustomMessageView)(UIView * (^handler)(void));

/**
 * message最小高度 默认0
 * 仅限有message且没有自定义makeCustomMessageView和makeCustomTextContentView
 * 该高度不包括message的上下间距
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeMessageMinHeight)(CGFloat minHeight);

/**
 * 仅有title或message时且没有自定义view时最小高度 默认0
 * 该高度不包括上下间距
 * 优先级 > makeMessageMinHeight
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeSingleTextMinHeight)(CGFloat minHeight);
@end
