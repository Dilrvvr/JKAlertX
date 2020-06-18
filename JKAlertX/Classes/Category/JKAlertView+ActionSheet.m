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
 * 设置actionSheet样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 * isClearContainerBackgroundColor : 是否让其容器视图透明
 */
- (JKAlertView *(^)(BOOL isClearContainerBackgroundColor, UIView *(^customView)(void)))setCustomActionSheetTitleView{
    
    return ^(BOOL isClearContainerBackgroundColor, UIView *(^customView)(void)) {
        
        self.customSheetTitleView = !customView ? nil : customView();
        
        self.isClearTextContainerBackground = isClearContainerBackgroundColor;
        
        // TODO: JKTODO <#注释#>
//        if (isClearContainerBackgroundColor) {
//
//            self->_textContainerView.backgroundColor = nil;
//        }
        
        return self;
    };
}

/** 设置sheet样式最大高度 默认屏幕高度 * 0.85 */
- (JKAlertView *(^)(CGFloat height))setSheetMaxHeight{
    
    return ^(CGFloat height) {
        
        self->JKAlertSheetMaxH = height;
        
        self->SheetMaxHeightSetted = YES;
        
        return self;
    };
}

/** 自定义配置tableView */
- (JKAlertView *(^)(void(^)(UITableView *tableView)))setTableViewConfiguration{
    
    return ^(void(^tableViewConfiguration)(UITableView *tableView)) {
        
        // TODO: JKTODO <#注释#>
        //!tableViewConfiguration ? : tableViewConfiguration(self->_tableView);
        
        return self;
    };
}

/** 设置UITableViewDataSource */
- (JKAlertView *(^)(id<UITableViewDataSource> dataSource))setCustomTableViewDataSource{
    
    return ^(id<UITableViewDataSource> dataSource) {
        
        self.tableViewDataSource = dataSource;
        
        // TODO: JKTODO <#注释#>
        //self->_tableView.dataSource = dataSource ? dataSource : self;
        
        return self;
    };
}

/** 设置UITableViewDelegate */
- (JKAlertView *(^)(id<UITableViewDelegate> delegate))setCustomTableViewDelegate{
    
    return ^(id<UITableViewDelegate> delegate) {
        
        self.tableViewDelegate = delegate;
        
        // TODO: JKTODO <#注释#>
        //self->_tableView.delegate = delegate ? delegate : self;
        
        return self;
    };
}

/** 设置actionSheet底部取消按钮是否固定在底部 默认NO */
- (JKAlertView *(^)(BOOL pinCancelButton))setPinCancelButton{
    
    return ^(BOOL pinCancelButton) {
        
        self.pinCancelButton = self.isActionSheetPierced ? YES : pinCancelButton;
        
        //[self updateInsets];
        
        // TODO: JKTODO <#注释#>
        
        self.actionsheetContentView.cancelButtonPinned = pinCancelButton;
        
        return self;
    };
}

/**
 * 设置actionSheet是否镂空
 * 类似UIAlertControllerStyleActionSheet效果
 * 设置为YES后，setPinCancelButton将强制为YES
 */
- (JKAlertView *(^)(BOOL isPierced, CGFloat cornerRadius, CGFloat horizontalMargin, CGFloat bottomMargin, UIColor *lightBackgroundColor, UIColor *darkBackgroundColor))setActionSheetPierced{
    
    return ^(BOOL isPierced, CGFloat cornerRadius, CGFloat horizontalMargin, CGFloat bottomMargin, UIColor *lightBackgroundColor, UIColor *darkBackgroundColor) {
        
        if (self.alertStyle != JKAlertStyleActionSheet) {
            
            return self;
        }
        
        // TODO: JKTODO <#注释#>
        self.actionsheetContentView.isPierced = isPierced;
        self.actionsheetContentView.piercedInsets = UIEdgeInsetsMake(0, horizontalMargin, bottomMargin, horizontalMargin);
        self.actionsheetContentView.piercedCornerRadius = cornerRadius;
        self.actionsheetContentView.piercedBackgroundColor = [JKAlertMultiColor colorWithLightColor:lightBackgroundColor darkColor:darkBackgroundColor];
        
        self.isActionSheetPierced = isPierced;
        
        self.piercedBackgroundColor = JKAlertAdaptColor(lightBackgroundColor ? lightBackgroundColor : [UIColor whiteColor], darkBackgroundColor ? darkBackgroundColor : [UIColor blackColor]);
        
        [self.actions enumerateObjectsUsingBlock:^(JKAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.isPierced = self.isActionSheetPierced;
            obj.piercedBackgroundColor = self.piercedBackgroundColor;
        }];
        
        if (!isPierced) {
            
            return self;
        }
        
        self.piercedCornerRadius = MAX(cornerRadius, 0);
        
        self.piercedHorizontalMargin = MAX(horizontalMargin, 0);
        
        self.pinCancelButton = YES;
        
        self.piercedBottomMargin = MAX(bottomMargin, 0);
        
        // TODO: JKTODO <#注释#>
        //[self updateInsets];
        
        return self;
    };
}








/// 不是actionSheet样式将不执行handler
- (JKAlertView *)checkActionSheetStyleHandler:(void(^)(void))handler {
    
    return [self checkAlertStyle:JKAlertStyleActionSheet handler:handler];
}
@end
