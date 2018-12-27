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

#define JKAlertScreenScale [UIScreen mainScreen].scale

#define JKAlertCurrentHomeIndicatorHeight (JKAlertIsIphoneX ? 34: 0)

#define JKAlertAdjustHomeIndicatorHeight (AutoAdjustHomeIndicator ? JKAlertCurrentHomeIndicatorHeight : 0)

#define JKAlertRowHeight ((JKAlertScreenW > 321) ? 53 : 46)

#define JKAlertTextContainerViewMaxH (JKAlertPlainViewMaxH - JKAlertScrollViewMaxH)

#define JKAlertSheetMaxH (JKAlertScreenH * 0.85)

static CGFloat    const JKAlertMinTitleLabelH = (22);
static CGFloat    const JKAlertMinMessageLabelH = (17);
static CGFloat    const JKAlertScrollViewMaxH = 176; // (JKAlertButtonH * 4)

static CGFloat    const JKAlertButtonH = 46;
static NSInteger  const JKAlertPlainButtonBeginTag = 100;

static CGFloat    const JKAlertSheetTitleMargin = 6;

/** 移除全部的通知 */
static NSString * const JKAlertDismissAllNotification = @"JKAlertDismissAllNotification";

/** 根据key来移除的通知 */
static NSString * const JKAlertDismissForKeyNotification = @"JKAlertDismissForKeyNotification";

@interface JKAlertHighlightedButton : UIButton

@end

@interface JKAlertSeparatorLayerButton : UIButton

/** topSeparatorLineLayer */
@property (nonatomic, weak) CALayer *topSeparatorLineLayer;
@end

@interface JKAlertView () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, JKAlertViewProtocol>
{
    BOOL JKAlertIsIphoneX;
    
    CGFloat TBMargin;
    CGFloat textContainerViewCurrentMaxH_;
    BOOL    _enableDeallocLog;
    CGFloat _iPhoneXLandscapeTextMargin;
    
    CGFloat JKAlertPlainViewMaxH;
    CGFloat JKAlertTitleMessageMargin;
    
    /** 分隔线宽度或高度 */
    CGFloat JKAlertSeparatorLineWH;
    
    CGRect oldPlainViewFrame;
    
    CGFloat CancelMargin;
    CGFloat PlainViewWidth;
    
    /** 是否自动适配 iPhone X homeIndicator */
    BOOL AutoAdjustHomeIndicator;
    
    BOOL FillHomeIndicator;
    
    BOOL Showed;
    
    UIView  *_backGroundView;
    UIColor *GlobalBackgroundColor;
    
    UIColor *titleTextColor;
    UIFont  *titleFont;
    
    UIColor *messageTextColor;
    UIFont  *messageFont;
    
    CGFloat JKAlertScreenW;
    CGFloat JKAlertScreenH;
}

/** customSuperView */
@property (nonatomic, weak) UIView *customSuperView;

/** 全屏的背景view */
@property (nonatomic, weak) UIView *fullScreenBackGroundView;

/** 全屏背景是否透明，默认黑色 0.4 alpha */
@property (nonatomic, assign) BOOL isClearFullScreenBackgroundColor;

/** 配置弹出视图的容器view */
@property (nonatomic, copy) void (^containerViewConfig)(UIView *containerView);

/** contentView */
@property (nonatomic, weak) UIView *contentView;

/** sheetContainerView */
@property (nonatomic, weak) UIView *sheetContainerView;

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

/** 最底层背景按钮 */
@property (nonatomic, weak) UIButton *dismissButton;

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

/** plainButtonVLineLayer */
@property (nonatomic, weak) CALayer *plainButtonVLineLayer;

/** plainCornerRadius */
@property (nonatomic, assign) CGFloat plainCornerRadius;

/** closeButton */
@property (nonatomic, weak) UIButton *closeButton;

/** clickPlainBlankDismiss */
@property (nonatomic, assign) BOOL clickPlainBlankDismiss;

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
@property (nonatomic, weak) CALayer *plainTitleMessageSeparatorLayer;

/** plain样式文字容器底部 分隔线 */
@property (nonatomic, weak) CALayer *plainTextContainerBottomLineLayer;

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
        
        alertView.customHUD = customView;
        
        !configuration ? : configuration(alertView);
        
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
        titleTextView.textColor = self.alertStyle == JKAlertStylePlain ? [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1] : [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1];
        titleTextView.font = self.alertStyle == JKAlertStylePlain ? [UIFont boldSystemFontOfSize:17] : [UIFont systemFontOfSize:17];
        [self addSubview:titleTextView];
        
        _titleTextView = titleTextView;
    }
    return _titleTextView;
}

