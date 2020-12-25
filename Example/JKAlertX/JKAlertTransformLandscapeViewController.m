//
//  JKAlertTransformLandscapeViewController.m
//  JKAlertX
//
//  Created by albert on 2019/5/8.
//  Copyright © 2019 Albert. All rights reserved.
//

#import "JKAlertTransformLandscapeViewController.h"
#import "JKAlertX/JKAlertX.h"

@interface JKAlertTestLabel : UILabel

@end

@interface JKAlertTransformLandscapeViewController ()

/** testLabel */
@property (nonatomic, weak) JKAlertTestLabel *testLabel;
@end

@implementation JKAlertTransformLandscapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"transform横屏";
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.testLabel.frame = self.view.bounds;
}

- (UIView *)customSuperView {
    
    if (!_testLabel) {
        
        CGRect rect = JKAlertUtility.keyWindow.bounds;
        
        JKAlertTestLabel *testLabel = [[JKAlertTestLabel alloc] initWithFrame:rect];
        //testLabel.textAlignment = NSTextAlignmentCenter;
        //testLabel.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
        //testLabel.text = @"TransformLandscape";
        //testLabel.hidden = YES;
        //testLabel.userInteractionEnabled = YES;
        [self.view addSubview:testLabel];
        _testLabel = testLabel;
        
        self.testLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
        testLabel.frame = rect;
    }
    
    return _testLabel;
}
@end





#pragma mark
#pragma mark - JKAlertTestLabel

@implementation JKAlertTestLabel

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    self.userInteractionEnabled = self.subviews.count > 0;
    
    return [super hitTest:point withEvent:event];
}
@end
