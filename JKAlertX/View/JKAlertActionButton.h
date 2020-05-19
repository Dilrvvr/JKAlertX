//
//  JKAlertActionButton.h
//  JKAlertX
//
//  Created by albertcc on 2020/5/10.
//  Copyright © 2020 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JKAlertAction;

@interface JKAlertActionButton : UIButton

/** action */
@property (nonatomic, strong) JKAlertAction *action;
@end
