//
//  JKAlertView.h
//  TestVideoAndPicture
//
//  Created by albert on 2017/4/18.
//  Copyright © 2017年 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKAlertAction.h"
#import "JKAlertCustomizer.h"
#import "JKAlertConst.h"

@interface JKAlertView : UIView

/** 自定义管理对象 */
@property (nonatomic, strong, readonly) JKAlertCustomizer *customizer;

#pragma mark - 公共部分

/**
 * 设置自定义的父控件
 * 默认添加到keywindow上
 * customSuperView在show之前有效
 * customSuperViewsize最好和屏幕大小一致，否则可能出现问题
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomSuperView)(UIView *customSuperView) JKAlertXDeprecatedCustomizer;

/**
 * 设置全屏背景view 默认无
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setFullScreenBackGroundView)(UIView *(^backGroundView)(void)) JKAlertXDeprecatedCustomizer;

/** 设置title和message是否可以响应事件，默认YES 如无必要不建议设置为NO */
@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewUserInteractionEnabled)(BOOL userInteractionEnabled) JKAlertXDeprecatedCustomizer;

/** 设置title和message是否可以选择文字，默认NO */
@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewCanSelectText)(BOOL canSelectText) JKAlertXDeprecatedCustomizer;

/**
 * 设置titleTextColor
 * plain默认RGB都为0.1，其它0.35
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleTextColor)(UIColor *textColor) JKAlertXDeprecatedCustomizer;

/**
 * 设置titleTextFont
 * plain默认 bold 17，其它17
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleTextFont)(UIFont *font) JKAlertXDeprecatedCustomizer;

/**
 * 设置messageTextColor
 * plain默认RGB都为0.55，其它0.3
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setMessageTextColor)(UIColor *textColor) JKAlertXDeprecatedCustomizer;

/**
 * 设置messageTextFont
 * plain默认14，其它13
 * action样式在没有title的时候，自动改为15，设置该值后将始终为该值，不自动修改
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setMessageTextFont)(UIFont *font) JKAlertXDeprecatedCustomizer;

/** 设置titleTextViewDelegate */
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleTextViewDelegate)(id<UITextViewDelegate> delegate) JKAlertXDeprecatedCustomizer;

/** 设置messageTextViewDelegate */
@property (nonatomic, copy, readonly) JKAlertView *(^setMessageTextViewDelegate)(id<UITextViewDelegate> delegate) JKAlertXDeprecatedCustomizer;

/** 设置titleTextView的文字水平样式 默认NSTextAlignmentCenter */
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleTextViewAlignment)(NSTextAlignment textAlignment) JKAlertXDeprecatedCustomizer;

/** 设置messageTextView的文字水平样式 默认NSTextAlignmentCenter */
@property (nonatomic, copy, readonly) JKAlertView *(^setMessageTextViewAlignment)(NSTextAlignment textAlignment) JKAlertXDeprecatedCustomizer;

/**
 * 设置背景view
 * 默认是一个UIToolbar
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setBackGroundView)(UIView *(^backGroundView)(void)) JKAlertXDeprecatedCustomizer;






/** 设置title和message的左右间距 默认20 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewLeftRightMargin)(CGFloat margin) JKAlertXDeprecatedCustomizer;

/**
 * 设置title和message上下间距 默认20
 * plain样式title上间距和message下间距
 * collection样式title上下间距
 * plain样式下setPlainTitleMessageSeparatorHidden为NO时，该值为title上下间距
 * plain样式下setCustomPlainTitleView onlyForMessage为YES时，该值为title上下间距
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewTopBottomMargin)(CGFloat margin);

/** 设置默认的取消action，不需要自带的可以自己设置，不可置为nil */
@property (nonatomic, copy, readonly) JKAlertView *(^setCancelAction)(JKAlertAction *action);

