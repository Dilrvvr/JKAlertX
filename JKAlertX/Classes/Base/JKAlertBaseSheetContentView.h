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
}

/** verticalDismissPanGesture */
@property (nonatomic, strong) JKAlertPanGestureRecognizer *verticalDismissPanGesture;

/** horizontalDismissPanGesture */
@property (nonatomic, strong) JKAlertPanGestureRecognizer *horizontalDismissPanGesture;

/** autoAdjustHomeIndicator */
@property (nonatomic, assign) BOOL autoAdjustHomeIndicator;

/** fillHomeIndicator */
@property (nonatomic, assign) BOOL fillHomeIndicator;

/// autoHideLastActionSeparatorLine
@property (nonatomic, assign) BOOL autoHideLastActionSeparatorLine;

/** bottomButtonPinned */
@property (nonatomic, assign) BOOL bottomButtonPinned;

/// separatorLineAlwaysHidden
@property (nonatomic, assign) BOOL separatorLineAlwaysHidden;

/** isPierced */
@property (nonatomic, assign) BOOL isPierced;

/** 镂空效果间距 只取左右下 */
@property (nonatomic, assign) UIEdgeInsets piercedInsets;

/** cancelMargin */
@property (nonatomic, assign) CGFloat cancelMargin;

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
@property (nonatomic, assign, readonly) BOOL horizontalGestureDismissEnabled;

/** horizontalGestureDismissDirection */
@property (nonatomic, assign) JKAlertSheetHorizontalGestureDismissDirection horizontalGestureDismissDirection;

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
