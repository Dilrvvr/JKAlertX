//
//  JKAlertCompareSystemViewController.m
//  TestAlert
//
//  Created by Albert on 2020/5/30.
//  Copyright © 2020 Albert. All rights reserved.
//

#import "JKAlertCompareSystemViewController.h"
#import "JKAlertX.h"

@interface JKAlertCompareSystemViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *clearTitleButton;
@property (weak, nonatomic) IBOutlet UIButton *textFiledButton;
@property (weak, nonatomic) IBOutlet UIButton *styleButton;
@property (weak, nonatomic) IBOutlet UIButton *clearMessageButton;
@property (weak, nonatomic) IBOutlet UIButton *addActionButton;

/** titleString */
@property (nonatomic, copy) NSString *titleString;

/** messageString */
@property (nonatomic, copy) NSString *messageString;

/** alertControllerStyle */
@property (nonatomic, assign) UIAlertControllerStyle alertControllerStyle;

/** jkAlertStyle */
@property (nonatomic, assign) JKAlertStyle jkAlertStyle;

/** textFieldCount */
@property (nonatomic, assign) NSInteger textFieldCount;

/** actionCount */
@property (nonatomic, assign) NSInteger actionCount;
@end

@implementation JKAlertCompareSystemViewController

- (BOOL)shouldAutorotate {
    
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"与系统弹框比较";
    
    self.alertControllerStyle = UIAlertControllerStyleAlert;
    self.jkAlertStyle = JKAlertStyleAlert;
    
    self.titleString = @"呵呵呵呵呵";
    self.messageString = @"呵呵呵呵呵";
    
    self.textFieldCount = 0;
}

- (void)buildUI {
    
}

- (void)setTitleString:(NSString *)titleString {
    _titleString = [titleString copy];
    
    self.titleLabel.text = _titleString;
}

- (void)setMessageString:(NSString *)messageString {
    _messageString = messageString;
    
    self.messageLabel.text = _messageString;
}

- (void)setTextFieldCount:(NSInteger)textFieldCount {
    _textFieldCount = textFieldCount;
    
    NSString *text = [NSString stringWithFormat:@"%zd text field", _textFieldCount];
    
    self.textFiledButton.titleLabel.text = text;
    [self.textFiledButton setTitle:text forState:UIControlStateNormal];
}

- (void)setActionCount:(NSInteger)actionCount {
    _actionCount = actionCount;
    
    NSString *text = [NSString stringWithFormat:@"%zd action", _actionCount];
    
    self.addActionButton.titleLabel.text = text;
    [self.addActionButton setTitle:text forState:UIControlStateNormal];
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

- (IBAction)addTextField:(id)sender {
    
    self.textFieldCount++;
}

- (IBAction)clearTextField:(id)sender {
    
    self.textFieldCount = 0;
}

- (IBAction)styleButtonClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    self.alertControllerStyle = sender.selected ? UIAlertControllerStyleActionSheet : UIAlertControllerStyleAlert;
    self.jkAlertStyle = sender.selected ? JKAlertStyleActionSheet : JKAlertStyleAlert;
}

- (IBAction)addAction:(id)sender {
    
    self.actionCount++;
}

- (IBAction)clearAction:(id)sender {
    
    self.actionCount = 0;
}

- (IBAction)clearMessageButtonClick:(id)sender {
    
    self.messageString = nil;
}

- (IBAction)showAlert:(id)sender {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:self.titleString message:self.messageString preferredStyle:(self.alertControllerStyle)];
    
    if (self.textFieldCount > 0 &&
        UIAlertControllerStyleAlert == self.alertControllerStyle) {
        
        for (NSInteger i = 0; i < self.textFieldCount; i++) {
            
            [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
                textField.text = @(i + 1).stringValue;
            }];
        }
    }
    
    if (self.actionCount > 0) {
        
        for (NSInteger i = 0; i < self.actionCount; i++) {
            
            [alertVC addAction:[UIAlertAction actionWithTitle:[@"action" stringByAppendingString:@(i + 1).stringValue] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
        }
    }
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)showAlertView:(id)sender {
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:self.titleString message:self.messageString style:self.jkAlertStyle];
    
    alertView.makeVerticalGestureDismissEnabled(YES)
    .makeHorizontalGestureDismissDirection(JKAlertSheetHorizontalGestureDismissDirectionHorizontal)
    .makeGestureIndicatorHidden(NO);
    
    alertView.makeTapBlankDismiss(self.actionCount <= 0 || JKAlertStyleActionSheet == self.jkAlertStyle);
    
    if (self.textFieldCount > 0) {
        
        for (NSInteger i = 0; i < self.textFieldCount; i++) {
            
            [alertView addTextFieldWithConfigurationHandler:^(JKAlertView *view, UITextField *textField) {
                
                textField.text = @(i + 1).stringValue;
            }];
        }
    }
    
    if (self.actionCount > 0) {
        
        for (NSInteger i = 0; i < self.actionCount; i++) {
            
            [alertView addAction:[JKAlertAction actionWithTitle:[@"action" stringByAppendingString:@(i + 1).stringValue] style:(JKAlertActionStyleDefaultBlack) handler:^(JKAlertAction *action) {
                
            }]];
        }
    }
    
    [alertView show];
}
@end
