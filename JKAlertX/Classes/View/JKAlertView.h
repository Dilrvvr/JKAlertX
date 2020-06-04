//
//  JKAlertView.h
//  TestVideoAndPicture
//
//  Created by albert on 2017/4/18.
//  Copyright © 2017年 安永博. All rights reserved.
//

#import "JKAlertBaseAlertView.h"
#import "JKAlertAction.h"
#import "JKAlertMultiColor.h"

@interface JKAlertView : JKAlertBaseAlertView

#pragma mark
#pragma mark - 基本方法

/** 实例化 */
+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                             style:(JKAlertStyle)style;

/** 富文本实例化 */
+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)attributedTitle
                           attributedMessage:(NSAttributedString *)attributedMessage
                                       style:(JKAlertStyle)style;

/** 添加action */
- (void)addAction:(JKAlertAction *)action;

/**
 * 添加textField 默认高度30
 * textField之间的间距是1，和其superView的上下左右间距也是1
 * textField可以直接对其superView进行一些属性修改，如背景色
 * block中的参数view用于调用dismiss()来移除当前弹框
 */
- (void)addTextFieldWithConfigurationHandler:(void (^)(JKAlertView *view, UITextField *textField))configurationHandler;

/** 显示 */
@property (nonatomic, copy, readonly) JKAlertView *(^show)(void);

/** 显示并监听JKAlertView消失动画完成 */
@property (nonatomic, copy, readonly) void (^showWithDidDismissHandler)(void(^handler)(void));

/** 退出 */
@property (nonatomic, copy, readonly) void (^dismiss)(void);


#pragma mark
#pragma mark - 公共部分

/** 设置默认的取消action，不需要自带的可以自己设置，不可置为nil */
@property (nonatomic, copy, readonly) JKAlertView *(^setCancelAction)(JKAlertAction *action);


#pragma mark
#pragma mark actionSheet样式

/**
 * 设置actionSheet样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 * isClearContainerBackgroundColor : 是否让其容器视图透明
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomActionSheetTitleView)(BOOL isClearContainerBackgroundColor, UIView *(^customView)(void));

/** 设置sheet样式最大高度 默认屏幕高度 * 0.85 */
@property (nonatomic, copy, readonly) JKAlertView *(^setSheetMaxHeight)(CGFloat height);

/** 自定义配置tableView */
@property (nonatomic, copy, readonly) JKAlertView *(^setTableViewConfiguration)(void(^)(UITableView *tableView));

/** 设置UITableViewDataSource */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomTableViewDataSource)(id<UITableViewDataSource> dataSource);

/** 设置UITableViewDelegate */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomTableViewDelegate)(id<UITableViewDelegate> delegate);

/** 设置actionSheet底部取消按钮是否固定在底部 默认NO */
@property (nonatomic, copy, readonly) JKAlertView *(^setPinCancelButton)(BOOL pinCancelButton);

/**
 * 设置actionSheet是否镂空
 * 类似UIAlertControllerStyleActionSheet效果
 * 设置为YES后，setPinCancelButton将强制为YES
 * bottomMargin : 非X设备底部取消按钮距离底部的间距 默认为((JKAlertScreenW > 321) ? 7 : 5)
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setActionSheetPierced)(BOOL isPierced, CGFloat cornerRadius, CGFloat horizontalMargin, CGFloat bottomMargin, UIColor *lightBackgroundColor, UIColor *darkBackgroundColor);


#pragma mark
#pragma mark collectionSheet样式

/**
 * 设置collection的itemSize的宽度
 * 最大不可超过屏幕宽度的一半
 * 注意图片的宽高是设置的宽度-30，即图片在cell中是左右各15的间距
 * 自动计算item之间间距，最小为0，可自己计算该值设置每屏显示个数
 * 默认的高度是宽度-6，暂不支持自定义高度
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setFlowlayoutItemWidth)(CGFloat width);

/**
 * 设置collection列数（每行数量）
 * 默认0，自动设置，不得大于自动设置的数量
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionColumnCount)(NSInteger columnCount);

/**
 * 设置collection的水平（左右方向）的sectionInset
 * 默认0，为0时自动设置为item间距的一半
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionHorizontalInset)(CGFloat inset);

/** 设置collection的title下分隔线是否隐藏 默认YES */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionTitleSeperatorHidden)(BOOL hidden);

