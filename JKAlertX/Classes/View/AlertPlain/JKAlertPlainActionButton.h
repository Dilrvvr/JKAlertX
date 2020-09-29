//
//  JKAlertPlainActionButton.h
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import <UIKit/UIKit.h>

@class JKAlertAction;

@interface JKAlertPlainActionButton : UIButton

/** topSeparatorLineView */
@property (nonatomic, weak) UIView *topSeparatorLineView;

/** action */
@property (nonatomic, strong) JKAlertAction *action;
@end
