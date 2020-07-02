//
//  JKAlertView+PrivateProperty.h
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertView.h"
#import "JKAlertPanGestureRecognizer.h"
#import "JKAlertActionButton.h"
#import "JKAlertTextView.h"
#import "JKAlertBaseTextContentView.h"
#import "JKAlertPlainContentView.h"
#import "JKAlertHUDContentView.h"
#import "JKAlerActionSheetContentView.h"
#import "JKAlertCollectionSheetContentView.h"

@interface JKAlertView () <UIGestureRecognizerDelegate>



{
    CGFloat textContainerViewCurrentMaxH_;
    
    CGFloat JKAlertSheetMaxH;
    
    /** 分隔线宽度或高度 */
    CGFloat JKAlertSeparatorLineWH;
    
    CGFloat PlainViewWidth;
    CGFloat OriginalPlainWidth;
    
    UIView  *_alertBackGroundView;
    
    
    BOOL ObserverAdded;
    
    BOOL SheetMaxHeightSetted;
    
    CGFloat GestureIndicatorHeight;
    
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
}

/** 样式 */
@property (nonatomic, assign) JKAlertStyle alertStyle;

/** plainContentView */
@property (nonatomic, weak) JKAlertPlainContentView *plainContentView;

/** hudContentView */
@property (nonatomic, weak) JKAlertHUDContentView *hudContentView;

/** actionsheetContentView */
@property (nonatomic, weak) JKAlerActionSheetContentView *actionsheetContentView;

/** actionsheetContentView */
@property (nonatomic, weak) JKAlertCollectionSheetContentView *collectionsheetContentView;

/** alertContentView */
@property (nonatomic, weak, readonly) UIView *alertContentView;

/** currentAlertContentView */
@property (nonatomic, weak, readonly) JKAlertBaseAlertContentView *currentAlertContentView;

/** currentAlertContentView */
@property (nonatomic, weak, readonly) JKAlertBaseTextContentView *currentTextContentView;

/** deallocLogEnabled */
@property (nonatomic, assign) BOOL deallocLogEnabled;


/** isSheetDismissHorizontal */
@property (nonatomic, assign) BOOL isSheetDismissHorizontal;



/** observerSuperView */
@property (nonatomic, weak) UIView *observerSuperView;

/** actions */
@property (nonatomic, strong) NSMutableArray *actions;

/** actions2 */
@property (nonatomic, strong) NSMutableArray *actions2;

/** closeButton */
@property (nonatomic, weak) UIButton *closeButton;

/** 监听点击空白处的block */
@property (nonatomic, copy) void (^blankClickBlock)(void);

/** customHUD */
@property (nonatomic, weak) UIView *customHUD;

/** 即将显示动画的回调 */
@property (nonatomic, copy) void (^willShowHandler)(JKAlertView *view);

/** 显示动画完成的回调 */
@property (nonatomic, copy) void (^didShowHandler)(JKAlertView *view);

/** 即将消失的回调 */
@property (nonatomic, copy) void (^willDismissHandler)(void);

/** 消失后的回调 */
@property (nonatomic, copy) void (^didDismissHandler)(void);

#pragma mark
#pragma mark - textField

/** 当前的textField */
@property (nonatomic, weak) UITextField *currentTextField;

/** textField数组 */
@property (nonatomic, strong) NSMutableArray *textFieldArr;

/**
 * 设置plain样式Y值
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainY)(CGFloat Y, BOOL animated);

/** 监听屏幕旋转 */
@property (nonatomic, copy) void (^orientationDidChangeHandler)(JKAlertView *view, UIInterfaceOrientation orientation);

/** 自定义展示动画 */
@property (nonatomic, copy) void (^customShowAnimationBlock)(JKAlertView *view, UIView *animationView);

/** 自定义消失动画 */
@property (nonatomic, copy) void (^customDismissAnimationBlock)(JKAlertView *view, UIView *animationView);

/** 监听重新布局完成 */
@property (nonatomic, copy) void (^relayoutComplete)(JKAlertView *view);

#pragma mark
#pragma mark - 外界可自定义属性 移至内部 外界全部改为使用链式语法修改 2018-09-28

/** dealloc时会调用的block */
@property (nonatomic, copy) void (^deallocHandler)(void);

/** 监听superView尺寸改变时将要自适应的block */
@property (nonatomic, copy) void (^willRelayoutHandler)(JKAlertView *view, UIView *containerView);

/** 监听superView尺寸改变时自适应完成的block */
@property (nonatomic, copy) void (^didRelayoutHandler)(JKAlertView *view, UIView *containerView);

/** 是否自动缩小plain样式的宽度以适应屏幕宽度 默认NO */
@property (nonatomic, assign) BOOL autoReducePlainWidth;

/**
 * plain和HUD样式centerY的偏移
 * 正数表示向下/右偏移，负数表示向上/左偏移
 */
@property (nonatomic, assign) CGPoint plainCenterOffset;

/**
 * 是否使JKAlertView.dismissAll(); 对当前JKAlertView无效
 * 请谨慎使用，若设置为YES 调用JKAlertView.dismissAll(); 将对当前JKAlertView无效
 */
@property (nonatomic, assign) BOOL isDismissAllNoneffective;

/** 用于通知消失的key */
@property (nonatomic, copy) NSString *dismissKey;

/** 用于通知消失的类别的key */
@property (nonatomic, copy) NSString *dismissCategory;

/** verticalSlideDismissEnabled */
@property (nonatomic, assign) BOOL enableVerticalGestureDismiss;

/** horizontalSlideDismissEnabled */
@property (nonatomic, assign) BOOL enableHorizontalGestureDismiss;

/** showGestureIndicator */
@property (nonatomic, assign) BOOL showGestureIndicator;

/** topGestureIndicatorView */
@property (nonatomic, weak) UIView *topGestureIndicatorView;

/** topGestureLineView */
@property (nonatomic, weak) UIView *topGestureLineView;

/** 是否自动适配键盘 */
@property (nonatomic, assign) BOOL autoAdaptKeyboard;

/** plain样式弹出键盘时与键盘的间距 竖屏 */
@property (nonatomic, assign) CGFloat plainKeyboardMargin;

/** show的时候是否振动 默认NO */
@property (nonatomic, assign) BOOL vibrateEnabled;

- (void)addKeyboardWillChangeFrameNotification;

- (void)removeKeyboardWillChangeFrameNotification;

- (void)calculateUI;

- (void)setAlertViewToAction:(JKAlertAction *)action;
@end





@interface JKAlertView (PrivateProperty)

- (void)updateWidthHeight;

- (void)updateMaxHeight;

/// 不是plain样式将不执行handler
- (JKAlertView *)checkPlainStyleHandler:(void(^)(void))handler;

/// 不是HUD样式将不执行handler
- (JKAlertView *)checkHudStyleHandler:(void(^)(void))handler;

/// 不是collectionSheet样式将不执行handler
- (JKAlertView *)checkCollectionSheetStyleHandler:(void(^)(void))handler;

/// 不是actionSheet样式将不执行handler
- (JKAlertView *)checkActionSheetStyleHandler:(void(^)(void))handler;

/// 检查样式判断是否执行handler
- (JKAlertView *)checkAlertStyle:(JKAlertStyle)alertStyle
                         handler:(void(^)(void))handler;
@end
