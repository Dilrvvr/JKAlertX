//
//  JKAlertCustomizerCommon.h
//  JKAlertX
//
//  Created by albert on 2018/10/17.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "JKAlertBaseCustomizer.h"

@interface JKAlertCustomizerCommon : JKAlertBaseCustomizer

/** customSuperView */
@property (nonatomic, weak, readonly) UIView *customSuperView;

/**
 * 设置自定义的父控件
 * 默认添加到keywindow上
 * customSuperView在show之前有效
 * customSuperViewsize最好和屏幕大小一致，否则可能出现问题
 */
@property (nonatomic, copy, readonly) JKAlertCustomizerCommon *(^setCustomSuperView)(UIView *customSuperView);




/**
 * 背景view
 * 默认是一个UIToolbar
 */
@property (nonatomic, strong, readonly) UIView *backgroundView;

/**
 * 设置背景view
 * 默认是一个UIToolbar
 */
@property (nonatomic, copy, readonly) JKAlertCustomizerCommon *(^setBackgroundView)(UIView *(^backgroundViewBlock)(void));




/** 全屏的背景view */
@property (nonatomic, strong, readonly) UIView *fullScreenBackgroundView;

/**
 * 设置全屏背景view 默认nil
 */
@property (nonatomic, copy, readonly) JKAlertCustomizerCommon *(^setFullScreenBackgroundView)(UIView *(^backgroundViewBlock)(void));




/** title和message是否可以响应事件，默认YES 如无必要不建议设置为NO */
@property (nonatomic, assign, readonly) BOOL textViewUserInteractionEnabled;

/** 设置title和message是否可以响应事件，默认YES 如无必要不建议设置为NO */
@property (nonatomic, copy, readonly) JKAlertCustomizerCommon *(^setTextViewUserInteractionEnabled)(BOOL userInteractionEnabled);




/** title和message是否可以选择文字，默认NO */
@property (nonatomic, assign, readonly) BOOL textViewCanSelectText;

/** 设置title和message是否可以选择文字，默认NO */
@property (nonatomic, copy, readonly) JKAlertCustomizerCommon *(^setTextViewCanSelectText)(BOOL canSelectText);



/** title文字颜色 */
@property (nonatomic, strong, readonly) UIColor *titleTextColor;

/**
 * 设置title文字颜色
 * plain默认RGB都为0.1，其它0.35
 */
@property (nonatomic, copy, readonly) JKAlertCustomizerCommon *(^setTitleTextColor)(UIColor *textColor);




/** title文字 字体 */
@property (nonatomic, strong, readonly) UIFont *titleFont;

/**
 * 设置title文字 字体
 * plain默认 bold 17，其它17
 */
@property (nonatomic, copy, readonly) JKAlertCustomizerCommon *(^setTitleTextFont)(UIFont *font);




/** message文字颜色 */
@property (nonatomic, strong, readonly) UIColor *messageTextColor;

/**
 * 设置message文字颜色
 * plain默认RGB都为0.55，其它0.3
 */
@property (nonatomic, copy, readonly) JKAlertCustomizerCommon *(^setMessageTextColor)(UIColor *textColor);




/** message文字 字体 */
@property (nonatomic, strong, readonly) UIFont *messageFont;

/**
 * 设置message文字 字体
 * plain默认14，其它13
 * action样式在没有title的时候，自动改为15，设置该值后将始终为该值，不自动修改
 */
@property (nonatomic, copy, readonly) JKAlertCustomizerCommon *(^setMessageTextFont)(UIFont *font);




/** titleTextViewDelegate */
@property (nonatomic, weak, readonly) id<UITextViewDelegate> titleTextViewDelegate;

/** 设置titleTextViewDelegate */
@property (nonatomic, copy, readonly) JKAlertCustomizerCommon *(^setTitleTextViewDelegate)(id<UITextViewDelegate> delegate);




/** messageTextViewDelegate */
@property (nonatomic, weak, readonly) id<UITextViewDelegate> messageTextViewDelegate;

/** 设置messageTextViewDelegate */
@property (nonatomic, copy, readonly) JKAlertCustomizerCommon *(^setMessageTextViewDelegate)(id<UITextViewDelegate> delegate);




/** titleTextViewAlignment 默认NSTextAlignmentCenter */
@property (nonatomic, assign, readonly) NSTextAlignment titleTextViewAlignment;

/** 设置titleTextView的文字水平样式 默认NSTextAlignmentCenter */
@property (nonatomic, copy, readonly) JKAlertCustomizerCommon *(^setTitleTextViewAlignment)(NSTextAlignment textAlignment);




/** messageTextViewAlignment 默认NSTextAlignmentCenter */
@property (nonatomic, assign, readonly) NSTextAlignment messageTextViewAlignment;

/** 设置messageTextView的文字水平样式 默认NSTextAlignmentCenter */
@property (nonatomic, copy, readonly) JKAlertCustomizerCommon *(^setMessageTextViewAlignment)(NSTextAlignment textAlignment);




/** title和message的左右间距 默认20 */
@property (nonatomic, assign, readonly) CGFloat textViewLeftRightMargin;

/** 设置title和message的左右间距 默认20 */
@property (nonatomic, copy, readonly) JKAlertCustomizerCommon *(^setTextViewLeftRightMargin)(CGFloat margin);







/** 是否允许dealloc打印，用于检查循环引用 */
@property (nonatomic, assign, readonly) BOOL deallocLogEnabled;

/** 设置是否允许dealloc打印，用于检查循环引用 */
@property (nonatomic, copy, readonly) JKAlertBaseCustomizer *(^setDeallocLogEnabled)(BOOL enabled);
@end
