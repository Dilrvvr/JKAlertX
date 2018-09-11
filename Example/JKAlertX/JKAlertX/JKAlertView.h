//
//  JKAlertView.h
//  TestVideoAndPicture
//
//  Created by albert on 2017/4/18.
//  Copyright © 2017年 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKAlertAction.h"

@protocol JKAlertViewProtocol

@required

/** 监听JKAlertView消失完成 */
- (void(^)(void(^dismissComplete)(void)))setDismissComplete;

@end

typedef enum : NSUInteger {
    
    /**
     * none
     * 该样式将不会创建JKAlertView
     */
    JKAlertStyleNone,
    
    /** 面板 */
    JKAlertStylePlain,
    
    /** 列表 */
    JKAlertStyleActionSheet,
    
    /**
     * collectionView样式
     * 该样式没有message，只有一个title
     */
    JKAlertStyleCollectionSheet,
    
    /**
     * HUD提示
     * 该样式没有message，只有一个title
     */
    JKAlertStyleHUD,
    
} JKAlertStyle;

@interface JKAlertView : UIView

#pragma mark - 公共部分

/**
 * 设置自定义的父控件
 * 默认添加到keywindow上
 * customSuperView在show之前有效
 * customSuperViewsize最好和屏幕大小一致，否则可能出现问题
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomSuperView)(UIView *customSuperView);

/** title和message是否可以响应事件，默认YES 如无必要不建议设置为NO */
@property (nonatomic, assign) BOOL textViewUserInteractionEnabled;

/** 设置title和message是否可以响应事件，默认YES 如无必要不建议设置为NO */
@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewUserInteractionEnabled)(BOOL userInteractionEnabled);

/** title和message是否可以选择文字，默认NO */
@property (nonatomic, assign) BOOL textViewCanSelectText;

/** 设置title和message是否可以选择文字，默认NO */
@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewCanSelectText)(BOOL canSelectText);

/**
 * 设置titleTextColor
 * plain默认RGB都为0.1，其它0.35
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleTextColor)(UIColor *textColor);

/**
 * 设置titleTextFont
 * plain默认 bold 17，其它17
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleTextFont)(UIFont *font);

/**
 * 设置messageTextColor
 * plain默认RGB都为0.55，其它0.3
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setMessageTextColor)(UIColor *textColor);

/**
 * 设置messageTextFont
 * plain默认14，其它13
 * action样式在没有title的时候，自动改为15，设置该值后将始终为该值，不自动修改
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setMessageTextFont)(UIFont *font);

/** titleTextViewDelegate */
@property (nonatomic, weak) id<UITextViewDelegate> titleTextViewDelegate;

/** 设置titleTextViewDelegate */
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleTextViewDelegate)(id<UITextViewDelegate> delegate);

/** messageTextViewDelegate */
@property (nonatomic, weak) id<UITextViewDelegate> messageTextViewDelegate;

/** 设置messageTextViewDelegate */
@property (nonatomic, copy, readonly) JKAlertView *(^setMessageTextViewDelegate)(id<UITextViewDelegate> delegate);

/** titleTextViewAlignment 默认NSTextAlignmentCenter */
@property (nonatomic, assign) NSTextAlignment titleTextViewAlignment;

/** 设置titleTextView的文字水平样式 默认NSTextAlignmentCenter */
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleTextViewAlignment)(NSTextAlignment textAlignment);

/** messageTextViewAlignment 默认NSTextAlignmentCenter */
@property (nonatomic, assign) NSTextAlignment messageTextViewAlignment;

/** 设置messageTextView的文字水平样式 默认NSTextAlignmentCenter */
@property (nonatomic, copy, readonly) JKAlertView *(^setMessageTextViewAlignment)(NSTextAlignment textAlignment);

/** title和message的左右间距 默认20 */
@property (nonatomic, assign) CGFloat textViewLeftRightMargin;

/** 设置title和message的左右间距 默认20 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewLeftRightMargin)(CGFloat margin);

/**
 * 设置title和message上下间距 默认20
 * plain样式title上间距和message下间距
 * collection样式title上下间距
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTextViewTopBottomMargin)(CGFloat margin);

/** 默认的取消action，不需要自带的可以自己设置，不可置为nil */
@property (nonatomic, strong) JKAlertAction *cancelAction;

/** 设置默认的取消action，不需要自带的可以自己设置，不可置为nil */
@property (nonatomic, copy, readonly) JKAlertView *(^setCancelAction)(JKAlertAction *action);

/** dealloc时会调用的block */
@property (nonatomic, copy) void (^deallocBlock)(void);

