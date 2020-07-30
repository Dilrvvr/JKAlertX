//
//  JKAlertCustomViewController.m
//  JKAlertX_Example
//
//  Created by albert on 2020/7/30.
//  Copyright © 2020 jkayb123cool@gmail.com. All rights reserved.
//

#import "JKAlertCustomViewController.h"
#import "JKAlertX.h"

@interface JKAlertCustomViewController ()

@end

@implementation JKAlertCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)customAlert:(id)sender {
    
    [JKAlertManager showCustomAlertWithViewHandler:^UIView *{
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.0, 200.0)];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = @"我是自定义的alert~";
        
        label.backgroundColor = [UIColor orangeColor];
        
        return label;
        
    } clearAlertBackgroundColor:NO configurationBeforeShow:^(JKAlertView *innerAlertView) {
        
        [innerAlertView addAction:JKAlertAction.action(@"确定", JKAlertActionStyleDefaultBlack, ^(JKAlertAction *action) {
            
        })];
    }];
}

- (IBAction)customSheet:(id)sender {
    
    [JKAlertManager showCustomSheetWithViewHandler:^UIView *{
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.0, 300.0)];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = @"我是自定义的sheet~";
        
        label.backgroundColor = [UIColor orangeColor];
        
        return label;
        
    } configurationBeforeShow:^(JKAlertView *innerAlertView) {
        
    }];
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
