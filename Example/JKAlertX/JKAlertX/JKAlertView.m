//
//  JKAlertView.m
//  TestVideoAndPicture
//
//  Created by albert on 2017/4/18.
//  Copyright © 2017年 安永博. All rights reserved.
//

#import "JKAlertView.h"
#import "JKAlertTableViewCell.h"
#import "JKAlertCollectionViewCell.h"
#import "JKAlertTextView.h"


@interface JKAlertHighlightedButton : UIButton

@end

@interface JKAlertSeparatorLayerButton : UIButton

/** topSeparatorLineView */
@property (nonatomic, weak) UIView *topSeparatorLineView;
@end

@interface JKAlertView () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, JKAlertViewProtocol, UIGestureRecognizerDelegate>
{
    BOOL JKAlertIsIphoneX;
    
    CGFloat TBMargin;
    CGFloat textContainerViewCurrentMaxH_;
    BOOL    _enableDeallocLog;
    CGFloat _iPhoneXLandscapeTextMargin;
    
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
    
    CGFloat lastContainerY;
    CGFloat currentContainerY;
    
    JKAlertScrollDirection beginScrollDirection;
    JKAlertScrollDirection endScrollDirection;
    
    BOOL disableScrollSheetContainerView;
    
    BOOL isDragging;
    
    CGFloat lastTableViewOffsetY;
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

/** sheet样式添加自定义的titleView */
@property (nonatomic, weak) UIView *customSheetTitleView;

/** pageControl */
@property (nonatomic, weak) UIPageControl *pageControl;

/** cancelButton */
@property (nonatomic, weak) JKAlertHighlightedButton *cancelButton;

/** collectionButton */
@property (nonatomic, weak) JKAlertHighlightedButton *collectionButton;

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

/** clickPlainBlankDismiss */
@property (nonatomic, assign) BOOL clickPlainBlankDismiss;

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

/** 即将消失的回调 */
@property (nonatomic, copy) void (^willDismissHandler)(void);

/** 消失后的回调 */
@property (nonatomic, copy) void (^didDismissHandler)(void);

/** 显示动画完成的回调 */
@property (nonatomic, copy) void (^showAnimationCompleteHandler)(JKAlertView *view);

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
@property (nonatomic, assign) BOOL textViewCanSelectText;

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

/** enableGestureDismiss */
@property (nonatomic, assign) BOOL enableGestureDismiss;

/** topGestureIndicatorView */
@property (nonatomic, weak) UIView *topGestureIndicatorView;

/** topGestureLineView */
@property (nonatomic, weak) UIView *topGestureLineView;

/** dismissPanGesture */
@property (nonatomic, strong) UIPanGestureRecognizer *dismissPanGesture;
@end

@implementation JKAlertView

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message style:(JKAlertStyle)alertStyle{
    
    if (alertStyle == JKAlertStyleNone) {
        
        return nil;
    }
    
    JKAlertView *alertView = [[JKAlertView alloc] init];
    
    alertView.alertStyle = alertStyle;
    alertView.alertTitle = [title copy];
    alertView.message    = [message copy];
    
    return alertView;
}

/** 链式实例化 */
+ (JKAlertView *(^)(NSString *title, NSString *message, JKAlertStyle style))alertView{
    
    return ^(NSString *title, NSString *message, JKAlertStyle style){
        
        return [JKAlertView alertViewWithTitle:title message:message style:style];
    };
}

+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)attributedTitle attributedMessage:(NSAttributedString *)attributedMessage style:(JKAlertStyle)alertStyle{
    
    if (alertStyle == JKAlertStyleNone) {
        
        return nil;
    }
    
    JKAlertView *alertView = [[JKAlertView alloc] init];
    
    alertView.alertStyle = alertStyle;
    alertView.alertAttributedTitle = [attributedTitle copy];
    alertView.attributedMessage = [attributedMessage copy];
    
    return alertView;
}

/** 函数式类方法 */
+ (id<JKAlertViewProtocol> (^)(NSString *title, NSString *message, JKAlertStyle style, void(^)(JKAlertView *alertView)))show{
    
    return ^(NSString *title, NSString *message, JKAlertStyle style, void(^configuration)(JKAlertView *alertView)){
        
        JKAlertView *view = [self alertViewWithTitle:title message:message style:style];
        
        !configuration ? : configuration(view);
        
        view.show();
        
        return view;
    };
}

/** 链式实例化 */
+ (JKAlertView *(^)(NSAttributedString *attributedTitle, NSAttributedString *attributedMessage, JKAlertStyle style))alertViewAttributed{
    
    return ^(NSAttributedString *attributedTitle, NSAttributedString *attributedMessage, JKAlertStyle style){
        
        return [JKAlertView alertViewWithAttributedTitle:attributedTitle attributedMessage:attributedMessage style:style];
    };
}

/** 显示文字HUD */
+ (void (^)(NSString *title, void(^configuration)(JKAlertView *alertView)))showHUDWithTitle{
    
    return ^(NSString *title, void(^configuration)(JKAlertView *alertView)){
        
        JKAlertView *alertView = nil;
        
        if (!title) {
            
            return;
        }
        
        alertView = [JKAlertView alertViewWithTitle:title message:nil style:(JKAlertStyleHUD)];
        
        !configuration ? : configuration(alertView);
        
        [alertView show];
    };
}

/** 显示富文本HUD */
+ (void (^)(NSAttributedString *attributedTitle, void(^configuration)(JKAlertView *alertView)))showHUDWithAttributedTitle{
    
    return ^(NSAttributedString *attributedTitle, void(^configuration)(JKAlertView *alertView)){
        
        JKAlertView *alertView = nil;
        
        if (!attributedTitle) {
            
            return;
        }
        
        alertView = [JKAlertView alertViewWithAttributedTitle:attributedTitle attributedMessage:nil style:(JKAlertStyleHUD)];
        
        !configuration ? : configuration(alertView);
        
        [alertView show];
    };
}

/**
 * 显示自定义HUD
 * 注意使用点语法调用，否则莫名报错 JKAlertView.showCustomHUD
 * customHUD尺寸将完全由自定义控制，默认显示在屏幕中间
 * 注意自己计算好自定义HUD的size，以避免横竖屏出现问题
 */
+ (void (^)(UIView *(^customHUD)(void), void(^configuration)(JKAlertView *alertView)))showCustomHUD{
    
    return ^(UIView *(^customHUD)(void), void(^configuration)(JKAlertView *alertView)){
        
        JKAlertView *alertView = nil;
        
        if (!customHUD) {
            
            return;
        }
        
        UIView *customView = customHUD();
        
        alertView = [[JKAlertView alloc] init];
        
        !configuration ? : configuration(alertView);
        
        alertView.customHUD = customView;
        
        [alertView show];
    };
}

/**
 * 移除当前所有的JKAlertView
 * 本质是发送一个通知，让所有的JKAlertView对象执行消失操作
 * 注意如果某个对象setDismissAllNoneffective为YES时，该对象将不会响应通知
 * ***谨慎使用该方法***
 */
+ (void(^)(void))dismissAll{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:JKAlertDismissAllNotification object:nil];
    
    return ^{};
}

/**
 * 移除设置了dismissKey的JKAlertView
 * 本质是发送一个通知，让dismissKey为该值的JKAlertView对象执行消失操作
 */
+ (void(^)(NSString *dismissKey))dismissForKey{
    
    return ^(NSString *dismissKey){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:JKAlertDismissForKeyNotification object:dismissKey];
    };
}

#pragma mark - 懒加载------------------------

- (NSMutableArray *)actions{
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    return _actions;
}

- (NSMutableArray *)actions2{
    if (!_actions2) {
        _actions2 = [NSMutableArray array];
    }
    return _actions2;
}

- (NSMutableArray *)textFieldArr{
    if (!_textFieldArr) {
        _textFieldArr = [NSMutableArray array];
    }
    return _textFieldArr;
}

- (UIView *)textContainerView{
    if (!_textContainerView) {
        UIView *textContainerView = [[UIView alloc] init];
        [self addSubview:textContainerView];
        _textContainerView = textContainerView;
    }
    return _textContainerView;
}

- (JKAlertTextView *)titleTextView{
    if (!_titleTextView) {
        JKAlertTextView *titleTextView = [[JKAlertTextView alloc] init];
        titleTextView.textColor = self.alertStyle == JKAlertStylePlain ? JKALertAdaptColor(JKAlertSameRGBColor(25.5), JKAlertSameRGBColor(229.5)) : JKALertAdaptColor(JKAlertSameRGBColor(89.25), JKAlertSameRGBColor(165.75));
        titleTextView.font = self.alertStyle == JKAlertStylePlain ? [UIFont boldSystemFontOfSize:17] : [UIFont systemFontOfSize:17];
        [self addSubview:titleTextView];
        
        _titleTextView = titleTextView;
    }
    return _titleTextView;
}

- (JKAlertTextView *)messageTextView{
    if (!_messageTextView) {
        JKAlertTextView *messageTextView = [[JKAlertTextView alloc] init];
        messageTextView.textColor = self.alertStyle == JKAlertStyleActionSheet ? JKALertAdaptColor(JKAlertSameRGBColor(140.25), JKAlertSameRGBColor(114.75)) : JKALertAdaptColor(JKAlertSameRGBColor(76.5), JKAlertSameRGBColor(178.5));
        messageTextView.font = self.alertStyle == JKAlertStylePlain ? [UIFont systemFontOfSize:14] : [UIFont systemFontOfSize:13];
        [self addSubview:messageTextView];
        
        _messageTextView = messageTextView;
    }
    return _messageTextView;
}

- (UIScrollView *)plainTextContainerScrollView{
    if (!_plainTextContainerScrollView) {
        UIScrollView *plainTextContainerScrollView = [[UIScrollView alloc] init];
        plainTextContainerScrollView.delegate = self;
        [self addSubview:plainTextContainerScrollView];
        
        [self adjustScrollView:plainTextContainerScrollView];
        
        _plainTextContainerScrollView = plainTextContainerScrollView;
        
        [self.textContainerView insertSubview:_plainTextContainerScrollView atIndex:0];
        
        _plainTextContainerScrollView.translatesAutoresizingMaskIntoConstraints = NO;
        NSArray *scrollViewCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|" options:0 metrics:nil views:@{@"scrollView" : _plainTextContainerScrollView}];
        [_textContainerView addConstraints:scrollViewCons1];
        
        NSArray *scrollViewCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[scrollView]-0-|" options:0 metrics:nil views:@{@"scrollView" : _plainTextContainerScrollView}];
        [_textContainerView addConstraints:scrollViewCons2];
    }
    return _plainTextContainerScrollView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.delegate = self;
        [self addSubview:scrollView];
        
        [self adjustScrollView:scrollView];
        
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (void)adjustScrollView:(UIScrollView *)scrollView{
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    
    SEL selector = NSSelectorFromString(@"setContentInsetAdjustmentBehavior:");
    
    if ([scrollView respondsToSelector:selector]) {
        
        IMP imp = [scrollView methodForSelector:selector];
        void (*func)(id, SEL, NSInteger) = (void *)imp;
        func(scrollView, selector, 2);
        
        // [tbView performSelector:@selector(setContentInsetAdjustmentBehavior:) withObject:@(2)];
    }
}

- (UIView *)backGroundView{
    if (!_backGroundView) {
        //UIToolbar *toolbar = [[UIToolbar alloc] init];
        //toolbar.clipsToBounds = YES;
        
        BOOL isLight = YES;
        
        if (@available(iOS 13.0, *)) {
            
            isLight = ([self.traitCollection userInterfaceStyle] == UIUserInterfaceStyleLight);
        }
        
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:isLight ? UIBlurEffectStyleExtraLight : UIBlurEffectStyleDark]];
        effectView.clipsToBounds = YES;
        self.backGroundView = effectView;
    }
    return _backGroundView;
}

- (UIView *)sheetContainerView{
    if (!_sheetContainerView) {
        UIView *sheetContainerView = [[UIView alloc] init];
        [self.contentView addSubview:sheetContainerView];
        _sheetContainerView = sheetContainerView;
        
        _dismissPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        
        [sheetContainerView addGestureRecognizer:_dismissPanGesture];
        
        // 背景
        [self backGroundView];
    }
    return _sheetContainerView;
}

- (UIView *)sheetContentView{
    if (!_sheetContentView) {
        UIView *sheetContentView = [[UIView alloc] init];
        [self.sheetContainerView insertSubview:sheetContentView aboveSubview:self.backGroundView];
        _sheetContentView = sheetContentView;
    }
    return _sheetContentView;
}

- (UIView *)topGestureIndicatorView{
    if (!_topGestureIndicatorView) {
        UIView *topGestureIndicatorView = [[UIView alloc] init];
        topGestureIndicatorView.userInteractionEnabled = NO;
        topGestureIndicatorView.backgroundColor = JKALertGlobalBackgroundColor();
        [self.sheetContainerView addSubview:topGestureIndicatorView];
        _topGestureIndicatorView = topGestureIndicatorView;
        
        UIView *topGestureLineView = [[UIView alloc] initWithFrame:CGRectMake((JKAlertScreenW - 40) * 0.5, 14.5, 40, 5)];
        topGestureLineView.userInteractionEnabled = NO;
        topGestureLineView.layer.cornerRadius = 2.5;
        topGestureLineView.backgroundColor = JKALertAdaptColor(JKAlertSameRGBColor(217), JKAlertSameRGBColor(38));
        [topGestureIndicatorView addSubview:topGestureLineView];
        _topGestureLineView = topGestureLineView;
    }
    return _topGestureIndicatorView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        // 分隔线
        UIView *hline = [UIView new];
        hline.backgroundColor = JKALertAdaptColor([[UIColor blackColor] colorWithAlphaComponent:0.2], [[UIColor whiteColor] colorWithAlphaComponent:0.2]);
        [self.textContainerView addSubview:hline];
        _textContainerBottomLineView = hline;
        
        //        NSString *hVF = [NSString stringWithFormat:@"H:|-%d-[bottomLineView]-%d-|", (int)_iPhoneXLandscapeTextMargin, (int)_iPhoneXLandscapeTextMargin];
        //
        //        bottomLineView.translatesAutoresizingMaskIntoConstraints = NO;
        //        NSArray *bottomLineViewCons1 = [NSLayoutConstraint constraintsWithVisualFormat:hVF options:0 metrics:nil views:@{@"bottomLineView" : bottomLineView}];
        //        [self.textContainerView addConstraints:bottomLineViewCons1];
        //
        //        NSArray *bottomLineViewCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomLineView(0.5)]-0-|" options:0 metrics:nil views:@{@"bottomLineView" : bottomLineView}];
        //        [self.textContainerView addConstraints:bottomLineViewCons2];
        
        // title和message的容器view
        self.textContainerView.backgroundColor = JKALertGlobalBackgroundColor();
        [self.sheetContentView addSubview:self.textContainerView];
        
        [self.textContainerView insertSubview:self.scrollView atIndex:0];
        
        //        self.scrollView.scrollEnabled = NO;
        
        [self.scrollView addSubview:self.titleTextView];
        
        [self.scrollView addSubview:self.messageTextView];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        
        tableView.dataSource = self;
        tableView.delegate = self;
        
        tableView.scrollsToTop = NO;
        tableView.scrollEnabled = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableView.contentInset = UIEdgeInsetsMake(0, 0, FillHomeIndicator ? 0 :  JKAlertAdjustHomeIndicatorHeight, 0);
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, JKAlertCurrentHomeIndicatorHeight, 0);
        
        if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft) {
            
            tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, -34, JKAlertCurrentHomeIndicatorHeight, 34);
        }
        
        tableView.backgroundColor = nil;
        
        [tableView registerClass:[JKAlertTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JKAlertTableViewCell class])];
        
        [_sheetContentView addSubview:tableView];
        [_sheetContentView insertSubview:tableView belowSubview:self.textContainerView];
        
        tableView.rowHeight = JKAlertRowHeight;
        tableView.sectionFooterHeight = 0;
        tableView.sectionHeaderHeight = 0;
        
        tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JKAlertScreenW, CGFLOAT_MIN)];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JKAlertScreenW, CGFLOAT_MIN)];
        
        SEL selector = NSSelectorFromString(@"setContentInsetAdjustmentBehavior:");
        
        if ([tableView respondsToSelector:selector]) {
            
            IMP imp = [tableView methodForSelector:selector];
            void (*func)(id, SEL, NSInteger) = (void *)imp;
            func(tableView, selector, 2);
            
            // [tbView performSelector:@selector(setContentInsetAdjustmentBehavior:) withObject:@(2)];
        }
        
        //        if (@available(iOS 11.0, *)) {
        //            tbView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //        }
        
        if (@available(iOS 13.0, *)) {
            
            [tableView setAutomaticallyAdjustsScrollIndicatorInsets:NO];
        }
        
        _tableView = tableView;
    }
    return _tableView;
}

- (UIView *)collectionTopContainerView{
    if (!_collectionTopContainerView) {
        UIView *collectionTopContainerView = [[UIView alloc] init];
        collectionTopContainerView.backgroundColor = JKALertGlobalBackgroundColor();
        [self.sheetContentView addSubview:collectionTopContainerView];
        _collectionTopContainerView = collectionTopContainerView;
    }
    return _collectionTopContainerView;
}

