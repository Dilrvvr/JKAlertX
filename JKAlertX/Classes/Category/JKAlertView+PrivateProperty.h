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

@interface JKAlertView () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>
{
    CGFloat TBMargin;
    CGFloat textContainerViewCurrentMaxH_;
    BOOL    _enableDeallocLog;
    
    CGFloat JKAlertPlainViewMaxH;
    CGFloat JKAlertTitleMessageMargin;
    
    CGFloat JKAlertSheetMaxH;
    
    /** 分隔线宽度或高度 */
    CGFloat JKAlertSeparatorLineWH;
    
    CGRect oldPlainViewFrame;
    
    CGFloat CancelMargin;
    CGFloat PlainViewWidth;
    CGFloat OriginalPlainWidth;
    
    /** 是否自动适配 iPhone X homeIndicator */
    BOOL AutoAdjustHomeIndicator;
    
    BOOL FillHomeIndicator;
    
    BOOL Showed;
    
    UIView  *_backGroundView;
    
    UIColor *titleTextColor;
    UIFont  *titleFont;
    
    UIColor *messageTextColor;
    UIFont  *messageFont;
    
    CGFloat JKAlertScreenW;
    CGFloat JKAlertScreenH;
    
    BOOL ObserverAdded;
    
    BOOL SheetMaxHeightSetted;
    
    CGFloat GestureIndicatorHeight;
    
