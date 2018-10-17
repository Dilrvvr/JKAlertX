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
@end