- (JKAlertHighlightedButton *)cancelButton{
    if (!_cancelButton) {
        
        JKAlertHighlightedButton *cancelButton = [JKAlertHighlightedButton buttonWithType:(UIButtonTypeCustom)];
        [self.scrollView addSubview:cancelButton];
        
        cancelButton.backgroundColor = JKALertGlobalBackgroundColor();
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [cancelButton setTitleColor:JKALertAdaptColor(JKAlertSameRGBColor(51), JKAlertSameRGBColor(204)) forState:(UIControlStateNormal)];
        [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        _cancelButton = cancelButton;
    }
    return _cancelButton;
}

- (JKAlertHighlightedButton *)collectionButton{
    if (!_collectionButton) {
        JKAlertHighlightedButton *collectionButton = [JKAlertHighlightedButton buttonWithType:(UIButtonTypeCustom)];
        collectionButton.backgroundColor = JKALertGlobalBackgroundColor();
        [self.scrollView addSubview:collectionButton];
        collectionButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [collectionButton setTitleColor:JKALertAdaptColor(JKAlertSameRGBColor(51), JKAlertSameRGBColor(204)) forState:(UIControlStateNormal)];
        [collectionButton addTarget:self action:@selector(collectionButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        //        [collectionButton setBackgroundImage:JKAlertCreateImageWithColor([UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1], 1, 1, 0) forState:(UIControlStateHighlighted)];
        
        _collectionButton = collectionButton;
    }
    return _collectionButton;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.backgroundColor = nil;
        pageControl.pageIndicatorTintColor = JKALertAdaptColor(JKAlertSameRGBColor(217), JKAlertSameRGBColor(38));
        pageControl.currentPageIndicatorTintColor = JKALertAdaptColor(JKAlertSameRGBColor(102), JKAlertSameRGBColor(153));
        pageControl.userInteractionEnabled = NO;
        
        [self.collectionTopContainerView addSubview:pageControl];
        
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        [self.sheetContentView insertSubview:self.scrollView atIndex:1];
        
        self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, JKAlertAdjustHomeIndicatorHeight, 0);
        
        if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft) {
            
            self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, -34, JKAlertCurrentHomeIndicatorHeight, 34);
        }
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSArray *scrollViewCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|" options:0 metrics:nil views:@{@"scrollView" : self.scrollView}];
        [self addConstraints:scrollViewCons1];
        
        NSArray *scrollViewCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[scrollView]-0-|" options:0 metrics:nil views:@{@"scrollView" : self.scrollView}];
        [self addConstraints:scrollViewCons2];
        
        [self.scrollView insertSubview:self.collectionTopContainerView atIndex:0];
        
        // title和message的容器view
        self.textContainerView.backgroundColor = nil;
        [self.collectionTopContainerView addSubview:self.textContainerView];
        
        [self.textContainerView addSubview:self.titleTextView];
        
        UIView *hline = [UIView new];
        hline.backgroundColor = JKALertAdaptColor([[UIColor blackColor] colorWithAlphaComponent:0.2], [[UIColor whiteColor] colorWithAlphaComponent:0.2]);
        [self.textContainerView addSubview:hline];
        _textContainerBottomLineView = hline;
        
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowlayout = flowlayout;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.textContainerView.frame), JKAlertScreenW, 80) collectionViewLayout:flowlayout];
        collectionView.backgroundColor = nil;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        collectionView.scrollsToTop = NO;
        
        [collectionView registerClass:[JKAlertCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JKAlertCollectionViewCell class])];
        
        SEL selector = NSSelectorFromString(@"setContentInsetAdjustmentBehavior:");
        
        if ([collectionView respondsToSelector:selector]) {
            
            IMP imp = [collectionView methodForSelector:selector];
            void (*func)(id, SEL, NSInteger) = (void *)imp;
            func(collectionView, selector, 2);
            
            // [tbView performSelector:@selector(setContentInsetAdjustmentBehavior:) withObject:@(2)];
        }
        
        [self.collectionTopContainerView insertSubview:collectionView belowSubview:self.textContainerView];
        
        [self cancelButton];
        
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UICollectionView *)collectionView2{
    if (!_collectionView2) {
        
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowlayout2 = flowlayout;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowlayout2];
        collectionView.backgroundColor = nil;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        collectionView.scrollsToTop = NO;
        
        [collectionView registerClass:[JKAlertCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JKAlertCollectionViewCell class])];
        
        SEL selector = NSSelectorFromString(@"setContentInsetAdjustmentBehavior:");
        
        if ([collectionView respondsToSelector:selector]) {
            
            IMP imp = [collectionView methodForSelector:selector];
            void (*func)(id, SEL, NSInteger) = (void *)imp;
            func(collectionView, selector, 2);
            
            // [tbView performSelector:@selector(setContentInsetAdjustmentBehavior:) withObject:@(2)];
        }
        
        [self.collectionTopContainerView addSubview:collectionView];
        
        _collectionView2 = collectionView;
    }
    return _collectionView2;
}

- (UIView *)plainView{
    if (!_plainView) {
        UIView *plainView = [[UIView alloc] init];
        plainView.clipsToBounds = YES;
        plainView.layer.cornerRadius = _plainCornerRadius;
        plainView.frame = CGRectMake((JKAlertScreenW - PlainViewWidth) * 0.5, (JKAlertScreenH - 200) * 0.5, PlainViewWidth, 200);
        
        [plainView addSubview:self.textContainerView];
        
        [self.plainTextContainerScrollView addSubview:self.titleTextView];
        
        [self.plainTextContainerScrollView addSubview:self.messageTextView];
        
        [plainView addSubview:self.scrollView];
        
        [plainView insertSubview:self.scrollView belowSubview:self.textContainerView];
        
        if (_alertStyle == JKAlertStylePlain) {
            
            // 分隔线
            UIView *hline = [UIView new];
            hline.backgroundColor = JKALertAdaptColor([[UIColor blackColor] colorWithAlphaComponent:0.2], [[UIColor whiteColor] colorWithAlphaComponent:0.2]);
            [self.textContainerView addSubview:hline];
            _textContainerBottomLineView = hline;
            
            // 分隔线
            UIView *hline2 = [UIView new];
            hline2.hidden = YES;
            hline2.backgroundColor = JKALertAdaptColor([[UIColor blackColor] colorWithAlphaComponent:0.2], [[UIColor whiteColor] colorWithAlphaComponent:0.2]);
            [self.plainTextContainerScrollView addSubview:hline2];
            _plainTitleMessageSeparatorView = hline2;
        }
        
        [self addSubview:plainView];
        _plainView = plainView;
        
        // 背景
        [self backGroundView];
    }
    return _plainView;
}

- (UIButton *)closeButton{
    
    if (_alertStyle != JKAlertStylePlain) {
        
        return nil;
    }
    
    if (!_closeButton) {
        
        UIButton *closeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [closeButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        closeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        closeButton.frame = CGRectMake(PlainViewWidth - 30, 5, 25, 25);
        [_plainView addSubview:closeButton];
        
        [closeButton addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
        
        _closeButton = closeButton;
    }
    return _closeButton;
}

#pragma mark - 初始化------------------------

/** 初始化自身属性 */
- (void)initializeProperty{
    [super initializeProperty];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    
    /** 屏幕宽度 */
    JKAlertScreenW = keyWindow.bounds.size.width;
    
    /** 屏幕高度 */
    JKAlertScreenH = keyWindow.bounds.size.height;
    
    _isLandScape = [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight;
    
    if (@available(iOS 11.0, *)) {
        
        JKAlertIsIphoneX = UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom > 0;
        
    } else {
        
        JKAlertIsIphoneX = NO;
    }
    
    JKAlertPlainViewMaxH = (JKAlertScreenH - 100);
    
    JKAlertSheetMaxH = (JKAlertScreenH > JKAlertScreenW) ? JKAlertScreenH * 0.85 : JKAlertScreenH * 0.8;
    
    _HUDHeight = -1;
    _enableDeallocLog = NO;
    _messageMinHeight = -1;
    _plainCornerRadius = 8;
    _dismissTimeInterval = 1;
    _textViewUserInteractionEnabled = YES;
    _plainTitleMessageSeparatorHidden = YES;
    _collectionTitleSeperatorHidden = YES;
    _iPhoneXLandscapeTextMargin = 0;//((JKAlertIsIphoneX && JKAlertScreenW > JKAlertScreenH) ? 44 : 0);
    
    TBMargin = 20;
    PlainViewWidth = 290;
    OriginalPlainWidth = PlainViewWidth;
    _collectionViewMargin = 10;
    JKAlertTitleMessageMargin = 7;
    CancelMargin = ((JKAlertScreenW > 321) ? 7 : 5);
    JKAlertSeparatorLineWH = (1 / [UIScreen mainScreen].scale);
    textContainerViewCurrentMaxH_ = (JKAlertScreenH - 100 - JKAlertButtonH * 4);
    
    _autoShowKeyboard = YES;
    FillHomeIndicator = YES;
    AutoAdjustHomeIndicator = YES;
    
    self.flowlayoutItemWidth = 76;
    self.textViewLeftRightMargin = 20;
    self.titleTextViewAlignment = NSTextAlignmentCenter;
    self.messageTextViewAlignment = NSTextAlignmentCenter;
    
    _enableGestureDismiss = NO;
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization{
    [super initialization];
    
    [self addNotifications];
}

/** 创建UI */
- (void)createUI{
    [super createUI];
    
}

/** 布局UI */
- (void)layoutUI{
    [super layoutUI];
    
}

/** 初始化UI数据 */
- (void)initializeUIData{
    [super initializeUIData];
    
}

- (void)addNotifications{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    // 移除全部的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissAllNotification:) name:JKAlertDismissAllNotification object:nil];
    
    // 根据key来移除的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissForKeyNotification:) name:JKAlertDismissForKeyNotification object:nil];
}

#pragma mark - setter------------------------

- (void)setAlertStyle:(JKAlertStyle)alertStyle{
    _alertStyle = alertStyle;
    
    _clickPlainBlankDismiss = NO;
    
    switch (_alertStyle) {
        case JKAlertStylePlain:
        {
            [self plainView];
        }
            break;
            
        case JKAlertStyleActionSheet:
        {
            [self tableView];
            _clickPlainBlankDismiss = YES;
        }
            break;
            
        case JKAlertStyleCollectionSheet:
        {
            CancelMargin = 10;
            
            [self collectionView];
            _clickPlainBlankDismiss = YES;
        }
            break;
            
        case JKAlertStyleHUD:
        {
            [self plainView];
        }
            break;
            
        default:
            break;
    }
}

/** 设置默认的取消action，不需要自带的可以自己设置，不可置为nil */
- (void)setCancelAction:(JKAlertAction *)cancelAction{
    
    if (cancelAction == nil) {
        return;
    }
    
    _cancelAction = cancelAction;
    
    _cancelAction.alertView = self;
}

/**
 * 设置collection的itemSize的宽度
 * 最大不可超过屏幕宽度的一半
 * 注意图片的宽高是设置的宽度-30，即图片在cell中是左右各15的间距
 * 自动计算item之间间距，最小为0，可自己计算该值设置每屏显示个数
 * 默认的高度是宽度-6，暂不支持自定义高度
 */
- (void)setFlowlayoutItemWidth:(CGFloat)flowlayoutItemWidth{
    
    _flowlayoutItemWidth = flowlayoutItemWidth > JKAlertScreenW * 0.5 ? JKAlertScreenW * 0.5 : flowlayoutItemWidth;
}

- (void)setCustomHUD:(UIView *)customHUD{
    _customHUD = customHUD;
    
    [self.plainView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.plainView addSubview:_customHUD];
    
    [self calculateUI];
}

- (void)setCustomSheetTitleView:(UIView *)customSheetTitleView{
    _customSheetTitleView = customSheetTitleView;
    
    if (!_customSheetTitleView) {
        return;
    }
    
    _titleTextView.hidden = YES;
    _messageTextView.hidden = YES;
    [_textContainerView addSubview:_customSheetTitleView];
    
    if (_alertStyle == JKAlertStyleActionSheet) {
        
        
        [_scrollView addSubview:_customSheetTitleView];
    }
}

- (void)setCustomPlainTitleView:(UIView *)customPlainTitleView{
    _customPlainTitleView = customPlainTitleView;
    
    if (!_customPlainTitleView) { return; }
    
    _titleTextView.hidden = !_customPlainTitleViewOnlyForMessage;
    _messageTextView.hidden = YES;
    
    [_plainTextContainerScrollView addSubview:_customPlainTitleView];
}

- (void)setPlainCenterOffsetY:(CGFloat)plainCenterOffsetY{
    
    _plainCenterOffsetY = plainCenterOffsetY;
    
    _plainView.center = CGPointMake(JKAlertScreenW * 0.5, JKAlertScreenH * 0.5 + _plainCenterOffsetY);
}

- (void)setPlainCornerRadius:(CGFloat)plainCornerRadius{
    
    if (plainCornerRadius < 0) { return; }
    
    _plainCornerRadius = plainCornerRadius;
    
    _plainView.layer.cornerRadius = _plainCornerRadius;
}

- (void)setHUDHeight:(CGFloat)HUDHeight{
    
    if (_alertStyle != JKAlertStyleHUD) { return; }
    
    _HUDHeight = HUDHeight;
}

- (void)setBackGroundView:(UIView *)backGroundView{
    
    if (backGroundView == nil) { return; }
    
    [_backGroundView removeFromSuperview];
    
    _backGroundView = backGroundView;
    
    [_sheetContainerView insertSubview:_backGroundView atIndex:0];
    [_plainView insertSubview:_backGroundView atIndex:0];
    
    backGroundView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *cons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[sheetBackGroundView]-0-|" options:0 metrics:nil views:@{@"sheetBackGroundView" : backGroundView}];
    [_sheetContainerView addConstraints:cons1];
    [_plainView addConstraints:cons1];
    
    NSArray *cons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[sheetBackGroundView]-0-|" options:0 metrics:nil views:@{@"sheetBackGroundView" : backGroundView}];
    [_sheetContainerView addConstraints:cons2];
    [_plainView addConstraints:cons2];
}

- (void)setFullScreenBackGroundView:(UIView *)fullScreenBackGroundView{
    
    if (fullScreenBackGroundView == nil) { return; }
    
    [_fullScreenBackGroundView removeFromSuperview];
    
    _fullScreenBackGroundView = fullScreenBackGroundView;
    
    [self.contentView insertSubview:_fullScreenBackGroundView atIndex:0];
    
    fullScreenBackGroundView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *cons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[fullBackGroundView]-0-|" options:0 metrics:nil views:@{@"fullBackGroundView" : fullScreenBackGroundView}];
    [self addConstraints:cons1];
    
    NSArray *cons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[fullBackGroundView]-0-|" options:0 metrics:nil views:@{@"fullBackGroundView" : fullScreenBackGroundView}];
    [self addConstraints:cons2];
}

- (void)setPlainTitleMessageSeparatorHidden:(BOOL)plainTitleMessageSeparatorHidden{
    _plainTitleMessageSeparatorHidden = plainTitleMessageSeparatorHidden;
    
    _plainTitleMessageSeparatorView.hidden = _plainTitleMessageSeparatorHidden;
}

- (void)setMessageMinHeight:(CGFloat)messageMinHeight{
    _messageMinHeight = messageMinHeight < 0 ? 0 : messageMinHeight;
}

#pragma mark - 链式setter------------------------

/**
 * 设置自定义的父控件
 * 默认添加到keywindow上
 * customSuperView在show之前有效
 * customSuperViewsize最好和屏幕大小一致，否则可能出现问题
 */
- (JKAlertView *(^)(UIView *customSuperView))setCustomSuperView{
    
    return ^(UIView *customSuperView){
        
        self.customSuperView = customSuperView;
        
        if (customSuperView) {
            
            CGFloat rotation = [[self.customSuperView.layer valueForKeyPath:@"transform.rotation.z"] floatValue];
            
            if ((rotation > 1.57 && rotation < 1.58) ||
                (rotation > -1.58 && rotation < -1.57)) {
                
                self->JKAlertScreenW = self.customSuperView.frame.size.height;//MAX(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
                self->JKAlertScreenH = self.customSuperView.frame.size.width;//MIN(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
                
                [self updateMaxHeight];
                
            } else  {
                
                //self->JKAlertScreenW = MIN(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
                //self->JKAlertScreenH = MAX(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
                
                [self updateWidthHeight];
            }
        }
        
        return self;
    };
}

/** 设置默认的取消action，不需要自带的可以自己设置，不可置为nil */
- (JKAlertView *(^)(JKAlertAction *action))setCancelAction{
    
    return ^(JKAlertAction *action){
        
        self.cancelAction = action;
        
        return self;
    };
}

/** collection样式默认有一个取消按钮，设置这个可以在取消按钮的上面再添加一个按钮 */
- (JKAlertView *(^)(JKAlertAction *action))setCollectionAction{
    
    return ^(JKAlertAction *action){
        
        self.collectionAction = action;
        
        self.collectionAction.alertView = self;
        
        return self;
    };
}

/**
 * 设置titleTextColor
 * plain默认RGB都为0.1，其它0.35
 */
- (JKAlertView *(^)(UIColor *textColor))setTitleTextColor{
    
    return ^(UIColor *textColor){
        
        self->titleTextColor = textColor;
        
        return self;
    };
}

/**
 * 设置titleTextFont
 * plain默认 bold 17，其它17
 */
- (JKAlertView *(^)(UIFont *font))setTitleTextFont{
    
    return ^(UIFont *font){
        
        self->titleFont = font;
        
        return self;
    };
}

/**
 * 设置messageTextColor
 * plain默认RGB都为0.55，其它0.3
 */
- (JKAlertView *(^)(UIColor *textColor))setMessageTextColor{
    
    return ^(UIColor *textColor){
        
        self->messageTextColor = textColor;
        
        return self;
    };
}

/**
 * 设置messageTextFont
 * plain默认14，其它13
 * action样式在没有title的时候，自动改为15，设置该值后将始终为该值，不自动修改
 */
- (JKAlertView *(^)(UIFont *font))setMessageTextFont{
    
    return ^(UIFont *font){
        
        self->messageFont = font;
        
        return self;
    };
}

/** 设置titleTextViewDelegate */
- (JKAlertView *(^)(id<UITextViewDelegate> delegate))setTitleTextViewDelegate{
    
    return ^(id<UITextViewDelegate> delegate){
        
        self.titleTextViewDelegate = delegate;
        
        return self;
    };
}

/** 设置messageTextViewDelegate */
- (JKAlertView *(^)(id<UITextViewDelegate> delegate))setMessageTextViewDelegate{
    
    return ^(id<UITextViewDelegate> delegate){
        
        self.messageTextViewDelegate = delegate;
        
        return self;
    };
}

/** 设置title和message是否可以响应事件，默认YES 如无必要不建议设置为NO */
- (JKAlertView *(^)(BOOL userInteractionEnabled))setTextViewUserInteractionEnabled{
    
    return ^(BOOL userInteractionEnabled){
        
        self.textViewUserInteractionEnabled = userInteractionEnabled;
        
        return self;
    };
}

/** 设置title和message是否可以选择文字，默认NO */
- (JKAlertView *(^)(BOOL canselectText))setTextViewCanSelectText{
    
    return ^(BOOL canSelectText){
        
        self.textViewCanSelectText = canSelectText;
        
        return self;
    };
}

/** 设置titleTextView的文字水平样式 */
- (JKAlertView *(^)(NSTextAlignment textAlignment))setTitleTextViewAlignment{
    
    return ^(NSTextAlignment textAlignment){
        
        self.titleTextViewAlignment = textAlignment;
        
        return self;
    };
}

/** 设置messageTextView的文字水平样式 */
- (JKAlertView *(^)(NSTextAlignment textAlignment))setMessageTextViewAlignment{
    
    return ^(NSTextAlignment textAlignment){
        
        self.messageTextViewAlignment = textAlignment;
        
        return self;
    };
}

/** 设置title和message的左右间距 默认15 */
- (JKAlertView *(^)(CGFloat margin))setTextViewLeftRightMargin{
    
    return ^(CGFloat margin){
        
        self.textViewLeftRightMargin = margin;
        
        return self;
    };
}

/**
 * 设置title和message上下间距 默认20
 * plain样式title上间距和message下间距
 * collection样式title上下间距
 * plain样式下setPlainTitleMessageSeparatorHidden为NO时，该值为title上下间距
 * plain样式下setCustomPlainTitleView onlyForMessage为YES时，该值为title上下间距
 */
- (JKAlertView *(^)(CGFloat margin))setTextViewTopBottomMargin{
    
    return ^(CGFloat margin){
        
        self->TBMargin = margin;
        
        return self;
    };
}

/** 设置colletion样式的底部按钮左右间距 */
- (JKAlertView *(^)(CGFloat margin))setCollectionButtonLeftRightMargin{
    
    return ^(CGFloat margin){
        
        self.collectionButtonLeftRightMargin = margin;
        
        return self;
    };
}

/** 设置action和colletion样式的底部按钮上下间距 不可小于0 */
- (JKAlertView *(^)(CGFloat margin))setBottomButtonMargin{
    
    return ^(CGFloat margin){
        
        self->CancelMargin = margin < 0 ? 0 : margin;
        
        return self;
    };
}

/**
 * 设置plain样式的宽度
 * 默认290
 * 不可小于0，不可大于屏幕宽度
 */
- (JKAlertView *(^)(CGFloat width))setPlainWidth{
    
    return ^(CGFloat width) {
        
        //self->PlainViewWidth = width < 0 ? 0 : (width > MIN(self->JKAlertScreenW, self->JKAlertScreenH) ? MIN(self->JKAlertScreenW, self->JKAlertScreenH) : width);
        
        self->PlainViewWidth = MIN(MAX(0, width), self->JKAlertScreenW);
        
        self->OriginalPlainWidth = self->PlainViewWidth;
        
        return self;
    };
}

/**
 * 是否自动缩小plain样式的宽度以适应屏幕宽度 默认NO
 */
 - (JKAlertView *(^)(BOOL autoReducePlainWidth))setAutoReducePlainWidth{
     
     return ^(BOOL autoReducePlainWidth) {

         self.autoReducePlainWidth = autoReducePlainWidth;
         
         return self;
     };
 }

/**
 * 设置是否自动弹出键盘 默认YES
 */
 - (JKAlertView *(^)(BOOL autoShowKeyboard))setAutoShowKeyboard{
     
     return ^(BOOL autoShowKeyboard) {

         self.autoShowKeyboard = autoShowKeyboard;
         
         return self;
     };
 }

/**
 * 设置plain样式的圆角
 * 默认8 不可小于0
 */
- (JKAlertView *(^)(CGFloat cornerRadius))setPlainCornerRadius{
    
    return ^(CGFloat cornerRadius){
        
        self.plainCornerRadius = cornerRadius;
        
        return self;
    };
}

/**
 * 设置是否将两个collection合体
 * 设为YES可让两个collection同步滚动
 * 设置YES时会自动让两个collection的action数量保持一致，即向少的一方添加空的action
 */
- (JKAlertView *(^)(BOOL compoundCollection))setCompoundCollection{
    
    return ^(BOOL compoundCollection){
        
        self.compoundCollection = compoundCollection;
        
        return self;
    };
}

/** 设置collection是否分页 */
- (JKAlertView *(^)(BOOL collectionPagingEnabled))setCollectionPagingEnabled{
    
    return ^(BOOL collectionPagingEnabled){
        
        self.collectionPagingEnabled = collectionPagingEnabled;
        
        return self;
    };
}

/** 设置是否自动适配 iPhone X homeIndicator 默认YES */
- (JKAlertView *(^)(BOOL autoAdjust))setAutoAdjustHomeIndicator{
    
    return ^(BOOL autoAdjust){
        
        self->AutoAdjustHomeIndicator = autoAdjust;
        
        return self;
    };
}

/** 设置是否填充底部 iPhone X homeIndicator 默认YES */
- (JKAlertView *(^)(BOOL fillHomeIndicator))setFillHomeIndicator{
    
    return ^(BOOL fillHomeIndicator){
        
        if (!self->JKAlertIsIphoneX) { return self; }
        
        self->FillHomeIndicator = fillHomeIndicator;
        
        return self;
    };
}

/** 设置是否自动适配 iPhone X homeIndicator 默认YES
 - (JKAlertView *(^)(BOOL autoAdjust))setAutoLandscapeNotch{
 
 return ^(BOOL autoAdjust){
 
 if (!JKAlertIsIphoneX) { return self; }
 
 self->_iPhoneXLandscapeTextMargin = autoAdjust ? 44 : 0;
 
 return self;
 };
 } */

/**
 * 设置是否显示pageControl
 * 如果只有一组collection，则必须设置分页为YES才有效
 * 如果有两组collection，则仅在分页和合体都为YES时才有效
 * 注意自己计算好每页显示的个数相等
 * 可以添加空的action来保证每页显示个数相等
 * JKAlertAction使用类方法初始化时每个参数传nil或者直接自己实例化一个即为空action
 */
- (JKAlertView *(^)(BOOL showPageControl))setShowPageControl{
    
    return ^(BOOL showPageControl){
        
        self.showPageControl = showPageControl;
        
        return self;
    };
}

/**
 * 设置pageControl
 * 必须setShowPageControl为YES之后才会有值
 */
- (JKAlertView *(^)(void (^)(UIPageControl *pageControl)))setCollectionPageControlConfig{
    
    return ^(void (^pageControlConfig)(UIPageControl *pageControl)){
        
        if (self.showPageControl) {
            
            !pageControlConfig ? : pageControlConfig(self.pageControl);
        }
        
        return self;
    };
}
//@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionPageControlConfig)(void(^)(UIPageControl *pageControl))

/**
 * 设置HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
- (JKAlertView *(^)(CGFloat dismissTimeInterval))setDismissTimeInterval{
    
    return ^(CGFloat dismissTimeInterval){
        
        self.dismissTimeInterval = dismissTimeInterval;
        
        return self;
    };
}

/**
 * 设置HUD样式centerY的偏移
 * 正数表示向下偏移，负数表示向上偏移
 */
- (JKAlertView *(^)(CGFloat centerOffsetY))setPlainCenterOffsetY{
    
    return ^(CGFloat centerOffsetY){
        
        self.plainCenterOffsetY = centerOffsetY;
        
        return self;
    };
}

/**
 * 设置plain样式Y值
 */
- (JKAlertView *(^)(CGFloat Y, BOOL animated))setPlainY{
    
    return ^(CGFloat Y, BOOL animated){
        
        CGRect frame = self->_plainView.frame;
        frame.origin.y = Y;
        
        if (animated) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self->_plainView.frame = frame;
            }];
            
        } else {
            
            self->_plainView.frame = frame;
        }
        
        return self;
    };
}

/**
 * 展示完成后 移动plain和HUD样式centerY
 * 正数表示向下偏移，负数表示向上偏移
 */
- (JKAlertView *(^)(CGFloat centerOffsetY, BOOL animated))movePlainCenterOffsetY{
    
    return ^(CGFloat centerOffsetY, BOOL animated){
        
        if (animated) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self->_plainView.center = CGPointMake(self->_plainView.center.x, self->JKAlertScreenH * 0.5 + self.plainCenterOffsetY + centerOffsetY);
            }];
            
        } else {
            
            self->_plainView.center = CGPointMake(self->_plainView.center.x, self->JKAlertScreenH * 0.5 + self.plainCenterOffsetY + centerOffsetY);
        }
        
        return self;
    };
}

