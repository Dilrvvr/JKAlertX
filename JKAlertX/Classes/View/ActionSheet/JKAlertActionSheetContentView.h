//
//  JKAlertActionSheetContentView.h
//  JKAlertX
//
//  Created by albert on 2020/6/4.
//

#import "JKAlertBaseSheetContentView.h"
#import "JKAlertActionSheetTextContentView.h"

@class JKAlertAction, JKAlertActionButton;

@interface JKAlertActionSheetContentView : JKAlertBaseSheetContentView <JKAlertVerticalSlideToDismissDelegate>

/** textContentView */
@property (nonatomic, weak, readonly) JKAlertActionSheetTextContentView *textContentView;

/** tableView */
@property (nonatomic, weak, readonly) UITableView *tableView;

/** cancelButton */
@property (nonatomic, weak, readonly) JKAlertActionButton *cancelButton;

/** cell类名 必须是或继承自JKAlertTableViewCell */
@property (nonatomic, copy) NSString *cellClassName;

/** tableViewDataSource */
@property (nonatomic, weak) id <UITableViewDataSource> tableViewDataSource;

/** tableViewDelegate */
@property (nonatomic, weak) id <UITableViewDelegate> tableViewDelegate;

- (void)restoreTopBackgroundColor;
@end
