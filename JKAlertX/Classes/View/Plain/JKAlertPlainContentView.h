//
//  JKAlertPlainContentView.h
//  JKAlertX
//
//  Created by albert on 2020/5/29.
//

#import "JKAlertBaseAlertContentView.h"
#import "JKAlertPlainTextContentView.h"

@interface JKAlertPlainContentView : JKAlertBaseAlertContentView

/** textContentView */
@property (nonatomic, weak, readonly) JKAlertPlainTextContentView *textContentView;

/** separatorLineWH */
@property (nonatomic, assign) CGFloat separatorLineWH;

/** 圆角 默认8 */
@property (nonatomic, assign) CGFloat cornerRadius;
@end
