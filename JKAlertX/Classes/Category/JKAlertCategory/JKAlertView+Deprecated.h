//
//  JKAlertView+Deprecated.h
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertView.h"

@interface JKAlertView (Deprecated)

/** 显示并监听JKAlertView消失动画完成 */
@property (nonatomic, copy, readonly) void (^showWithDismissComplete)(void (^dismissComplete)(void)) JKAlertXDeprecated("use showWithDidDismissHandler");

@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewCanSelectText)(BOOL canSelectText) JKAlertXDeprecated("use setTextViewShouldSelectText");

@property (nonatomic, copy, readonly) JKAlertView *(^setWillShowAnimation)(void (^willShowAnimation)(JKAlertView *view)) JKAlertXDeprecated("use setWillShowHandler");

@property (nonatomic, copy, readonly) JKAlertView *(^setShowAnimationComplete)(void (^showAnimationComplete)(JKAlertView *view)) JKAlertXDeprecated("use setDidShowHandler");

@property (nonatomic, copy, readonly) JKAlertView *(^setWillDismiss)(void (^willDismiss)(void)) JKAlertXDeprecated("use setWillDismissHandler");

@property (nonatomic, copy, readonly) JKAlertView *(^setDismissComplete)(void (^dismissComplete)(void)) JKAlertXDeprecated("use setDidDismissHandler");

/** 准备重新布局 */
@property (nonatomic, copy, readonly) JKAlertView *(^prepareToRelayout)(void) JKAlertXDeprecated("JKAlertViewProtocol已移除，无需调用该方法");

/** 重新设置其它属性，调用该方法返回JKAlertView，设置好其它属性后，再调用relayout即可 */
@property (nonatomic, copy, readonly) JKAlertView *(^resetOther)(void) JKAlertXDeprecated("JKAlertViewProtocol已移除，无需调用该方法");


#pragma mark
#pragma mark - 公共部分

/** 可以在这个block内自定义其它属性 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomizePropertyHandler)(void (^customizePropertyHandler)(JKAlertView *customizePropertyAlertView)) JKAlertXDeprecated("use makeCustomizationHandler");

/**
 * 设置点击空白处是否消失，plain默认NO，其它YES
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setClickBlankDismiss)(BOOL shouldDismiss) JKAlertXDeprecated("use makeTapBlankDismiss");

/** 设置监听点击空白处的block */
@property (nonatomic, copy, readonly) JKAlertView *(^setBlankClickBlock)(void (^blankClickBlock)(void)) JKAlertXDeprecated("use makeTapBlankHandler");

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
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleTextViewDelegate)(id <UITextViewDelegate> delegate) JKAlertXDeprecated("use makeTitleDelegate");

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
@property (nonatomic, copy, readonly) JKAlertView *(^setMessageTextViewDelegate)(id <UITextViewDelegate> delegate) JKAlertXDeprecated("use makeMessageDelegate");

/** 设置title和message的左右间距 默认20 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewLeftRightMargin)(CGFloat margin) JKAlertXDeprecated("use makeTitleInsets & makeMessageInsets");

/**
 * 设置title上间距和message下间距 默认20
 * HUD/collection样式title上下间距 
 * plain样式下setPlainTitleMessageSeparatorHidden为NO时，该值为title上下间距
 * plain样式下setCustomPlainTitleView onlyForMessage为YES时，该值为title上下间距
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewTopBottomMargin)(CGFloat margin) JKAlertXDeprecated("use makeTitleInsets & makeMessageInsets");

/** 设置默认的取消action，不需要自带的可以自己设置，不可置为nil */
@property (nonatomic, copy, readonly) JKAlertView *(^setCancelAction)(JKAlertAction *action) JKAlertXDeprecated("use makeCancelAction");

/// 监听屏幕旋转
/// 考虑到通知执行的顺序问题，不再监听屏幕旋转，统一使用makeWillRelayoutHandler执行一些布局前操作
@property (nonatomic, copy, readonly) JKAlertView *(^setOrientationChangeBlock)(void (^orientationChangeBlock)(JKAlertView *view, UIInterfaceOrientation orientation)) JKAlertXDeprecated("use makeWillRelayoutHandler");

