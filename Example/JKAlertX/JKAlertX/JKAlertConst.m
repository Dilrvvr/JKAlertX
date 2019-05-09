//
//  JKAlertConst.m
//  JKAlertX
//
//  Created by albert on 2018/10/22.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "JKAlertConst.h"


#pragma mark
#pragma mark - 通知

/** 移除全部的通知 */
NSString * const JKAlertDismissAllNotification = @"JKAlertDismissAllNotification";

/** 根据key来移除的通知 */
NSString * const JKAlertDismissForKeyNotification = @"JKAlertDismissForKeyNotification";


#pragma mark
#pragma mark - 常量

CGFloat    const JKAlertMinTitleLabelH = (22);
CGFloat    const JKAlertMinMessageLabelH = (17);
CGFloat    const JKAlertScrollViewMaxH = 176; // (JKAlertButtonH * 4)

CGFloat    const JKAlertButtonH = 46;
NSInteger  const JKAlertPlainButtonBeginTag = 100;

CGFloat    const JKAlertSheetTitleMargin = 6;