/** 设置是否允许手势退出 仅限sheet样式 */
- (JKAlertView *(^)(BOOL enableGestureDismiss))setEnableGestureDismiss{
    
    return ^(BOOL enableGestureDismiss){
        
        self.enableGestureDismiss = enableGestureDismiss;
        
        return self;
    };
}

/**
 * 设置点击空白处是否消失，plain默认NO，其它YES
 */
- (JKAlertView *(^)(BOOL shouldDismiss))setClickBlankDismiss{
    
    return ^(BOOL shouldDismiss){
        
        self.clickPlainBlankDismiss = shouldDismiss;
        
        return self;
    };
}

/** 设置监听点击空白处的block */
- (JKAlertView * (^)(void(^blankClickBlock)(void)))setBlankClickBlock{
    
    return ^(void(^blankClickBlock)(void)){
        
        self.blankClickBlock = blankClickBlock;
        
        return self;
    };
}

/**
 * 配置弹出视图的容器view，加圆角等
 */
- (JKAlertView *(^)(void (^containerViewConfig)(UIView *containerView)))setContainerViewConfig{
    
    return ^(void (^containerViewConfig)(UIView *containerView)){
        
        self.containerViewConfig = containerViewConfig;
        
        return self;
    };
}

/**
 * 设置plain样式title和messagex上下之间的分隔线是否隐藏，默认YES
 * 当设置为NO时:
 1、setTextViewTopBottomMargini将自动改为title上下间距
 2、setTitleMessageMargin将自动改为message的上下间距
 * leftRightMargin : 分隔线的左右间距
 */
- (JKAlertView *(^)(BOOL separatorHidden, CGFloat leftRightMargin))setPlainTitleMessageSeparatorHidden{
    
    return ^(BOOL separatorHidden, CGFloat leftRightMargin){
        
        self.plainTitleMessageSeparatorHidden = separatorHidden;
        
        self.plainTitleMessageSeparatorMargin = leftRightMargin;
        
        return self;
    };
}

/**
 * 设置plain样式message最小高度 默认0
 * 仅在message != nil时有效
 * 该高度不包括message的上下间距
 */
- (JKAlertView *(^)(CGFloat minHeight))setMessageMinHeight{
    
    return ^(CGFloat minHeight){
        
        self.messageMinHeight = minHeight;
        
        return self;
    };
}

/** 设置plain样式关闭按钮 */
- (JKAlertView *(^)(void (^)(UIButton *button)))setPlainCloseButtonConfig{
    
    return ^(void (^closeButtonConfig)(UIButton *button)){
        
        !closeButtonConfig ? : closeButtonConfig(self.closeButton);
        
        return self;
    };
}

/**
 * 设置HUD样式高度，不包含customHUD
 * 小于0将没有效果，默认-1
 */
- (JKAlertView *(^)(CGFloat height))setHUDHeight{
    
    return ^(CGFloat height){
        
        self.HUDHeight = height;
        
        return self;
    };
}

/**
 * 设置collection的itemSize的宽度
 * 最大不可超过屏幕宽度的一半
 * 注意图片的宽高是设置的宽度-30，即图片在cell中是左右各15的间距
 * 自动计算item之间间距，最小为0，可自己计算该值设置每屏显示个数
 * 默认的高度是宽度-6，暂不支持自定义高度
 */
- (JKAlertView *(^)(CGFloat width))setFlowlayoutItemWidth{
    
    return ^(CGFloat width){
        
        self.flowlayoutItemWidth = width;
        
        return self;
    };
}

/**
 * 设置collection列数（每行数量）
 * 默认0，自动设置，不得大于自动设置的数量
 */
- (JKAlertView *(^)(NSInteger columnCount))setCollectionColumnCount{
    
    return ^(NSInteger columnCount){
        
        self.collectionColumnCount = columnCount;
        
        return self;
    };
}

/**
 * 设置collection的水平（左右方向）的sectionInset
 * 默认0，为0时自动设置为item间距的一半
 */
- (JKAlertView *(^)(CGFloat inset))setCollectionHorizontalInset{
    
    return ^(CGFloat inset){
        
        self.collectionHorizontalInset = inset;
        
        return self;
    };
}

/** 设置collection的title下分隔线是否隐藏 默认YES */
- (JKAlertView *(^)(BOOL hidden))setCollectionTitleSeperatorHidden{
    
    return ^(BOOL hidden){
        
        self.collectionTitleSeperatorHidden = hidden;
        
        return self;
    };
}

/**
 * 设置两个collectionView之间的间距
 * 有第二个collectionView时有效 默认10, 最小为0
 */
- (JKAlertView *(^)(CGFloat margin))setCollectionViewMargin{
    
    return ^(CGFloat margin){
        
        self.collectionViewMargin = margin < 0 ? 0 : margin;
        
        return self;
    };
}

/**
 * 设置actionSheet样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 * isClearContainerBackgroundColor : 是否让其容器视图透明
 */
- (JKAlertView *(^)(BOOL isClearContainerBackgroundColor, UIView *(^customView)(void)))setCustomActionSheetTitleView{
    
    return ^(BOOL isClearContainerBackgroundColor, UIView *(^customView)(void)){
        
        self.customSheetTitleView = !customView ? nil : customView();
        
        if (isClearContainerBackgroundColor) {
            
            self->_textContainerView.backgroundColor = nil;
        }
        
        return self;
    };
}

/** 设置sheet样式最大高度 默认屏幕高度 * 0.85 */
- (JKAlertView *(^)(CGFloat height))setSheetMaxHeight{
    
    return ^(CGFloat height){
        
        self->JKAlertSheetMaxH = height;
        
        self->SheetMaxHeightSetted = YES;
        
        return self;
    };
};

/**
 * 设置collection样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 */
- (JKAlertView *(^)(UIView *(^customView)(void)))setCustomCollectionTitleView{
    
    return ^(UIView *(^customView)(void)){
        
        self.customSheetTitleView = !customView ? nil : customView();
        
        return self;
    };
}

/**
 * 设置plain样式添加自定义的titleView
 * frame给出高度即可，宽度自适应plain宽度
 * 请将自定义view视为容器view，推荐使用自动布局约束其子控件
 * onlyForMessage : 是否仅放在message位置
 * onlyForMessage如果为YES，有title时，title的上下间距则变为setTextViewTopBottomMargin的值
 */
- (JKAlertView *(^)(BOOL onlyForMessage, UIView *(^customView)(JKAlertView *view)))setCustomPlainTitleView{
    
    return ^(BOOL onlyForMessage, UIView *(^customView)(JKAlertView *view)){
        
        self.customPlainTitleViewOnlyForMessage = onlyForMessage;
        
        self.customPlainTitleView = !customView ? nil : customView(self);
        
        return self;
    };
}

/**
 * 设置plain样式title和message之间的间距 默认7
 * setPlainTitleMessageSeparatorHidden为NO时，该值表示message的上下间距
 * plain样式下setCustomPlainTitleView onlyForMessage为YES时，该值无影响
 */
- (JKAlertView *(^)(CGFloat margin))setTitleMessageMargin{
    
    return ^(CGFloat margin){
        
        self->JKAlertTitleMessageMargin = margin;
        
        return self;
    };
}

