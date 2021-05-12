//
//  JKAlertBaseViewController.m
//  JKAlertX_Example
//
//  Created by albert on 2020/9/13.
//  Copyright © 2020 jkayb123cool@gmail.com. All rights reserved.
//

#import "JKAlertBaseViewController.h"
#import "JKAlertX.h"
#import "JKAlertHeaderFooterView.h"
#import "JKAlertTableCell.h"
#import "JKAlertTableModel.h"
#import "JKAlertTableGroupModel.h"
#import "JKAlertThemeManager.h"
#import "JKAlertUITableView.h"

@interface JKAlertBaseViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_dataArray;
}
@end

@implementation JKAlertBaseViewController

- (void)dealloc {
    
    NSLog(@"%@, (Line: %d), %s", [NSString stringWithFormat:@"%s", __func__].lastPathComponent, __LINE__, __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightNavigationItemClick:)];
    
    [self buildUI];
    
    [self loadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView setContentOffset:CGPointMake(0, -self.tableView.contentInset.top) animated:NO];
    });
}

- (void)buildUI {
    
    UITableView *tableView = [[JKAlertUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, JKAlertUtility.currentHomeIndicatorHeight, 0);
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [tableView registerClass:[JKAlertTableCell class] forCellReuseIdentifier:NSStringFromClass([JKAlertTableCell class])];
    [tableView registerClass:[JKAlertHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([JKAlertHeaderFooterView class])];
}

- (void)loadData {
    
}

- (void)rightNavigationItemClick:(JKAlertTableModel *)sender {
    
    NSString *systemMode = @"系统样式: 浅色模式";
    NSString *message = @"\n当前选择: 浅色模式";
    
    NSString *alertKey = @"JKAlertDarkModelAlertKey";
    
    JKAlertView.dismissForKey(alertKey);
    
    JKAlertView *alertView = JKAlertView.alertView(@"深色模式切换", message, JKAlertStyleActionSheet);
    
    alertView.makeVerticalGestureDismissEnabled(YES)
    .makeHorizontalGestureDismissDirection(JKAlertSheetHorizontalGestureDismissDirectionHorizontal)
    .makeGestureIndicatorHidden(NO)
    .makeShowScaleAnimated(YES)
    .makeDismissKey(alertKey);
    
    if (@available(iOS 13.0, *)) {
        
        UIWindow *keyWindow = JKAlertUtility.keyWindow;
        
        UIUserInterfaceStyle systemStyle = [UIScreen mainScreen].traitCollection.userInterfaceStyle;
        
        switch (systemStyle) {
            case UIUserInterfaceStyleLight:
            {
                systemMode = @"系统样式: 浅色模式";
            }
                break;
            case UIUserInterfaceStyleDark:
            {
                systemMode = @"系统样式: 深色模式";
            }
                break;
                
            default:
            {
                systemMode = @"系统样式: 未知模式";
            }
                break;
        }
        
        UIUserInterfaceStyle currentStyle = keyWindow.overrideUserInterfaceStyle;
        
        switch (currentStyle) {
            case UIUserInterfaceStyleLight:
            {
                message = @"\n当前选择: 浅色模式";
            }
                break;
            case UIUserInterfaceStyleDark:
            {
                message = @"\n当前选择: 深色模式";
            }
                break;
                
            default:
            {
                message = @"\n当前选择: 跟随系统";
            }
                break;
        }
        
        alertView.addAction(JKAlertAction.action(@"浅色模式", (UIUserInterfaceStyleLight == currentStyle ? JKAlertActionStyleDestructive : JKAlertActionStyleDefault), ^(JKAlertAction *action) {
            
            keyWindow.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
            JKAlertView.makeThemeStyle(JKAlertThemeStyleLight);
            
            if (action.alertView) {
                
                action.alertView.remakeMessage([systemMode stringByAppendingString:@"\n当前选择: 浅色模式"])
                .getActionArrayFrom(NO, ^(NSArray *actionArray) {
                    
                    for (JKAlertAction *action in actionArray) {
                        
                        action.remakeActionStyle(JKAlertActionStyleDefault);
                    }
                });
            }
            
            action.remakeActionStyle(JKAlertActionStyleDestructive);
            
            [action.alertView relayoutAnimated:NO];
            
        }).makeAutoDismiss(NO))
        .addAction(JKAlertAction.action(@"深色模式", (UIUserInterfaceStyleDark == currentStyle ? JKAlertActionStyleDestructive : JKAlertActionStyleDefault), ^(JKAlertAction *action) {
            
            keyWindow.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
            JKAlertView.makeThemeStyle(JKAlertThemeStyleDark);
            
            if (action.alertView) {
                
                action.alertView.remakeMessage([systemMode stringByAppendingString:@"\n当前选择: 深色模式"])
                .getActionArrayFrom(NO, ^(NSArray *actionArray) {
                    
                    for (JKAlertAction *action in actionArray) {
                        
                        action.remakeActionStyle(JKAlertActionStyleDefault);
                    }
                });
            }
            
            action.remakeActionStyle(JKAlertActionStyleDestructive);
            
            [action.alertView relayoutAnimated:NO];
            
        }).makeAutoDismiss(NO))
        .addAction(JKAlertAction.action(@"跟随系统", (UIUserInterfaceStyleUnspecified == currentStyle ? JKAlertActionStyleDestructive : JKAlertActionStyleDefault), ^(JKAlertAction *action) {
            
            keyWindow.overrideUserInterfaceStyle = UIUserInterfaceStyleUnspecified;
            JKAlertView.makeThemeStyle(JKAlertThemeStyleSystem);
            
            if (action.alertView) {
                
                action.alertView.remakeMessage([systemMode stringByAppendingString:@"\n当前选择: 跟随系统"])
                .getActionArrayFrom(NO, ^(NSArray *actionArray) {
                    
                    for (JKAlertAction *action in actionArray) {
                        
                        action.remakeActionStyle(JKAlertActionStyleDefault);
                    }
                });
            }
            
            action.remakeActionStyle(JKAlertActionStyleDestructive);
            
            [action.alertView relayoutAnimated:NO];
            
        }).makeAutoDismiss(NO));
        
    } else {
        
        JKAlertThemeStyle currentStyle = [JKAlertThemeManager sharedManager].themeStyle;
        
        switch (currentStyle) {
            case JKAlertThemeStyleLight:
            {
                message = @"\n当前选择: 浅色模式";
            }
                break;
            case JKAlertThemeStyleDark:
            {
                message = @"\n当前选择: 深色模式";
            }
                break;
                
            default:
            {
                message = @"\n当前选择: 跟随系统";
            }
                break;
        }
        
        alertView.addAction(JKAlertAction.action(@"浅色模式", (JKAlertThemeStyleLight == currentStyle ? JKAlertActionStyleDestructive : JKAlertActionStyleDefault), ^(JKAlertAction *action) {
            
            JKAlertView.makeThemeStyle(JKAlertThemeStyleLight);
            
            if (action.alertView) {
                
                action.alertView.remakeMessage([systemMode stringByAppendingString:@"\n当前选择: 浅色模式"])
                .getActionArrayFrom(NO, ^(NSArray *actionArray) {
                    
                    for (JKAlertAction *action in actionArray) {
                        
                        action.remakeActionStyle(JKAlertActionStyleDefault);
                    }
                });
            }
            
            action.remakeActionStyle(JKAlertActionStyleDestructive);
            
            [action.alertView relayoutAnimated:NO];
            
        }).makeAutoDismiss(NO))
        .addAction(JKAlertAction.action(@"深色模式", (JKAlertThemeStyleDark == currentStyle ? JKAlertActionStyleDestructive : JKAlertActionStyleDefault), ^(JKAlertAction *action) {
            
            JKAlertView.makeThemeStyle(JKAlertThemeStyleDark);
            
            if (action.alertView) {
                
                action.alertView.remakeMessage([systemMode stringByAppendingString:@"\n当前选择: 深色模式"])
                .getActionArrayFrom(NO, ^(NSArray *actionArray) {
                    
                    for (JKAlertAction *action in actionArray) {
                        
                        action.remakeActionStyle(JKAlertActionStyleDefault);
                    }
                });
            }
            
            action.remakeActionStyle(JKAlertActionStyleDestructive);
            
            [action.alertView relayoutAnimated:NO];
            
        }).makeAutoDismiss(NO))
        .addAction(JKAlertAction.action(@"跟随系统", (JKAlertThemeStyleSystem == currentStyle ? JKAlertActionStyleDestructive : JKAlertActionStyleDefault), ^(JKAlertAction *action) {
            
            JKAlertView.makeThemeStyle(JKAlertThemeStyleSystem);
            
            if (action.alertView) {
                
                action.alertView.remakeMessage([systemMode stringByAppendingString:@"\n当前选择: 跟随系统"])
                .getActionArrayFrom(NO, ^(NSArray *actionArray) {
                    
                    for (JKAlertAction *action in actionArray) {
                        
                        action.remakeActionStyle(JKAlertActionStyleDefault);
                    }
                });
            }
            
            action.remakeActionStyle(JKAlertActionStyleDestructive);
            
            [action.alertView relayoutAnimated:NO];
            
        }).makeAutoDismiss(NO));
    }
    
    message = [systemMode stringByAppendingString:message];
    
    alertView.remakeMessage(message).show();
}

#pragma mark
#pragma mark - Override

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    self.tableView.contentInset = UIEdgeInsetsMake(JKAlertUtility.navigationBarHeight, 0, JKAlertUtility.currentHomeIndicatorHeight, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(JKAlertUtility.navigationBarHeight, 0, JKAlertUtility.currentHomeIndicatorHeight, 0);
}

#pragma mark
#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    JKAlertTableGroupModel *group = [self.dataArray objectAtIndex:section];
    
    return group.sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JKAlertTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JKAlertTableCell class])];
    
    if (cell == nil) {
        
        cell = [[JKAlertTableCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:NSStringFromClass([JKAlertTableCell class])];
    }
    
    JKAlertTableGroupModel *group = [self.dataArray objectAtIndex:indexPath.section];
    
    cell.model = [group.sectionArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static CGFloat rowHeight_ = 0;
    
    if (rowHeight_ <= 0) {
        
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        
        rowHeight_ = (MIN(screenSize.width, screenSize.height) > 321) ? 53 : 46;
    }
    
    return rowHeight_;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JKAlertTableGroupModel *group = [self.dataArray objectAtIndex:indexPath.section];
    
    JKAlertTableModel *model = [group.sectionArray objectAtIndex:indexPath.row];
    
    !model.executeHandler ? : model.executeHandler(model);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    JKAlertHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([JKAlertHeaderFooterView class])];
    
    if (!header) {
        
        header = [[JKAlertHeaderFooterView alloc] initWithReuseIdentifier:NSStringFromClass([JKAlertHeaderFooterView class])];
    }
    
    JKAlertTableGroupModel *group = [self.dataArray objectAtIndex:section];
    
    header.textLabel.text = group.title;
    
    return header;
}

#pragma mark
#pragma mark - Property

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
