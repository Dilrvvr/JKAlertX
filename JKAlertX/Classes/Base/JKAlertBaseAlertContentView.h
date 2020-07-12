//
//  JKAlertBaseAlertContentView.h
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseView.h"
#import "JKAlertScrollContentView.h"

@class JKAlertView, JKAlertAction;

@interface JKAlertBaseAlertContentView : JKAlertBaseView <UIScrollViewDelegate>

/** alertView */
@property (nonatomic, weak) JKAlertView *alertView;

/** 圆角 默认8 */
@property (nonatomic, assign) CGFloat cornerRadius;

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

/** lightModeBlurEffect */
@property (nonatomic, strong) UIBlurEffect *lightModeBlurEffect;

/** darkModeBlurEffect */
@property (nonatomic, strong) UIBlurEffect *darkModeBlurEffect;

/** 默认的取消action，不需要自带的可以自己设置，不可置为nil */
@property (nonatomic, strong) JKAlertAction *cancelAction;

- (void)calculateUI NS_REQUIRES_SUPER;
@end