/**
 * 设置两个collectionView之间的间距
 * 有第二个collectionView时有效 默认10, 最小为0
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionViewMargin)(CGFloat margin);

/**
 * 设置是否将两个collection合体
 * 设为YES可让两个collection同步滚动
 * 设置YES时会自动让两个collection的action数量保持一致，即向少的一方添加空的action
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCompoundCollection)(BOOL compoundCollection);

/** 设置collection是否分页 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionPagingEnabled)(BOOL collectionPagingEnabled);

/**
 * 设置collection是否显示pageControl
 * 如果只有一组collection，则必须设置分页为YES才有效
 * 如果有两组collection，则仅在分页和合体都为YES时才有效
 * 注意自己计算好每页显示的个数相等
 * 可以添加空的action来保证每页显示个数相等
 * JKAlertAction使用类方法初始化时每个参数传nil或者直接自己实例化一个即为空action
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setShowPageControl)(BOOL showPageControl);

/**
 * 设置pageControl
 * 必须setShowPageControl为YES之后才会有值
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionPageControlConfig)(void(^)(UIPageControl *pageControl));

/** 设置colletion样式的底部按钮左右间距 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionButtonLeftRightMargin)(CGFloat margin);

/** collection样式默认有一个取消按钮，设置这个可以在取消按钮的上面再添加一个按钮 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCollectionAction)(JKAlertAction *action);

/**
 * 设置collection样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomCollectionTitleView)(UIView *(^customView)(void));

/** collection添加第二个collectionView的action */
- (void)addSecondCollectionAction:(JKAlertAction *)action;

/** 添加第二个collectionView的action */
- (void)insertSecondCollectionAction:(JKAlertAction *)action atIndex:(NSUInteger)index;

/** collection链式添加第二个collectionView的action */
@property (nonatomic, copy, readonly) JKAlertView *(^addSecondCollectionAction)(JKAlertAction *action);

/** collection链式添加第二个collectionView的action */
@property (nonatomic, copy, readonly) JKAlertView *(^insertSecondCollectionAction)(JKAlertAction *action, NSUInteger atIndex);


#pragma mark
#pragma mark 类方法

/** 函数式类方法 */
@property (class, nonatomic, copy, readonly) JKAlertView *(^show)(NSString *title, NSString *message, JKAlertStyle style, void(^configuration)(JKAlertView *alertView));

/** 链式实例化 */
@property (class, nonatomic, copy, readonly) JKAlertView *(^alertView)(NSString *title, NSString *message, JKAlertStyle style);

/** 富文本链式实例化 */
@property (class, nonatomic, copy, readonly) JKAlertView *(^alertViewAttributed)(NSAttributedString *attributedTitle, NSAttributedString *attributedMessage, JKAlertStyle style);

/** 显示文字HUD */
@property (class, nonatomic, copy, readonly) void (^showHUDWithTitle)(NSString *title, void(^configuration)(JKAlertView *alertView));

/** 显示富文本HUD */
@property (class, nonatomic, copy, readonly) void (^showHUDWithAttributedTitle)(NSAttributedString *attributedTitle, void(^configuration)(JKAlertView *alertView));

/**
 * 显示自定义HUD
 * 注意使用点语法调用，否则莫名报错 JKAlertView.showCustomHUD
 * customHUD尺寸将完全由自定义控制，默认显示在屏幕中间
 * 注意自己计算好自定义HUD的size，以避免横竖屏出现问题
 */
@property (class, nonatomic, copy, readonly) void (^showCustomHUD)(UIView *(^customHUD)(void), void(^configuration)(JKAlertView *alertView));


#pragma mark
#pragma mark 添加action

/** 添加action */
- (void)insertAction:(JKAlertAction *)action atIndex:(NSUInteger)index;

/** 链式添加action */
@property (nonatomic, copy, readonly) JKAlertView *(^addAction)(JKAlertAction *action);

/** 链式添加action */
@property (nonatomic, copy, readonly) JKAlertView *(^insertAction)(JKAlertAction *action, NSUInteger atIndex);


#pragma mark
#pragma mark action数组操作

/** 添加action */
- (void)addAction:(JKAlertAction *)action isSecondCollection:(BOOL)isSecondCollection;

/** 移除action */
- (void)removeAction:(JKAlertAction *)action isSecondCollection:(BOOL)isSecondCollection;

/** 添加action */
- (void)insertAction:(JKAlertAction *)action atIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection;

/** 移除action */
- (void)removeActionAtIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection;

/** 获取action */
- (JKAlertAction *)getActionAtIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection;

/** 获取cancelAction */
- (JKAlertAction *)getCancelAction;

/** 获取collectionAction */
- (JKAlertAction *)getCollectionAction;

/** 获取action数组 */
- (NSArray *)getActionArrayIsSecondCollection:(BOOL)isSecondCollection;

/** 清空action数组 */
- (void)clearActionArrayIsSecondCollection:(BOOL)isSecondCollection;

/** 链式添加action */
@property (nonatomic, copy, readonly) JKAlertView *(^addActionTo)(JKAlertAction *action, BOOL isSecondCollection);

/** 链式移除action */
@property (nonatomic, copy, readonly) JKAlertView *(^removeActionFrom)(JKAlertAction *action, BOOL isSecondCollection);

/** 链式添加action */
@property (nonatomic, copy, readonly) JKAlertView *(^insertActionTo)(JKAlertAction *action, NSUInteger atIndex, BOOL isSecondCollection);

/** 链式移除action */
@property (nonatomic, copy, readonly) JKAlertView *(^removeActionAtIndexFrom)(NSUInteger index, BOOL isSecondCollection);

