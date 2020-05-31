//
//  JKAlertHUDContentView.h
//  JKAlertX
//
//  Created by albertcc on 2020/5/31.
//

#import "JKAlertBaseAlertContentView.h"
#import "JKAlertHUDTextContentView.h"

@interface JKAlertHUDContentView : JKAlertBaseAlertContentView

/** textContentView */
@property (nonatomic, weak, readonly) JKAlertHUDTextContentView *textContentView;

/** 圆角 默认8 */
@property (nonatomic, assign) CGFloat cornerRadius;
@end