/**
 * 设置背景view
 * 默认是一个UIVisualEffectView的UIBlurEffectStyleExtraLight效果
 */
- (JKAlertView *(^)(UIView *(^backGroundView)(void)))setBackGroundView{
    
    return ^(UIView *(^backGroundView)(void)){
        
        self.backGroundView = !backGroundView ? nil : backGroundView();
        
        if (self.alertStyle == JKAlertStyleCollectionSheet) {
            
            self.collectionTopContainerView.backgroundColor = (self.backGroundView ? nil : JKALertGlobalBackgroundColor());
        }
        
        return self;
    };
}

/** 设置全屏背景是否透明，默认黑色 0.4 alpha */
- (JKAlertView *(^)(BOOL isClearFullScreenBackgroundColor))setClearFullScreenBackgroundColor{
    
    return ^(BOOL isClearFullScreenBackgroundColor){
        
        self.isClearFullScreenBackgroundColor = isClearFullScreenBackgroundColor;
        
        return self;
    };
}

/**
 * 设置全屏背景view 默认无
 */
- (JKAlertView *(^)(UIView *(^backGroundView)(void)))setFullScreenBackGroundView{
    
    return ^(UIView *(^backGroundView)(void)){
        
        self.fullScreenBackGroundView = !backGroundView ? nil : backGroundView();
        
        return self;
    };
}

/**
 * 设置是否使JKAlertView.dismissAll(); 对当前JKAlertView无效
 * 请谨慎使用，若设置为YES 调用JKAlertView.dismissAll(); 将对当前JKAlertView无效
 */
- (JKAlertView *(^)(BOOL isNoneffective))setDismissAllNoneffective{
    
    return ^(BOOL isNoneffective){
        
        self.isDismissAllNoneffective = isNoneffective;
        
        return self;
    };
}

/**
 * 设置用于通知消失的key
 * 设置该值后可以使用类方法 JKAlertView.DismissForKey(dismissKey); 来手动消失
 */
- (JKAlertView *(^)(NSString *dismissKey))setDismissKey{
    
    return ^(NSString *dismissKey){
        
        self.dismissKey = dismissKey;
        
        return self;
    };
}

/**
 * 设置自定义展示动画，动画完成一定要调用showAnimationDidComplete
 * 此时所有frame已经计算好，plain样式animationView在中间，sheet样式animationView在底部
 */
- (JKAlertView *(^)(void (^)(JKAlertView *view, UIView *animationView)))setCustomShowAnimationBlock{
    
    return ^(void (^showAnimationBlock)(JKAlertView *view, UIView *animationView)){
        
        self.customShowAnimationBlock = showAnimationBlock;
        
        return self;
    };
}

/** 设置自定义消失动画 */
- (JKAlertView *(^)(void (^)(JKAlertView *view, UIView *animationView)))setCustomDismissAnimationBlock{
    
    return ^(void (^dismissAnimationBlock)(JKAlertView *view, UIView *animationView)){
        
        self.customDismissAnimationBlock = dismissAnimationBlock;
        
        return self;
    };
}

#pragma mark - 监听屏幕旋转------------------------

- (void)orientationChanged:(NSNotification *)noti{
    
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, JKAlertCurrentHomeIndicatorHeight, 0);
    
    if (_alertStyle == JKAlertStyleCollectionSheet) {
        
        _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, JKAlertAdjustHomeIndicatorHeight, 0);
    }
    
    !self.orientationChangeBlock ? : self.orientationChangeBlock(self, [UIApplication sharedApplication].statusBarOrientation);
    
    [self updateWidthHeight];
    
    [self calculateUI];
}

- (void)updateWidthHeight{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    
    UIView *superView = self.superview ? self.superview : keyWindow;
    
    switch ([UIApplication sharedApplication].statusBarOrientation){
        case UIInterfaceOrientationPortrait:{
            
            //orientationLabel.text = "面向设备保持垂直，Home键位于下部"
            
            /** 屏幕宽度 */
            //JKAlertScreenW = MIN(superView.bounds.size.width, superView.bounds.size.height);
            /** 屏幕高度 */
            //JKAlertScreenH = MAX(superView.bounds.size.width, superView.bounds.size.height);
            
            _isLandScape = NO;
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:{
            
            //orientationLabel.text = "面向设备保持垂直，Home键位于上部"
            
            /** 屏幕宽度 */
            //JKAlertScreenW = MIN(superView.bounds.size.width, superView.bounds.size.height);
            /** 屏幕高度 */
            //JKAlertScreenH = MAX(superView.bounds.size.width, superView.bounds.size.height);
            
            _isLandScape = NO;
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            
            //orientationLabel.text = "面向设备保持水平，Home键位于左侧"
            
            /** 屏幕宽度 */
            //JKAlertScreenW = MAX(superView.bounds.size.width, superView.bounds.size.height);
            /** 屏幕高度 */
            //JKAlertScreenH = MIN(superView.bounds.size.width, superView.bounds.size.height);
            
            _isLandScape = YES;
            
            _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, -34, JKAlertCurrentHomeIndicatorHeight, 34);
            
            if (_alertStyle == JKAlertStyleCollectionSheet) {
                
                _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, -34, JKAlertCurrentHomeIndicatorHeight, 34);
            }
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            
            //orientationLabel.text = "面向设备保持水平，Home键位于右侧"
            
            /** 屏幕宽度 */
            //JKAlertScreenW = MAX(superView.bounds.size.width, superView.bounds.size.height);
            /** 屏幕高度 */
            //JKAlertScreenH = MIN(superView.bounds.size.width, superView.bounds.size.height);
            
            _isLandScape = YES;
        }
            break;
        default:{
            
            // orientationLabel.text = "方向未知"
        }
            break;
    }
    /** 屏幕宽度 */
    JKAlertScreenW = superView.bounds.size.width;//MIN(superView.bounds.size.width, superView.bounds.size.height);
    /** 屏幕高度 */
    JKAlertScreenH = superView.bounds.size.height;//MAX(superView.bounds.size.width, superView.bounds.size.height);
    
    [self updateMaxHeight];
}

- (void)updateMaxHeight{
    
    JKAlertPlainViewMaxH = (JKAlertScreenH - 100);
    
    if (!SheetMaxHeightSetted) {
        
        JKAlertSheetMaxH = (JKAlertScreenH > JKAlertScreenW) ? JKAlertScreenH * 0.85 : JKAlertScreenH * 0.8;
    }
    
    textContainerViewCurrentMaxH_ = (JKAlertScreenH - 100 - JKAlertButtonH * 4);
}

#pragma mark - 添加action------------------------

