//
//  JKAlertBaseAlertContentView.h
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseView.h"

@interface JKAlertBaseAlertContentView : JKAlertBaseView

/** customBackgroundView */
@property (nonatomic, weak) UIView *customBackgroundView;

/** 标题 */
@property (nonatomic, copy) NSString *alertTitle;

/** 富文本标题 */
@property (nonatomic, copy) NSAttributedString *alertAttributedTitle;

/** 提示信息 */
@property (nonatomic, copy) NSString *alertMessage;

/** 富文本提示信息 */
@property (nonatomic, copy) NSAttributedString *attributedMessage;
@end
