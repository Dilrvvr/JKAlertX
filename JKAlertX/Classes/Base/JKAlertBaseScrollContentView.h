//
//  JKAlertBaseScrollContentView.h
//  JKAlertX
//
//  Created by albert on 2020/6/16.
//

#import "JKAlertBaseView.h"

@interface JKAlertBaseScrollContentView : JKAlertBaseView

/** scrollView */
@property (nonatomic, weak, readonly) UIScrollView *scrollView;

/** scrollViewBottomConstraint */
@property (nonatomic, strong) NSLayoutConstraint *scrollViewBottomConstraint;
@end