- (JKAlertTextView *)messageTextView{
    if (!_messageTextView) {
        JKAlertTextView *messageTextView = [[JKAlertTextView alloc] init];
        messageTextView.textColor = self.alertStyle == JKAlertStyleActionSheet ? [UIColor colorWithRed:0.55 green:0.55 blue:0.55 alpha:1] : [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
        messageTextView.font = self.alertStyle == JKAlertStylePlain ? [UIFont systemFontOfSize:14] : [UIFont systemFontOfSize:13];
        [self addSubview:messageTextView];
        
        _messageTextView = messageTextView;
    }
    return _messageTextView;
}

- (UIScrollView *)plainTextContainerScrollView{
    if (!_plainTextContainerScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self addSubview:scrollView];
        
        [self adjustScrollView:scrollView];
        
        _plainTextContainerScrollView = scrollView;
        
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
        UIToolbar *toolbar = [[UIToolbar alloc] init];
        toolbar.clipsToBounds = YES;
        //UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        toolbar.clipsToBounds = YES;
        self.backGroundView = toolbar;
    }
    return _backGroundView;
}

- (UIView *)sheetContainerView{
    if (!_sheetContainerView) {
        UIView *sheetContainerView = [[UIView alloc] init];
        [self.contentView addSubview:sheetContainerView];
        _sheetContainerView = sheetContainerView;
        
        // 背景
        [self backGroundView];
    }
    return _sheetContainerView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        // 分隔线
        CALayer *hline = [CALayer layer];
        hline.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
        [self.textContainerView.layer addSublayer:hline];
        _plainTextContainerBottomLineLayer = hline;
        
        //        NSString *hVF = [NSString stringWithFormat:@"H:|-%d-[bottomLineView]-%d-|", (int)_iPhoneXLandscapeTextMargin, (int)_iPhoneXLandscapeTextMargin];
        //
        //        bottomLineView.translatesAutoresizingMaskIntoConstraints = NO;
        //        NSArray *bottomLineViewCons1 = [NSLayoutConstraint constraintsWithVisualFormat:hVF options:0 metrics:nil views:@{@"bottomLineView" : bottomLineView}];
        //        [self.textContainerView addConstraints:bottomLineViewCons1];
        //
        //        NSArray *bottomLineViewCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomLineView(0.5)]-0-|" options:0 metrics:nil views:@{@"bottomLineView" : bottomLineView}];
        //        [self.textContainerView addConstraints:bottomLineViewCons2];
        
        // title和message的容器view
        self.textContainerView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:0.7];
        [self.sheetContainerView addSubview:self.textContainerView];
        
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
        
        [_sheetContainerView addSubview:tableView];
        [_sheetContainerView insertSubview:tableView belowSubview:self.textContainerView];
        
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
        
        _tableView = tableView;
    }
    return _tableView;
}

- (UIView *)collectionTopContainerView{
    if (!_collectionTopContainerView) {
        UIView *collectionTopContainerView = [[UIView alloc] init];
        collectionTopContainerView.backgroundColor = GlobalBackgroundColor;
        [self.sheetContainerView addSubview:collectionTopContainerView];
        _collectionTopContainerView = collectionTopContainerView;
    }
    return _collectionTopContainerView;
}

- (JKAlertHighlightedButton *)cancelButton{
    if (!_cancelButton) {
        
        JKAlertHighlightedButton *cancelButton = [JKAlertHighlightedButton buttonWithType:(UIButtonTypeCustom)];
        [self.scrollView addSubview:cancelButton];
        
        cancelButton.backgroundColor = GlobalBackgroundColor;
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [cancelButton setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] forState:(UIControlStateNormal)];
        [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        //        [cancelButton setBackgroundImage:JKAlertCreateImageWithColor([UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:0.3], 1, 1, 0) forState:(UIControlStateHighlighted)];
        
        _cancelButton = cancelButton;
    }
    return _cancelButton;
}

- (JKAlertHighlightedButton *)collectionButton{
    if (!_collectionButton) {
        JKAlertHighlightedButton *collectionButton = [JKAlertHighlightedButton buttonWithType:(UIButtonTypeCustom)];
        collectionButton.backgroundColor = GlobalBackgroundColor;
        [self.scrollView addSubview:collectionButton];
        collectionButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [collectionButton setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] forState:(UIControlStateNormal)];
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
        pageControl.pageIndicatorTintColor = [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1];
        pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1];
        pageControl.userInteractionEnabled = NO;
        
        [self.collectionTopContainerView addSubview:pageControl];
        
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        [self.sheetContainerView insertSubview:self.scrollView atIndex:1];
        
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
        self.textContainerView.backgroundColor = nil;//GlobalBackgroundColor;
        [self.collectionTopContainerView addSubview:self.textContainerView];
        
        [self.textContainerView addSubview:self.titleTextView];
        
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
        //        plainView.backgroundColor = GlobalBackgroundColor;
        
        [plainView addSubview:self.textContainerView];
        
        [self.plainTextContainerScrollView addSubview:self.titleTextView];
        
        [self.plainTextContainerScrollView addSubview:self.messageTextView];
        
        [plainView addSubview:self.scrollView];
        
        [plainView insertSubview:self.scrollView belowSubview:self.textContainerView];
        
        if (_alertStyle == JKAlertStylePlain) {
            
            // 分隔线
            CALayer *hline = [CALayer layer];
            hline.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
            [self.textContainerView.layer addSublayer:hline];
            _plainTextContainerBottomLineLayer = hline;
            
            // 分隔线
            CALayer *hline2 = [CALayer layer];
            hline2.hidden = YES;
            hline2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
            [self.plainTextContainerScrollView.layer addSublayer:hline2];
            _plainTitleMessageSeparatorLayer = hline2;
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

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
    }
    return self;
}

