//
//  JKAlertActionView.h
//  JKAlertX
//
//  Created by albertcc on 2020/5/10.
//  Copyright © 2020 安永博. All rights reserved.
//

#import "JKAlertBaseActionView.h"

@class JKAlertAction;

@interface JKAlertActionView : JKAlertBaseActionView

/** action */
@property (nonatomic, strong) JKAlertAction *action;
@end