/// 监听屏幕旋转
/// 考虑到通知执行的顺序问题，不再监听屏幕旋转，统一使用makeWillRelayoutHandler执行一些布局前操作
@property (nonatomic, copy, readonly) JKAlertView *(^makeOrientationDidChangeHandler)(void (^handler)(JKAlertView *innerAlertView, UIInterfaceOrientation orientation)) JKAlertXDeprecated("use makeWillRelayoutHandler");

/** 设置监听superView尺寸改变时将要自适应的block */
@property (nonatomic, copy, readonly) JKAlertView *(^setWillAutoAdaptSuperViewBlock)(void (^willAdaptBlock)(JKAlertView *view, UIView *containerView)) JKAlertXDeprecated("use makeWillRelayoutHandler");

/** 设置监听superView尺寸改变时自适应完成的block */
@property (nonatomic, copy, readonly) JKAlertView *(^setDidAutoAdaptSuperViewBlock)(void (^didAdaptBlock)(JKAlertView *view, UIView *containerView)) JKAlertXDeprecated("use makeDidRelayoutHandler");

/**
 * 重新布局完成的block
 * ****************** WARNING!!! ******************
 * 如果需要在block中再次relayout，请在block中销毁该block
 * 即调用setRelayoutComplete(nil); 否则会造成死循环
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setRelayoutComplete)(void (^relayoutComplete)(JKAlertView *view)) JKAlertXDeprecated("use makeDidRelayoutHandler");

/** 设置show的时候是否振动 默认NO */
@property (nonatomic, copy, readonly) JKAlertView *(^setShouldVibrate)(BOOL shouldVibrate) JKAlertXDeprecated("use makeVibrateEnabled");

/** 设置是否自动适配底部 iPhone X homeIndicator 默认YES */
@property (nonatomic, copy, readonly) JKAlertView *(^setAutoAdjustHomeIndicator)(BOOL autoAdjust) JKAlertXDeprecated("use makeHomeIndicatorAdapted");

/** 设置是否填充底部 iPhone X homeIndicator 默认YES */
@property (nonatomic, copy, readonly) JKAlertView *(^setFillHomeIndicator)(BOOL fillHomeIndicator) JKAlertXDeprecated("use makeHomeIndicatorFilled");

/** 设置action和colletion样式的底部按钮上下间距 不可小于0 */
@property (nonatomic, copy, readonly) JKAlertView *(^setBottomButtonMargin)(CGFloat margin) JKAlertXDeprecated("use makeBottomButtonMargin");

/** 监听即将开始显示动画 */
@property (nonatomic, copy, readonly) JKAlertView *(^setWillShowHandler)(void (^willShowHandler)(JKAlertView *view)) JKAlertXDeprecated("use makeWillShowHandler");

/** 监听显示动画完成 */
@property (nonatomic, copy, readonly) JKAlertView *(^setDidShowHandler)(void (^didShowHandler)(JKAlertView *view)) JKAlertXDeprecated("use makeDidShowHandler");

/** 监听JKAlertView即将开始消失动画 */
@property (nonatomic, copy, readonly) JKAlertView *(^setWillDismissHandler)(void (^willDismissHandler)(void)) JKAlertXDeprecated("use makeWillDismissHandler");

/** 监听JKAlertView消失动画完成 */
@property (nonatomic, copy, readonly) JKAlertView *(^setDidDismissHandler)(void (^didDismissHandler)(void)) JKAlertXDeprecated("use makeDidDismissHandler");

/** 设置是否允许dealloc打印，用于检查循环引用 */
@property (nonatomic, copy, readonly) JKAlertView *(^enableDeallocLog)(BOOL enable) JKAlertXDeprecated("use makeDeallocLogEnabled");

/** 设置dealloc时会调用的block */
@property (nonatomic, copy, readonly) void (^setDeallocBlock)(void (^deallocBlock)(void)) JKAlertXDeprecated("use makeDeallocHandler");

