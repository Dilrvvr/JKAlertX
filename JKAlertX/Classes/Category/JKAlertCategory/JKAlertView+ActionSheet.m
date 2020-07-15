//
//  JKAlertView+ActionSheet.m
//  JKAlertX
//
//  Created by albert on 2020/6/8.
//

#import "JKAlertView+ActionSheet.h"
#import "JKAlertView+Public.h"
#import "JKAlertView+PrivateProperty.h"

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
 * actionSheet样式title的背景色
 * 默认JKAlertGlobalMultiBackgroundColor()
 */
- (JKAlertView *(^)(UIColor *color))makeActionSheetTopBackgroundColor {
    
    return ^(UIColor *color) {
        
        return [self checkActionSheetStyleHandler:^{
            
            [self.actionsheetContentView.backgroundView.jkalert_themeProvider removeProvideHandlerForKey:NSStringFromSelector(@selector(backgroundColor))];
            
            self.actionsheetContentView.topContentView.backgroundView.backgroundColor = color;
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
            
            // TODO: - JKTODO <#注释#>
            
            self->JKAlertSheetMaxH = maxHeight;
            
            self->SheetMaxHeightSetted = YES;
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
            
            [self.actions enumerateObjectsUsingBlock:^(JKAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                // TODO: - JKTODO <#注释#>
                obj.isPierced = isPierced;
            }];
        }];
    };
}
@end
