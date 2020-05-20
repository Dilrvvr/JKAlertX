//
//  JKAlertVisualFormatConstraintManager.h
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import <Foundation/Foundation.h>

@interface JKAlertVisualFormatConstraintManager : NSObject

+ (void)addConstraintsWithFormat:(NSString *)format
                     viewKeyName:(NSString *)viewKeyName
                      targetView:(UIView *)targetView
                 constraintsView:(UIView *)constraintsView;
@end
