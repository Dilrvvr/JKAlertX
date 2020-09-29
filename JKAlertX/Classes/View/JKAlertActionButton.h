//
//  JKAlertActionButton.h
//  JKAlertX
//
//  Created by Albert on 2020/5/10.
//  Copyright © 2020 Albert. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JKAlertAction;

@interface JKAlertActionButton : UIButton

/** action */
@property (nonatomic, strong) JKAlertAction *action;
@end
