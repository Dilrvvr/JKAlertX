//
//  JKAlertBaseAlertContentView.h
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseView.h"
#import "JKAlertScrollContentView.h"

@class JKAlertBaseAlertContentView, JKAlertAction;



@protocol JKAlertBaseAlertContentViewDelegate <NSObject>

@required

/// 执行action的handler操作
- (void)alertContentView:(JKAlertBaseAlertContentView *)alertContentView executeHandlerOfAction:(JKAlertAction *)action;

/// 执行dismiss操作
- (void)alertContentViewExecuteGestureDismiss:(JKAlertBaseAlertContentView *)alertContentView dismissType:(JKAlertSheetDismissAnimationType)dismissType;
@end



@interface JKAlertBaseAlertContentView : JKAlertBaseView <UIScrollViewDelegate>

/** delegate */
@property (nonatomic, weak) id <JKAlertBaseAlertContentViewDelegate> delegate;

/** 圆角 默认10 */
@property (nonatomic, assign) CGFloat cornerRadius;

/** screenSafeInsets */
@property (nonatomic, assign) UIEdgeInsets screenSafeInsets;

/** maxHeight */
@property (nonatomic, assign) CGFloat maxHeight;

/** alertWidth */
@property (nonatomic, assign) CGFloat alertWidth;

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

/** 默认的取消action，不需要自带的可以自己设置，不可置为nil */
@property (nonatomic, strong) JKAlertAction *cancelAction;

- (void)calculateUI NS_REQUIRES_SUPER;

- (void)restoreAlertBackgroundColor;
@end