/** 添加action */
- (JKAlertView *(^)(JKAlertAction *action))addAction{
    
    return ^(JKAlertAction *action){
        
        [self addAction:action];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(JKAlertAction *action))removeAction{
    
    return ^(JKAlertAction *action){
        
        [self removeAction:action];
        
        return self;
    };
}

/** 链式添加action */
- (JKAlertView *(^)(JKAlertAction *action, NSUInteger atIndex))insertAction{
    
    return ^(JKAlertAction *action, NSUInteger atIndex){
        
        [self insertAction:action atIndex:atIndex];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(NSUInteger index))removeActionAtIndex{
    
    return ^(NSUInteger index){
        
        [self removeActionAtIndex:index];
        
        return self;
    };
}

/** 链式获取action */
- (JKAlertView *(^)(NSUInteger index, void(^)(JKAlertAction *action)))getActionAtIndex{
    
    return ^(NSUInteger index, void(^getAction)(JKAlertAction *action)){
        
        JKAlertAction *action = [self getActionAtIndex:index];
        
        !getAction ? : getAction(action);
        
        return self;
    };
}

/** 添加第二个collectionView的action */
- (JKAlertView *(^)(JKAlertAction *action))addSecondCollectionAction{
    
    return ^(JKAlertAction *action){
        
        [self addSecondCollectionAction:action];
        
        return self;
    };
}


/** collection链式添加第二个collectionView的action */
- (JKAlertView *(^)(JKAlertAction *action, NSUInteger atIndex))insertSecondCollectionAction{
    
    return ^(JKAlertAction *action, NSUInteger atIndex){
        
        [self insertSecondCollectionAction:action atIndex:atIndex];
        
        return self;
    };
}

/** 添加action */
- (void)addAction:(JKAlertAction *)action{
    
    if (!action) { return; }
    
    action.alertView = self;
    
    [self.actions addObject:action];
}

/** 移除action */
- (void)removeAction:(JKAlertAction *)action{
    
    if (!action || ![self.actions containsObject:action]) { return; }
    
    [self.actions removeObject:action];
}

/** 添加action */
- (void)insertAction:(JKAlertAction *)action atIndex:(NSUInteger)index{
    
    if (!action) { return; }
    
    action.alertView = self;
    
    [self.actions insertObject:action atIndex:index];
}

/** 移除action */
- (void)removeActionAtIndex:(NSUInteger)index{
    
    if (index < 0 || index >= self.actions.count) { return; }
    
    [self.actions removeObjectAtIndex:index];
}

/** 获取action */
- (JKAlertAction *)getActionAtIndex:(NSUInteger)index{
    
    if (index < 0 || index >= self.actions.count) { return nil; }
    
    JKAlertAction *action = [self.actions objectAtIndex:index];
    
    return action;
}

/** 添加第二个collectionView的action */
- (void)addSecondCollectionAction:(JKAlertAction *)action{
    
    if (!action) { return; }
    
    action.alertView = self;
    
    [self.actions2 addObject:action];
}

/** 添加第二个collectionView的action */
- (void)insertSecondCollectionAction:(JKAlertAction *)action atIndex:(NSUInteger)index{
    
    if (!action) { return; }
    
    action.alertView = self;
    
    [self.actions2 insertObject:action atIndex:index];
}


#pragma mark - action数组操作

/** 添加action */
- (JKAlertView *(^)(JKAlertAction *action, BOOL isSecondCollection))addActionTo{
    
    return ^(JKAlertAction *action, BOOL isSecondCollection) {
        
        [self addAction:action isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(JKAlertAction *action, BOOL isSecondCollection))removeActionFrom{
    
    return ^(JKAlertAction *action, BOOL isSecondCollection) {
        
        [self removeAction:action isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式添加action */
- (JKAlertView *(^)(JKAlertAction *action, NSUInteger atIndex, BOOL isSecondCollection))insertActionTo{
    
    return ^(JKAlertAction *action, NSUInteger atIndex, BOOL isSecondCollection) {
        
        [self insertAction:action atIndex:atIndex isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(NSUInteger index, BOOL isSecondCollection))removeActionAtIndexFrom{
    
    return ^(NSUInteger index, BOOL isSecondCollection) {
        
        [self removeActionAtIndex:index isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式获取action */
- (JKAlertView *(^)(NSUInteger index, BOOL isSecondCollection, void(^)(JKAlertAction *action)))getActionAtIndexFrom{
    
    return ^(NSUInteger index, BOOL isSecondCollection, void(^getAction)(JKAlertAction *action)) {
        
        JKAlertAction *action = [self getActionAtIndex:index isSecondCollection:isSecondCollection];
        
        !getAction ? : getAction(action);
        
        return self;
    };
}

/** 链式获取action数组 */
- (JKAlertView *(^)(BOOL isSecondCollection, void(^)(NSArray *actionArray)))getActionArrayFrom{
    
    return ^(BOOL isSecondCollection, void(^getActionArray)(NSArray *actionArray)) {
        
        !getActionArray ? : getActionArray([self getActionArrayIsSecondCollection:isSecondCollection]);
        
        return self;
    };
}

/** 链式清空action数组 */
- (JKAlertView *(^)(BOOL isSecondCollection))clearActionArrayFrom{
    
    return ^(BOOL isSecondCollection) {
        
        [self clearActionArrayIsSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 添加action */
- (void)addAction:(JKAlertAction *)action isSecondCollection:(BOOL)isSecondCollection{
    
    if (!action) { return; }
    
    action.alertView = self;
    
    if (isSecondCollection) {
        
        [self.actions2 addObject:action];
        
    } else {
        
        [self.actions addObject:action];
    }
}

/** 移除action */
- (void)removeAction:(JKAlertAction *)action isSecondCollection:(BOOL)isSecondCollection{
    
    if (!action) { return; }
    
    if (isSecondCollection) {
        
        if ([self.actions2 containsObject:action]) {
            
            [self.actions2 removeObject:action];
        }
        
    } else {
        
        if ([self.actions containsObject:action]) {
            
            [self.actions removeObject:action];
        }
    }
}

/** 添加action */
- (void)insertAction:(JKAlertAction *)action atIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection{
    
    if (!action) { return; }
    
    action.alertView = self;
    
    if (isSecondCollection) {
        
        [self.actions2 insertObject:action atIndex:index];
        
    } else {
        
        [self.actions insertObject:action atIndex:index];
    }
}

/** 移除action */
- (void)removeActionAtIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection{
    
    if (index < 0) { return; }
    
    if (isSecondCollection) {
        
        if (index >= self.actions2.count) { return; }
        
        [self.actions2 removeObjectAtIndex:index];
        
    } else {
        
        if (index >= self.actions.count) { return; }
        
        [self.actions removeObjectAtIndex:index];
    }
}

/** 获取action */
- (JKAlertAction *)getActionAtIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection{
    
    if (index < 0) { return nil; }
    
    JKAlertAction *action = nil;
    
    if (isSecondCollection) {
        
        if (index >= self.actions2.count) { return nil; }
        
        action = [self.actions2 objectAtIndex:index];
        
    } else {
        
        if (index >= self.actions.count) { return nil; }
        
        action = [self.actions objectAtIndex:index];
    }
    
    return action;
}

/** 获取action数组 */
- (NSArray *)getActionArrayIsSecondCollection:(BOOL)isSecondCollection{
    
    if (isSecondCollection) {
        
        return [self.actions2 copy];
        
    } else {
        
        return [self.actions copy];
    }
}

/** 清空action数组 */
- (void)clearActionArrayIsSecondCollection:(BOOL)isSecondCollection{
    
    if (isSecondCollection) {
        
        [_actions2 removeAllObjects];
        
    } else {
        
        [_actions removeAllObjects];
    }
}



#pragma mark - 添加textField

/**
 * 添加textField 默认高度30
 * textField之间的间距是1，和其superView的上下左右间距也是1
 * textField可以直接对其superView进行一些属性修改，如背景色
 * block中的参数view用于调用dismiss()来移除当前弹框
 */
- (void)addTextFieldWithConfigurationHandler:(void (^)(JKAlertView *view, UITextField *textField))configurationHandler{
    
    UITextField *tf = [[UITextField alloc] init];
    
    tf.backgroundColor = JKALertGlobalBackgroundColor();
    
    if (_textFieldContainerView == nil) {
        
        UIView *textFieldContainerView = [[UIView alloc] init];
        textFieldContainerView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];//[[UIColor blackColor] colorWithAlphaComponent:0.15];//nil;
        _textFieldContainerView = textFieldContainerView;
        [_plainTextContainerScrollView addSubview:_textFieldContainerView];
    }
    
    [self.textFieldArr addObject:tf];
    
    [_textFieldContainerView addSubview:tf];
    
    if (self.currentTextField == nil) {
        
        self.currentTextField = tf;
    }
    
    !configurationHandler ? : configurationHandler(self, tf);
}

/**
 * 链式添加textField 默认高度30
 * textField之间的间距是1，和其superView的上下左右间距也是1
 * textField可以直接对其superView进行一些属性修改，如背景色
 * block中的参数view用于调用dismiss()来移除当前弹框
 */
- (JKAlertView *(^)(void (^)(JKAlertView *view, UITextField *textField)))addTextFieldWithConfigurationHandler{
    
    return ^(void (^configurationHandler)(JKAlertView *view, UITextField *textField)){
        
        [self addTextFieldWithConfigurationHandler:configurationHandler];
        
        return self;
    };
}

#pragma mark - 显示------------------------

/** 显示 */
- (id<JKAlertViewProtocol>(^)(void))show{
    
    if (_textFieldArr.count <= 0) {
        
        [[UIApplication sharedApplication].delegate.window endEditing:YES];
    }
    
    if (Showed) {
        
        return ^{
            
            return self;
        };
    }
    
    Showed = YES;
    
    switch (self.alertStyle) {
        case JKAlertStylePlain:
        {
            [self showPlain];
        }
            break;
            
        case JKAlertStyleActionSheet:
        {
            [self showAcitonSheet];
        }
            break;
            
        case JKAlertStyleCollectionSheet:
        {
            [self showCollectionSheet];
        }
            break;
            
        case JKAlertStyleHUD:
        {
            [self showPlain];
        }
            break;
            
        default:
            break;
    }
    
    !self.containerViewConfig ? : self.containerViewConfig(_plainView ? _plainView : _sheetContainerView);
    
    if (self.customSuperView != nil) {
        
        [self.customSuperView addSubview:self];
        
    } else {
        
        [[UIApplication sharedApplication].delegate.window addSubview:self];
    }
    
    return ^{
        
        return self;
    };
}

/** 监听JKAlertView显示动画完成 */
- (id<JKAlertViewProtocol>(^)(void(^showAnimationComplete)(JKAlertView *view)))setShowAnimationComplete{
    
    return ^(void(^showAnimationComplete)(JKAlertView *view)){
        
        self.showAnimationCompleteHandler = showAnimationComplete;
        
        return self;
    };
}

/** 监听屏幕旋转 */
- (JKAlertView * (^)(void(^orientationChangeBlock)(JKAlertView *view, UIInterfaceOrientation orientation)))setOrientationChangeBlock{
    
    return ^(void(^orientationChangeBlock)(JKAlertView *view, UIInterfaceOrientation orientation)){
        
        self.orientationChangeBlock = orientationChangeBlock;
        
        return self;
    };
}

/** 设置监听superView尺寸改变时将要自适应的block */
- (JKAlertView *(^)(void(^willAdaptBlock)(JKAlertView *view, UIView *containerView)))setWillAutoAdaptSuperViewBlock{
    
    return ^JKAlertView *(void(^willAdaptBlock)(JKAlertView *view, UIView *containerView)){
        
        self.willAdaptBlock = willAdaptBlock;
        
        return self;
    };
}

/** 设置监听superView尺寸改变时自适应完成的block */
- (JKAlertView *(^)(void(^didAdaptBlock)(JKAlertView *view, UIView *containerView)))setDidAutoAdaptSuperViewBlock{
    
    return ^JKAlertView *(void(^didAdaptBlock)(JKAlertView *view, UIView *containerView)){
        
        self.didAdaptBlock = didAdaptBlock;
        
        return self;
    };
}

/** 显示并监听JKAlertView消失动画完成 */
- (void(^)(void(^dismissComplete)(void)))showWithDismissComplete{
    
    return ^(void(^dismissComplete)(void)){
        
        [self show];
        
        self.didDismissHandler = dismissComplete;
    };
}

/** 监听JKAlertView即将消失 */
- (id<JKAlertViewProtocol> (^)(void(^willDismiss)(void)))setWillDismiss{
    
    return ^id<JKAlertViewProtocol> (void(^willDismiss)(void)){
        
        self.willDismissHandler = willDismiss;
        
        return self;
    };
}

/** 监听JKAlertView消失动画完成 */
- (id<JKAlertViewProtocol> (^)(void(^dismissComplete)(void)))setDismissComplete{
    
    return ^(void(^dismissComplete)(void)){
        
        self.didDismissHandler = dismissComplete;
        
        return self;
    };
}

/** 设置dealloc时会调用的block */
- (void(^)(void(^deallocBlock)(void)))setDeallocBlock{
    
    return ^(void(^deallocBlock)(void)){
        
        self.deallocBlock = deallocBlock;
    };
}

// plain样式 alert
- (void)showPlain{
    
    if (_alertStyle == JKAlertStyleHUD) {
        
        [self calculateUI];
        
        [_scrollView removeFromSuperview];
        
        return;
    }
    
    [self calculateUI];
}

// sheet样式
- (void)showAcitonSheet{
    
    if (!self.cancelAction) {
        
        self.cancelAction = [JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {}];
        self.cancelAction.setTitleFont([UIFont systemFontOfSize:17]);
        self.cancelAction.setTitleColor(JKALertAdaptColor(JKAlertSameRGBColor(51), JKAlertSameRGBColor(204)));
    }
    
    self.cancelAction.setSeparatorLineHidden(YES);
    [self.actions.lastObject setSeparatorLineHidden:YES];
    
    [self calculateUI];
}

// collectionSheet样式
- (void)showCollectionSheet{
    
    if (!self.cancelAction) {
        
        self.cancelAction = [JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {}];
        self.cancelAction.setTitleFont([UIFont systemFontOfSize:17]);
        self.cancelAction.setTitleColor(JKALertAdaptColor(JKAlertSameRGBColor(51), JKAlertSameRGBColor(204)));
    }
    
    [self calculateUI];
}

- (void)adjustButton:(UIButton *)button action:(JKAlertAction *)action{
    
    if (action.customView) {
        
        [button addSubview:action.customView];
        
        // 有customViewm，清空文字
        [button setTitle:nil forState:(UIControlStateNormal)];
        [button setAttributedTitle:nil forState:(UIControlStateNormal)];
        
        return;
    }
    
    if (action.title) {
        
        [button setTitle:action.title forState:(UIControlStateNormal)];
    }
    
    if (action.attributedTitle) {
        
        [button setAttributedTitle:action.attributedTitle forState:(UIControlStateNormal)];
    }
    
    if (action.titleColor == nil) {
        
        switch (action.alertActionStyle) {
            case JKAlertActionStyleDefault:
                
                action.setTitleColor((_alertStyle == JKAlertStylePlain ? JKAlertSystemBlueColor : JKALertAdaptColor(JKAlertSameRGBColor(51), JKAlertSameRGBColor(204))));
                break;
                
            case JKAlertActionStyleCancel:
                
                action.setTitleColor(JKALertAdaptColor(JKAlertSameRGBColor(153), JKAlertSameRGBColor(102)));
                break;
                
            case JKAlertActionStyleDestructive:
                
                action.setTitleColor(JKAlertSystemRedColor);
                break;
                
            default:
                break;
        }
    }
    
    if (action.titleFont == nil) {
        
        action.setTitleFont([UIFont systemFontOfSize:17]);
    }
    
    button.titleLabel.font = action.titleFont;
    [button setTitleColor:action.titleColor forState:(UIControlStateNormal)];
    [button setTitleColor:[action.titleColor colorWithAlphaComponent:0.5] forState:(UIControlStateHighlighted)];
    
    if (action.normalImage) {
        
        [button setImage:action.normalImage forState:(UIControlStateNormal)];
    }
    
    if (action.hightlightedImage) {
        
        [button setImage:action.hightlightedImage forState:(UIControlStateHighlighted)];
    }
}

#pragma mark - 计算frame------------------------------------

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];

    if (@available(iOS 13.0, *)) {
        
        if ([self.backGroundView isKindOfClass:[UIVisualEffectView class]]) {
            
            BOOL isLight = (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight);
            
            [(UIVisualEffectView *)self.backGroundView setEffect:[UIBlurEffect effectWithStyle:isLight ? UIBlurEffectStyleExtraLight : UIBlurEffectStyleDark]];
        }
    }
    
    /* 判断当前的SizeClass,如果为width compact&height regular 则说明正在分屏
     BOOL isTrait = (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) &&
     (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular);
     
     if (isTrait) {
     
     NSLog(@"正在分屏");
     
     } else {
     
     NSLog(@"取消分屏");
     } //*/
}

- (void)calculateUI{
    
    self.frame = CGRectMake(0, 0, JKAlertScreenW, JKAlertScreenH);
    
    if (_customHUD) {
        
        [self layoutCustomHUD];
        
        return;
    }
    
    _titleTextView.textAlignment = self.titleTextViewAlignment;
    _messageTextView.textAlignment = self.messageTextViewAlignment;
    
    _titleTextView.userInteractionEnabled = self.textViewUserInteractionEnabled;
    _messageTextView.userInteractionEnabled = self.textViewUserInteractionEnabled;
    
    _titleTextView.canSelectText = self.textViewCanSelectText;
    _messageTextView.canSelectText = self.textViewCanSelectText;
    
    _titleTextView.textColor = titleTextColor ? titleTextColor : _titleTextView.textColor;
    _messageTextView.textColor = messageTextColor ? messageTextColor : _messageTextView.textColor;
    
    _titleTextView.font = titleFont ? titleFont : _titleTextView.font;
    _messageTextView.font = messageFont ? messageFont : _messageTextView.font;
    
    if (self.alertAttributedTitle) {
        
        _titleTextView.attributedText = self.alertAttributedTitle;
        
    } else if (self.alertTitle) {
        
        _titleTextView.text = self.alertTitle;
        
    } else {
        
        _titleTextView.hidden = YES;
    }
    
    if (self.attributedMessage) {
        
        _messageTextView.attributedText = self.attributedMessage;
        
    } else if (self.message) {
        
        _messageTextView.text = self.message;
        
    } else {
        
        _messageTextView.hidden = YES;
    }
    
    if (_alertStyle == JKAlertStyleHUD) {
        
        _messageTextView.hidden = YES;
    }
    
    switch (self.alertStyle) {
        case JKAlertStylePlain:
        {
            [self layoutPlain];
        }
            break;
            
        case JKAlertStyleActionSheet:
        {
            [self layoutActionSheet];
        }
            break;
            
        case JKAlertStyleCollectionSheet:
        {
            [self layoutCollectionSheet];
        }
            break;
            
        case JKAlertStyleHUD:
        {
            [self layoutPlain];
        }
            break;
            
        default:
            break;
    }
    
    [self calculateUIFinish];
}

- (void)calculateUIFinish{
    
    [_tableView reloadData];
    
    [_collectionView reloadData];
    
    [_collectionView2 reloadData];
    
    [_tableView setContentOffset:CGPointMake(_tableView.contentOffset.x, lastTableViewOffsetY) animated:YES];
}

#pragma mark - 布局plain
- (void)layoutPlain{
    
    if (self.autoReducePlainWidth) {
        
        UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
        
        UIView *superView = self.superview ? self.superview : keyWindow;
        
        CGFloat safeAreaInset = 0;
        
        if (@available(iOS 11.0, *)) {
            
            safeAreaInset = MAX(superView.safeAreaInsets.left, superView.safeAreaInsets.right);;
        }
        
        PlainViewWidth = MIN(OriginalPlainWidth, JKAlertScreenW - safeAreaInset * 2);
    }
    
    _plainView.frame = CGRectMake((JKAlertScreenW - PlainViewWidth) * 0.5, (JKAlertScreenH - 200) * 0.5, PlainViewWidth, 200);
    _textContainerView.frame = CGRectMake(0, 0, PlainViewWidth, TBMargin + JKAlertMinTitleLabelH + JKAlertTitleMessageMargin + JKAlertMinMessageLabelH + TBMargin);
    
    NSInteger count = self.actions.count;
    
    [self.titleTextView calculateFrameWithMaxWidth:PlainViewWidth - self.textViewLeftRightMargin * 2 minHeight:JKAlertMinTitleLabelH originY:TBMargin superView:self.textContainerView];
    
    CGFloat messageOriginY = CGRectGetMaxY(self.titleTextView.frame) + (_plainTitleMessageSeparatorHidden ? JKAlertTitleMessageMargin : TBMargin + JKAlertTitleMessageMargin);
    
    if (!_plainTitleMessageSeparatorHidden) {
        
        _plainTitleMessageSeparatorView.frame = CGRectMake(_plainTitleMessageSeparatorMargin, messageOriginY - JKAlertTitleMessageMargin - JKAlertSeparatorLineWH, PlainViewWidth - _plainTitleMessageSeparatorMargin * 2, JKAlertSeparatorLineWH);
    }
    
    [self.messageTextView calculateFrameWithMaxWidth:PlainViewWidth - self.textViewLeftRightMargin * 2 minHeight:JKAlertMinMessageLabelH originY:messageOriginY superView:self.textContainerView];
    
    CGRect rect = self.textContainerView.frame;
    
    rect.size.height = TBMargin + self.titleTextView.frame.size.height + JKAlertTitleMessageMargin + self.messageTextView.frame.size.height + TBMargin;
    
    rect.size.height += (_plainTitleMessageSeparatorHidden ? 0 : (JKAlertTitleMessageMargin));
    
    if (self.titleTextView.hidden && self.messageTextView.hidden) {
        
        _plainTitleMessageSeparatorView.hidden = YES;
        
        rect.size.height = 0;
        
    } else if (self.titleTextView.hidden && !self.messageTextView.hidden) {
        
        _plainTitleMessageSeparatorView.hidden = YES;
        
        self.messageTextView.frame = CGRectMake((PlainViewWidth - self.messageTextView.frame.size.width) * 0.5, 0, self.messageTextView.frame.size.width, self.messageTextView.frame.size.height);
        
        rect.size.height = TBMargin + self.messageTextView.frame.size.height + TBMargin;
        
        self.messageTextView.center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
        
        _messageMinHeight = (_messageMinHeight == -1 ? 30 : _messageMinHeight);
        
    } else if (self.messageTextView.hidden && !self.titleTextView.hidden) {
        
        self.titleTextView.frame = CGRectMake((PlainViewWidth - self.titleTextView.frame.size.width) * 0.5, 0, self.titleTextView.frame.size.width, self.titleTextView.frame.size.height);
        
        CGFloat titleH = (self.titleTextView.frame.size.height < 30 ? 30 : self.titleTextView.frame.size.height);
        
        titleH = (!_plainTitleMessageSeparatorHidden || (_customPlainTitleView != nil && _customPlainTitleViewOnlyForMessage)) ? self.titleTextView.frame.size.height : titleH;
        
        rect.size.height = TBMargin + self.titleTextView.frame.size.height + TBMargin;
        self.titleTextView.center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    }
    
    if (!_messageTextView.hidden && _messageTextView.frame.size.height < _messageMinHeight) {
        
        CGFloat delta = (_messageMinHeight - _messageTextView.frame.size.height);
        
        rect.size.height += delta;
        
        CGRect messageFrame = _messageTextView.frame;
        messageFrame.origin.y += (delta * 0.5);
        _messageTextView.frame = messageFrame;
    }
    
    // 自定义
    if (_customPlainTitleView) {
        
        rect.size.height = _customPlainTitleView.frame.size.height;
        _customPlainTitleView.frame = rect;
        
        if (_customPlainTitleViewOnlyForMessage && !_titleTextView.hidden) {
            
            rect.size.height += (TBMargin + _titleTextView.frame.size.height + TBMargin);
            
            _customPlainTitleView.frame = CGRectMake(0, TBMargin + _titleTextView.frame.size.height + TBMargin, rect.size.width, _customPlainTitleView.frame.size.height);
        }
        
        _plainTextContainerScrollView.contentSize = rect.size;
    }
    
    if (_textFieldArr.count > 0) {
        
        CGFloat tfH = 0;
        
        for (UITextField *tf in _textFieldArr) {
            
            tfH += 1;
            
            CGRect tfFrame = tf.frame;
            
            tfFrame.origin.x = 1;//JKAlertSeparatorLineWH;
            tfFrame.origin.y = tfH;
            tfFrame.size.width = PlainViewWidth - self.textViewLeftRightMargin * 2 - 2;//JKAlertSeparatorLineWH * 2;
            tfFrame.size.height = tfFrame.size.height ? tfFrame.size.height : 30;
            tf.frame = tfFrame;
            
            tfH += (tfFrame.size.height);
        }
        
        tfH += 1;//JKAlertSeparatorLineWH;
        
        _textFieldContainerView.frame = CGRectMake(self.textViewLeftRightMargin, rect.size.height, PlainViewWidth - self.textViewLeftRightMargin * 2, tfH);
        
        rect.size.height += tfH;
        
        rect.size.height += TBMargin;
    }
    
    self.textContainerView.frame = rect;
    
    self.plainTextContainerScrollView.contentSize = rect.size;
    
    [self layoutPlainButtons];
    
    CGFloat H = 0;
    
    for (NSInteger i = 0; i < count; i++) {
        
        H += [self.scrollView viewWithTag:JKAlertPlainButtonBeginTag + i].frame.size.height;
    }
    
    H = (count == 2 ? [self.scrollView viewWithTag:JKAlertPlainButtonBeginTag].frame.size.height : H);
    
    rect = CGRectMake(0, CGRectGetMaxY(self.textContainerView.frame), self.plainView.frame.size.width, H);
    self.scrollView.contentSize = rect.size;
    self.scrollView.frame = rect;
    
    [self adjustPlainViewFrame];
    
    rect = self.plainView.frame;
    rect.size.height = self.textContainerView.frame.size.height + self.scrollView.frame.size.height;
    self.plainView.frame = rect;
    
    self.plainView.center = CGPointMake(JKAlertScreenW * 0.5, JKAlertScreenH * 0.5 + self.plainCenterOffsetY);
    
    if (_textContainerBottomLineView.hidden) { return; }
    
    _textContainerBottomLineView.frame = CGRectMake(0, self.textContainerView.frame.size.height - JKAlertSeparatorLineWH, self.textContainerView.frame.size.width, JKAlertSeparatorLineWH);
    
    _textContainerBottomLineView.hidden = (self.textContainerView.frame.size.height <= 0 || self.scrollView.frame.size.height <= 0);
    
    if (_HUDHeight > 0) {
        
        CGRect rect = _plainView.frame;
        rect.size.height = _HUDHeight;
        _plainView.frame = rect;
        
        _textContainerView.center = CGPointMake(_plainView.frame.size.width * 0.5, _plainView.frame.size.height * 0.5);
        
        _plainView.center = CGPointMake(JKAlertScreenW * 0.5, JKAlertScreenH * 0.5 + _plainCenterOffsetY);
    }
}

- (void)layoutPlainButtons{
    
    NSInteger count = self.actions.count;
    
    if (count == 0) {
        
        if (!self.cancelAction) {
            
            self.cancelAction = [JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {}];
        }
        
        [self addAction:self.cancelAction];
        
        count = 1;
    }
    
    for (NSInteger i = 0; i < count; i++) {
        
        CGFloat X = (count == 2 ? i * PlainViewWidth * 0.5 : 0);
        CGFloat Y = (count == 2 ? 0 : (i == 0 ? 0 : CGRectGetMaxY([self.scrollView viewWithTag:JKAlertPlainButtonBeginTag + i - 1].frame)));
        CGFloat W = (count == 2 ? PlainViewWidth * 0.5 : PlainViewWidth);
        
        JKAlertAction *action = self.actions[i];
        
        JKAlertSeparatorLayerButton *button = [self.scrollView viewWithTag:JKAlertPlainButtonBeginTag + i];
        
        if (!button) {
            
            button = [JKAlertSeparatorLayerButton buttonWithType:(UIButtonTypeCustom)];
            [self.scrollView addSubview:button];
            
            //[button setBackgroundImage:JKAlertCreateImageWithColor([UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1], 1, 1, 0) forState:(UIControlStateHighlighted)];
            
            [button addTarget:self action:@selector(plainButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            
            button.tag = JKAlertPlainButtonBeginTag + i;
        }
        
        button.frame = CGRectMake(X, Y, W, JKAlertButtonH);
        
        [self adjustButton:button action:action];
        
        if ([action customView] != nil) {
            
            button.frame = CGRectMake(X, Y, W, [action customView].frame.size.height);
            
            [action customView].frame = button.bounds;
        }
        
        if (i == 0) {
            
            _textContainerBottomLineView.hidden = action.separatorLineHidden;
        }
        
        if (i == 1 && count == 2) {
            
            button.frame = CGRectMake(X, Y, W, [self.scrollView viewWithTag:JKAlertPlainButtonBeginTag].frame.size.height);
        }
        
        if (action.separatorLineHidden) {
            continue;
        }
        
        if (count == 2 && i == 1) {
            
            if (action.separatorLineHidden) { continue; }
            
            if (!self.plainButtonVLineView) {
                
                UIView *vline = [UIView new];
                [button addSubview:vline];
                vline.backgroundColor = JKALertAdaptColor([[UIColor blackColor] colorWithAlphaComponent:0.2], [[UIColor whiteColor] colorWithAlphaComponent:0.2]);
                self.plainButtonVLineView = vline;
            }
            
            self.plainButtonVLineView.frame = CGRectMake(0, -0.2, JKAlertSeparatorLineWH, JKAlertButtonH);
        }
        
        if (count <= 2 || i == 0) { continue; }
        
        if (action.separatorLineHidden) { continue; }
        
        if (!button.topSeparatorLineView) {
            UIView *hline = [UIView new];
            hline.backgroundColor = JKALertAdaptColor([[UIColor blackColor] colorWithAlphaComponent:0.2], [[UIColor whiteColor] colorWithAlphaComponent:0.2]);
            [button addSubview:hline];
            button.topSeparatorLineView = hline;
        }
        
        button.topSeparatorLineView.frame = CGRectMake(0.3, 0, button.frame.size.width, JKAlertSeparatorLineWH);
    }
}

- (void)adjustPlainViewFrame{
    
    CGRect frame = CGRectZero;
    
    if (self.textContainerView.frame.size.height > JKAlertTextContainerViewMaxH && self.scrollView.frame.size.height > JKAlertScrollViewMaxH) {
        
        frame = self.textContainerView.frame;
        frame.size.height = JKAlertTextContainerViewMaxH;
        self.textContainerView.frame = frame;
        
        frame = self.scrollView.frame;
        frame.origin.y = self.textContainerView.frame.size.height;
        frame.size.height = JKAlertScrollViewMaxH;
        self.scrollView.frame = frame;
        
    } else if (self.textContainerView.frame.size.height > JKAlertTextContainerViewMaxH) {
        
        frame = self.textContainerView.frame;
        frame.size.height = (frame.size.height + self.scrollView.frame.size.height) > JKAlertPlainViewMaxH ? JKAlertPlainViewMaxH - self.scrollView.frame.size.height : frame.size.height;
        self.textContainerView.frame = frame;
        
    } else if (self.scrollView.frame.size.height > JKAlertScrollViewMaxH) {
        
        frame = self.scrollView.frame;
        frame.origin.y = self.textContainerView.frame.size.height;
        frame.size.height = (frame.size.height + self.textContainerView.frame.size.height) > JKAlertPlainViewMaxH ? JKAlertPlainViewMaxH - self.textContainerView.frame.size.height : frame.size.height;
        self.scrollView.frame = frame;
    }
    
    frame = self.scrollView.frame;
    frame.origin.y = self.textContainerView.frame.size.height;
    self.scrollView.frame = frame;
    
    textContainerViewCurrentMaxH_ = self.textContainerView.frame.size.height;
    
    //    [self adjustTextContainerViewFrame];
}

- (void)adjustTextContainerViewFrame{
    
    if (self.messageTextView.hidden && self.titleTextView.hidden) { return; }
    
    CGRect frame = CGRectZero;
    
    if (self.messageTextView.hidden) {
        
        frame = self.titleTextView.frame;
        //        frame.size.height = frame.size.height > textContainerViewCurrentMaxH_ - TBMargin * 2 ? textContainerViewCurrentMaxH_ - TBMargin * 2 : frame.size.height;
        //        self.titleTextView.frame = frame;
        
        self.plainTextContainerScrollView.contentSize = CGSizeMake(self.plainTextContainerScrollView.frame.size.width, frame.size.height + TBMargin * 2);
        
        return;
    }
    
    if (self.titleTextView.hidden) {
        
        frame = self.messageTextView.frame;
        //        frame.size.height = frame.size.height > textContainerViewCurrentMaxH_ - TBMargin * 2 ? textContainerViewCurrentMaxH_ - TBMargin * 2 : frame.size.height;
        //        self.messageTextView.frame = frame;
        
        self.plainTextContainerScrollView.contentSize = CGSizeMake(self.plainTextContainerScrollView.frame.size.width, frame.size.height + TBMargin * 2);
        
        return;
    }
    
    CGFloat contentSizeH = self.titleTextView.frame.size.height + JKAlertTitleMessageMargin + self.messageTextView.frame.size.height + TBMargin * 2;
    
    self.plainTextContainerScrollView.contentSize = CGSizeMake(self.plainTextContainerScrollView.frame.size.width, contentSizeH);
    /*
     CGFloat maxH = (textContainerViewCurrentMaxH_ - TBMargin - JKAlertTitleMessageMargin - TBMargin) * 0.5;
     
     if (self.titleTextView.frame.size.height > maxH && self.messageTextView.frame.size.height > maxH) {
     
     frame = self.titleTextView.frame;
     frame.size.height = maxH;
     self.titleTextView.frame = frame;
     
     frame = self.messageTextView.frame;
     frame.origin.y = CGRectGetMaxY(self.titleTextView.frame) + JKAlertTitleMessageMargin;
     frame.size.height = maxH;
     self.messageTextView.frame = frame;
     
     } else if (self.titleTextView.frame.size.height > maxH) {
     
     frame = self.titleTextView.frame;
     frame.size.height = textContainerViewCurrentMaxH_ - TBMargin - JKAlertTitleMessageMargin - TBMargin - self.messageTextView.frame.size.height;
     self.titleTextView.frame = frame;
     
     frame = self.messageTextView.frame;
     frame.origin.y = CGRectGetMaxY(self.titleTextView.frame) + JKAlertTitleMessageMargin;
     self.messageTextView.frame = frame;
     
     } else if (self.messageTextView.frame.size.height > maxH) {
     
     frame = self.messageTextView.frame;
     frame.origin.y = CGRectGetMaxY(self.titleTextView.frame) + JKAlertTitleMessageMargin;
     frame.size.height = textContainerViewCurrentMaxH_ - TBMargin - JKAlertTitleMessageMargin - TBMargin - self.titleTextView.frame.size.height;
     self.messageTextView.frame = frame;
     } */
}

#pragma mark - 布局actionSheet

- (void)layoutActionSheet{
    
    self.titleTextView.scrollEnabled = NO;
    self.messageTextView.scrollEnabled = NO;
    
    if (self.message && !self.alertTitle && !self.alertAttributedTitle) {
        
        self.messageTextView.font = [UIFont systemFontOfSize:15];
    }
    
    _iPhoneXLandscapeTextMargin = ((JKAlertIsIphoneX && JKAlertScreenW > JKAlertScreenH) ? 44 : 0);
    
    _textContainerView.frame = CGRectMake(_iPhoneXLandscapeTextMargin, 0, JKAlertScreenW - _iPhoneXLandscapeTextMargin * 2, JKAlertRowHeight);
    
    CGFloat tableViewH = 0;
    
    for (JKAlertAction *action in self.actions) {
        
        tableViewH += action.rowHeight;
    }
    
    if (self.cancelAction.rowHeight > 0) {
        
        tableViewH += (self.cancelAction.rowHeight + CancelMargin);
    }
    
    tableViewH += JKAlertAdjustHomeIndicatorHeight;
    
    _tableView.frame = CGRectMake(0, CGRectGetMaxY(_textContainerView.frame), JKAlertScreenW, tableViewH);
    
    _sheetContainerView.frame = CGRectMake(0, JKAlertScreenH, JKAlertScreenW, _textContainerView.frame.size.height + _tableView.frame.size.height);
    
    [self.titleTextView calculateFrameWithMaxWidth:_textContainerView.frame.size.width - self.textViewLeftRightMargin * 2 minHeight:JKAlertMinTitleLabelH originY:JKAlertSheetTitleMargin superView:_textContainerView];
    
    [self.messageTextView calculateFrameWithMaxWidth:_textContainerView.frame.size.width - self.textViewLeftRightMargin * 2 minHeight:JKAlertMinMessageLabelH originY:CGRectGetMaxY(self.titleTextView.frame) + JKAlertSheetTitleMargin superView:_textContainerView];
    
    CGRect rect = _textContainerView.frame;
    rect.size.height = JKAlertSheetTitleMargin + self.titleTextView.frame.size.height + JKAlertSheetTitleMargin + self.messageTextView.frame.size.height + JKAlertSheetTitleMargin;
    
    if (self.titleTextView.hidden && self.messageTextView.hidden) {
        
        rect.size.height = 0;
        
    } else if (self.titleTextView.hidden && !self.messageTextView.hidden) {
        
        rect.size.height = JKAlertSheetTitleMargin + self.messageTextView.frame.size.height + JKAlertSheetTitleMargin;
        rect.size.height = rect.size.height < JKAlertRowHeight ? JKAlertRowHeight : rect.size.height;
        
        self.messageTextView.center = CGPointMake(self.textContainerView.frame.size.width * 0.5, rect.size.height * 0.5);
        
    } else if (self.messageTextView.hidden && !self.titleTextView.hidden) {
        
        rect.size.height = JKAlertSheetTitleMargin + self.titleTextView.frame.size.height + JKAlertSheetTitleMargin;
        rect.size.height = rect.size.height < JKAlertRowHeight ? JKAlertRowHeight : rect.size.height;
        
        self.titleTextView.center = CGPointMake(self.textContainerView.frame.size.width * 0.5, rect.size.height * 0.5);
    }
    
    if (_customSheetTitleView) {
        
        rect.size.height = _customSheetTitleView.frame.size.height;
        
        _customSheetTitleView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    }
    
    _textContainerBottomLineView.hidden = (rect.size.height == 0 || (!_customSheetTitleView && self.actions.count <= 0));
    
    _textContainerView.frame = rect;
    _scrollView.contentSize = rect.size;
    
    GestureIndicatorHeight = self.enableGestureDismiss ? JKAlertTopGestureIndicatorHeight : 0;
    
    [self adjustSheetFrame];
    
    CGFloat sheetContainerHeight = _textContainerView.frame.size.height + _tableView.frame.size.height;
    
    sheetContainerHeight += GestureIndicatorHeight;
    
    _sheetContainerView.frame = CGRectMake(0, JKAlertScreenH - sheetContainerHeight, JKAlertScreenW, sheetContainerHeight);
    
    self.topGestureIndicatorView.frame = CGRectMake(0, 0, _sheetContainerView.frame.size.width, GestureIndicatorHeight);
    
    self.topGestureLineView.frame = CGRectMake((self.topGestureIndicatorView.frame.size.width - JKAlertTopGestureIndicatorLineWidth) * 0.5, (JKAlertTopGestureIndicatorHeight - JKAlertTopGestureIndicatorLineHeight) * 0.5, JKAlertTopGestureIndicatorLineWidth, JKAlertTopGestureIndicatorLineHeight);
    
    self.topGestureIndicatorView.hidden = !self.enableGestureDismiss;
    
    _sheetContentView.frame = CGRectMake(0, GestureIndicatorHeight, _sheetContainerView.frame.size.width, sheetContainerHeight - GestureIndicatorHeight);
    
    _scrollView.frame = CGRectMake(0, 0, _textContainerView.bounds.size.width, _textContainerView.bounds.size.height);
    
    _tableView.scrollEnabled = _tableView.frame.size.height < tableViewH;
    
    _textContainerBottomLineView.frame = CGRectMake(0, self.textContainerView.frame.size.height - JKAlertSeparatorLineWH, self.textContainerView.frame.size.width, JKAlertSeparatorLineWH);
}

- (void)adjustSheetFrame{
    
    /*
     CGRect frame = self.tableView.frame;
     
     frame.origin.y = 0;
     frame.size.height += self.textContainerView.frame.size.height;
     
     _tableView.scrollEnabled = frame.size.height > JKAlertSheetMaxH;
     
     frame.size.height = frame.size.height > JKAlertSheetMaxH ? JKAlertSheetMaxH : frame.size.height;
     
     _tableView.frame = frame;
     
     UIView *tableHeader = _tableView.tableHeaderView;
     
     if (!tableHeader) {
     
     tableHeader = [[UIView alloc] init];
     }
     [tableHeader addSubview:_textContainerView];
     
     frame = tableHeader.frame;
     frame.size.height = _textContainerView.frame.size.height;
     
     tableHeader.frame = frame;
     
     _tableView.tableHeaderView = tableHeader; //*/
    
    CGRect frame = CGRectZero;
    
    if (self.textContainerView.frame.size.height > JKAlertSheetMaxH * 0.5 && self.tableView.frame.size.height > JKAlertSheetMaxH * 0.5) {
        
        frame = self.textContainerView.frame;
        frame.size.height = JKAlertSheetMaxH * 0.5;
        self.textContainerView.frame = frame;
        
        frame = self.tableView.frame;
        frame.origin.y = self.textContainerView.frame.size.height;
        frame.size.height = JKAlertSheetMaxH * 0.5;
        self.tableView.frame = frame;
        
    } else if (self.textContainerView.frame.size.height > JKAlertSheetMaxH * 0.5) {
        
        frame = self.textContainerView.frame;
        frame.size.height = (frame.size.height + self.tableView.frame.size.height) > JKAlertSheetMaxH ? JKAlertSheetMaxH - self.tableView.frame.size.height : frame.size.height;
        self.textContainerView.frame = frame;
        
    } else if (self.tableView.frame.size.height > JKAlertSheetMaxH * 0.5) {
        
        frame = self.tableView.frame;
        frame.origin.y = self.textContainerView.frame.size.height;
        frame.size.height = (frame.size.height + self.textContainerView.frame.size.height) > JKAlertSheetMaxH ? JKAlertSheetMaxH - self.textContainerView.frame.size.height : frame.size.height;
        self.tableView.frame = frame;
    }
    
    frame = self.tableView.frame;
    frame.origin.y = self.textContainerView.frame.size.height;
    self.tableView.frame = frame;
}

#pragma mark - 布局collectionSheet

- (void)layoutCollectionSheet{
    
    NSInteger count = self.actions.count;
    NSInteger count2 = self.actions2.count;
    
    if (count <= 0 && count2 > 0) {
        
        [self.actions addObjectsFromArray:self.actions2];
        
        [self.actions2 removeAllObjects];
        
        count = count2;
        count2 = 0;
        
        self.compoundCollection = NO;
    }
    
    if (count == 0 && count2 == 0) {
        
        self.compoundCollection = NO;
    }
    
    // 合体
    if (self.compoundCollection && count2 > 0 && count != count2) {
        
        if (count > count2) {
            
            for (NSInteger i = 0; i < count - count2; i++) {
                
                [self addSecondCollectionAction:[JKAlertAction actionWithTitle:nil style:(0) handler:nil]];
            }
            
            count2 = count;
            
        } else {
            
            for (NSInteger i = 0; i < count2 - count; i++) {
                
                [self addAction:[JKAlertAction actionWithTitle:nil style:(0) handler:nil]];
            }
            
            count = count2;
        }
    }
    
    _iPhoneXLandscapeTextMargin = ((JKAlertIsIphoneX && JKAlertScreenW > JKAlertScreenH) ? 44 : 0);
    
    CGRect rect = [self.titleTextView calculateFrameWithMaxWidth:JKAlertScreenW - self.textViewLeftRightMargin * 2 - _iPhoneXLandscapeTextMargin * 2 minHeight:JKAlertMinTitleLabelH originY:0 superView:self.textContainerView];
    
    _iPhoneXLandscapeTextMargin = 0;
    
    if (JKAlertSheetMaxH - 395 > JKAlertMinTitleLabelH) {
        
        rect.size.height = rect.size.height > JKAlertSheetMaxH - 395 ? JKAlertSheetMaxH - 395 : rect.size.height;
    }
    
    rect.size.height = self.titleTextView.hidden ? -TBMargin * 2 : rect.size.height;
    
    self.titleTextView.frame = rect;
    
    self.textContainerView.frame = CGRectMake(0, 0, JKAlertScreenW, TBMargin + rect.size.height + TBMargin);
    self.titleTextView.center = CGPointMake(self.textContainerView.frame.size.width * 0.5, self.textContainerView.frame.size.height * 0.5);
    
    if (_customSheetTitleView) {
        
        self.textContainerView.frame = CGRectMake(0, 0, JKAlertScreenW, _customSheetTitleView.frame.size.height);
        _customSheetTitleView.frame = CGRectMake(_iPhoneXLandscapeTextMargin, 0, JKAlertScreenW - _iPhoneXLandscapeTextMargin * 2, _customSheetTitleView.frame.size.height);
    }
    
    if (self.collectionTitleSeperatorHidden) {
        
        _textContainerBottomLineView.hidden = YES;
        
    } else {
        
        _textContainerBottomLineView.hidden = (self.textContainerView.frame.size.height == 0 || (!_customSheetTitleView && self.actions.count <= 0 && self.actions2.count <= 0));
    }
    
    CGFloat collectionViewY = CGRectGetMaxY(self.textContainerView.frame) + (_textContainerBottomLineView.hidden ? 0 : 10);
    
    CGFloat collectionViewHeight = (self.actions.count <= 0) ? 0 : self.flowlayoutItemWidth - 6 + self.collectionViewMargin;
    
    self.collectionView.frame = CGRectMake(0, collectionViewY, JKAlertScreenW, collectionViewHeight);
    
    self.flowlayout.itemSize = CGSizeMake(self.flowlayoutItemWidth, self.flowlayoutItemWidth - 6);
    self.flowlayout.sectionInset = UIEdgeInsetsMake(self.flowlayout.itemSize.height - self.collectionView.frame.size.height, 0, 0, 0);
    
    if (count2 > 0) {
        
        self.collectionView2.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), JKAlertScreenW, self.collectionView.frame.size.height - self.collectionViewMargin);
        
        self.flowlayout2.itemSize = CGSizeMake(self.flowlayoutItemWidth, self.flowlayoutItemWidth - 6);
        self.flowlayout2.sectionInset = UIEdgeInsetsMake(self.flowlayout2.itemSize.height - self.collectionView2.frame.size.height, 0, 0, 0);
    }
    
    if (_showPageControl && _collectionPagingEnabled) {
        
        if (count2 <= 0) {
            
            self.pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), self.sheetContainerView.frame.size.width, 27);
            
        } else {
            
            if (_compoundCollection) {
                
                self.pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView2.frame), self.sheetContainerView.frame.size.width, 27);
            }
        }
    }
    
    [self adjustButton:self.cancelButton action:self.cancelAction];
    
    CGRect frame = CGRectZero;
    
    CGFloat Y = 0;
    
    if (self.collectionAction) {
        
        [self adjustButton:self.collectionButton action:self.collectionAction];
        
        if (_pageControl) {
            
            Y = CGRectGetMaxY(_pageControl.frame);
            
        } else if (_collectionView2) {
            
            Y = CGRectGetMaxY(_collectionView2.frame) + 10;
            
        } else if (_collectionView) {
            
            Y = CGRectGetMaxY(_collectionView.frame) + (_collectionView.frame.size.height > 0 ? 10 : 0);
        }
        
        Y += CancelMargin;
        
        frame = CGRectMake(self.collectionButtonLeftRightMargin + _iPhoneXLandscapeTextMargin, Y, JKAlertScreenW - self.collectionButtonLeftRightMargin * 2 - _iPhoneXLandscapeTextMargin * 2, JKAlertButtonH);
        
        if (self.collectionAction.customView) {
            
            self.collectionButton.backgroundColor = nil;
            
            frame.size.height = self.collectionAction.customView.frame.size.height;
        }
        
        self.collectionButton.frame = frame;
        
        self.collectionAction.customView.frame = self.collectionButton.bounds;
    }
    
    Y = 0;
    
    if (_collectionButton) {
        
        Y = CGRectGetMaxY(_collectionButton.frame);
        
    } else if (_pageControl) {
        
        Y = CGRectGetMaxY(_pageControl.frame);
        
    } else if (_collectionView2) {
        
        Y = CGRectGetMaxY(_collectionView2.frame) + 10;
        
    } else if (_collectionView) {
        
        Y = CGRectGetMaxY(_collectionView.frame) + (_collectionView.frame.size.height > 0 ? 10 : 0);
    }
    
    Y += CancelMargin;
    
    frame = CGRectMake(self.collectionButtonLeftRightMargin + _iPhoneXLandscapeTextMargin, Y, JKAlertScreenW - self.collectionButtonLeftRightMargin * 2 - _iPhoneXLandscapeTextMargin * 2, JKAlertButtonH);
    
    if (self.cancelAction.customView) {
        
        self.cancelButton.backgroundColor = nil;
        
        frame.size.height = self.cancelAction.customView.frame.size.height - (self.cancelButton.titleEdgeInsets.bottom > 0 ? JKAlertCurrentHomeIndicatorHeight : 0);
    }
    
    self.cancelButton.frame = frame;
    
    self.cancelAction.customView.frame = self.cancelButton.bounds;
    
    rect = CGRectMake(0, JKAlertScreenH - (CGRectGetMaxY(self.cancelButton.frame) + JKAlertAdjustHomeIndicatorHeight), JKAlertScreenW, CGRectGetMaxY(self.cancelButton.frame) + JKAlertAdjustHomeIndicatorHeight);
    
    CGFloat height = 0;
    
    if (_pageControl) {
        
        height = CGRectGetMaxY(_pageControl.frame);
        
    } else if (_collectionView2) {
        
        height = CGRectGetMaxY(_collectionView2.frame) + 10;
        
    } else if (_collectionView) {
        
        height = CGRectGetMaxY(_collectionView.frame) + (_collectionView.frame.size.height > 0 ? 10 : 0);
    }
    
    self.collectionTopContainerView.frame = CGRectMake(0, 0, JKAlertScreenW, height);
    
    self.scrollView.contentSize = rect.size;
    
    GestureIndicatorHeight = self.enableGestureDismiss ? JKAlertTopGestureIndicatorHeight : 0;
    
    if (rect.size.height > JKAlertSheetMaxH) {
        
        rect.size.height = JKAlertSheetMaxH;
        rect.origin.y = JKAlertScreenH - JKAlertSheetMaxH;
    }
    
    CGFloat sheetContainerHeight = rect.size.height;
    
    sheetContainerHeight += GestureIndicatorHeight;
    
    rect.size.height = sheetContainerHeight;
    rect.origin.y = JKAlertScreenH - sheetContainerHeight;
    
    self.sheetContainerView.frame = rect;
    
    self.topGestureIndicatorView.frame = CGRectMake(0, 0, _sheetContainerView.frame.size.width, GestureIndicatorHeight);
    
    self.topGestureLineView.frame = CGRectMake((self.topGestureIndicatorView.frame.size.width - JKAlertTopGestureIndicatorLineWidth) * 0.5, (JKAlertTopGestureIndicatorHeight - JKAlertTopGestureIndicatorLineHeight) * 0.5, JKAlertTopGestureIndicatorLineWidth, JKAlertTopGestureIndicatorLineHeight);
    
    self.topGestureIndicatorView.hidden = !self.enableGestureDismiss;
    
    _sheetContentView.frame = CGRectMake(0, GestureIndicatorHeight, _sheetContainerView.frame.size.width, sheetContainerHeight - GestureIndicatorHeight);
    
    CGFloat totalMargin = 0;
    
    CGFloat itemMargin = 0;
    
    if (self.collectionColumnCount > 0) {
        
        totalMargin = (JKAlertScreenW - self.flowlayout.itemSize.width * self.collectionColumnCount - self.collectionHorizontalInset * 2);
        
        itemMargin = totalMargin / ((self.collectionHorizontalInset == 0) ? self.collectionColumnCount : self.collectionColumnCount - 1);
    }
    
    if (totalMargin < 0 || self.collectionColumnCount <= 0) {
        
        totalMargin = (JKAlertScreenW - self.flowlayout.itemSize.width * count - self.collectionHorizontalInset * 2);
        
        itemMargin = totalMargin / ((self.collectionHorizontalInset == 0) ? count : count - 1);
    }
    
    itemMargin = itemMargin < 0 ? 0 : itemMargin;
    
    CGFloat leftRightInset = self.collectionHorizontalInset == 0 ? itemMargin * 0.5 : self.collectionHorizontalInset;
    
    if (count2 > 0) {
        
        CGFloat itemMargin2 = 0;
        
        if (self.collectionColumnCount > 0) {
            
            totalMargin = (JKAlertScreenW - self.flowlayout.itemSize.width * self.collectionColumnCount - self.collectionHorizontalInset * 2);
            
            itemMargin2 = totalMargin / ((self.collectionHorizontalInset == 0) ? self.collectionColumnCount : self.collectionColumnCount - 1);
        }
        
        if (totalMargin < 0 || self.collectionColumnCount <= 0) {
            
            totalMargin = (JKAlertScreenW - self.flowlayout.itemSize.width * count - self.collectionHorizontalInset * 2);
            
            itemMargin2 = totalMargin / ((self.collectionHorizontalInset == 0) ? count2 : count2 - 1);
        }
        
        itemMargin2 = itemMargin2 < 0 ? 0 : itemMargin2;
        
        itemMargin = MIN(itemMargin, itemMargin2);
        
        leftRightInset = self.collectionHorizontalInset == 0 ? itemMargin * 0.5 : self.collectionHorizontalInset;
        
        self.flowlayout2.sectionInset = UIEdgeInsetsMake(self.flowlayout2.sectionInset.top, leftRightInset, 0, leftRightInset);
        self.flowlayout2.minimumLineSpacing = itemMargin;
        self.flowlayout2.minimumInteritemSpacing = itemMargin;
    }
    
    self.flowlayout.sectionInset = UIEdgeInsetsMake(self.flowlayout.sectionInset.top, leftRightInset, 0, leftRightInset);
    self.flowlayout.minimumLineSpacing = itemMargin;
    self.flowlayout.minimumInteritemSpacing = itemMargin;
    
    _pageControl.numberOfPages = ceil(((itemMargin + _flowlayout.itemSize.width) * count - 5) / JKAlertScreenW);
    
    // 处理iPhoneX并且横屏的情况
    _collectionView.contentInset = (JKAlertIsIphoneX && JKAlertScreenW > JKAlertScreenH && itemMargin < 44) ? UIEdgeInsetsMake(0, 44 - itemMargin, 0, 44 - itemMargin) : UIEdgeInsetsZero;
    _collectionView2.contentInset = _collectionView.contentInset;
    
    // 分页
    _collectionView.pagingEnabled = self.collectionPagingEnabled && _pageControl.numberOfPages > 1;
    _collectionView2.pagingEnabled = _collectionView.pagingEnabled;
    
    if (FillHomeIndicator) {
        
        CGRect cancelButtonFrame = self.cancelButton.frame;
        cancelButtonFrame.size.height += JKAlertCurrentHomeIndicatorHeight;
        self.cancelButton.frame = cancelButtonFrame;
        
        self.cancelAction.customView.frame = self.cancelButton.bounds;
        
        [self.cancelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, JKAlertCurrentHomeIndicatorHeight, 0)];
        
        //        NSLog(@"%@", NSStringFromUIEdgeInsets(self.cancelButton.titleEdgeInsets));
    }
    
    _textContainerBottomLineView.frame = CGRectMake(0, self.textContainerView.frame.size.height - JKAlertSeparatorLineWH, self.textContainerView.frame.size.width, JKAlertSeparatorLineWH);
}

#pragma mark - 布局自定义HUD

- (void)layoutCustomHUD{
    
    if (!_customHUD) {
        return;
    }
    
    self.plainView.frame = _customHUD.bounds;
    self.plainView.center = CGPointMake(JKAlertScreenW * 0.5, JKAlertScreenH * 0.5 + self.plainCenterOffsetY);
}

#pragma mark - 动画弹出来------------------------

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    if (!self.superview) {
        return;
    }
    
    if (self.currentTextField != nil) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    
    [self startShowAnimation];
    
    if (self.observerSuperView && self.observerSuperView != self.superview) {
        
        [self removeAllOberserver];
    }
    
    if (ObserverAdded) { return; }
    
    self.observerSuperView = self.superview;
    
    [self.superview addObserver:self forKeyPath:@"frame" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:nil];
    
    ObserverAdded = YES;
}

- (void)removeAllOberserver{
    
    if (ObserverAdded) {
        
        [self.observerSuperView removeObserver:self forKeyPath:@"frame"];
    }
    
    ObserverAdded = NO;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (object == self.superview && [keyPath isEqualToString:@"frame"]) {
        
        CGRect oldFrame = [[change objectForKey:NSKeyValueChangeOldKey] CGRectValue];
        CGRect currentFrame = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue];
        
        if (CGSizeEqualToSize(oldFrame.size, currentFrame.size)) { return; }
        
        [self updateWidthHeight];
        
        !self.willAdaptBlock ? : self.willAdaptBlock(self, (_plainView ? _plainView : _sheetContainerView));
        
        self.relayout(YES);
        
        !self.didAdaptBlock ? : self.didAdaptBlock(self, (_plainView ? _plainView : _sheetContainerView));
    }
}

- (void)startShowAnimation{
    
    self.window.userInteractionEnabled = NO;
    
    if (self.customShowAnimationBlock) {
        
        self.customShowAnimationBlock(self, _plainView ? _plainView : _sheetContainerView);
        
    } else {
        
        _plainView.alpha = 0;
        _plainView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        _sheetContainerView.frame = CGRectMake(_sheetContainerView.frame.origin.x, JKAlertScreenH, _sheetContainerView.frame.size.width, _sheetContainerView.frame.size.height);
    }
    
    self.fullScreenBackGroundView.alpha = 0;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        if (!self.isClearFullScreenBackgroundColor) {
            
            self.contentView.backgroundColor = JKALertAdaptColor([[UIColor blackColor] colorWithAlphaComponent:0.4], [[UIColor whiteColor] colorWithAlphaComponent:0.3]);
        }
        self.fullScreenBackGroundView.alpha = 1;
        
        [self showAnimationOperation];
        
    } completion:^(BOOL finished) {
        
        if (self.customShowAnimationBlock) { return; }
        
        self.showAnimationDidComplete();
    }];
}

- (void)showAnimationOperation{
    
    if (self.customShowAnimationBlock) { return; }
    
    CGRect rect = _sheetContainerView.frame;
    rect.origin.y = JKAlertScreenH - _sheetContainerView.frame.size.height;
    _sheetContainerView.frame = rect;
    
    _plainView.transform = CGAffineTransformIdentity;
    _plainView.alpha = 1;
}

- (void(^)(void))showAnimationDidComplete{
    
    self.window.userInteractionEnabled = YES;
    
    self->_titleTextView.delegate = self.titleTextViewDelegate;
    self->_messageTextView.delegate = self.messageTextViewDelegate;
    
    !self.showAnimationCompleteHandler ? : self.showAnimationCompleteHandler(self);
    
    self->oldPlainViewFrame = self->_plainView.frame;
    
    if (self.autoShowKeyboard && self.currentTextField) {
        
        if (!self.currentTextField.hidden) {
            
            if (!self.currentTextField.isFirstResponder) {
                
                [self.currentTextField becomeFirstResponder];
            }
            
        } else {
            
            for (UITextField *tf in _textFieldArr) {
                
                if (tf.hidden) { continue; }
                
                if (!tf.isFirstResponder) {
                    
                    [tf becomeFirstResponder];
                }
                
                break;
            }
        }
    }
    
    if (self.dismissTimeInterval > 0 && (self.alertStyle == JKAlertStyleHUD || self.customHUD)) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.dismissTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismiss];
        });
    }
    
    return ^{};
}