/**
 * 设置是否使JKAlertView.dismissAll(); 对当前JKAlertView无效
 * 请谨慎使用，若设置为YES 调用JKAlertView.dismissAll(); 将对当前JKAlertView无效
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setDismissAllNoneffective)(BOOL isNoneffective);

/**
 * 设置用于通知消失的key
 * 设置该值后可以使用类方法 JKAlertView.DismissForKey(dimissKey); 来手动消失
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setDismissKey)(NSString *dimissKey);


#pragma mark - plain样式

/**
 * 设置plain样式的宽度
 * 默认290
 * 不可小于0，不可大于屏幕宽度
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainWidth)(CGFloat width);

/**
 * 设置plain样式的圆角
 * 默认8 不可小于0
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainCornerRadius)(CGFloat cornerRadius);

/**
 * 设置plain样式添加自定义的titleView
 * frame给出高度即可，宽度自适应plain宽度
 * 请将自定义view视为容器view，推荐使用自动布局约束其子控件
 * onlyForMessage : 是否仅放在message位置
 * onlyForMessage如果为YES，有title时，title的上下间距则变为setTextViewTopBottomMargin的值
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomPlainTitleView)(BOOL onlyForMessage, UIView *(^customView)(JKAlertView *view));

/**
 * 设置plain样式title和message之间的间距 默认7
 * setPlainTitleMessageSeparatorHidden为NO时，该值表示message的上下间距
 * plain样式下setCustomPlainTitleView onlyForMessage为YES时，该值无影响
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleMessageMargin)(CGFloat margin);

/**
 * 设置plain样式title和messagex上下之间的分隔线是否隐藏，默认YES
 * 当设置为NO时:
        1、setTextViewTopBottomMargin将自动改为title上下间距
        2、setTitleMessageMargin将自动改为message的上下间距
 * leftRightMargin : 分隔线的左右间距
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainTitleMessageSeparatorHidden)(BOOL separatorHidden, CGFloat leftRightMargin);

/**
 * 设置plain样式message最小高度 默认0
 * 仅在message != nil时有效
 * 该高度不包括message的上下间距
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setMessageMinHeight)(CGFloat minHeight);

/** 设置plain样式关闭按钮 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainCloseButtonConfig)(void(^)(UIButton *closeButton));

/**
 * 设置plain和HUD样式centerY的偏移
 * 正数表示向下偏移，负数表示向上偏移
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainCenterOffsetY)(CGFloat centerOffsetY);

/**
 * 展示完成后 移动plain和HUD样式centerY
 * 正数表示向下偏移，负数表示向上偏移
 */
@property (nonatomic, copy, readonly) JKAlertView *(^movePlainCenterOffsetY)(CGFloat centerOffsetY, BOOL animated);

/**
 * 设置点击plain空白处是否消失
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setClickPlainBlankDismiss)(BOOL shouldDismiss);


#pragma mark - HUD样式

/**
 * 设置HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setDismissTimeInterval)(CGFloat dismissTimeInterval);

/**
 * 设置HUD样式高度，不包含customHUD
 * 小于0将没有效果，默认-1
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setHUDHeight)(CGFloat height);


#pragma mark - actionSheet样式

/**
 * 设置actionSheet样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomActionSheetTitleView)(UIView *(^customView)(void));


#pragma mark - collectionSheet样式

/**
 * 设置collection的itemSize的宽度
 * 最大不可超过屏幕宽度的一半
 * 注意图片的宽高是设置的宽度-30，即图片在cell中是左右各15的间距
 * 自动计算item之间间距，最小为0，可自己计算该值设置每屏显示个数
 * 默认的高度是宽度-6，暂不支持自定义高度
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setFlowlayoutItemWidth)(CGFloat width);

/**
 * 设置是否将两个collection合体
 * 设为YES可让两个collection同步滚动
 * 设置YES时会自动让两个collection的action数量保持一致，即向少的一方添加空的action
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCompoundCollection)(BOOL compoundCollection);

/** 设置collection是否分页 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionPagingEnabled)(BOOL collectionPagingEnabled);

/**
 * 设置collection是否显示pageControl
 * 如果只有一组collection，则必须设置分页为YES才有效
 * 如果有两组collection，则仅在分页和合体都为YES时才有效
 * 注意自己计算好每页显示的个数相等
 * 可以添加空的action来保证每页显示个数相等
 * JKAlertAction使用类方法初始化时每个参数传nil或者直接自己实例化一个即为空action
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setShowPageControl)(BOOL showPageControl);

/** 设置colletion样式的底部按钮左右间距 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionButtonLeftRightMargin)(CGFloat margin);

/** collection样式默认有一个取消按钮，设置这个可以在取消按钮的上面再添加一个按钮 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionAction)(JKAlertAction *action);

/**
 * 设置collection样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomCollectionTitleView)(UIView *(^customView)(void));

/** collection添加第二个collectionView的action */
- (void)addSecondCollectionAction:(JKAlertAction *)action;

