//
//  JKAlertBaseSheetContentView.h
//  JKAlertX
//
//  Created by albert on 2020/6/29.
//

#import "JKAlertBaseAlertContentView.h"

@class JKAlertPanGestureRecognizer;

@interface JKAlertBaseSheetContentView : JKAlertBaseAlertContentView
{
    CGFloat lastContainerY;
    CGFloat currentContainerY;
    
    CGFloat lastContainerX;
    CGFloat currentContainerX;
    
    JKAlertScrollDirection beginScrollDirection;
    JKAlertScrollDirection endScrollDirection;
    
    BOOL disableScrollToDismiss;
    
    BOOL isDragging;
    
    //CGFloat lastTableViewOffsetY;
    
    BOOL isSheetDismissHorizontal;
}
/** verticalDismissPanGesture */
@property (nonatomic, strong) JKAlertPanGestureRecognizer *verticalDismissPanGesture;

/** horizontalDismissPanGesture */
@property (nonatomic, strong) JKAlertPanGestureRecognizer *horizontalDismissPanGesture;

/** autoAdjustHomeIndicator */
@property (nonatomic, assign) BOOL autoAdjustHomeIndicator;

/** fillHomeIndicator */
@property (nonatomic, assign) BOOL fillHomeIndicator;

/**
 * 展示时是否进行缩放动画 Y轴缩放
 * 默认NO
 */
@property (nonatomic, assign) BOOL showScaleAnimated;

/** topGestureIndicatorView */
@property (nonatomic, weak) UIView *topGestureIndicatorView;

/** topGestureLineView */
@property (nonatomic, weak) UIView *topGestureLineView;

/** verticalGestureDismissEnabled */
@property (nonatomic, assign) BOOL verticalGestureDismissEnabled;

/** horizontalGestureDismissEnabled */
@property (nonatomic, assign) BOOL horizontalGestureDismissEnabled;

/** gestureIndicatorHidden */
@property (nonatomic, assign) BOOL gestureIndicatorHidden;

/** tapBlankDismiss */
@property (nonatomic, assign) BOOL tapBlankDismiss;

/** correctFrame */
@property (nonatomic, assign) CGRect correctFrame;

/** horizontalDismissHandler */
@property (nonatomic, copy) void (^horizontalDismissHandler)(void);

- (void)verticalPanGestureAction:(UIPanGestureRecognizer *)panGesture;

- (void)horizontalPanGestureAction:(UIPanGestureRecognizer *)panGesture;

- (void)checkVerticalSlideDirection;

- (void)checkHorizontalSlideDirection;

- (void)checkVerticalSlideShouldDismiss;

- (void)checkHorizontalSlideShouldDismiss;
@end