#pragma mark - 监听键盘

//- (BOOL)isLandScape{
//
//    return JKAlertScreenW > JKAlertScreenH;
//}

- (void)keyboardWillChangeFrame:(NSNotification *)noti{
    
    CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect frame = _plainView.frame;
    
    if (keyboardFrame.origin.y >= JKAlertScreenH) { // 退出键盘
        
        JKAlertPlainViewMaxH = JKAlertScreenH - 100;
        
        [self calculateUI];
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [self layoutIfNeeded];
        }];
        
    } else {
        
        CGFloat maxH = JKAlertScreenH - (JKAlertIsIphoneX ? 44 : 20) - keyboardFrame.size.height - 40;
        
        if ([self isLandScape]) {
            
            maxH = JKAlertScreenH - 5 - keyboardFrame.size.height - 5;
            
            JKAlertPlainViewMaxH = maxH;
            
            [self calculateUI];
        }
        
        if (frame.size.height <= maxH) {
            
            frame.origin.y = (JKAlertIsIphoneX ? 44 : 20) + (maxH - frame.size.height) * 0.5;
            
            if ([self isLandScape]) {
                
                frame.origin.y = 5 + (maxH - frame.size.height) * 0.5;
            }
            
            self.setPlainY(frame.origin.y, YES);
            
            return;
        }
        
        JKAlertPlainViewMaxH = maxH;
        
        [self calculateUI];
        
        frame = _plainView.frame;
        frame.origin.y = [self isLandScape] ? 5 : (JKAlertIsIphoneX ? 44 : 20);
        _plainView.frame = frame;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [self layoutIfNeeded];
        }];
    }
}

