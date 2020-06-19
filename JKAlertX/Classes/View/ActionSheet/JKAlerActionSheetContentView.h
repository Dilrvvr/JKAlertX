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

/** 默认的取消action，不需要自带的可以自己设置，不可置为nil */
@property (nonatomic, strong) JKAlertAction *cancelAction;

/** 是否固定取消按钮在底部 */
@property (nonatomic, assign) BOOL cancelButtonPinned;

/** autoAdjustHomeIndicator */
@property (nonatomic, assign) BOOL autoAdjustHomeIndicator;

/** fillHomeIndicator */
@property (nonatomic, assign) BOOL fillHomeIndicator;

/** fillHomeIndicator */
@property (nonatomic, assign) CGFloat cancelMargin;

/** tableViewDataSource */
@property (nonatomic, weak) id <UITableViewDataSource> tableViewDataSource;

/** tableViewDelegate */
@property (nonatomic, weak) id <UITableViewDelegate> tableViewDelegate;

/** cell类名 必须是或继承自JKAlertTableViewCell */
@property (nonatomic, copy) NSString *cellClassName;

/** isPierced */
@property (nonatomic, assign) BOOL isPierced;

/** 镂空效果间距 只取左右下 */
@property (nonatomic, assign) UIEdgeInsets piercedInsets;

/** 镂空整体圆角 */
@property (nonatomic, assign) CGFloat piercedCornerRadius;

/** piercedBackgroundColor */
@property (nonatomic, strong) JKAlertMultiColor *piercedBackgroundColor;
@end