/**
 * 设置用于通知消失的key
 * 设置该值后可以使用类方法 JKAlertView.dismissForKey(dismissKey); 来手动消失
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setDismissKey)(NSString *dismissKey) JKAlertXDeprecated("use makeDismissKey");

/**
 * 设置是否使JKAlertView.dismissAll(); 对当前JKAlertView无效
 * 请谨慎使用，若设置为YES 调用JKAlertView.dismissAll(); 将对当前JKAlertView无效
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setDismissAllNoneffective)(BOOL isNoneffective) JKAlertXDeprecated("use makeDismissAllNoneffective");

/**
 * 设置用于通知消失的类别
 * 可以将多个弹框设置同一类别，方便移除同一类别的弹框
 * 设置该值后可以使用类方法 JKAlertView.dismissForCategory(dismissCategory); 来手动消失
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setDismissCategory)(NSString *dismissCategory) JKAlertXDeprecated("makeDismissCategory");

/**
 * 是否允许手势退出
 * 默认NO 仅限以下样式
 * JKAlertStyleActionSheet
 * JKAlertStyleCollectionSheet
 * JKAlertStyleNotification(: - JKTODO)
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeGestureDismissEnabled)(BOOL verticalEnabled, BOOL horizontalEnabled) JKAlertXDeprecated("use makeVerticalGestureDismissEnabled & makeHorizontalGestureDismissDirection");

#pragma mark
#pragma mark - 显示之后更新UI

/** 重新设置alertTitle */
@property (nonatomic, copy, readonly) JKAlertView *(^resetAlertTitle)(NSString *alertTitle) JKAlertXDeprecated("use remakeAlertTitle");

/** 重新设置alertAttributedTitle */
@property (nonatomic, copy, readonly) JKAlertView *(^resetAlertAttributedTitle)(NSAttributedString *alertAttributedTitle) JKAlertXDeprecated("use remakeAlertAttributedTitle");

/** 重新设置message */
@property (nonatomic, copy, readonly) JKAlertView *(^resetMessage)(NSString *message) JKAlertXDeprecated("use remakeMessage");

/** 重新设置attributedMessage */
@property (nonatomic, copy, readonly) JKAlertView *(^resetAttributedMessage)(NSAttributedString *attributedMessage) JKAlertXDeprecated("use remakeAttributedMessage");

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
 * 默认10 不可小于0
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainCornerRadius)(CGFloat cornerRadius) JKAlertXDeprecated("use makeCornerRadius");

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
 * 默认0 不控制间距，如需紧挨着键盘，可设置一个非常小的数，如0.01 
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
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainCloseButtonConfig)(void (^)(UIButton *closeButton)) JKAlertXDeprecated("use makePlainCloseButtonConfiguration");

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
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainCenterOffsetY)(CGFloat centerOffsetY) JKAlertXDeprecated("use makePlainCenterOffset or makeHudCenterOffset");

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

/**
 * 设置actionSheet样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 * isClearContainerBackgroundColor : 是否让其容器视图透明
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomActionSheetTitleView)(BOOL isClearContainerBackgroundColor, UIView *(^customView)(void)) JKAlertXDeprecated("use makeActionSheetCustomTitleView & makeActionSheetTopBackgroundColor");

/** 设置sheet样式最大高度 默认屏幕高度 * 0.85 */
@property (nonatomic, copy, readonly) JKAlertView *(^setSheetMaxHeight)(CGFloat height) JKAlertXDeprecated("use makeActionSheetMaxHeight");

/** 自定义配置tableView */
@property (nonatomic, copy, readonly) JKAlertView *(^setTableViewConfiguration)(void (^)(UITableView *tableView)) JKAlertXDeprecated("use makeActionSheetTableViewConfiguration");

/** 设置UITableViewDataSource */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomTableViewDataSource)(id <UITableViewDataSource> dataSource) JKAlertXDeprecated("use makeActionSheetTableViewDataSource");

/** 设置UITableViewDelegate */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomTableViewDelegate)(id <UITableViewDelegate> delegate) JKAlertXDeprecated("use makeActionSheetTableViewDelegate");

/** 设置actionSheet底部取消按钮是否固定在底部 默认NO */
@property (nonatomic, copy, readonly) JKAlertView *(^setPinCancelButton)(BOOL pinCancelButton) JKAlertXDeprecated("use makeActionSheetBottomButtonPinned");

