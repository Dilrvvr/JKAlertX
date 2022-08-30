//
//  JKAlertView+ActionSheet.m
//  JKAlertX
//
//  Created by albert on 2020/6/8.
//

#import "JKAlertView+ActionSheet.h"
#import "JKAlertView+Public.h"
#import "JKAlertView+PrivateProperty.h"
#import "JKAlertTheme.h"

@implementation JKAlertView (ActionSheet)

/**
 * actionSheet样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 */
- (JKAlertView *(^)(UIView *(^customView)(void)))makeActionSheetCustomTitleView {
    
    return ^(UIView *(^customView)(void)) {
        
        return [self checkActionSheetStyleHandler:^{
            
            if (customView) {
                
                self.actionsheetContentView.textContentView.customContentView = customView();
            }
        }];
    };
}

/**
 * actionSheet样式顶部的背景色
 * pierced镂空样式时，表示上部分的颜色，包括title和tableView 
 */
- (JKAlertView *(^)(UIColor *color))makeActionSheetTopBackgroundColor {
    
    return ^(UIColor *color) {
        
        return [self checkActionSheetStyleHandler:^{
            
            [self.actionsheetContentView.topContentView.jkalert_themeProvider removeProvideHandlerForKey:NSStringFromSelector(@selector(backgroundColor))];
            
            self.actionsheetContentView.topContentView.backgroundColor = color;
        }];
    };
}

/**
 * actionSheet样式底部按钮的颜色
 * 默认无
 * 仅底部按钮被固定时有效，包括pierced镂空样式
 */
- (JKAlertView *(^)(UIColor *color))makeActionSheetBottomButtonBackgroundColor {
    
    return ^(UIColor *color) {
        
        return [self checkActionSheetStyleHandler:^{
            
            [self.actionsheetContentView.cancelButton.jkalert_themeProvider removeProvideHandlerForKey:NSStringFromSelector(@selector(backgroundColor))];
            
            self.actionsheetContentView.cancelButton.backgroundColor = color;
        }];
    };
}

/**
 * actionSheet样式最大高度
 * 默认屏幕高度 * 0.85
 */
- (JKAlertView *(^)(CGFloat maxHeight))makeActionSheetMaxHeight {
    
    return ^(CGFloat maxHeight) {
        
        return [self checkActionSheetStyleHandler:^{
            
            self.maxSheetHeight = maxHeight;
            
            self.maxSheetHeightSetted = YES;
        }];
    };
}

/**
 * 自定义配置tableView
 */
- (JKAlertView *(^)(void (^)(UITableView *tableView)))makeActionSheetTableViewConfiguration {
    
    return ^(void(^tableViewConfiguration)(UITableView *tableView)) {
        
        return [self checkActionSheetStyleHandler:^{
            
            !tableViewConfiguration ? : tableViewConfiguration(self.actionsheetContentView.tableView);
        }];
    };
}

/**
 * UITableView dataSource
 */
- (JKAlertView *(^)(id <UITableViewDataSource> dataSource))makeActionSheetTableViewDataSource {
    
    return ^(id <UITableViewDataSource> dataSource) {
        
        return [self checkActionSheetStyleHandler:^{
            
            self.actionsheetContentView.tableView.dataSource = dataSource;
        }];
    };
}

/**
 * UITableView delegate
 */
- (JKAlertView *(^)(id <UITableViewDelegate> delegate))makeActionSheetTableViewDelegate {
    
    return ^(id <UITableViewDelegate> delegate) {
        
        return [self checkActionSheetStyleHandler:^{
            
            self.actionsheetContentView.tableView.delegate = delegate;
        }];
    };
}

/**
 * actionSheet顶部与action之间分隔线是否总是隐藏
 * 默认NO
 */
- (JKAlertView *(^)(BOOL alwaysHidden))makeActionSheetSeparatorLineAlwaysHidden {
    
    return ^(BOOL alwaysHidden) {
        
        return [self checkActionSheetStyleHandler:^{
            
            self.actionsheetContentView.separatorLineAlwaysHidden = alwaysHidden;
        }];
    };
}

/**
 * actionSheet最后一个action(非cancelAction)是否自动隐藏分隔线
 * 默认YES
 */
- (JKAlertView *(^)(BOOL isAuto))makeActionSheetAutoHideLastActionSeparatorLine {
    
    return ^(BOOL isAuto) {
        
        return [self checkActionSheetStyleHandler:^{
            
            self.actionsheetContentView.autoHideLastActionSeparatorLine = isAuto;
        }];
    };
}

/**
 * actionSheet底部取消按钮是否固定在底部
 * 默认NO
 */
- (JKAlertView *(^)(BOOL pinned))makeActionSheetBottomButtonPinned {
    
    return ^(BOOL pinned) {
        
        return [self checkActionSheetStyleHandler:^{
            
            self.actionsheetContentView.bottomButtonPinned = pinned;
        }];
    };
}

/**
 * actionSheet是否镂空
 * 类似UIAlertControllerStyleActionSheet效果
 * 设置为YES后，makeActionSheetBottomButtonPinned将强制为YES
 * piercedInsets : 整体左、右、下间距
 */
- (JKAlertView *(^)(BOOL isPierced, UIEdgeInsets piercedInsets))makeActionSheetPierced {
    
    return ^(BOOL isPierced, UIEdgeInsets piercedInsets) {
        
        return [self checkActionSheetStyleHandler:^{
            
            self.actionsheetContentView.isPierced = isPierced;
            self.actionsheetContentView.piercedInsets = piercedInsets;
        }];
    };
}

/**
 * actionSheet自定义tableView滑动退出
 */
- (JKAlertView *(^)(id <JKAlertVerticalSlideToDismissProtocol> object))makeActionSheetCustomVerticalSlideToDismiss {
    
    return ^(id <JKAlertVerticalSlideToDismissProtocol> object) {
        
        return [self checkActionSheetStyleHandler:^{
            
            object.jkalert_verticalSlideToDismissDelegate = self.actionsheetContentView;
        }];
    };
}
@end