/** 设置dealloc时会调用的block */
@property (nonatomic, copy, readonly) void (^setDeallocBlock)(void(^deallocBlock)(void));

/** 设置是否允许dealloc打印，用于检查循环引用 */
@property (nonatomic, copy, readonly) JKAlertView *(^enableDeallocLog)(BOOL enable);

/**
 * 设置背景view
 * 默认是一个UIToolbar，背景是黑色0.1透明度
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setBackGroundView)(UIView *(^backGroundView)(void));

#pragma mark - plain样式

/**
 * 设置plain样式的宽度
 * 默认290
 * 不可小于0，不可大于屏幕宽度
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainWidth)(CGFloat width);

/**
 * 设置plain样式添加自定义的titleView
 * frame给出高度即可，宽度自适应plain宽度
 * 请将自定义view视为容器view，推荐使用自动布局约束其子控件
 */
@property (nonatomic, copy, readonly) JKAlertView *(^addCustomPlainTitleView)(UIView *(^customView)(void));

/** 设置title和message之间的间距 默认7 */
@property (nonatomic, copy, readonly) JKAlertView *(^setTitleMessageMargin)(CGFloat margin);

/**
 * 设置plain样式Y值
 */
//@property (nonatomic, copy, readonly) JKAlertView *(^setPlainY)(CGFloat Y, BOOL animated);

/**
 * 设置plain样式centerY的偏移
 * 正数表示向下偏移，负数表示向上偏移
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainCenterOffsetY)(CGFloat centerOffsetY, BOOL animated);



#pragma mark - HUD样式

/**
 * HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
@property (nonatomic, assign) CGFloat dismissTimeInterval;

/**
 * 设置HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setDismissTimeInterval)(CGFloat dismissTimeInterval);

/**
 * HUD样式centerY的偏移
 * 正数表示向下偏移，负数表示向上偏移
 */
@property (nonatomic, assign) CGFloat HUDCenterOffsetY;

/**
 * 设置HUD样式centerY的偏移
 * 正数表示向下偏移，负数表示向上偏移
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setHUDCenterOffsetY)(CGFloat centerOffsetY);

/**
 * HUD样式高度，不包含customHUD
 * 小于0将没有效果，默认-1
 */
@property (nonatomic, assign) CGFloat HUDHeight;

/**
 * 设置HUD样式高度，不包含customHUD
 * 小于0将没有效果，默认-1
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setHUDHeight)(CGFloat height);



#pragma mark - collectionSheet样式

/**
 * collection的itemSize的宽度
 * 最大不可超过屏幕宽度的一半
 * 注意图片的宽高是设置的宽度-30，即图片在cell中是左右各15的间距
 * 自动计算item之间间距，最小为0，可自己计算该值设置每屏显示个数
 * 默认的高度是宽度-6，暂不支持自定义高度
 */
@property (nonatomic, assign) CGFloat flowlayoutItemWidth;

/**
 * 设置collection的itemSize的宽度
 * 最大不可超过屏幕宽度的一半
 * 注意图片的宽高是设置的宽度-30，即图片在cell中是左右各15的间距
 * 自动计算item之间间距，最小为0，可自己计算该值设置每屏显示个数
 * 默认的高度是宽度-6，暂不支持自定义高度
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setFlowlayoutItemWidth)(CGFloat width);

/**
 * 是否将两个collection合体
 * 设为YES可让两个collection同步滚动
 * 设置YES时会自动让两个collection的action数量保持一致，即向少的一方添加空的action
 */
@property (nonatomic, assign) BOOL compoundCollection;

/**
 * 设置是否将两个collection合体
 * 设为YES可让两个collection同步滚动
 * 设置YES时会自动让两个collection的action数量保持一致，即向少的一方添加空的action
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCompoundCollection)(BOOL compoundCollection);

/** collection是否分页 */
@property (nonatomic, assign) BOOL collectionPagingEnabled;

/** 设置collection是否分页 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionPagingEnabled)(BOOL collectionPagingEnabled);

/**
 * 是否显示pageControl
 * 如果只有一组collection，则必须设置分页为YES才有效
 * 如果有两组collection，则仅在分页和合体都为YES时才有效
 * 注意自己计算好每页显示的个数相等
 * 可以添加空的action来保证每页显示个数相等
 * JKAlertAction使用类方法初始化时每个参数传nil或者直接自己实例化一个即为空action
 */
@property (nonatomic, assign) BOOL showPageControl;