- (void)initialization{
    
    [self setupDefaultData];
    
    [self setupUI];
}

- (void)setupDefaultData{
    
    /** 屏幕宽度 */
    JKAlertScreenW = [UIScreen mainScreen].bounds.size.width;
    
    /** 屏幕高度 */
    JKAlertScreenH = [UIScreen mainScreen].bounds.size.height;
    
    _isLandScape = [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight;
    
    if (@available(iOS 11.0, *)) {
        
        JKAlertIsIphoneX = UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom > 0;
        
    } else {
        
        JKAlertIsIphoneX = NO;
    }
    
    JKAlertPlainViewMaxH = (JKAlertScreenH - 100);
    
    _HUDHeight = -1;
    _enableDeallocLog = NO;
    _messageMinHeight = -1;
    _plainCornerRadius = 8;
    _dismissTimeInterval = 1;
    _textViewUserInteractionEnabled = YES;
    _plainTitleMessageSeparatorHidden = YES;
    _iPhoneXLandscapeTextMargin = 0;//((JKAlertIsIphoneX && JKAlertScreenW > JKAlertScreenH) ? 44 : 0);
    
    TBMargin = 20;
    PlainViewWidth = 290;
    AutoAdjustHomeIndicator = YES;
    FillHomeIndicator = YES;
    JKAlertTitleMessageMargin = 7;
    CancelMargin = ((JKAlertScreenW > 321) ? 7 : 5);
    JKAlertSeparatorLineWH = (1 / [UIScreen mainScreen].scale);
    textContainerViewCurrentMaxH_ = (JKAlertScreenH - 100 - JKAlertButtonH * 4);
    
    self.flowlayoutItemWidth = 76;
    self.textViewLeftRightMargin = 20;
    self.titleTextViewAlignment = NSTextAlignmentCenter;
    self.messageTextViewAlignment = NSTextAlignmentCenter;
    
    GlobalBackgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:0.7];
}

