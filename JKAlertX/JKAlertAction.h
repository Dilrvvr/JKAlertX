//
//  JKAlertAction.h
//  TestVideoAndPicture
//
//  Created by albert on 2017/4/18.
//  Copyright © 2017年 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKAlertConst.h"

@interface JKAlertAction : NSObject

/** title */
@property (nonatomic, copy, readonly) NSString *title;

/** 重新设置title */
@property (nonatomic, copy, readonly) JKAlertAction *(^resetTitle)(NSString *title);

/** attributedTitle */
@property (nonatomic, strong, readonly) NSAttributedString *attributedTitle;

/** 重新设置attributedTitle */
@property (nonatomic, copy, readonly) JKAlertAction *(^resetAttributedTitle)(NSAttributedString *attributedTitle);

/** handler */
@property (nonatomic, copy, readonly) void (^handler)(JKAlertAction *action);

/** imageContentMode */
@property (nonatomic, assign) UIViewContentMode imageContentMode;

/** normalImage */
@property (nonatomic, strong) UIImage *normalImage;

/** hightlightedImage */
@property (nonatomic, strong) UIImage *hightlightedImage;

/** aciton所处的alertView 仅用于dismiss */
@property (nonatomic, weak) id <JKAlertViewProtocol> alertView;

/**
 * 是否是空的action
 * 以上5个属性都为nil时即为空的action
 * 空action在plain样式以外，点击将没有任何反应
 */
@property (nonatomic, assign, readonly) BOOL isEmpty;

/** 样式 */
@property (nonatomic, assign, readonly) JKAlertActionStyle alertActionStyle;

/** actionSheet样式cell高度 */
@property (nonatomic, assign, readonly) CGFloat rowHeight;

/** 是否隐藏分隔线 */
@property (nonatomic, assign) BOOL separatorLineHidden;

/** titleColor 默认nil */
@property (nonatomic, strong) UIColor *titleColor;

/** 设置titleColor 默认nil */
@property (nonatomic, copy, readonly) JKAlertAction *(^setTitleColor)(UIColor *color);

/** titleFont 默认nil  */
@property (nonatomic, strong) UIFont *titleFont;

/** 设置titleFont 默认nil */
@property (nonatomic, copy, readonly) JKAlertAction *(^setTitleFont)(UIFont *font);

/** 执行操作后是否自动消失 */
@property (nonatomic, assign, getter=isAutoDismiss) BOOL autoDismiss;

/** 设置执行操作后是否自动消失 */
@property (nonatomic, copy, readonly) JKAlertAction *(^setAutoDismiss)(BOOL autoDismiss);

/**
 * 自定义的view
 * 注意要自己计算好frame
 * action.customView将会自动适应宽度，所以frame给出高度即可
 * actionSheet样式的行高rowHeight将取决于action.customView的高度
 * 自定义时请将action.customView视为一个容器view
 * 推荐使用自动布局在action.customView约束子控件
 */
@property (nonatomic, strong) UIView *customView;

/**
 * 设置自定义的view
 * 注意要自己计算好frame
 * action.customView将会自动适应宽度，所以frame给出高度即可
 * actionSheet样式的行高rowHeight将取决于action.customView的高度
 * 自定义时请将action.customView视为一个容器view
 * 推荐使用自动布局在action.customView约束子控件
 * 若自定义的view挡住了原有action交互，推荐使用action.alertView.dismiss();来移除当前的JKAlertView
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^setCustomView)(UIView *(^customView)(JKAlertAction *action));

/** 设置imageContentMode 默认UIViewContentModeScaleAspectFill */
@property (nonatomic, copy, readonly) JKAlertAction *(^setImageContentMode)(UIViewContentMode contentMode);

/** 设置普通状态图片 */
@property (nonatomic, copy, readonly) JKAlertAction *(^setNormalImage)(UIImage *image);

/** 设置高亮状态图片 */
@property (nonatomic, copy, readonly) JKAlertAction *(^setHightlightedImage)(UIImage *image);

/** 设置是否隐藏分隔线 */
@property (nonatomic, copy, readonly) JKAlertAction *(^setSeparatorLineHidden)(BOOL hidden);

/**
 * 实例化action
 * title: 标题
 * style: 样式
 * handler: 点击的操作
 */
+ (instancetype)actionWithTitle:(NSString *)title style:(JKAlertActionStyle)style handler:(void(^)(JKAlertAction *action))handler;

/**
 * 链式实例化action
 * title: 标题
 * style: 样式
 * handler: 点击的操作
 */
@property (class, nonatomic, readonly) JKAlertAction *(^action)(NSString *title, JKAlertActionStyle style, void(^handler)(JKAlertAction *action));

/**
 * 实例化action
 * attributedTitle: 富文本标题
 * style: 样式
 * handler: 点击的操作
 */
+ (instancetype)actionWithAttributedTitle:(NSAttributedString *)attributedTitle handler:(void(^)(JKAlertAction *action))handler;

/**
 * 链式实例化action
 * attributedTitle: 富文本标题
 * style: 样式
 * handler: 点击的操作
 */
@property (class, nonatomic, readonly) JKAlertAction *(^actionAttributed)(NSAttributedString *attributedTitle, void(^handler)(JKAlertAction *action));
@end
