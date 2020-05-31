//
//  JKAlertBaseAlertContentView.h
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseView.h"

@class JKAlertView;

@interface JKAlertBaseAlertContentView : JKAlertBaseView

/** alertView */
@property (nonatomic, weak) JKAlertView *alertView;

/** safeInsets */
@property (nonatomic, assign) UIEdgeInsets safeInsets;

/** maxHeight */
@property (nonatomic, assign) CGFloat maxHeight;

/** contentWidth */
@property (nonatomic, assign) CGFloat contentWidth;

/** actionArray */
@property (nonatomic, strong) NSMutableArray *actionArray;

/** textScrollView */
@property (nonatomic, weak) UIScrollView *textScrollView;

/** actionScrollView */
@property (nonatomic, weak) UIScrollView *actionScrollView;

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

/** lightBlurEffect */
@property (nonatomic, strong) UIBlurEffect *lightBlurEffect;

/** darkBlurEffect */
@property (nonatomic, strong) UIBlurEffect *darkBlurEffect;

- (void)calculateUI;
@end
