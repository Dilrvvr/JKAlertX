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
    
    /** none */
    JKAlertStyleNone,
    
    /** 列表 */
    JKAlertStyleActionSheet,
    
    /** 面板 */
    JKAlertStylePlain,
    
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

/** title和message是否可以响应事件，默认NO */
@property (nonatomic, assign) BOOL textViewUserInteractionEnabled;

/** 设置title和message是否可以响应事件，默认NO */
- (JKAlertView *(^)(BOOL userInteractionEnabled))setTextViewUserInteractionEnabled;

/** titleTextViewDelegate */
@property (nonatomic, weak) id<UITextViewDelegate> titleTextViewDelegate;

/** 设置titleTextViewDelegate */
- (JKAlertView *(^)(id<UITextViewDelegate> delegate))setTitleTextViewDelegate;

/** messageTextViewDelegate */
@property (nonatomic, weak) id<UITextViewDelegate> messageTextViewDelegate;

/** 设置messageTextViewDelegate */
- (JKAlertView *(^)(id<UITextViewDelegate> delegate))setMessageTextViewSetDelegate;

/** titleTextViewAlignment */
@property (nonatomic, assign) NSTextAlignment titleTextViewAlignment;

/** 设置titleTextView的文字水平样式 */
- (JKAlertView *(^)(NSTextAlignment textAlignment))setTitleTextViewAlignment;

/** messageTextViewAlignment */
@property (nonatomic, assign) NSTextAlignment messageTextViewAlignment;

/** 设置messageTextView的文字水平样式 */
- (JKAlertView *(^)(NSTextAlignment textAlignment))setMessageTextViewAlignment;

/** title和message的左右间距 */
@property (nonatomic, assign) CGFloat textViewLeftRightMargin;

/** 设置title和message的左右间距 */
- (JKAlertView *(^)(CGFloat margin))setTextViewLeftRightMargin;

/** JKAlertStyleActionSheet样式底部的取消action，不需要自带的可以自己设置，不可置为nil */
@property (nonatomic, strong) JKAlertAction *cancelAction;

/** 设置JKAlertStyleActionSheet样式底部的取消action，不需要自带的可以自己设置，不可置为nil */
- (JKAlertView *(^)(JKAlertAction *action))setCancelAction;

/** dealloc时会调用的block */
@property (nonatomic, copy) void (^deallocBlock)(void);

/** 设置dealloc时会调用的block */
- (void(^)(void(^deallocBlock)(void)))setDeallocBlock;

/** 允许dealloc打印，用于检查循环引用 */
- (JKAlertView *(^)(BOOL enable))enableDeallocLog;



#pragma mark - plain样式

/**
 * 设置plain样式的宽度
 * 默认290
 * 不可小于0，不可大于屏幕宽度
 */
- (JKAlertView *(^)(CGFloat width))setPlainWidth;

/** plain样式添加自定义的titleView */
- (JKAlertView *(^)(UIView *(^customView)(void)))addCustomPlainTitleView;



#pragma mark - collectionSheet样式

/**
 * collection的item的宽度
 * 注意图片的宽高是设置的宽度-30
 * 最大不可超过屏幕宽度的一半
 * 自动计算item之间间距，最小为0，可自己计算该值设置每屏显示个数
 */
@property (nonatomic, assign) CGFloat flowlayoutItemWidth;

/**
 * 设置collection的item的宽度
 * 注意图片的宽高是设置的宽度-30
 * 最大不可超过屏幕宽度的一半
 * 自动计算item之间间距，最小为0，可自己计算该值设置每屏显示个数
 */
- (JKAlertView *(^)(CGFloat width))setFlowlayoutItemWidth;

/**
 * 是否将两个collection合体
 * 设为YES可让两个collection同步滚动
 * 设置YES时会自动让两个collection的action数量保持一致，即向少的一方添加空的action
 */
@property (nonatomic, assign) BOOL compoundCollection;

