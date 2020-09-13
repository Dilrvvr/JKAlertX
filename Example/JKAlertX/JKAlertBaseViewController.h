//
//  JKAlertBaseViewController.h
//  JKAlertX_Example
//
//  Created by albert on 2020/9/13.
//  Copyright © 2020 jkayb123cool@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKAlertBaseViewController : UIViewController

/** tableView */
@property (nonatomic, weak, readonly) UITableView *tableView;

/** dataArray */
@property (nonatomic, strong, readonly) NSMutableArray *dataArray;

- (void)loadData;
@end
