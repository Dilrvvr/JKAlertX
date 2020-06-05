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
{
    BOOL AutoAdjustHomeIndicator;
}

/** textContentView */
@property (nonatomic, weak, readonly) JKAlertActionSheetTextContentView *textContentView;

/** 默认的取消action，不需要自带的可以自己设置，不可置为nil */
@property (nonatomic, strong) JKAlertAction *cancelAction;

/** 是否固定取消按钮在底部 */
@property (nonatomic, assign) BOOL cancelButtonPinned;

/** customSuperView */
@property (nonatomic, weak) UIView *customSuperView;

/** fillHomeIndicator */
@property (nonatomic, assign) BOOL fillHomeIndicator;

/** fillHomeIndicator */
@property (nonatomic, assign) CGFloat cancelMargin;

/** tableViewDataSource */
@property (nonatomic, weak) id <UITableViewDataSource> tableViewDataSource;

/** tableViewDelegate */
@property (nonatomic, weak) id <UITableViewDelegate> tableViewDelegate;

/** isPierced */
@property (nonatomic, assign) BOOL isPierced;

/** 镂空效果间距 只取左右下 */
@property (nonatomic, assign) UIEdgeInsets piercedInsets;

/** 镂空整体圆角 */
@property (nonatomic, assign) CGFloat piercedCornerRadius;

/** piercedBackgroundColor */
@property (nonatomic, strong) JKAlertMultiColor *piercedBackgroundColor;

/** textContentBackgroundColor */
@property (nonatomic, strong) JKAlertMultiColor *textContentBackgroundColor;
@end
