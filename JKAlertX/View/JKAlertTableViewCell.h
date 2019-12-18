//
//  JKAlertTableViewCell.h
//  TestVideoAndPicture
//
//  Created by albert on 2017/4/19.
//  Copyright © 2017年 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JKAlertAction;

@interface JKAlertTableViewCell : UITableViewCell

/** action */
@property (nonatomic, strong) JKAlertAction *action;

/** alertSuperView */
@property (nonatomic, weak) UIView *alertSuperView;
@end
