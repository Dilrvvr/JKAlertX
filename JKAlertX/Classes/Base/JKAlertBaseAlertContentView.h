//
//  JKAlertBaseAlertContentView.h
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseView.h"
#import "JKAlertScrollContentView.h"

@class JKAlertView;

@interface JKAlertBaseAlertContentView : JKAlertBaseView

/** alertView */
@property (nonatomic, weak) JKAlertView *alertView;

/** screenSafeInsets */
@property (nonatomic, assign) UIEdgeInsets screenSafeInsets;

/** maxHeight */
@property (nonatomic, assign) CGFloat maxHeight;

/** contentWidth */
@property (nonatomic, assign) CGFloat contentWidth;

/** actionArray */
@property (nonatomic, strong) NSMutableArray *actionArray;

/** topContentView */
@property (nonatomic, weak) JKAlertScrollContentView *topContentView;

/** bottomContentView */
@property (nonatomic, weak) JKAlertScrollContentView *bottomContentView;

/** backgroundEffectView */
@property (nonatomic, weak) UIVisualEffectView *backgroundEffectView;

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

- (void)calculateUI NS_REQUIRES_SUPER;
@end