#pragma mark - 退出------------------------

- (void)dismissButtonClick:(UIButton *)button{
    
    !self.blankClickBlock ? : self.blankClickBlock();
    
    if (_clickPlainBlankDismiss) {
        
        self.dismiss();
        
    } else {
        
        [self endEditing:YES];
    }
}

// 通过通知来dismiss
- (void)dismissAllNotification:(NSNotification *)noti{
    
    if (self.isDismissAllNoneffective) { return; }
    
    self.dismiss();
}

// 通过key通知来dismiss
- (void)dismissForKeyNotification:(NSNotification *)noti{
    
    if ([noti.object isEqualToString:self.dismissKey]) {
        
        self.dismiss();
    }
}

- (void(^)(void))dismiss{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self startDismissAnimation];
    
    return ^{};
}

- (void)startDismissAnimation{
    
    self.window.userInteractionEnabled = NO;
    
    // 即将消失
    !self.willDismissHandler ? : self.willDismissHandler();
    
    // 自定义消失动画
    !self.customDismissAnimationBlock ? : self.customDismissAnimationBlock(self, _plainView ? _plainView : _sheetContainerView);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.contentView.backgroundColor = JKALertAdaptColor([[UIColor blackColor] colorWithAlphaComponent:0], [[UIColor whiteColor] colorWithAlphaComponent:0]);
        self.fullScreenBackGroundView.alpha = 0;
        
        [self dismissAnimationOperation];
        
    } completion:^(BOOL finished) {
        
        if (self.customDismissAnimationBlock) { return; }
        
        self.dismissAnimationDidComplete();
    }];
}

