//
//  JKAlertVisualFormatConstraintManager.m
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertVisualFormatConstraintManager.h"

@implementation JKAlertVisualFormatConstraintManager

+ (void)addConstraintsWithFormat:(NSString *)format
                     viewKeyName:(NSString *)viewKeyName
                      targetView:(UIView *)targetView
                 constraintsView:(UIView *)constraintsView {
    
    if (!format || !viewKeyName || !targetView || !constraintsView) { return; }
    
    targetView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:@{viewKeyName : targetView}];
    [constraintsView addConstraints:constraints];
}
@end
