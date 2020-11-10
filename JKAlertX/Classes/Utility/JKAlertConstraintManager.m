//
//  JKAlertConstraintManager.m
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertConstraintManager.h"

@implementation JKAlertConstraintManager

+ (void)addConstraintsWithHorizontalFormat:(NSString *)horizontalFormat
                            verticalFormat:(NSString *)verticalFormat
                               viewKeyName:(NSString *)viewKeyName
                                targetView:(UIView *)targetView
                           constraintsView:(UIView *)constraintsView {
    
    if (!targetView ||
        !targetView.superview ||
        !constraintsView) {
        
        return;
    }
    
    targetView.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (horizontalFormat) {
        
        NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:horizontalFormat options:0 metrics:nil views:@{viewKeyName : targetView}];
        [constraintsView addConstraints:horizontalConstraints];
    }
    
    if (verticalFormat) {
        
        NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:verticalFormat options:0 metrics:nil views:@{viewKeyName : targetView}];
        [constraintsView addConstraints:verticalConstraints];
    }
}

+ (void)addZeroEdgeConstraintsWithTargetView:(UIView *)targetView
                             constraintsView:(UIView *)constraintsView {
    
    [self addConstraintsWithHorizontalFormat:@"H:|-0-[view]-0-|" verticalFormat:@"V:|-0-[view]-0-|" viewKeyName:@"view" targetView:targetView constraintsView:constraintsView];
}
@end
