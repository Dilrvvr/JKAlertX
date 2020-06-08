//
//  JKAlertView+ActionSheet.h
//  JKAlertX
//
//  Created by albert on 2020/6/8.
//

#import "JKAlertView.h"

@interface JKAlertView (ActionSheet)

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
@end