/**
 * 设置是否显示pageControl
 * 如果只有一组collection，则必须设置分页为YES才有效
 * 如果有两组collection，则仅在分页和合体都为YES时才有效
 * 注意自己计算好每页显示的个数相等
 * 可以添加空的action来保证每页显示个数相等
 * JKAlertAction使用类方法初始化时每个参数传nil或者直接自己实例化一个即为空action
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setShowPageControl)(BOOL showPageControl);

/** colletion样式的底部按钮左右间距 */
@property (nonatomic, assign) CGFloat collectionButtonLeftRightMargin;

/** 设置colletion样式的底部按钮左右间距 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionButtonLeftRightMargin)(CGFloat margin);

/** collection样式默认有一个取消按钮，设置这个可以在取消按钮的上面再添加一个按钮 */
@property (nonatomic, strong) JKAlertAction *collectionAction;

/** collection样式默认有一个取消按钮，设置这个可以在取消按钮的上面再添加一个按钮 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionAction)(JKAlertAction *action);

/**
 * 设置collection样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 */
@property (nonatomic, copy, readonly) JKAlertView *(^addCustomCollectionTitleView)(UIView *(^customView)(void));

/** 添加第二个collectionView的action */
- (void)addSecondCollectionAction:(JKAlertAction *)action;

/** 链式添加第二个collectionView的action */
@property (nonatomic, copy, readonly) JKAlertView *(^addSecondCollectionAction)(JKAlertAction *action);



#pragma mark - 类方法

/** 实例化 */
+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message style:(JKAlertStyle)alertStyle;

/** 链式实例化 */
+ (JKAlertView *(^)(NSString *title, NSString *message, JKAlertStyle style))alertView;

/** 实例化 */
+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)attributedTitle attributedMessage:(NSAttributedString *)attributedMessage style:(JKAlertStyle)alertStyle;

/** 链式实例化 */
+ (JKAlertView *(^)(NSAttributedString *attributedTitle, NSAttributedString *attributedMessage, JKAlertStyle style))alertViewAttributed;

/** 显示文字HUD */
+ (JKAlertView *(^)(NSString *title))showHUDWithTitle;

/** 显示富文本HUD */
+ (JKAlertView *(^)(NSAttributedString *attributedTitle))showHUDWithAttributedTitle;

/**
 * 显示自定义HUD
 * 注意使用点语法调用，否则莫名报错 JKAlertView.showCustomHUD
 * customHUD尺寸将完全由自定义控制，默认显示在屏幕中间
 * 注意自己计算好自定义HUD的size，以避免横竖屏出现问题
 */
+ (JKAlertView *(^)(UIView *(^customHUD)(void)))showCustomHUD;

/** 移除当前所有的JKAlertView */
+ (void(^)(void))dismiss;


#pragma mark - 添加action

/** 添加action */
- (void)addAction:(JKAlertAction *)action;

/** 链式添加action */
@property (nonatomic, copy, readonly) JKAlertView *(^addAction)(JKAlertAction *action);


#pragma mark - 添加textField

/** 添加textField */
- (void)addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField *textField))configurationHandler;

/** 链式添加textField */
@property (nonatomic, copy, readonly) JKAlertView *(^addTextFieldWithConfigurationHandler)(void (^ __nullable)(UITextField *textField));


#pragma mark - 显示

/** 显示 */
@property (nonatomic, copy, readonly) id<JKAlertViewProtocol> (^show)(void);

/** 监听显示动画完成 */
@property (nonatomic, copy, readonly) id<JKAlertViewProtocol> (^setShowAnimationComplete)(void(^showAnimationComplete)(JKAlertView *view));

/** 显示并监听JKAlertView消失动画完成 */
@property (nonatomic, copy, readonly) void (^showWithDismissComplete)(void(^dismissComplete)(void));

/** 退出 */
@property (nonatomic, copy, readonly) void (^dismiss)(void);

/** 监听JKAlertView消失动画完成 */
@property (nonatomic, copy, readonly) void (^setDismissComplete)(void(^dismissComplete)(void));


#pragma mark - 其它适配

/** 设置action和colletion样式的底部按钮上下间距 不可小于0 */
@property (nonatomic, copy, readonly) JKAlertView *(^setBottomButtonMargin)(CGFloat margin);

/** 设置是否自动适配底部 iPhone X homeIndicator 默认YES */
@property (nonatomic, copy, readonly) JKAlertView *(^setAutoAdjustHomeIndicator)(BOOL autoAdjust);

/** 设置是否填充底部 iPhone X homeIndicator 默认YES */
@property (nonatomic, copy, readonly) JKAlertView *(^setFillHomeIndicator)(BOOL fillHomeIndicator);
@end









