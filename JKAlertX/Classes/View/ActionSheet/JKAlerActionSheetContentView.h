//
//  JKAlerActionSheetContentView.h
//  JKAlertX
//
//  Created by albert on 2020/6/4.
//

#import "JKAlertBaseSheetContentView.h"
#import "JKAlertActionSheetTextContentView.h"

@class JKAlertAction;

@interface JKAlerActionSheetContentView : JKAlertBaseSheetContentView

/** delegate */
@property (nonatomic, weak) id <UIScrollViewDelegate> delegate;

/** textContentView */
@property (nonatomic, weak, readonly) JKAlertActionSheetTextContentView *textContentView;

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

/** isPierced */
@property (nonatomic, assign) BOOL isPierced;

/** 镂空效果间距 只取左右下 */
@property (nonatomic, assign) UIEdgeInsets piercedInsets;

- (void)restoreTopBackgroundColor;
@end
