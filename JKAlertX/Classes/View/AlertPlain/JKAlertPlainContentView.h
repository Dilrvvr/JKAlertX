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

/** textFieldArray */
@property (nonatomic, strong, readonly) NSMutableArray *textFieldArray;

/** textFieldContainerView */
@property (nonatomic, weak, readonly) UIView *textFieldContainerView;

/** textFieldContainerInset 默认(0, 20, 20, 20) */
@property (nonatomic, assign) UIEdgeInsets textFieldContainerInset;

/** textFieldContainerCornerRadius 默认8 */  // TODO: - JKTODO textFieldContainerCornerRadius
@property (nonatomic, assign) CGFloat textFieldContainerCornerRadius;

/** textFieldHeight 默认30 */
@property (nonatomic, assign) CGFloat textFieldHeight;

/** 是否自动弹出键盘 默认YES */
@property (nonatomic, assign) BOOL autoShowKeyboard;
@end
