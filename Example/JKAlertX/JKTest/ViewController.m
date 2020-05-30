//
//  ViewController.m
//  TestAlert
//
//  Created by albertcc on 2020/5/30.
//  Copyright © 2020 albertcc. All rights reserved.
//

#import "ViewController.h"
#import "JKAlertX.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *clearTitleButton;
@property (weak, nonatomic) IBOutlet UIButton *styleButton;
@property (weak, nonatomic) IBOutlet UIButton *clearMessageButton;

/** titleString */
@property (nonatomic, copy) NSString *titleString;

/** messageString */
@property (nonatomic, copy) NSString *messageString;

/** alertControllerStyle */
@property (nonatomic, assign) UIAlertControllerStyle alertControllerStyle;

/** jkAlertStyle */
@property (nonatomic, assign) JKAlertStyle jkAlertStyle;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.alertControllerStyle = UIAlertControllerStyleAlert;
    self.jkAlertStyle = JKAlertStyleAlert;
    
    self.titleString = @"呵呵呵呵呵";
    self.messageString = @"呵呵呵呵呵";
}

- (void)setTitleString:(NSString *)titleString {
    _titleString = [titleString copy];
    
    self.titleLabel.text = _titleString;
}

- (void)setMessageString:(NSString *)messageString {
    _messageString = messageString;
    
    self.messageLabel.text = _messageString;
}

- (IBAction)titleButtonClick:(UIButton *)sender {
    
    self.titleString = [(self.titleString ? self.titleString : @"") stringByAppendingString:sender.currentTitle];
}

- (IBAction)messageButtonClick:(UIButton *)sender {
    
    self.messageString = [(self.messageString ? self.messageString : @"") stringByAppendingString:sender.currentTitle];
}

- (IBAction)clearTitleButtonClick:(id)sender {
    
    self.titleString = nil;
}

- (IBAction)styleButtonClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    self.alertControllerStyle = sender.selected ? UIAlertControllerStyleActionSheet : UIAlertControllerStyleAlert;
    self.jkAlertStyle = sender.selected ? JKAlertStyleActionSheet : JKAlertStyleAlert;
}

- (IBAction)clearMessageButtonClick:(id)sender {
    
    self.messageString = nil;
}

- (IBAction)showAlert:(id)sender {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:self.titleString message:self.messageString preferredStyle:(self.alertControllerStyle)];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)showAlertView:(id)sender {
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:self.titleString message:self.messageString style:self.jkAlertStyle];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleCancel) handler:^(JKAlertAction *action) {
        
    }]];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确认" style:(JKAlertActionStyleDefaultBlue) handler:^(JKAlertAction *action) {
        
    }]];
    
    [alertView show];
}

@end
