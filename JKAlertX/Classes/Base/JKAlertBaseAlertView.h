//
//  JKAlertBaseAlertView.h
//  JKAlertX
//
//  Created by albert on 2019/1/14.
//  Copyright © 2019 Albert. All rights reserved.
//

#import "JKAlertBaseView.h"

@interface JKAlertBaseAlertView : JKAlertBaseView

#pragma mark
#pragma mark - Private

/** 最底层背景按钮 */
@property (nonatomic, weak, readonly) UIButton *dismissButton;

/** fullBackgroundView */
@property (nonatomic, weak) UIView *fullBackgroundView;

- (void)restoreFullBackgroundColor;
@end
