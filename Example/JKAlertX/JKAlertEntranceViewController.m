//
//  JKAlertEntranceViewController.m
//  JKAlertX_Example
//
//  Created by yban on 2022/8/5.
//  Copyright © 2022 jkayb123cool@gmail.com. All rights reserved.
//

#import "JKAlertEntranceViewController.h"
#import "JKAlertX.h"

@interface JKAlertEntranceViewController ()

@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
@end

@implementation JKAlertEntranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.jumpButton JKAlertX_clipRoundWithRadius:10.0 corner:(UIRectCornerAllCorners) borderWidth:5.0 borderColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