- (void)dismissAnimationOperation{
    
    if (self.customDismissAnimationBlock) { return; }
    
    CGRect rect = _sheetContainerView.frame;
    rect.origin.y = JKAlertScreenH;
    _sheetContainerView.frame = rect;
    
    _plainView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    _plainView.alpha = 0;
}

- (void(^)(void))dismissAnimationDidComplete{
    
    self.window.userInteractionEnabled = YES;
    
    // 消失完成
    !self.didDismissHandler ? : self.didDismissHandler();
    
    [self.actions removeAllObjects];
    self.actions = nil;
    
    [self.actions2 removeAllObjects];
    self.actions2 = nil;
    
    _cancelAction = nil;
    _collectionAction = nil;
    
    [self removeFromSuperview];
    
    return ^{};
}

#pragma mark - 强制更改frame为屏幕尺寸

- (void)setFrame:(CGRect)frame{
    frame = CGRectMake(0, 0, JKAlertScreenW, JKAlertScreenH);
    [super setFrame:frame];
}

#pragma mark - UITableViewDataSource------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.alertStyle == JKAlertStyleActionSheet ? (self.cancelAction.rowHeight > 0 ? 2 : 1) : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? self.actions.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JKAlertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JKAlertTableViewCell class])];
    
    if (cell == nil) {
        
        cell = [[JKAlertTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([JKAlertTableViewCell class])];
    }
    
    if (indexPath.section == 0) {
        
        cell.action = self.actions[indexPath.row];
        
    } else {
        
        cell.action = self.cancelAction;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JKAlertAction *action = indexPath.section == 0 ? self.actions[indexPath.row] : self.cancelAction;
    
    if (!FillHomeIndicator) { return action.rowHeight; }
    
    return indexPath.section == 0 ? action.rowHeight : action.rowHeight + JKAlertCurrentHomeIndicatorHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (section == 0) ? CGFLOAT_MIN : CancelMargin;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    JKAlertAction *action = indexPath.section == 0 ? self.actions[indexPath.row] : self.cancelAction;
    
    if (action.autoDismiss && ![action isEmpty]) { [self dismiss]; }
    
    !action.handler ? : action.handler(action);
}

#pragma mark - UICollectionViewDataSource------------------------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return collectionView == self.collectionView ? self.actions.count : self.actions2.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JKAlertCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JKAlertCollectionViewCell class]) forIndexPath:indexPath];
    
    cell.action = collectionView == self.collectionView ? self.actions[indexPath.item] : self.actions2[indexPath.item];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate------------------------

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    JKAlertAction *action = collectionView == self.collectionView ? self.actions[indexPath.item] : self.actions2[indexPath.item];
    
    if (action.autoDismiss && ![action isEmpty]) { [self dismiss]; }
    
    !action.handler ? : action.handler(action);
}

#pragma mark - UIScrollViewDelegate------------------------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    switch (self.alertStyle) {
        case JKAlertStyleActionSheet:
        {
            if (!self.enableGestureDismiss) { return; }
            
            if ((scrollView == self.scrollView &&
                self.tableView.isDecelerating) ||
                (scrollView == self.tableView &&
                self.scrollView.isDecelerating)) {
                    return;
            }
            
            [self solveCollectionScroll:scrollView];
        }
            break;
        case JKAlertStyleCollectionSheet:
        {
            if (scrollView == self.scrollView) {
                
                [self solveCollectionScroll:scrollView];
                
            } else if (self.compoundCollection) {
                
                _collectionView.contentOffset = scrollView.contentOffset;
                
                _collectionView2.contentOffset = scrollView.contentOffset;
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    switch (self.alertStyle) {
        case JKAlertStyleActionSheet:
        {
            if (!self.enableGestureDismiss) { return; }
            
            beginScrollDirection = JKAlertScrollDirectionNone;
            endScrollDirection = JKAlertScrollDirectionNone;
            
            lastContainerY = self.sheetContainerView.frame.origin.y;
        }
            break;
        case JKAlertStyleCollectionSheet:
        {
            if (scrollView == self.scrollView) {
                
                if (!self.enableGestureDismiss) { return; }
                
                beginScrollDirection = JKAlertScrollDirectionNone;
                endScrollDirection = JKAlertScrollDirectionNone;
                
                lastContainerY = self.sheetContainerView.frame.origin.y;
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    switch (self.alertStyle) {
        case JKAlertStyleActionSheet:
        {
            [self solveWillEndDragging:scrollView withVelocity:velocity];
        }
            break;
        case JKAlertStyleCollectionSheet:
        {
            if (scrollView == self.scrollView) {
                
                [self solveWillEndDragging:scrollView withVelocity:velocity];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if (self.alertStyle == JKAlertStyleCollectionSheet &&
        [scrollView isKindOfClass:[UICollectionView class]]) {
        
        _pageControl.currentPage = ceil((scrollView.contentOffset.x - 5) / JKAlertScreenW);
    }
}
///*
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    switch (self.alertStyle) {
        case JKAlertStyleActionSheet:
        {
            if (!self.enableGestureDismiss) { return; }
            
            if (self.scrollView.isDecelerating ||
                self.tableView.isDecelerating) {
                return;
            }
            
            disableScrollSheetContainerView = NO;
            
            //[self checkSlideShouldDismiss];
        }
            break;
        case JKAlertStyleCollectionSheet:
        {
            if (scrollView == self.scrollView) {
                
                if (!self.enableGestureDismiss) { return; }
                
                disableScrollSheetContainerView = NO;
                
                //[self checkSlideShouldDismiss];
                
            } else {
                
                _pageControl.currentPage = ceil((scrollView.contentOffset.x - 5) / JKAlertScreenW);
            }
        }
            break;
            
        default:
            break;
    }
} //*/

- (void)solveCollectionScroll:(UIScrollView *)scrollView{
    
    if (!self.enableGestureDismiss || disableScrollSheetContainerView) { return; }
    
    NSLog(@"contentOffset-->%@", NSStringFromCGPoint(scrollView.contentOffset));
    
    if (scrollView.contentOffset.y + scrollView.contentInset.top <= 0) {
        
        CGRect frame = self.sheetContainerView.frame;
        
        frame.origin.y -= (scrollView.contentOffset.y + scrollView.contentInset.top);
        
        self.sheetContainerView.frame = frame;
        
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -scrollView.contentInset.top);
        
    } else if (self.sheetContainerView.frame.origin.y > JKAlertScreenH - self.sheetContainerView.frame.size.height) {
        
        CGRect frame = self.sheetContainerView.frame;
        
        frame.origin.y -= (scrollView.contentOffset.y + scrollView.contentInset.top);
        
        self.sheetContainerView.frame = frame;
        
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -scrollView.contentInset.top);
    }
    
    if (scrollView.isDragging) {
        
        [self checkSlideDirection];
    }
}

- (void)solveWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity{
    
    if (!self.enableGestureDismiss) { return; }
    
    if (scrollView.contentOffset.y + scrollView.contentInset.top > 0) {
        
        disableScrollSheetContainerView = YES;
        
        return;
    }
    
    if (velocity.y < -1.5 && beginScrollDirection == endScrollDirection) {
        
        [self dismiss];
        
    } else {
        
        [self checkSlideShouldDismiss];
    }
}

- (void)checkSlideDirection{

    currentContainerY = self.sheetContainerView.frame.origin.y;
    
    if (currentContainerY < lastContainerY) {
        
        if (beginScrollDirection == JKAlertScrollDirectionNone) {
            
            beginScrollDirection = JKAlertScrollDirectionUp;
        }
        
        endScrollDirection = JKAlertScrollDirectionUp;
        
        //JKLog("上滑-------")
    }
    
    if (currentContainerY > lastContainerY) {
        
        //JKLog("下滑-------")
        
        if (beginScrollDirection == JKAlertScrollDirectionNone) {
            
            beginScrollDirection = JKAlertScrollDirectionDown;
        }
        
        endScrollDirection = JKAlertScrollDirectionDown;
    }
    
    lastContainerY = currentContainerY;
}

- (void)checkSlideShouldDismiss{
    
    CGFloat correctSheetContainerY = (JKAlertScreenH - self.sheetContainerView.frame.size.height);
    
    CGFloat currentSheetContainerY = self.sheetContainerView.frame.origin.y;
    
    CGFloat delta = currentSheetContainerY - correctSheetContainerY;
    
    if ((delta > self.sheetContainerView.frame.size.height * 0.5) &&
        beginScrollDirection == endScrollDirection) {
        
        [self dismiss];
        
    } else if (fabs(correctSheetContainerY - currentSheetContainerY) > 1) {
        
        self.relayout(YES);
    }
}

#pragma mark
#pragma mark - 滑动手势

- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture{
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            // 获取偏移
            CGPoint point = [panGesture translationInView:self.contentView];
            
            CGPoint center = self.sheetContainerView.center;
            
            if (point.y > 0) {
                
                center.y += point.y;
                
            } else {
                
                if (center.y <= (JKAlertScreenH - self.sheetContainerView.frame.size.height) + self.sheetContainerView.frame.size.height * 0.5) {

                    center.y += (point.y * 0.05);
                    
                } else {
                    
                    center.y += point.y;
                }
            }
            
            self.sheetContainerView.center = center;
            
            // 归零
            [panGesture setTranslation:CGPointZero inView:self.contentView];
            
            [self checkSlideDirection];
        }
            break;
            
        default:
        {
            CGPoint velocity = [panGesture velocityInView:panGesture.view];
            CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
            CGFloat slideMult = magnitude / 200;
            
            float slideFactor = 0.1 * slideMult;
            CGPoint finalPoint = CGPointMake(self.sheetContainerView.center.x + (velocity.x * slideFactor), self.sheetContainerView.center.y + (velocity.y * slideFactor));
            
            CGFloat correctSheetContainerY = (JKAlertScreenH - self.sheetContainerView.frame.size.height);
            
            CGFloat currentSheetContainerY = self.sheetContainerView.frame.origin.y;
            
            if (((finalPoint.y - self.sheetContainerView.frame.size.height * 0.5) - (JKAlertScreenH - self.sheetContainerView.frame.size.height) > self.sheetContainerView.frame.size.height * 0.5) &&
                beginScrollDirection == endScrollDirection) {
                
                [self dismiss];
                
            } else if (fabs(correctSheetContainerY - currentSheetContainerY) > 1) {
                
                self.relayout(YES);
            }
        }
            break;
    }
}

#pragma mark
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (gestureRecognizer == self.dismissPanGesture) {
        
        return self.enableGestureDismiss;
    }
    
    return YES;
}

#pragma mark - plain样式按钮点击------------------------

- (void)plainButtonClick:(UIButton *)button{
    
    JKAlertAction *action = self.actions[button.tag - JKAlertPlainButtonBeginTag];
    
    if (action.autoDismiss) { [self dismiss]; }
    
    !action.handler ? : action.handler(action);
}

#pragma mark - collection样式按钮点击------------------------

- (void)collectionButtonClick{
    
    if (self.collectionAction.autoDismiss) { [self dismiss]; }
    
    !self.collectionAction.handler ? : self.collectionAction.handler(self.collectionAction);
}

- (void)cancelButtonClick{
    
    !self.cancelAction.handler ? : self.cancelAction.handler(self.cancelAction);
    
    if (self.cancelAction.autoDismiss) { [self dismiss]; }
}

#pragma mark - JKAlertViewProtocol

/** 准备重新布局 返回JKAlertViewProtocol协议对象，去调用相应协议方法 */
- (id<JKAlertViewProtocol> (^)(void))prepareToRelayout{
    
    return ^{ return self; };
}

/** 重新布局 */
- (id<JKAlertViewProtocol> (^)(BOOL animated))relayout{
    
    lastTableViewOffsetY = _tableView.contentOffset.y;
    
    return ^(BOOL animated){
        
        if (animated) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                [self calculateUI];
                
            } completion:^(BOOL finished) {
                
                !self.relayoutComplete ? : self.relayoutComplete(self);
            }];
            
        } else {
            
            [self calculateUI];
            
            !self.relayoutComplete ? : self.relayoutComplete(self);
        }
        
        return self;
    };
}

/** 监听重新布局完成 */
- (id<JKAlertViewProtocol> (^)(void(^relayoutComplete)(JKAlertView *view)))setRelayoutComplete{
    
    return ^(void(^relayoutComplete)(JKAlertView *view)){
        
        self.relayoutComplete = relayoutComplete;
        
        return self;
    };
}

/** 重新设置alertTitle */
- (id<JKAlertViewProtocol> (^)(NSString *alertTitle))resetAlertTitle{
    
    return ^(NSString *alertTitle){
        
        self.alertTitle = alertTitle;
        
        return self;
    };
}

/** 重新设置alertAttributedTitle */
- (id<JKAlertViewProtocol> (^)(NSAttributedString *alertAttributedTitle))resetAlertAttributedTitle{
    
    return ^(NSAttributedString *alertAttributedTitle){
        
        self.alertAttributedTitle = alertAttributedTitle;
        
        return self;
    };
}

/** 重新设置message */
- (id<JKAlertViewProtocol> (^)(NSString *message))resetMessage{
    
    return ^(NSString *message){
        
        self.message = message;
        
        return self;
    };
}

/** 重新设置attributedMessage */
- (id<JKAlertViewProtocol> (^)(NSAttributedString *attributedMessage))resetAttributedMessage{
    
    return ^(NSAttributedString *attributedMessage){
        
        self.attributedMessage = attributedMessage;
        
        return self;
    };
}

/** 重新设置其它属性，调用该方法返回JKAlertView，设置好其它属性后，再调用relayout即可 */
- (JKAlertView * (^)(void))resetOther{
    
    return ^{
        
        return self;
    };
}

#pragma mark - dealloc------------------------

/** 允许dealloc打印，用于检查循环引用 */
- (JKAlertView *(^)(BOOL enable))enableDeallocLog{
    
    return ^(BOOL enable){
        
        self->_enableDeallocLog = enable;
        
        return self;
    };
}

- (void)dealloc{
    
    [self removeAllOberserver];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (_enableDeallocLog) {
        
        NSLog(@"%d, %s",__LINE__, __func__);
    }
    
    !self.deallocBlock ? : self.deallocBlock();
}

UIImage * JKAlertCreateImageWithColor (UIColor *color, CGFloat width, CGFloat height, CGFloat cornerRadius) {
    
    if (width <= 0 || height <= 0 || !color) { return nil; }
    
    CGRect rect = CGRectMake(0.0f, 0.0f, width, height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    if (cornerRadius > 0) {
        
        // NO代表透明
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
        
        // 获取上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        // 添加一个圆
        //CGContextAddEllipseInRect(ctx, rect);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerAllCorners) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        
        CGContextAddPath(ctx, path.CGPath);
        
        // 裁剪
        CGContextClip(ctx);
        
        // 将图片画上去
        [theImage drawInRect:rect];
        
        theImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
    
    return theImage;
}
@end

@implementation JKAlertHighlightedButton

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
    UIColor *normalColor = JKALertAdaptColor(JKAlertSameRGBColorAlpha(247, 0.7), JKAlertSameRGBColorAlpha(8, 0.7));
    UIColor *highlightedColor = JKALertAdaptColor(JKAlertSameRGBColorAlpha(247, 0.3), JKAlertSameRGBColorAlpha(8, 0.3));
    
    self.backgroundColor = highlighted ? highlightedColor : normalColor;
}
@end




@implementation JKAlertSeparatorLayerButton

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
    //UIColor *normalColor = JKALertAdaptColor(JKAlertSameRGBColor(217), JKAlertSameRGBColor(38));
    UIColor *highlightedColor = JKALertAdaptColor(JKAlertSameRGBColor(217), JKAlertSameRGBColor(38));
    
    self.backgroundColor = highlighted ? highlightedColor : nil;
}
@end


