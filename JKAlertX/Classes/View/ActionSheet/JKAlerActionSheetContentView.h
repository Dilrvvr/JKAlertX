//
//  JKAlerActionSheetContentView.h
//  JKAlertX
//
//  Created by albert on 2020/6/4.
//

#import "JKAlertBaseAlertContentView.h"
#import "JKAlertActionSheetTextContentView.h"

@class JKAlertAction;

@interface JKAlerActionSheetContentView : JKAlertBaseAlertContentView

/** textContentView */
@property (nonatomic, weak, readonly) JKAlertActionSheetTextContentView *textContentView;

/** titleBackgroundColor */
@property (nonatomic, strong) JKAlertMultiColor *titleBackgroundColor;

/** tableView */
@property (nonatomic, weak, readonly) UITableView *tableView;

/** cell类名 必须是或继承自JKAlertTableViewCell */
@property (nonatomic, copy) NSString *cellClassName;

/** tableViewDataSource */
@property (nonatomic, weak) id <UITableViewDataSource> tableViewDataSource;

/** tableViewDelegate */
@property (nonatomic, weak) id <UITableViewDelegate> tableViewDelegate;

/** fillHomeIndicator */
@property (nonatomic, assign) CGFloat cancelMargin;

/** 是否固定取消按钮在底部 */
@property (nonatomic, assign) BOOL cancelButtonPinned;

/** autoAdjustHomeIndicator */
@property (nonatomic, assign) BOOL autoAdjustHomeIndicator;

/** fillHomeIndicator */
@property (nonatomic, assign) BOOL fillHomeIndicator;

/** isPierced */
@property (nonatomic, assign) BOOL isPierced;

/** 镂空效果间距 只取左右下 */
@property (nonatomic, assign) UIEdgeInsets piercedInsets;

/** 镂空整体圆角 */
@property (nonatomic, assign) CGFloat piercedCornerRadius;

/** piercedBackgroundColor */
@property (nonatomic, strong) JKAlertMultiColor *piercedBackgroundColor;
@end