/** 添加第二个collectionView的action */
- (void)insertSecondCollectionAction:(JKAlertAction *)action atIndex:(NSUInteger)index;

/** collection链式添加第二个collectionView的action */
@property (nonatomic, copy, readonly) JKAlertView *(^addSecondCollectionAction)(JKAlertAction *action);

/** collection链式添加第二个collectionView的action */
@property (nonatomic, copy, readonly) JKAlertView *(^insertSecondCollectionAction)(JKAlertAction *action, NSUInteger atIndex);



#pragma mark - 类方法

/** 函数式类方法 */
@property (class, nonatomic, copy, readonly) id<JKAlertViewProtocol> (^show)(NSString *title, NSString *message, JKAlertStyle style, void(^configuration)(JKAlertView *alertView));

/** 实例化 */
+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message style:(JKAlertStyle)alertStyle;

/** 链式实例化 */
@property (class, nonatomic, copy, readonly) JKAlertView * (^alertView)(NSString *title, NSString *message, JKAlertStyle style);

/** 富文本实例化 */
+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)attributedTitle attributedMessage:(NSAttributedString *)attributedMessage style:(JKAlertStyle)alertStyle;

/** 富文本链式实例化 */
@property (class, nonatomic, copy, readonly) JKAlertView * (^alertViewAttributed)(NSAttributedString *attributedTitle, NSAttributedString *attributedMessage, JKAlertStyle style);

/** 显示文字HUD */
@property (class, nonatomic, copy, readonly) JKAlertView *(^showHUDWithTitle)(NSString *title);

/** 显示富文本HUD */
@property (class, nonatomic, copy, readonly) JKAlertView *(^showHUDWithAttributedTitle)(NSAttributedString *attributedTitle);

/**
 * 移除当前所有的JKAlertView
 * 本质是发送一个通知，让所有的JKAlertView对象执行消失操作
 * 注意如果某个对象setDismissAllNoneffective为YES时，该对象将不会响应通知
 * ***谨慎使用该方法***
 */
@property (class, nonatomic, copy, readonly) void (^dismissAll)(void);

/**
 * 移除设置了dismissKey的JKAlertView
 * 本质是发送一个通知，让dismissKey为该值的JKAlertView对象执行消失操作
 */
@property (class, nonatomic, copy, readonly) void (^dismissForKey)(NSString *dismissKey);

/**
 * 显示自定义HUD
 * 注意使用点语法调用，否则莫名报错 JKAlertView.showCustomHUD
 * customHUD尺寸将完全由自定义控制，默认显示在屏幕中间
 * 注意自己计算好自定义HUD的size，以避免横竖屏出现问题
 */
@property (class, nonatomic, copy, readonly) JKAlertView *(^showCustomHUD)(UIView *(^customHUD)(void));


#pragma mark - 添加action

/** 添加action */
- (void)addAction:(JKAlertAction *)action;

/** 添加action */
- (void)insertAction:(JKAlertAction *)action atIndex:(NSUInteger)index;

/** 链式添加action */
@property (nonatomic, copy, readonly) JKAlertView *(^addAction)(JKAlertAction *action);

/** 链式添加action */
@property (nonatomic, copy, readonly) JKAlertView *(^insertAction)(JKAlertAction *action, NSUInteger atIndex);


#pragma mark - 添加textField

/**
 * 添加textField 默认高度30
 * textField之间的间距是1，和其superView的上下左右间距也是1
 * textField可以直接对其superView进行一些属性修改，如背景色
 * block中的参数view用于调用dismiss()来移除当前弹框
 */
