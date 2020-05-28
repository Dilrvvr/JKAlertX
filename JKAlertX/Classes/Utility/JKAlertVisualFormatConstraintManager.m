//
//  JKAlertVisualFormatConstraintManager.m
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertVisualFormatConstraintManager.h"

@implementation JKAlertVisualFormatConstraintManager

+ (void)addConstraintsWithHorizontalFormat:(NSString *)horizontalFormat
                            verticalFormat:(NSString *)verticalFormat
                               viewKeyName:(NSString *)viewKeyName
                                targetView:(UIView *)targetView
                           constraintsView:(UIView *)constraintsView {
    
    targetView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:horizontalFormat options:0 metrics:nil views:@{viewKeyName : targetView}];
    [constraintsView addConstraints:horizontalConstraints];
    
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:verticalFormat options:0 metrics:nil views:@{viewKeyName : targetView}];
    [constraintsView addConstraints:verticalConstraints];
}

+ (void)addZeroEdgeConstraintsWithTargetView:(UIView *)targetView
                             constraintsView:(UIView *)constraintsView {
    
    [self addConstraintsWithHorizontalFormat:@"H:|-0-[view]-0-|" verticalFormat:@"V:|-0-[view]-0-|" viewKeyName:@"view" targetView:targetView constraintsView:constraintsView];
}
@end
