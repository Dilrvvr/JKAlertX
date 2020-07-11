//
//  JKAlertBaseAlertView.h
//  JKAlertX
//
//  Created by albert on 2019/1/14.
//  Copyright © 2019 安永博. All rights reserved.
//

#import "JKAlertBaseView.h"

@interface JKAlertBaseAlertView : JKAlertBaseView

#pragma mark
#pragma mark - Private

/** 最底层背景按钮 */
@property (nonatomic, weak, readonly) UIButton *dismissButton;

/** fullBackgroundColor */ // TODO: JKTODO <#注释#>
@property (nonatomic, strong) UIColor *fullBackgroundColor;

/** fullBackgroundView */
@property (nonatomic, weak) UIView *fullBackgroundView;

- (void)restoreFullBackgroundColor;

- (UITableView *)createTableViewWithStyle:(UITableViewStyle)style;

- (void)adjustScrollView:(UIScrollView *)scrollView;
@end
