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
 * actionSheet样式title的背景色
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeActionSheetTopBackgroundColor)(UIColor *color);

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
@end