/**
 * 是否将两个collection合体
 * 设为YES可让两个collection同步滚动
 * 设置YES时会自动让两个collection的action数量保持一致，即向少的一方添加空的action
 */
- (JKAlertView *(^)(BOOL compoundCollection))setCompoundCollection;

/** collection是否分页 */
@property (nonatomic, assign) BOOL collectionPagingEnabled;

/** 设置collection是否分页 */
- (JKAlertView *(^)(BOOL collectionPagingEnabled))setCollectionPagingEnabled;

/**
 * 设置是否显示pageControl
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
- (JKAlertView *(^)(BOOL showPageControl))setShowPageControl;

/** colletion样式的底部按钮左右间距 */
@property (nonatomic, assign) CGFloat collectionButtonLeftRightMargin;

/** 设置colletion样式的底部按钮左右间距 */
- (JKAlertView *(^)(CGFloat margin))setCollectionButtonLeftRightMargin;

/** collection样式默认有一个取消按钮，设置这个可以在取消按钮的上面再添加一个按钮 */
@property (nonatomic, strong) JKAlertAction *collectionAction;

/** collection样式默认有一个取消按钮，设置这个可以在取消按钮的上面再添加一个按钮 */
- (JKAlertView *(^)(JKAlertAction *action))setCollectionAction;

/** collection样式添加自定义的titleView */
- (JKAlertView *(^)(UIView *(^customView)(void)))addCustomCollectionTitleView;

/** 添加第二个collectionView的action */
- (void)addSecondCollectionAction:(JKAlertAction *)action;

/** 链式添加第二个collectionView的action */
- (JKAlertView *(^)(JKAlertAction *action))addSecondCollectionAction;



#pragma mark - HUD样式

/**
 * HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
@property (nonatomic, assign) CGFloat dismissTimeInterval;

/**
 * HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
- (JKAlertView *(^)(CGFloat dismissTimeInterval))setDismissTimeInterval;


#pragma mark - 类方法

/** 实例化 */
+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message style:(JKAlertStyle)alertStyle;

/** 实例化 */
+ (instancetype)alertViewWithAttributeTitle:(NSAttributedString *)attributeTitle attributeMessage:(NSAttributedString *)attributeMessage style:(JKAlertStyle)alertStyle;

/** 显示文字HUD */
+ (JKAlertView *(^)(NSString *title))showHUDWithTitle;

/** 显示富文本HUD */
+ (JKAlertView *(^)(NSAttributedString *attributedTitle))showHUDWithAttributedTitle;

/**
 * 显示自定义HUD
 * 注意使用点语法调用，否则莫名报错 JKAlertView.showCustomHUD
 * 注意自己计算好自定义HUD的size，以避免横竖屏出现问题
 */
+ (JKAlertView *(^)(UIView *(^customHUD)(void)))showCustomHUD;

/** 移除当前所有的JKAlertView */
+ (void(^)(void))dismiss;


#pragma mark - 添加action

/** 添加action */
- (void)addAction:(JKAlertAction *)action;

/** 链式添加action */
- (JKAlertView *(^)(JKAlertAction *action))addAction;


#pragma mark - 显示

/** 显示 */
- (id<JKAlertViewProtocol>(^)(void))show;

/** 显示并监听JKAlertView消失动画完成 */
- (void(^)(void(^dismissComplete)(void)))showWithDismissComplete;

/** 退出 */
- (void(^)(void))dismiss;

/** 监听JKAlertView消失动画完成 */
- (void(^)(void(^dismissComplete)(void)))setDismissComplete;


#pragma mark - 其它适配
/** 设置action和colletion样式的底部按钮上下间距 不可小于0 */
- (JKAlertView *(^)(CGFloat margin))setBottomButtonMargin;

/** 设置是否自动适配 iPhone X homeIndicator */
- (JKAlertView *(^)(BOOL autoAdjust))setAutoAdjustHomeIndicator;
@end