- (void)setupUI{
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [self insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *contentViewCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[contentView]-0-|" options:0 metrics:nil views:@{@"contentView" : contentView}];
    [self addConstraints:contentViewCons1];
    
    NSArray *contentViewCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[contentView]-0-|" options:0 metrics:nil views:@{@"contentView" : contentView}];
    [self addConstraints:contentViewCons2];
    
    UIButton *dismissButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    dismissButton.backgroundColor = nil;
    [self.contentView insertSubview:dismissButton atIndex:0];
    self.dismissButton = dismissButton;
    
    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *dismissButtonCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[dismissButton]-0-|" options:0 metrics:nil views:@{@"dismissButton" : dismissButton}];
    [self.contentView addConstraints:dismissButtonCons1];
    
    NSArray *dismissButtonCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[dismissButton]-0-|" options:0 metrics:nil views:@{@"dismissButton" : dismissButton}];
    [self.contentView addConstraints:dismissButtonCons2];
    
    [dismissButton addTarget:self action:@selector(dismissButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    // 移除全部的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissAllNotification:) name:JKAlertDismissAllNotification object:nil];
    
    // 根据key来移除的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissForKeyNotification:) name:JKAlertDismissForKeyNotification object:nil];
}

#pragma mark - setter------------------------

- (void)setAlertStyle:(JKAlertStyle)alertStyle{
    _alertStyle = alertStyle;
    
    _clickPlainBlankDismiss = YES;
    
    switch (_alertStyle) {
        case JKAlertStylePlain:
        {
            [self plainView];
            _clickPlainBlankDismiss = NO;
        }
            break;
            
        case JKAlertStyleActionSheet:
        {
            [self tableView];
        }
            break;
            
        case JKAlertStyleCollectionSheet:
        {
            CancelMargin = 10;
            
            [self collectionView];
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
    
    [self layoutUI];
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
    
    if (!_customPlainTitleView) {
        return;
    }
    
    //    if (!_customPlainTitleScrollView) {
    //
    //        UIScrollView *scrollView = [[UIScrollView alloc] init];
    //        [_textContainerView insertSubview:scrollView atIndex:0];
    //        _customPlainTitleScrollView = self.plainTextContainerScrollView;
    //
    //        [self adjustScrollView:scrollView];
    //
    //        scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    //        NSArray *scrollViewCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|" options:0 metrics:nil views:@{@"scrollView" : scrollView}];
    //        [_textContainerView addConstraints:scrollViewCons1];
    //
    //        NSArray *scrollViewCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[scrollView]-0-|" options:0 metrics:nil views:@{@"scrollView" : scrollView}];
    //        [_textContainerView addConstraints:scrollViewCons2];
    //    }
    
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
    
    _plainTitleMessageSeparatorLayer.hidden = _plainTitleMessageSeparatorHidden;
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
    
    return ^(CGFloat width){
        
        self->PlainViewWidth = width < 0 ? 0 : (width > MIN(JKAlertScreenW, JKAlertScreenH) ? MIN(JKAlertScreenW, JKAlertScreenH) : width);
        
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
        
        if (!JKAlertIsIphoneX) { return self; }
        
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
        
        CGRect frame = _plainView.frame;
        frame.origin.y = Y;
        
        if (animated) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self->_plainView.frame = frame;
            }];
            
        }else{
            
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
                
                self->_plainView.center = CGPointMake(self->_plainView.center.x, self->_plainView.center.y + centerOffsetY);
            }];
            
        }else{
            
            self->_plainView.center = CGPointMake(self->_plainView.center.x, self->_plainView.center.y + centerOffsetY);
        }
        
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
 * 默认是一个UIToolbar
 */
- (JKAlertView *(^)(UIView *(^backGroundView)(void)))setBackGroundView{
    
    return ^(UIView *(^backGroundView)(void)){
        
        self.backGroundView = !backGroundView ? nil : backGroundView();
        
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
 * 设置该值后可以使用类方法 JKAlertView.DismissForKey(dimissKey); 来手动消失
 */
- (JKAlertView *(^)(NSString *dimissKey))setDismissKey{
    
    return ^(NSString *dimissKey){
        
        self.dismissKey = dimissKey;
        
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
    
    switch ([UIApplication sharedApplication].statusBarOrientation){
        case UIInterfaceOrientationPortrait:{
            
            //orientationLabel.text = "面向设备保持垂直，Home键位于下部"
            
            /** 屏幕宽度 */
            JKAlertScreenW = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            /** 屏幕高度 */
            JKAlertScreenH = MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
            _isLandScape = NO;
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:{
            
            //orientationLabel.text = "面向设备保持垂直，Home键位于上部"
            
            /** 屏幕宽度 */
            JKAlertScreenW = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            /** 屏幕高度 */
            JKAlertScreenH = MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
            _isLandScape = NO;
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            
            //orientationLabel.text = "面向设备保持水平，Home键位于左侧"
            
            /** 屏幕宽度 */
            JKAlertScreenW = MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            /** 屏幕高度 */
            JKAlertScreenH = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
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
            JKAlertScreenW = MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            /** 屏幕高度 */
            JKAlertScreenH = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
            _isLandScape = YES;
        }
            break;
        default:{
            
            // orientationLabel.text = "方向未知"
        }
            break;
    }
    
    [self layoutUI];
}

#pragma mark - 添加action------------------------

/** 添加action */
- (JKAlertView *(^)(JKAlertAction *action))addAction{
    
    return ^(JKAlertAction *action){
        
        [self addAction:action];
        
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

/** 添加action */
- (void)insertAction:(JKAlertAction *)action atIndex:(NSUInteger)index{
    
    if (!action) { return; }
    
    action.alertView = self;
    
    [self.actions insertObject:action atIndex:index];
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


#pragma mark - 添加textField

/**
 * 添加textField 默认高度30
 * textField之间的间距是1，和其superView的上下左右间距也是1
 * textField可以直接对其superView进行一些属性修改，如背景色
 * block中的参数view用于调用dismiss()来移除当前弹框
 */
- (void)addTextFieldWithConfigurationHandler:(void (^)(JKAlertView *view, UITextField *textField))configurationHandler{
    
    UITextField *tf = [[UITextField alloc] init];
    
    tf.backgroundColor = GlobalBackgroundColor;
    
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
        
    }else{
        
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
        
        [self layoutUI];
        
        [_scrollView removeFromSuperview];
        
        return;
    }
    
    [self layoutUI];
}

// sheet样式
- (void)showAcitonSheet{
    
    if (!self.cancelAction) {
        
        self.cancelAction = [JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {}];
        self.cancelAction.setTitleFont([UIFont systemFontOfSize:17]);
        self.cancelAction.setTitleColor([UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]);
    }
    
    self.cancelAction.setSeparatorLineHidden(YES);
    [self.actions.lastObject setSeparatorLineHidden:YES];
    
    [self layoutUI];
}

// collectionSheet样式
- (void)showCollectionSheet{
    
    if (!self.cancelAction) {
        
        self.cancelAction = [JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {}];
        self.cancelAction.setTitleFont([UIFont systemFontOfSize:17]);
        self.cancelAction.setTitleColor([UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]);
    }
    
    [self layoutUI];
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
                
                action.setTitleColor((_alertStyle == JKAlertStylePlain ? [UIColor colorWithRed:0 green:119.0/255.0 blue:251.0/255.0 alpha:1] : [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]));
                break;
                
            case JKAlertActionStyleCancel:
                
                action.setTitleColor([UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1]);
                break;
                
            case JKAlertActionStyleDestructive:
                
                action.setTitleColor([UIColor redColor]);
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

- (void)layoutUI{
    
    self.frame = [UIScreen mainScreen].bounds;
    
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
        
    }else if (self.alertTitle) {
        
        _titleTextView.text = self.alertTitle;
        
    }else{
        
        _titleTextView.hidden = YES;
    }
    
    if (self.attributedMessage) {
        
        _messageTextView.attributedText = self.attributedMessage;
        
    }else if (self.message) {
        
        _messageTextView.text = self.message;
        
    }else{
        
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
    
    [self layoutUIFinish];
}

- (void)layoutUIFinish{
    
    [_tableView reloadData];
    
    [_collectionView reloadData];
    
    [_collectionView2 reloadData];
}

#pragma mark - 布局plain
- (void)layoutPlain{
    
    _plainView.frame = CGRectMake((JKAlertScreenW - PlainViewWidth) * 0.5, (JKAlertScreenH - 200) * 0.5, PlainViewWidth, 200);
    _textContainerView.frame = CGRectMake(0, 0, PlainViewWidth, TBMargin + JKAlertMinTitleLabelH + JKAlertTitleMessageMargin + JKAlertMinMessageLabelH + TBMargin);
    
    NSInteger count = self.actions.count;
    
    [self.titleTextView calculateFrameWithMaxWidth:PlainViewWidth - self.textViewLeftRightMargin * 2 minHeight:JKAlertMinTitleLabelH originY:TBMargin superView:self.textContainerView];
    
    CGFloat messageOriginY = CGRectGetMaxY(self.titleTextView.frame) + (_plainTitleMessageSeparatorHidden ? JKAlertTitleMessageMargin : TBMargin + JKAlertTitleMessageMargin);
    
    if (!_plainTitleMessageSeparatorHidden) {
        
        _plainTitleMessageSeparatorLayer.frame = CGRectMake(_plainTitleMessageSeparatorMargin, messageOriginY - JKAlertTitleMessageMargin - JKAlertSeparatorLineWH, PlainViewWidth - _plainTitleMessageSeparatorMargin * 2, JKAlertSeparatorLineWH);
    }
    
    [self.messageTextView calculateFrameWithMaxWidth:PlainViewWidth - self.textViewLeftRightMargin * 2 minHeight:JKAlertMinMessageLabelH originY:messageOriginY superView:self.textContainerView];
    
    CGRect rect = self.textContainerView.frame;
    
    rect.size.height = TBMargin + self.titleTextView.frame.size.height + JKAlertTitleMessageMargin + self.messageTextView.frame.size.height + TBMargin;
    
    rect.size.height += (_plainTitleMessageSeparatorHidden ? 0 : (JKAlertTitleMessageMargin));
    
    if (self.titleTextView.hidden && self.messageTextView.hidden) {
        
        _plainTitleMessageSeparatorLayer.hidden = YES;
        
        rect.size.height = 0;
        
    }else if (self.titleTextView.hidden && !self.messageTextView.hidden) {
        
        _plainTitleMessageSeparatorLayer.hidden = YES;
        
        self.messageTextView.frame = CGRectMake((PlainViewWidth - self.messageTextView.frame.size.width) * 0.5, 0, self.messageTextView.frame.size.width, self.messageTextView.frame.size.height);
        
        rect.size.height = TBMargin + self.messageTextView.frame.size.height + TBMargin;
        
        self.messageTextView.center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
        
        _messageMinHeight = (_messageMinHeight == -1 ? 30 : _messageMinHeight);
        
    }else if (self.messageTextView.hidden && !self.titleTextView.hidden) {
        
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
    
    if (_plainTextContainerBottomLineLayer.hidden) { return; }
    
    _plainTextContainerBottomLineLayer.frame = CGRectMake(0, self.textContainerView.frame.size.height - JKAlertSeparatorLineWH, self.textContainerView.frame.size.width, JKAlertSeparatorLineWH);
    
    _plainTextContainerBottomLineLayer.hidden = (self.textContainerView.frame.size.height <= 0 || self.scrollView.frame.size.height <= 0);
    
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
            
            [button setBackgroundImage:JKAlertCreateImageWithColor([UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1], 1, 1, 0) forState:(UIControlStateHighlighted)];
            
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
            
            _plainTextContainerBottomLineLayer.hidden = action.separatorLineHidden;
        }
        
        if (i == 1 && count == 2) {
            
            button.frame = CGRectMake(X, Y, W, [self.scrollView viewWithTag:JKAlertPlainButtonBeginTag].frame.size.height);
        }
        
        if (action.separatorLineHidden) {
            continue;
        }
        
        if (count == 2 && i == 1) {
            
            if (action.separatorLineHidden) { continue; }
            
            if (!self.plainButtonVLineLayer) {
                
                CALayer *vline = [CALayer layer];
                [button.layer addSublayer:vline];
                vline.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
                self.plainButtonVLineLayer = vline;
            }
            
            self.plainButtonVLineLayer.frame = CGRectMake(0, -0.2, JKAlertSeparatorLineWH, JKAlertButtonH);
        }
        
        if (count <= 2 || i == 0) { continue; }
        
        if (action.separatorLineHidden) { continue; }
        
        if (!button.topSeparatorLineLayer) {
            CALayer *hline = [CALayer layer];
            hline.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
            [button.layer addSublayer:hline];
            button.topSeparatorLineLayer = hline;
        }
        
        button.topSeparatorLineLayer.frame = CGRectMake(0.3, 0, button.frame.size.width, JKAlertSeparatorLineWH);
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
        
    }else if (self.textContainerView.frame.size.height > JKAlertTextContainerViewMaxH) {
        
        frame = self.textContainerView.frame;
        frame.size.height = (frame.size.height + self.scrollView.frame.size.height) > JKAlertPlainViewMaxH ? JKAlertPlainViewMaxH - self.scrollView.frame.size.height : frame.size.height;
        self.textContainerView.frame = frame;
        
    }else if (self.scrollView.frame.size.height > JKAlertScrollViewMaxH) {
        
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
     
     }else if (self.titleTextView.frame.size.height > maxH) {
     
     frame = self.titleTextView.frame;
     frame.size.height = textContainerViewCurrentMaxH_ - TBMargin - JKAlertTitleMessageMargin - TBMargin - self.messageTextView.frame.size.height;
     self.titleTextView.frame = frame;
     
     frame = self.messageTextView.frame;
     frame.origin.y = CGRectGetMaxY(self.titleTextView.frame) + JKAlertTitleMessageMargin;
     self.messageTextView.frame = frame;
     
     }else if (self.messageTextView.frame.size.height > maxH) {
     
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
        
    }else if (self.titleTextView.hidden && !self.messageTextView.hidden) {
        
        rect.size.height = JKAlertSheetTitleMargin + self.messageTextView.frame.size.height + JKAlertSheetTitleMargin;
        rect.size.height = rect.size.height < JKAlertRowHeight ? JKAlertRowHeight : rect.size.height;
        
        self.messageTextView.center = CGPointMake(self.textContainerView.frame.size.width * 0.5, rect.size.height * 0.5);
        
    }else if (self.messageTextView.hidden && !self.titleTextView.hidden) {
        
        rect.size.height = JKAlertSheetTitleMargin + self.titleTextView.frame.size.height + JKAlertSheetTitleMargin;
        rect.size.height = rect.size.height < JKAlertRowHeight ? JKAlertRowHeight : rect.size.height;
        
        self.titleTextView.center = CGPointMake(self.textContainerView.frame.size.width * 0.5, rect.size.height * 0.5);
    }
    
    if (_customSheetTitleView) {
        
        rect.size.height = _customSheetTitleView.frame.size.height;
        
        _customSheetTitleView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    }
    
    _plainTextContainerBottomLineLayer.hidden = rect.size.height == 0;
    
    _textContainerView.frame = rect;
    _scrollView.contentSize = rect.size;
    
    [self adjustSheetFrame];
    
    _sheetContainerView.frame = CGRectMake(0, JKAlertScreenH - (_textContainerView.frame.size.height + _tableView.frame.size.height), JKAlertScreenW, _textContainerView.frame.size.height + _tableView.frame.size.height);
    _scrollView.frame = CGRectMake(0, 0, _textContainerView.bounds.size.width, _textContainerView.bounds.size.height);
    
    _tableView.scrollEnabled = _tableView.frame.size.height < tableViewH;
    
    _plainTextContainerBottomLineLayer.frame = CGRectMake(0, self.textContainerView.frame.size.height - JKAlertSeparatorLineWH, self.textContainerView.frame.size.width, JKAlertSeparatorLineWH);
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
        
    }else if (self.textContainerView.frame.size.height > JKAlertSheetMaxH * 0.5) {
        
        frame = self.textContainerView.frame;
        frame.size.height = (frame.size.height + self.tableView.frame.size.height) > JKAlertSheetMaxH ? JKAlertSheetMaxH - self.tableView.frame.size.height : frame.size.height;
        self.textContainerView.frame = frame;
        
    }else if (self.tableView.frame.size.height > JKAlertSheetMaxH * 0.5) {
        
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
            
        }else{
            
            for (NSInteger i = 0; i < count2 - count; i++) {
                
                [self addAction:[JKAlertAction actionWithTitle:nil style:(0) handler:nil]];
            }
            
            count = count2;
        }
    }
    
    _iPhoneXLandscapeTextMargin = ((JKAlertIsIphoneX && JKAlertScreenW > JKAlertScreenH) ? 44 : 0);
    
    CGRect rect = [self.titleTextView calculateFrameWithMaxWidth:JKAlertScreenW - self.textViewLeftRightMargin * 2 - _iPhoneXLandscapeTextMargin * 2 minHeight:JKAlertMinTitleLabelH originY:0 superView:self.textContainerView];
    
    _iPhoneXLandscapeTextMargin = 0;
    
    if (JKAlertScreenH * 0.8 - 395 > JKAlertMinTitleLabelH) {
        
        rect.size.height = rect.size.height > JKAlertScreenH * 0.8 - 395 ? JKAlertScreenH * 0.8 - 395 : rect.size.height;
    }
    
    rect.size.height = self.titleTextView.hidden ? -TBMargin * 2 : rect.size.height;
    
    self.titleTextView.frame = rect;
    
    self.textContainerView.frame = CGRectMake(0, 0, JKAlertScreenW, TBMargin + rect.size.height + TBMargin);
    self.titleTextView.center = CGPointMake(self.textContainerView.frame.size.width * 0.5, self.textContainerView.frame.size.height * 0.5);
    
    if (_customSheetTitleView) {
        
        self.textContainerView.frame = CGRectMake(0, 0, JKAlertScreenW, _customSheetTitleView.frame.size.height);
        _customSheetTitleView.frame = CGRectMake(_iPhoneXLandscapeTextMargin, 0, JKAlertScreenW - _iPhoneXLandscapeTextMargin * 2, _customSheetTitleView.frame.size.height);
    }
    
    self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.textContainerView.frame), JKAlertScreenW, self.flowlayoutItemWidth - 6 + 10);
    self.flowlayout.itemSize = CGSizeMake(self.flowlayoutItemWidth, self.flowlayoutItemWidth - 6);
    self.flowlayout.sectionInset = UIEdgeInsetsMake(self.flowlayout.itemSize.height - self.collectionView.frame.size.height, 0, 0, 0);
    
    if (count2 > 0) {
        
        self.collectionView2.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), JKAlertScreenW, self.collectionView.frame.size.height);
        
        self.flowlayout2.itemSize = CGSizeMake(self.flowlayoutItemWidth, self.flowlayoutItemWidth - 6);
        self.flowlayout2.sectionInset = UIEdgeInsetsMake(self.flowlayout2.itemSize.height - self.collectionView2.frame.size.height, 0, 0, 0);
    }
    
    if (_showPageControl && _collectionPagingEnabled) {
        
        if (count2 <= 0) {
            
            self.pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), self.sheetContainerView.frame.size.width, 27);
            
        }else{
            
            if (_compoundCollection) {
                
                self.pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView2.frame), self.sheetContainerView.frame.size.width, 27);
            }
        }
    }
    
    [self adjustButton:self.cancelButton action:self.cancelAction];
    
    CGRect frame = CGRectZero;
    
    if (self.collectionAction) {
        
        [self adjustButton:self.collectionButton action:self.collectionAction];
        
        frame = CGRectMake(self.collectionButtonLeftRightMargin + _iPhoneXLandscapeTextMargin, CGRectGetMaxY(_pageControl ? _pageControl.frame : (_collectionView2 ? _collectionView2.frame : _collectionView.frame)) + CancelMargin, JKAlertScreenW - self.collectionButtonLeftRightMargin * 2 - _iPhoneXLandscapeTextMargin * 2, JKAlertButtonH);
        
        if (self.collectionAction.customView) {
            
            frame.size.height = self.collectionAction.customView.frame.size.height;
        }
        
        self.collectionButton.frame = frame;
        
        self.collectionAction.customView.frame = self.collectionButton.bounds;
    }
    
    frame = CGRectMake(self.collectionButtonLeftRightMargin + _iPhoneXLandscapeTextMargin, CGRectGetMaxY(_collectionButton ? _collectionButton.frame : (_collectionView2 ? _collectionView2.frame : _collectionView.frame)) + CancelMargin, JKAlertScreenW - self.collectionButtonLeftRightMargin * 2 - _iPhoneXLandscapeTextMargin * 2, JKAlertButtonH);
    
    if (self.cancelAction.customView) {
        
        frame.size.height = self.cancelAction.customView.frame.size.height;
    }
    
    self.cancelButton.frame = frame;
    
    self.cancelAction.customView.frame = self.cancelButton.bounds;
    
    rect = CGRectMake(0, JKAlertScreenH - (CGRectGetMaxY(self.cancelButton.frame) + JKAlertAdjustHomeIndicatorHeight), JKAlertScreenW, CGRectGetMaxY(self.cancelButton.frame) + JKAlertAdjustHomeIndicatorHeight);
    
    self.collectionTopContainerView.frame = CGRectMake(0, 0, JKAlertScreenW, (_pageControl ? CGRectGetMaxY(_pageControl.frame) : (_collectionView2 ? CGRectGetMaxY(_collectionView2.frame) : CGRectGetMaxY(_collectionView.frame))));
    
    self.scrollView.contentSize = rect.size;
    
    if (rect.size.height > JKAlertScreenH * 0.8) {
        
        rect.size.height = JKAlertScreenH * 0.8;
        rect.origin.y = JKAlertScreenH * 0.2;
    }
    
    self.sheetContainerView.frame = rect;
    
    CGFloat itemMargin = (JKAlertScreenW - self.flowlayout.itemSize.width * count) / count;
    
    itemMargin = itemMargin < 0 ? 0 : itemMargin;
    
    if (count2 > 0) {
        
        CGFloat itemMargin2 = (JKAlertScreenW - self.flowlayout2.itemSize.width * count2) / count2;
        itemMargin2 = itemMargin2 < 0 ? 0 : itemMargin2;
        
        itemMargin = MIN(itemMargin, itemMargin2);
        
        self.flowlayout2.sectionInset = UIEdgeInsetsMake(self.flowlayout2.sectionInset.top, itemMargin * 0.5, 0, itemMargin * 0.5);
        self.flowlayout2.minimumLineSpacing = itemMargin;
        self.flowlayout2.minimumInteritemSpacing = itemMargin;
    }
    
    self.flowlayout.sectionInset = UIEdgeInsetsMake(self.flowlayout.sectionInset.top, itemMargin * 0.5, 0, itemMargin * 0.5);
    self.flowlayout.minimumLineSpacing = itemMargin;
    self.flowlayout.minimumInteritemSpacing = itemMargin;
    
    _pageControl.numberOfPages = ceil((itemMargin + _flowlayout.itemSize.width) * count / JKAlertScreenW);
    
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
        
        //        NSLog(@"%@", NSStringFromUIEdgeInsets(self.cancelButton.titleEdgeInsets));
        [self.cancelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, JKAlertCurrentHomeIndicatorHeight, 0)];
        
        self.cancelAction.customView.frame = self.cancelButton.bounds;
    }
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
}

