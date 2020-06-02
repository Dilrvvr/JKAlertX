//
//  JKAlertView+Plain.h
//  JKAlertX
//
//  Created by albertcc on 2020/5/31.
//

#import "JKAlertView.h"

@interface JKAlertView (Plain)

/**
 * plain样式宽度
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makePlainWidth)(CGFloat width);

/**
 * 是否自动缩小plain样式的宽度以适应屏幕宽度 默认NO
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makePlainAutoReduceWidth)(BOOL autoReduceWidth);

/**
 * plain样式的圆角
 * 默认8
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makePlainCornerRadius)(CGFloat cornerRadius);

/**
 * 是否自动弹出键盘 默认YES
 * 添加了textField时会自动弹出键盘
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makePlainAutoShowKeyboard)(BOOL autoShowKeyboard);

/**
 * 是否自动适配键盘
 * 默认YES
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makePlainAutoAdaptKeyboard)(BOOL autoAdaptKeyboard);

/**
 * 弹框底部与键盘间距
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makePlainKeyboardMargin)(CGFloat margin);
@end