/**
 * 设置actionSheet是否镂空
 * 类似UIAlertControllerStyleActionSheet效果
 * 设置为YES后，setPinCancelButton将强制为YES
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setActionSheetPierced)(BOOL isPierced, CGFloat cornerRadius, CGFloat horizontalMargin, CGFloat bottomMargin, UIColor *lightBackgroundColor, UIColor *darkBackgroundColor) JKAlertXDeprecated("use makeActionSheetPierced & makeActionSheetTopBackgroundColor");

#pragma mark
#pragma mark - collection sheet样式

/**
 * 设置collection的itemSize的宽度
 * 最大不可超过屏幕宽度的一半
 * 注意图片的宽高是设置的宽度-30，即图片在cell中是左右各15的间距
 * 自动计算item之间间距，最小为0，可自己计算该值设置每屏显示个数
 * 默认的高度是宽度-6，暂不支持自定义高度
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setFlowlayoutItemWidth)(CGFloat width) JKAlertXDeprecated("use makeCollectionSheetItemSize");

/**
 * 设置collection列数（每行数量）
 * 默认0，自动设置，不得大于自动设置的数量
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionColumnCount)(NSInteger columnCount) JKAlertXDeprecated("use makeCollectionSheetItemSize");

/**
 * 设置collection样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomCollectionTitleView)(UIView *(^customView)(void)) JKAlertXDeprecated("use makeCollectionSheetCustomTitleView");

/** 设置collection的title下分隔线是否隐藏 默认YES */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionTitleSeparatorHidden)(BOOL hidden) JKAlertXDeprecated("use makeCollectionSheetTitleSeparatorLineHidden");

/**
 * 设置collection的水平（左右方向）的sectionInset
 * 默认0，为0时自动设置为item间距的一半
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionHorizontalInset)(CGFloat inset) JKAlertXDeprecated("use makeCollectionSheetSectionInset");

/**
 * 设置两个collectionView之间的间距
 * 有第二个collectionView时有效 默认10, 最小为0
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionViewMargin)(CGFloat margin) JKAlertXDeprecated("use makeCollectionSheetCollectionViewMargin");

/**
 * 设置是否将两个collection合体
 * 设为YES可让两个collection同步滚动
 * 设置YES时会自动让两个collection的action数量保持一致，即向少的一方添加空的action
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCompoundCollection)(BOOL compoundCollection) JKAlertXDeprecated("use makeCollectionSheetCombined");

/** 设置collection是否分页 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionPagingEnabled)(BOOL collectionPagingEnabled) JKAlertXDeprecated("use makeCollectionSheetPagingEnabled");

/**
 * 设置collection是否显示pageControl
 * 如果只有一组collection，则必须设置分页为YES才有效
 * 如果有两组collection，则仅在分页和合体都为YES时才有效
 * 注意自己计算好每页显示的个数相等
 * 可以添加空的action来保证每页显示个数相等
 * JKAlertAction使用类方法初始化时每个参数传nil或者直接自己实例化一个即为空action
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setShowPageControl)(BOOL showPageControl) JKAlertXDeprecated("use makeCollectionSheetPageControlHidden");

/**
 * 设置pageControl
 * 必须setShowPageControl为YES之后才会有值
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionPageControlConfig)(void (^)(UIPageControl *pageControl)) JKAlertXDeprecated("use makeCollectionSheetPageControlConfiguration");

/** 设置colletion样式的底部按钮左右间距 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionButtonLeftRightMargin)(CGFloat margin) JKAlertXDeprecated("use makeCollectionSheetButtonInsets");

/** collection样式默认有一个取消按钮，设置这个可以在取消按钮的上面再添加一个按钮 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionAction)(JKAlertAction *action) JKAlertXDeprecated("use makeCollectionSheetAction");

#pragma mark
#pragma mark - 自定义动画

/**
 * 设置自定义展示动画，动画完成一定要调用showAnimationDidComplete
 * 此时所有frame已经计算好，plain样式animationView在中间，sheet样式animationView在底部
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomShowAnimationBlock)(void (^)(JKAlertView *view, UIView *animationView)) JKAlertXDeprecated("use makeCustomShowAnimationHandler");

/** 设置自定义消失动画，动画完成一定要调用dismissAnimationDidComplete */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomDismissAnimationBlock)(void (^)(JKAlertView *view, UIView *animationView)) JKAlertXDeprecated("use makeCustomDismissAnimationHandler");
@end
