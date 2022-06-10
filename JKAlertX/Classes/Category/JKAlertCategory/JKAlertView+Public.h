//
//  JKAlertView+Public.h
//  JKAlertX
//
//  Created by Albert on 2020/5/31.
//

#import "JKAlertView.h"

@interface JKAlertView ()

/** 是否已展示 */
@property (nonatomic, assign) BOOL isShowed;

/**
 * customSuperView
 */
@property (nonatomic, weak) UIView *customSuperView;

/// 键盘是否弹出状态
@property (nonatomic, assign, readonly) BOOL isKeyboardShow;

/// 点击空白处是否消失
@property (nonatomic, assign) BOOL tapBlankDismiss;

/// 点击空白处是否优先退出键盘 plain样式默认YES
@property (nonatomic, assign) BOOL tapBlankHideKeyboardFirst;

/// show的时候是否移除键盘 plain/sheet样式默认YES 其它NO
@property (nonatomic, assign) BOOL shouldHideKeyboardWhenShow;

/// 点击空白处是否移除键盘 plain/sheet样式默认YES 其它NO
@property (nonatomic, assign) BOOL shouldHideKeyboardWhenTapBlank;

/// 监听点击空白处的block
@property (nonatomic, copy) void (^tapBlankHandler)(JKAlertView *innerAlertView);

/// 配置弹出视图的容器view
@property (nonatomic, copy) void (^alertContentViewConfiguration)(UIView *alertContentView);


#pragma mark
#pragma mark - 动画完成

/** 自定义展示动画时，用于通知一下动画已经完成 */
@property (nonatomic, copy, readonly) void (^showAnimationDidComplete)(void);

/** 自定义消失动画时，用于通知一下动画已经完成 */
@property (nonatomic, copy, readonly) void (^dismissAnimationDidComplete)(void);
@end






@interface JKAlertView (Public)

/**
 * 深色/浅色模式
 */
@property (class, nonatomic, readonly) JKAlertView *(^makeThemeStyle)(JKAlertThemeStyle themeStyle);

/**
 * 可以在这个block内自定义其它属性
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCustomizationHandler)(void (^handler)(JKAlertView *innerAlertView));

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
@property (nonatomic, copy, readonly) JKAlertView *(^makeFullBackgroundColor)(UIColor *color);

/**
 * 全屏背景view
 * 默认nil
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeFullBackgroundView)(UIView *(^backgroundView)(void));

/**
 * 点击空白处是否消失，plain/HUD默认NO，其它YES
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTapBlankDismiss)(BOOL shouldDismiss);

/**
 * 点击空白处是否优先退出键盘，plain样式默认YES
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTapBlankHideKeyboardFirst)(BOOL hideKeyboardFirst);

/**
 * show的时候是否移除键盘 plain/sheet样式默认YES 其它NO
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeShouldHideKeyboardWhenShow)(BOOL shouldHide);

/**
 * 点击空白处是否移除键盘 plain/sheet样式默认YES 其它NO
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeShouldHideKeyboardWhenTapBlank)(BOOL shouldHide);

/**
 * 监听点击空白处的block
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeTapBlankHandler)(void (^handler)(JKAlertView *innerAlertView));

/**
 * 圆角
 * 默认 10
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCornerRadius)(CGFloat cornerRadius);

/**
 * 配置弹出视图的容器view，加圆角等
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeAlertContentViewConfiguration)(void (^configuration)(UIView *alertContentView));

/**
 * 背景颜色
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeAlertBackgroundColor)(UIColor *backgroundColor);

/**
 * 恢复默认背景颜色
 */
@property (nonatomic, copy, readonly) JKAlertView *(^restoreAlertBackgroundColor)(void);

