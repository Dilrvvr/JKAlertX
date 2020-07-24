//
//  JKAlertBaseActionView.h
//  JKAlertX
//
//  Created by albertcc on 2020/5/10.
//  Copyright © 2020 安永博. All rights reserved.
//

#import "JKAlertBaseView.h"

@class JKAlertAction;

@interface JKAlertBaseActionView : JKAlertBaseView

/** action */
@property (nonatomic, strong) JKAlertAction *action;

/** iconImageView */
@property (nonatomic, weak, readonly) UIImageView *iconImageView;

/** titleLabel */
@property (nonatomic, weak, readonly) UILabel *titleLabel;

/** seleted */
@property (nonatomic, assign) BOOL seleted;

/** highlighted */
@property (nonatomic, assign) BOOL highlighted;

#pragma mark
#pragma mark - Private

/** selectedBackgroundView */
@property (nonatomic, weak, readonly) UIView *selectedBackgroundView;
@end
