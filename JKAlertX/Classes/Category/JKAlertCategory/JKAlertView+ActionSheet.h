//
//  JKAlertView+ActionSheet.h
//  JKAlertX
//
//  Created by albert on 2020/6/8.
//

#import "JKAlertView.h"

@interface JKAlertView (ActionSheet)

/**
 * actionSheet样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeActionSheetCustomTitleView)(UIView *(^customView)(void));

/**
 * actionSheet样式顶部的背景色
 * pierced镂空样式时，表示上部分的颜色，包括title和tableView
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeActionSheetTopBackgroundColor)(UIColor *color);

/**
 * actionSheet样式底部按钮的颜色
 * 默认无
 * 仅底部按钮被固定时有效，包括pierced镂空样式
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeActionSheetBottomButtonBackgroundColor)(UIColor *color);

/**
 * actionSheet样式最大高度
 * 默认屏幕高度 * 0.85
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeActionSheetMaxHeight)(CGFloat maxHeight);

/**
 * 自定义配置tableView
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeActionSheetTableViewConfiguration)(void (^)(UITableView *tableView));

/**
 * UITableView dataSource
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeActionSheetTableViewDataSource)(id <UITableViewDataSource> dataSource);

/**
 * UITableView delegate
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeActionSheetTableViewDelegate)(id <UITableViewDelegate> delegate);

/**
 * actionSheet顶部与action之间分隔线是否总是隐藏
 * 默认NO
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeActionSheetSeparatorLineAlwaysHidden)(BOOL alwaysHidden);

/**
 * actionSheet最后一个action(非cancelAction)是否自动隐藏分隔线
 * 默认YES
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeActionSheetAutoHideLastActionSeparatorLine)(BOOL isAuto);

/**
 * actionSheet底部取消按钮是否固定在底部
 * 默认NO
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeActionSheetBottomButtonPinned)(BOOL pinned);

/**
 * actionSheet是否镂空
 * 类似UIAlertControllerStyleActionSheet效果
 * 设置为YES后，makeActionSheetBottomButtonPinned将强制为YES
 * piercedInsets : 整体左、右、下间距
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeActionSheetPierced)(BOOL isPierced, UIEdgeInsets piercedInsets);

/**
 * actionSheet自定义tableView滑动退出
 * 使用场景: 当自定义了sheet的view后，并且在view上有一个tableView或其他上下滑动的scrollView，希望滑动到顶部时继续下拉滑动退出该sheet
 * 步骤: 1、alertView.makeVerticalGestureDismissEnabled(YES); 开启滑动退出(纵向)
 *      2、遵守JKAlertVerticalSlideToDismissProtocol协议，定义对应jkalert_verticalSlideToDismissDelegate属性
 *         可以使用`@synthesize jkalert_verticalSlideToDismissDelegate;`
 *      3、alertView.makeActionSheetCustomVerticalSlideToDismiss(`object <JKAlertVerticalSlideToDismissProtocol>`);
 *      4、在tableView(或其他上下滑动的scrollView)的UIScrollViewDelegate的方法中(共4个方法，详见JKAlertVerticalSlideToDismissDelegate协议)
 *         让jkalert_verticalSlideToDismissDelegate在四个方法中一一调用对应的方法
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeActionSheetCustomVerticalSlideToDismiss)(id <JKAlertVerticalSlideToDismissProtocol> object);
@end
