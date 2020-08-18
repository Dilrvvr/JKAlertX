//
//  JKAlertCollectionViewCell.h
//  JKAlert
//
//  Created by albert on 2018/4/4.
//  Copyright © 2018年 Albert. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JKAlertAction;

@interface JKAlertCollectionViewCell : UICollectionViewCell

/** action */
@property (nonatomic, strong) JKAlertAction *action;
@end
