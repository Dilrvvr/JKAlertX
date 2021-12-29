//
//  JKAlertAction.h
//  TestVideoAndPicture
//
//  Created by albert on 2017/4/18.
//  Copyright © 2017年 Albert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKAlertUtility.h"
#import "JKAlertThemeProvider.h"

@class JKAlertView;

@interface JKAlertAction : NSObject

/**
 * 实例化action
 * title: 标题
 * style: 样式
 * handler: 点击的操作
 */
+ (instancetype)actionWithTitle:(NSString *)title
                          style:(JKAlertActionStyle)style
                        handler:(void (^)(JKAlertAction *action))handler;

/**
 * 实例化action
 * attributedTitle: 富文本标题
 * handler: 点击的操作
 */
+ (instancetype)actionWithAttributedTitle:(NSAttributedString *)attributedTitle
                                  handler:(void (^)(JKAlertAction *action))handler;

/**
 * 链式实例化action
 * title: 标题
 * style: 样式
 * handler: 点击的操作
 */
@property (class, nonatomic, readonly) JKAlertAction *(^action)(NSString *title, JKAlertActionStyle style, void (^handler)(JKAlertAction *action));

/**
 * 链式实例化action
 * attributedTitle: 富文本标题
 * handler: 点击的操作
 */
@property (class, nonatomic, readonly) JKAlertAction *(^actionAttributed)(NSAttributedString *attributedTitle, void (^handler)(JKAlertAction *action));






/**
 * 可以在这个block内自定义其它属性
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^makeCustomizePropertyHandler)(void (^handler)(JKAlertAction *innerAction));

/**
 * sheet样式cell行高
 * 默认4寸屏46，以上53
 * customView有值则取customView的bounds高度
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^makeRowHeight)(CGFloat rowHeight);

/**
 * 执行操作后是否自动消失
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^makeAutoDismiss)(BOOL autoDismiss);

/**
 * 修改title
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^remakeTitle)(NSString *title);

/**
 * 修改attributedTitle
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^remakeAttributedTitle)(NSAttributedString *attributedTitle);

/**
 * 修改style
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^remakeActionStyle)(JKAlertActionStyle style);

/**
 * 字体颜色
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^makeTitleColor)(UIColor *color);

/**
 * 字体
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^makeTitleFont)(UIFont *font);

/**
 * 背景颜色
 * 仅 actionSheet 与 collectionSheet的底部按钮 有效
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^makeBackgroundColor)(UIColor *backgroundColor);

/**
 * 高亮背景颜色
 * 仅 actionSheet 与 collectionSheet的底部按钮 有效
 * */
@property (nonatomic, copy, readonly) JKAlertAction *(^makeSeletedBackgroundColor)(UIColor *seletedBackgroundColor);

/**
 * 普通状态图片
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^makeNormalImage)(UIImage *image);

/**
 * 高亮状态图片
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^makeHightlightedImage)(UIImage *image);

/**
 * 图片的ContentMode
 * 默认UIViewContentModeScaleAspectFill
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^makeImageContentMode)(UIViewContentMode contentMode);

/**
 * 是否隐藏分隔线
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^makeSeparatorLineHidden)(BOOL hidden);

/**
 * 分隔线颜色 默认nil 自动设置深/浅色
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^makeSeparatorLineColor)(UIColor *color);

/**
 * 分隔线内间距 目前仅取左右 默认zero
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^makeSeparatorLineInset)(UIEdgeInsets inset);

/**
 * 自定义view
 * 注意要自己计算好frame
 * action.customView将会自动适应宽度，所以frame给出高度即可
 * actionSheet样式的行高rowHeight将取决于action.customView的高度
 * 自定义时请将action.customView视为一个容器view
 * 推荐使用自动布局在action.customView约束子控件
 * 若自定义的view挡住了原有action交互，推荐使用action.alertView.dismiss();来移除当前的JKAlertView
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^makeCustomView)(UIView *(^handler)(JKAlertAction *innerAction));

/**
 * action更新后刷新页面
 * 更改以上数据后可调用该block刷新对应UI
 */
@property (nonatomic, copy) void (^refreshAppearanceHandler)(JKAlertAction *refreshAction);


























/** title */
@property (nonatomic, copy, readonly) NSString *title;

/** attributedTitle */
@property (nonatomic, strong, readonly) NSAttributedString *attributedTitle;

/** 样式 */
@property (nonatomic, assign, readonly) JKAlertActionStyle actionStyle;

/** handler */
@property (nonatomic, copy, readonly) void (^handler)(JKAlertAction *action);

/**
 * backgroundColor 默认JKAlertGlobalBackgroundColor()
 * 仅 actionSheet 与 collectionSheet的底部按钮 有效
 * */
@property (nonatomic, strong, readonly) UIColor *backgroundColor;

/** titleColor 默认 RGB 51 */
@property (nonatomic, strong, readonly) UIColor *titleColor;

/**
 * seletedBackgroundColor
 * 仅 actionSheet 与 collectionSheet的底部按钮 有效
 * */
@property (nonatomic, strong, readonly) UIColor *seletedBackgroundColor;

