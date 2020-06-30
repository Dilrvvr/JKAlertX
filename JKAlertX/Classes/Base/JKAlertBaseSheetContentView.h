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
    
    BOOL isBeginDragging;
    BOOL isDragging;
    
    //CGFloat lastTableViewOffsetY;
    
    BOOL isSheetDismissHorizontal;
}
/** verticalDismissPanGesture */
@property (nonatomic, strong) JKAlertPanGestureRecognizer *verticalDismissPanGesture;

/** horizontalDismissPanGesture */
@property (nonatomic, strong) JKAlertPanGestureRecognizer *horizontalDismissPanGesture;

/** topGestureIndicatorView */
@property (nonatomic, weak) UIView *topGestureIndicatorView;

/** topGestureLineView */
@property (nonatomic, weak) UIView *topGestureLineView;

/** enableVerticalGestureDismiss */
@property (nonatomic, assign) BOOL enableVerticalGestureDismiss;

/** enableHorizontalGestureDismiss */
@property (nonatomic, assign) BOOL enableHorizontalGestureDismiss;

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