    CGFloat correctContainerY;
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

/** observerSuperView */
@property (nonatomic, weak) UIView *observerSuperView;

/** customSuperView */
@property (nonatomic, weak) UIView *customSuperView;

/** 全屏的背景view */
@property (nonatomic, weak) UIView *fullScreenBackGroundView;

/** 全屏背景是否透明，默认黑色 0.4 alpha */
@property (nonatomic, assign) BOOL isClearFullScreenBackgroundColor;

/** 配置弹出视图的容器view */
@property (nonatomic, copy) void (^containerViewConfig)(UIView *containerView);

/** sheetContainerView */
@property (nonatomic, weak) UIView *sheetContainerView;

/** sheetContentView */
@property (nonatomic, weak) UIView *sheetContentView;

/** collectionTopContainerView */
@property (nonatomic, weak) UIView *collectionTopContainerView;

/** sheet样式的背景view */
@property (nonatomic, strong) UIView *backGroundView;

/** tableView */
@property (nonatomic, weak) UITableView *tableView;

/** flowlayout */
@property (nonatomic, strong) UICollectionViewFlowLayout *flowlayout;

/** flowlayout2 */
@property (nonatomic, strong) UICollectionViewFlowLayout *flowlayout2;

/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;

/** collectionView2 */
@property (nonatomic, weak) UICollectionView *collectionView2;

/** isClearTextContainerBackground */
@property (nonatomic, assign) BOOL isClearTextContainerBackground;

/** sheet样式添加自定义的titleView */
@property (nonatomic, weak) UIView *customSheetTitleView;

/** pageControl */
@property (nonatomic, weak) UIPageControl *pageControl;

/** cancelButton */
@property (nonatomic, weak) JKAlertActionButton *cancelButton;

/** collectionButton */
@property (nonatomic, weak) JKAlertActionButton *collectionButton;

/** actions */
@property (nonatomic, strong) NSMutableArray *actions;

/** actions2 */
@property (nonatomic, strong) NSMutableArray *actions2;

/** 样式 */
@property (nonatomic, assign) JKAlertStyle alertStyle;

/** 标题 */
@property (nonatomic, copy) NSString *alertTitle;

/** 富文本标题 */
@property (nonatomic, copy) NSAttributedString *alertAttributedTitle;

/** 提示信息 */
@property (nonatomic, copy) NSString *message;

/** 富文本提示信息 */
@property (nonatomic, copy) NSAttributedString *attributedMessage;

/** plainView */
@property (nonatomic, weak) UIView *plainView;

/** plainButtonVLineView */
@property (nonatomic, weak) UIView *plainButtonVLineView;

/** plainCornerRadius */
@property (nonatomic, assign) CGFloat plainCornerRadius;

/** closeButton */
@property (nonatomic, weak) UIButton *closeButton;

/** clickBlankDismiss */
@property (nonatomic, assign) BOOL clickBlankDismiss;

/** 监听点击空白处的block */
@property (nonatomic, copy) void (^blankClickBlock)(void);

/** plain样式title和messagex上下之间的分隔线是否隐藏 默认YES */
@property (nonatomic, assign) BOOL plainTitleMessageSeparatorHidden;

/** plain样式title和messagex上下之间的分隔线左右间距 默认0 */
@property (nonatomic, assign) CGFloat plainTitleMessageSeparatorMargin;

/** message最小高度 */
@property (nonatomic, assign) CGFloat messageMinHeight;

/** plain样式添加自定义的titleView */
@property (nonatomic, weak) UIView *customPlainTitleView;

/** plain样式添加自定义的titleView 是否仅放在message位置 */
@property (nonatomic, assign) BOOL customPlainTitleViewOnlyForMessage;

/** collection样式添加自定义的titleView的父视图 */
//@property (nonatomic, weak) UIScrollView *customPlainTitleScrollView;

/** customHUD */
@property (nonatomic, weak) UIView *customHUD;

/** textContainerView */
@property (nonatomic, weak) UIView *textContainerView;

/** plainTextContainerScrollView */
@property (nonatomic, weak) UIScrollView *plainTextContainerScrollView;

/** plain样式title和message之间 分隔线 */
@property (nonatomic, weak) UIView *plainTitleMessageSeparatorView;

/** plain样式文字容器底部 分隔线 */
@property (nonatomic, weak) UIView *textContainerBottomLineView;

/** titleTextView */
@property (nonatomic, weak) JKAlertTextView *titleTextView;

/** messageTextView */
@property (nonatomic, weak) JKAlertTextView *messageTextView;

/** scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;

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

/** textFieldContainerView */
@property (nonatomic, weak) UIView *textFieldContainerView;

/** 当前的textField */
@property (nonatomic, weak) UITextField *currentTextField;

/** textField数组 */
@property (nonatomic, strong) NSMutableArray *textFieldArr;

/**
 * 设置plain样式Y值
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setPlainY)(CGFloat Y, BOOL animated);

/** 是否横屏 */
@property (nonatomic, assign) BOOL isLandScape;

/** 监听屏幕旋转 */
@property (nonatomic, copy) void (^orientationChangeBlock)(JKAlertView *view, UIInterfaceOrientation orientation);

/** 自定义展示动画 */
@property (nonatomic, copy) void (^customShowAnimationBlock)(JKAlertView *view, UIView *animationView);

/** 自定义消失动画 */
@property (nonatomic, copy) void (^customDismissAnimationBlock)(JKAlertView *view, UIView *animationView);

/** 监听重新布局完成 */
@property (nonatomic, copy) void (^relayoutComplete)(JKAlertView *view);

#pragma mark
#pragma mark - 外界可自定义属性 移至内部 外界全部改为使用链式语法修改 2018-09-28

/** title和message是否可以响应事件，默认YES 如无必要不建议设置为NO */
@property (nonatomic, assign) BOOL textViewUserInteractionEnabled;

/** title和message是否可以选择文字，默认NO */
@property (nonatomic, assign) BOOL textViewShouldSelectText;

/** titleTextViewDelegate */
@property (nonatomic, weak) id<UITextViewDelegate> titleTextViewDelegate;

/** messageTextViewDelegate */
@property (nonatomic, weak) id<UITextViewDelegate> messageTextViewDelegate;

/** titleTextViewAlignment 默认NSTextAlignmentCenter */
@property (nonatomic, assign) NSTextAlignment titleTextViewAlignment;

/** messageTextViewAlignment 默认NSTextAlignmentCenter */
@property (nonatomic, assign) NSTextAlignment messageTextViewAlignment;

/** title和message的左右间距 默认20 */
@property (nonatomic, assign) CGFloat textViewLeftRightMargin;

/** 默认的取消action，不需要自带的可以自己设置，不可置为nil */
@property (nonatomic, strong) JKAlertAction *cancelAction;

/** dealloc时会调用的block */
@property (nonatomic, copy) void (^deallocBlock)(void);

/** 监听superView尺寸改变时将要自适应的block */
@property (nonatomic, copy) void (^willAdaptBlock)(JKAlertView *view, UIView *containerView);

/** 监听superView尺寸改变时自适应完成的block */
@property (nonatomic, copy) void (^didAdaptBlock)(JKAlertView *view, UIView *containerView);

/** 是否自动弹出键盘 默认YES */
@property (nonatomic, assign) BOOL autoShowKeyboard;

/** 是否自动缩小plain样式的宽度以适应屏幕宽度 默认NO */
@property (nonatomic, assign) BOOL autoReducePlainWidth;

/**
 * plain和HUD样式centerY的偏移
 * 正数表示向下偏移，负数表示向上偏移
 */
@property (nonatomic, assign) CGFloat plainCenterOffsetY;

/**
 * HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
@property (nonatomic, assign) CGFloat dismissTimeInterval;

/**
 * HUD样式高度，不包含customHUD
 * 小于0将没有效果，默认-1
 */
@property (nonatomic, assign) CGFloat HUDHeight;

/**
 * collection的itemSize的宽度
 * 最大不可超过屏幕宽度的一半
 * 注意图片的宽高是设置的宽度-30，即图片在cell中是左右各15的间距
 * 自动计算item之间间距，最小为0，可自己计算该值设置每屏显示个数
 * 默认的高度是宽度-6，暂不支持自定义高度
 */
@property (nonatomic, assign) CGFloat flowlayoutItemWidth;

/**
 * collection列数（每行数量）
 * 默认0，自动设置，不得大于自动设置的数量
 */
@property (nonatomic, assign) NSInteger collectionColumnCount;

/**
 * 设置collection的水平（左右方向）的sectionInset
 * 默认0，为0时自动设置为item间距的一半
 */
@property (nonatomic, assign) CGFloat collectionHorizontalInset;

/** collection的title下分隔线是否隐藏 */
@property (nonatomic, assign) BOOL collectionTitleSeperatorHidden;

/**
 * 设置两个collectionView之间的间距
 * 有第二个collectionView时有效 默认0, 最小为0
 */
@property (nonatomic, assign) CGFloat collectionViewMargin;

/**
 * 是否将两个collection合体
 * 设为YES可让两个collection同步滚动
 * 设置YES时会自动让两个collection的action数量保持一致，即向少的一方添加空的action
 */
@property (nonatomic, assign) BOOL compoundCollection;

/** collection是否分页 */
@property (nonatomic, assign) BOOL collectionPagingEnabled;

/**
 * collection是否显示pageControl
 * 如果只有一组collection，则必须设置分页为YES才有效
 * 如果有两组collection，则仅在分页和合体都为YES时才有效
 * 注意自己计算好每页显示的个数相等
 * 可以添加空的action来保证每页显示个数相等
 * JKAlertAction使用类方法初始化时每个参数传nil或者直接自己实例化一个即为空action
 */
@property (nonatomic, assign) BOOL showPageControl;

/** colletion样式的底部按钮左右间距 */
@property (nonatomic, assign) CGFloat collectionButtonLeftRightMargin;

/** collection样式默认有一个取消按钮，设置这个可以在取消按钮的上面再添加一个按钮 */
@property (nonatomic, strong) JKAlertAction *collectionAction;

/**
 * 是否使JKAlertView.dismissAll(); 对当前JKAlertView无效
 * 请谨慎使用，若设置为YES 调用JKAlertView.dismissAll(); 将对当前JKAlertView无效
 */
@property (nonatomic, assign) BOOL isDismissAllNoneffective;

/** 用于通知消失的key */
@property (nonatomic, copy) NSString *dismissKey;

/** 用于通知消失的类别的key */
@property (nonatomic, copy) NSString *dismissCategory;

/** enableVerticalGestureDismiss */
@property (nonatomic, assign) BOOL enableVerticalGestureDismiss;

/** enableHorizontalGestureDismiss */
@property (nonatomic, assign) BOOL enableHorizontalGestureDismiss;

/** showGestureIndicator */
@property (nonatomic, assign) BOOL showGestureIndicator;

/** topGestureIndicatorView */
@property (nonatomic, weak) UIView *topGestureIndicatorView;

/** topGestureLineView */
@property (nonatomic, weak) UIView *topGestureLineView;

/** verticalDismissPanGesture */
@property (nonatomic, strong) JKAlertPanGestureRecognizer *verticalDismissPanGesture;

/** horizontalDismissPanGesture */
@property (nonatomic, strong) JKAlertPanGestureRecognizer *horizontalDismissPanGesture;

/** tableViewDataSource */
@property (nonatomic, weak) id tableViewDataSource;

/** tableViewDelegate */
@property (nonatomic, weak) id tableViewDelegate;

/** 是否固定取消按钮在底部 */
@property (nonatomic, assign) BOOL pinCancelButton;

/** 是否自动适配键盘 */
@property (nonatomic, assign) BOOL autoAdaptKeyboard;

/** plain样式弹出键盘时与键盘的间距 竖屏 */
@property (nonatomic, assign) CGFloat plainKeyboardMargin;

/** show的时候是否振动 默认NO */
@property (nonatomic, assign) BOOL shouldVibrate;

/** action sheet样式是否镂空 */
@property (nonatomic, assign) BOOL isActionSheetPierced;

/** 镂空左右的间距 默认15 */
@property (nonatomic, assign) CGFloat piercedHorizontalMargin;

/** 非X设备镂空底部取消按钮距离底部的间距 默认15 */
@property (nonatomic, assign) CGFloat piercedBottomMargin;

/** 镂空整体圆角 */
@property (nonatomic, assign) CGFloat piercedCornerRadius;

/** 镂空时背景色 */
@property (nonatomic, strong) UIColor *piercedBackgroundColor;
@end





@interface JKAlertView (PrivateProperty)

@end