/** actionSheet样式cell高度 */
@property (nonatomic, assign, readonly) CGFloat rowHeight;

/**
 * 是否是空的action
 * title attributedTitle handler 都为空的时候返回YES
 * 空action在plain样式以外，点击将没有任何反应
 */
@property (nonatomic, assign, readonly) BOOL isEmpty;




/** aciton所处的alertView 仅用于dismiss */
@property (nonatomic, weak) JKAlertView *alertView;

/** titleFont 默认[UIFont systemFontOfSize:17]  */
@property (nonatomic, strong) UIFont *titleFont;




/** 图片尺寸 默认 */
//@property (nonatomic, assign) CGSize imageSize;

/** imageContentMode */
@property (nonatomic, assign) UIViewContentMode imageContentMode;

/** normalImage */
@property (nonatomic, strong) UIImage *normalImage;

/** hightlightedImage */
@property (nonatomic, strong) UIImage *hightlightedImage;

/** 是否隐藏分隔线 */
@property (nonatomic, assign) BOOL separatorLineHidden;

/// 分隔线颜色 默认nil 自动设置深/浅色
@property (nonatomic, strong) UIColor *separatorLineColor;

/** 分隔线内间距 目前仅取左右 默认zero */
@property (nonatomic, assign) UIEdgeInsets separatorLineInset;

/** 执行操作后是否自动消失 */
@property (nonatomic, assign, getter=isAutoDismiss) BOOL autoDismiss;

/**
 * 自定义的view
 * 注意要自己计算好frame
 * action.customView将会自动适应宽度，所以frame给出高度即可
 * actionSheet样式的行高rowHeight将取决于action.customView的高度
 * 自定义时请将action.customView视为一个容器view
 * 推荐使用自动布局在action.customView约束子控件
 */
@property (nonatomic, strong) UIView *customView;



#pragma mark
#pragma mark - Deprecated

/** 可以在这个block内自定义其它属性 */
@property (nonatomic, copy, readonly) JKAlertAction *(^setCustomizePropertyHandler)(void (^customizePropertyHandler)(JKAlertAction *customizePropertyAction)) JKAlertXDeprecated("use makeCustomizePropertyHandler");

/** 设置执行操作后是否自动消失 */
@property (nonatomic, copy, readonly) JKAlertAction *(^setAutoDismiss)(BOOL autoDismiss) JKAlertXDeprecated("use makeAutoDismiss");

/** 重新设置title */
@property (nonatomic, copy, readonly) JKAlertAction *(^resetTitle)(NSString *title) JKAlertXDeprecated("use remakeTitle");

/** 重新设置attributedTitle */
@property (nonatomic, copy, readonly) JKAlertAction *(^resetAttributedTitle)(NSAttributedString *attributedTitle) JKAlertXDeprecated("use remakeAttributedTitle");

/** 设置titleColor */
@property (nonatomic, copy, readonly) JKAlertAction *(^setTitleColor)(UIColor *color) JKAlertXDeprecated("use makeTitleColor");

/** 设置titleFont */
@property (nonatomic, copy, readonly) JKAlertAction *(^setTitleFont)(UIFont *font) JKAlertXDeprecated("use makeTitleFont");

/**
 * 设置backgroundColor
 * 仅 actionSheet 与 collectionSheet的底部按钮 有效
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^setBackgroundColor)(UIColor *backgroundColor) JKAlertXDeprecated("use makeBackgroundColor");

/**
 * 设置seletedBackgroundColor
 * 仅 actionSheet 与 collectionSheet的底部按钮 有效
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^setSeletedBackgroundColor)(UIColor *seletedBackgroundColor) JKAlertXDeprecated("use makeSeletedBackgroundColor");

/** 设置普通状态图片 */
@property (nonatomic, copy, readonly) JKAlertAction *(^setNormalImage)(UIImage *image) JKAlertXDeprecated("use makeNormalImage");

/** 设置高亮状态图片 */
@property (nonatomic, copy, readonly) JKAlertAction *(^setHightlightedImage)(UIImage *image) JKAlertXDeprecated("use makeHightlightedImage");

/** 设置imageContentMode 默认UIViewContentModeScaleAspectFill */
@property (nonatomic, copy, readonly) JKAlertAction *(^setImageContentMode)(UIViewContentMode contentMode) JKAlertXDeprecated("use makeImageContentMode");

/** 设置是否隐藏分隔线 */
@property (nonatomic, copy, readonly) JKAlertAction *(^setSeparatorLineHidden)(BOOL hidden) JKAlertXDeprecated("use makeSeparatorLineHidden");

/**
 * 设置自定义的view
 * 注意要自己计算好frame
 * action.customView将会自动适应宽度，所以frame给出高度即可
 * actionSheet样式的行高rowHeight将取决于action.customView的高度
 * 自定义时请将action.customView视为一个容器view
 * 推荐使用自动布局在action.customView约束子控件
 * 若自定义的view挡住了原有action交互，推荐使用action.alertView.dismiss();来移除当前的JKAlertView
 */
@property (nonatomic, copy, readonly) JKAlertAction *(^setCustomView)(UIView *(^customView)(JKAlertAction *action)) JKAlertXDeprecated("use makeCustomView");
@end