/** 链式获取action */
@property (nonatomic, copy, readonly) JKAlertView *(^getActionAtIndexFrom)(NSUInteger index, BOOL isSecondCollection, void(^)(JKAlertAction *action));

/** 链式获取cancelAction或collectionAction */
@property (nonatomic, copy, readonly) JKAlertView *(^getCancelOrCollectionAction)(BOOL isCancelAction, void(^)(JKAlertAction *action));

/** 链式获取action数组 */
@property (nonatomic, copy, readonly) JKAlertView *(^getActionArrayFrom)(BOOL isSecondCollection, void(^)(NSArray *actionArray));

/** 链式清空action数组 */
@property (nonatomic, copy, readonly) JKAlertView *(^clearActionArrayFrom)(BOOL isSecondCollection);


#pragma mark
#pragma mark 添加textField

/**
 * 链式添加textField 默认高度30
 * textField之间的间距是1，和其superView的上下左右间距也是1
 * textField可以直接对其superView进行一些属性修改，如背景色
 * block中的参数view用于调用dismiss()来移除当前弹框
 */
@property (nonatomic, copy, readonly) JKAlertView *(^addTextFieldWithConfigurationHandler)(void (^)(JKAlertView *view, UITextField *textField));


#pragma mark
#pragma mark 自定义动画

/**
 * 设置自定义展示动画，动画完成一定要调用showAnimationDidComplete
 * 此时所有frame已经计算好，plain样式animationView在中间，sheet样式animationView在底部
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomShowAnimationBlock)(void(^)(JKAlertView *view, UIView *animationView));

/** 自定义展示动画时，用于通知一下动画已经完成 */
@property (nonatomic, copy, readonly) void (^showAnimationDidComplete)(void);

/** 设置自定义消失动画，动画完成一定要调用dismissAnimationDidComplete */
@property (nonatomic, copy, readonly) JKAlertView *(^setCustomDismissAnimationBlock)(void(^)(JKAlertView *view, UIView *animationView));

/** 自定义消失动画时，用于通知一下动画已经完成 */
@property (nonatomic, copy, readonly) void (^dismissAnimationDidComplete)(void);


#pragma mark
#pragma mark 状态监听

/** 监听屏幕旋转 */
@property (nonatomic, copy, readonly) JKAlertView *(^setOrientationChangeBlock)(void(^orientationChangeBlock)(JKAlertView *view, UIInterfaceOrientation orientation));

/** 设置监听superView尺寸改变时将要自适应的block */
@property (nonatomic, copy, readonly) JKAlertView *(^setWillAutoAdaptSuperViewBlock)(void(^willAdaptBlock)(JKAlertView *view, UIView *containerView));

/** 设置监听superView尺寸改变时自适应完成的block */
@property (nonatomic, copy, readonly) JKAlertView *(^setDidAutoAdaptSuperViewBlock)(void(^didAdaptBlock)(JKAlertView *view, UIView *containerView));


#pragma mark
#pragma mark 显示之后更新UI

/** 重新设置alertTitle */
@property (nonatomic, copy, readonly) JKAlertView *(^resetAlertTitle)(NSString *alertTitle);

/** 重新设置alertAttributedTitle */
@property (nonatomic, copy, readonly) JKAlertView *(^resetAlertAttributedTitle)(NSAttributedString *alertAttributedTitle);

/** 重新设置message */
@property (nonatomic, copy, readonly) JKAlertView *(^resetMessage)(NSString *message);

/** 重新设置attributedMessage */
@property (nonatomic, copy, readonly) JKAlertView *(^resetAttributedMessage)(NSAttributedString *attributedMessage);

/** 重新布局 */
@property (nonatomic, copy, readonly) JKAlertView *(^relayout)(BOOL animated);

/**
 * 重新布局完成的block
 * ****************** WARNING!!! ******************
 * 如果需要在block中再次relayout，请在block中销毁该block
 * 即调用setRelayoutComplete(nil); 否则会造成死循环
 */
@property (nonatomic, copy, readonly) JKAlertView *(^setRelayoutComplete)(void(^relayoutComplete)(JKAlertView *view));


#pragma mark
#pragma mark 其它适配

/** 设置show的时候是否振动 默认NO */
@property (nonatomic, copy, readonly) JKAlertView *(^setShouldVibrate)(BOOL shouldVibrate);

/** 设置action和colletion样式的底部按钮上下间距 不可小于0 */
@property (nonatomic, copy, readonly) JKAlertView *(^setBottomButtonMargin)(CGFloat margin);

/** 设置是否自动适配底部 iPhone X homeIndicator 默认YES */
@property (nonatomic, copy, readonly) JKAlertView *(^setAutoAdjustHomeIndicator)(BOOL autoAdjust);

/** 设置是否填充底部 iPhone X homeIndicator 默认YES */
@property (nonatomic, copy, readonly) JKAlertView *(^setFillHomeIndicator)(BOOL fillHomeIndicator);
@end
