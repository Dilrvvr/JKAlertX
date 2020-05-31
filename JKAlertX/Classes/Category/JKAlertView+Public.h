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

/** customSuperView */
@property (nonatomic, weak) UIView *customSuperView;

/** tapBlankDismiss */
@property (nonatomic, assign) BOOL tapBlankDismiss;

/** 监听点击空白处的block */
@property (nonatomic, copy) void (^tapBlankHandler)(JKAlertView *innerView);

/** 配置弹出视图的容器view */
@property (nonatomic, copy) void (^alertContentViewConfiguration)(UIView *alertContentView);




/** 是否横屏 */
@property (nonatomic, assign) BOOL isLandScape;


// TODO: JKTODO <#注释#>

/** hierarchyFlag */
@property (nonatomic, assign) BOOL hierarchyFlag;
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
@end
