//
//  JKAlertBaseCustomizer.h
//  JKAlertX
//
//  Created by albert on 2018/10/17.
//  Copyright © 2018 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JKAlertView;

@interface JKAlertBaseCustomizer : NSObject

/** alertView */
@property (nonatomic, weak, readonly) JKAlertView *alertView;

/** 设置alerView */
@property (nonatomic, copy, readonly) void (^setAlertView)(JKAlertView *alertView);

/** 是否允许dealloc打印，用于检查循环引用 */
@property (nonatomic, assign, readonly) BOOL deallocLogEnabled;

/** 设置是否允许dealloc打印，用于检查循环引用 */
@property (nonatomic, copy, readonly) JKAlertBaseCustomizer *(^setDeallocLogEnabled)(BOOL enabled);
@end