- (void)startShowAnimation{
    
    self.window.userInteractionEnabled = NO;
    
    if (self.customShowAnimationBlock) {
        
        self.customShowAnimationBlock(self, _plainView ? _plainView : _sheetContainerView);
        
    }else{
        
        _plainView.alpha = 0;
        _plainView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        _sheetContainerView.frame = CGRectMake(_sheetContainerView.frame.origin.x, JKAlertScreenH, _sheetContainerView.frame.size.width, _sheetContainerView.frame.size.height);
    }
    
    self.fullScreenBackGroundView.alpha = 0;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        if (!self.isClearFullScreenBackgroundColor) {
            
            self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
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
    
    if (self.currentTextField) {
        
        if (!self.currentTextField.hidden) {
            
            if (!self.currentTextField.isFirstResponder) {
                
                [self.currentTextField becomeFirstResponder];
            }
            
        }else{
            
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
        
        [self layoutUI];
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [self layoutIfNeeded];
        }];
        
    }else{
        
        CGFloat maxH = JKAlertScreenH - (JKAlertIsIphoneX ? 44 : 20) - keyboardFrame.size.height - 40;
        
        if ([self isLandScape]) {
            
            maxH = JKAlertScreenH - 5 - keyboardFrame.size.height - 5;
            
            JKAlertPlainViewMaxH = maxH;
            
            [self layoutUI];
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
        
        [self layoutUI];
        
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
    
    if (_plainView != nil) {
        
        [self endEditing:YES];
    }
    
    if (_clickPlainBlankDismiss) {
        
        self.dismiss();
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
        
        self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
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
        
    }else{
        
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
    
    if (!self.compoundCollection || scrollView == _tableView) {
        return;
    }
    
    _collectionView.contentOffset = scrollView.contentOffset;
    
    _collectionView2.contentOffset = scrollView.contentOffset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == _tableView) {
        return;
    }
    
    _pageControl.currentPage = ceil(scrollView.contentOffset.x / JKAlertScreenW);
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

/** 重新布局 */
- (id<JKAlertViewProtocol> (^)(BOOL animated))relayout{
    
    return ^(BOOL animated){
        
        if (animated) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                [self layoutUI];
                
            } completion:^(BOOL finished) {
                
                !self.relayoutComplete ? : self.relayoutComplete(self);
            }];
            
        } else {
            
            [self layoutUI];
            
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
    
    self.backgroundColor = highlighted ? [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:0.3] : [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:0.7];
}
@end




@implementation JKAlertSeparatorLayerButton

@end


