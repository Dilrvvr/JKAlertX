//
//  JKAlertCommonCustomizer.h
//  JKAlertX
//
//  Created by albert on 2020/4/18.
//  Copyright © 2020 安永博. All rights reserved.
//

#import "JKAlertBaseCustomizer.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKAlertCommonCustomizer : JKAlertBaseCustomizer

/** 设置是否允许手势退出 默认NO NO 仅限sheet样式 */
@property (nonatomic, copy, readonly) JKAlertView *(^setEnableGestureDismiss)(BOOL enableVerticalGesture, BOOL enableHorizontalGesture, BOOL showGestureIndicator);
@end

NS_ASSUME_NONNULL_END