/**
 * 背景view
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeAlertBackgroundView)(UIView *(^backgroundView)(void));

/**
 * actionSheet和collectionSheet样式自定义cell类名
 * actionSheet必须是或继承自JKAlertTableViewCell
 * collectionSheet必须是或继承自JKAlertCollectionViewCell
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCustomCellClassName)(NSString *cellClassName);

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
@property (nonatomic, copy, readonly) JKAlertView *(^makeTitleColor)(UIColor *textColor);

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
@property (nonatomic, copy, readonly) JKAlertView *(^makeMessageColor)(UIColor *textColor);

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
@property (nonatomic, copy, readonly) JKAlertView *(^makeCustomTextContentView)(UIView * (^handler)(JKAlertView *innerAlertView));

/**
 * 自定义title
 * 赋值后 title将隐藏 仅展示自定义view
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCustomTitleView)(UIView * (^handler)(JKAlertView *innerAlertView));

/**
 * 自定义message
 * 赋值后 message将隐藏 仅展示自定义view
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCustomMessageView)(UIView * (^handler)(JKAlertView *innerAlertView));

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

/**
 * 默认的取消action，不需要自带的可以自己设置，不可置为nil
 * plain样式不再需要该属性
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCancelAction)(JKAlertAction *action);

#pragma mark
#pragma mark - 自定义动画

/**
 * actionSheet/collectionSheet展示的动画样式
 * 默认JKAlertSheetShowAnimationTypeFromBottom 从底部弹出
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeSheetShowAnimationType)(JKAlertSheetShowAnimationType type);

/**
 * actionSheet/collectionSheet dismiss的动画样式
 * 默认JKAlertSheetDismissAnimationTypeToBottom 滑动至底部dismiss
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeSheetDismissAnimationType)(JKAlertSheetDismissAnimationType type);

/**
 * 自定义展示动画，动画完成一定要调用showAnimationDidComplete
 * 此时所有frame已经计算好，plain样式animationView在中间，sheet样式animationView在底部
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCustomShowAnimationHandler)(void (^)(JKAlertView *innerAlertView, UIView *animationView));

/**
 * 自定义消失动画，动画完成一定要调用dismissAnimationDidComplete
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCustomDismissAnimationHandler)(void (^)(JKAlertView *innerAlertView, UIView *animationView));

#pragma mark
#pragma mark - 手势退出

/**
 * 是否允许竖向手势退出
 * 默认NO 仅限以下样式
 * JKAlertStyleActionSheet 手势向下滑动退出 ↓
 * JKAlertStyleCollectionSheet 手势向下滑动退出 ↓
 * JKAlertStyleNotification(: - JKTODO 手势向上滑动退出 ↑)
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeVerticalGestureDismissEnabled)(BOOL enabled);

/**
 * 横向手势退出支持的方向
 * 默认JKAlertSheetHorizontalGestureDismissDirectionNone
 * 默认不支持横向手势退出仅限以下样式
 * JKAlertStyleActionSheet
 * JKAlertStyleCollectionSheet
 * JKAlertStyleNotification(: - JKTODO)
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeHorizontalGestureDismissDirection)(JKAlertSheetHorizontalGestureDismissDirection direction);

/**
 * 是否隐藏手势指示器(在顶部一个横条)
 * 默认YES，允许垂直手势退出时有效
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeGestureIndicatorHidden)(BOOL gestureIndicatorHidden);

/**
 * 展示时是否进行缩放动画
 * 默认NO 限sheet样式 正常从底部弹出时有效
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeShowScaleAnimated)(BOOL scaleAnimated);

#pragma mark
#pragma mark - 状态监听

/**
 * 监听即将重新布局
 * 尽量避免在此block中再次执行重新布局
 * 如有必要执行重新布局，请在重新布局前将此block销毁
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeWillRelayoutHandler)(void (^handler)(JKAlertView *innerAlertView, UIView *containerView));

/**
 * 监听重新布局完成
 * 尽量避免在此block中再次执行重新布局
 * 如有必要执行重新布局，请在重新布局前将此block销毁
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeDidRelayoutHandler)(void (^handler)(JKAlertView *innerAlertView, UIView *containerView));


#pragma mark
#pragma mark - 显示之后更新UI

/** 重新设置alertTitle */
@property (nonatomic, copy, readonly) JKAlertView *(^remakeAlertTitle)(NSString *alertTitle);

/** 重新设置alertAttributedTitle */
@property (nonatomic, copy, readonly) JKAlertView *(^remakeAlertAttributedTitle)(NSAttributedString *alertAttributedTitle);

/** 重新设置message */
@property (nonatomic, copy, readonly) JKAlertView *(^remakeMessage)(NSString *message);

/** 重新设置attributedMessage */
@property (nonatomic, copy, readonly) JKAlertView *(^remakeAttributedMessage)(NSAttributedString *attributedMessage);

/** 重新布局 */
@property (nonatomic, copy, readonly) JKAlertView *(^relayout)(BOOL animated);

/** 重新布局 */
- (void)relayoutAnimated:(BOOL)animated;


#pragma mark
#pragma mark - 其它适配

/**
 * show的时候是否振动 默认NO
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeVibrateEnabled)(BOOL enabled);

/**
 * 是否自动适配 iPhone X 底部 homeIndicator
 * 默认YES
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeHomeIndicatorAdapted)(BOOL adapted);

/**
 * 是否填充底部 iPhone X homeIndicator
 * 默认YES
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeHomeIndicatorFilled)(BOOL filled);

/**
 * action和colletion样式的底部按钮上下间距
 * 默认4寸屏5 4寸以上7 不可小于0
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeBottomButtonMargin)(CGFloat margin);
@end