- (void)addTextFieldWithConfigurationHandler:(void (^)(JKAlertView *view, UITextField *textField))configurationHandler;

/**
 * 链式添加textField 默认高度30
 * textField之间的间距是1，和其superView的上下左右间距也是1
 * textField可以直接对其superView进行一些属性修改，如背景色
 * block中的参数view用于调用dismiss()来移除当前弹框
 */
@property (nonatomic, copy, readonly) JKAlertView *(^addTextFieldWithConfigurationHandler)(void (^)(JKAlertView *view, UITextField *textField));


#pragma mark - 显示

/** 显示 */
@property (nonatomic, copy, readonly) id<JKAlertViewProtocol> (^show)(void);

/** 显示并监听JKAlertView消失动画完成 */
@property (nonatomic, copy, readonly) void (^showWithDismissComplete)(void(^dismissComplete)(void));

/** 退出 */
@property (nonatomic, copy, readonly) void (^dismiss)(void);


#pragma mark - 自定义动画

/**
 * 设置自定义展示动画，动画完成一定要调用showAnimationDidComplete
 * 此时所有frame已经计算好，plain样式animationView在中间，sheet样式animationView在底部
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomShowAnimationBlock)(void(^)(JKAlertView *view, UIView *animationView));

/** 自定义展示动画时，用于通知一下动画已经完成 */
@property (nonatomic, copy, readonly) void (^showAnimationDidComplete)(void);

/** 设置自定义消失动画，动画完成一定要调用dismissAnimationDidComplete */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomDismissAnimationBlock)(void(^)(JKAlertView *view, UIView *animationView));

/** 自定义消失动画时，用于通知一下动画已经完成 */
@property (nonatomic, copy, readonly) void (^dismissAnimationDidComplete)(void);


#pragma mark - 状态监听

/** 监听显示动画完成 */
@property (nonatomic, copy, readonly) id<JKAlertViewProtocol> (^setShowAnimationComplete)(void(^showAnimationComplete)(JKAlertView *view));

/** 监听JKAlertView即将开始消失动画 */
@property (nonatomic, copy, readonly) void (^setWillDismiss)(void(^willDismiss)(void));

/** 监听JKAlertView消失动画完成 */
@property (nonatomic, copy, readonly) void (^setDismissComplete)(void(^dismissComplete)(void));

/** 设置dealloc时会调用的block */
@property (nonatomic, copy, readonly) void (^setDeallocBlock)(void(^deallocBlock)(void));

/** 设置是否允许dealloc打印，用于检查循环引用 */
@property (nonatomic, copy, readonly) JKAlertView *(^enableDeallocLog)(BOOL enable) JKAlertXDeprecatedCustomizer;


#pragma mark - 其它适配

/** 设置action和colletion样式的底部按钮上下间距 不可小于0 */
@property (nonatomic, copy, readonly) JKAlertView *(^setBottomButtonMargin)(CGFloat margin);

/** 设置是否自动适配底部 iPhone X homeIndicator 默认YES */
@property (nonatomic, copy, readonly) JKAlertView *(^setAutoAdjustHomeIndicator)(BOOL autoAdjust);

/** 设置是否填充底部 iPhone X homeIndicator 默认YES */
@property (nonatomic, copy, readonly) JKAlertView *(^setFillHomeIndicator)(BOOL fillHomeIndicator);
@end


#pragma mark
#pragma mark - UIControl点击分类

@interface UIControl (JKAlertX)


- (void)JKAlertX_addClickOperation:(void(^)(id control))clickOperation;

- (void)JKAlertX_addOperation:(void(^)(id control))clickOperation forControlEvents:(UIControlEvents)controlEvents;
@end


#pragma mark
#pragma mark - 手势分类

@interface UIGestureRecognizer (JKAlertX)


+ (instancetype)JKAlertX_gestureWithOperation:(void(^)(id gesture))gestureOperation;

- (void)JKAlertX_addGestureOperation:(void(^)(id gesture))gestureOperation;
@end
