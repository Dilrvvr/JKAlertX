//
//  JKAlertTransformLandscapeViewController.m
//  JKAlertX
//
//  Created by albert on 2019/5/8.
//  Copyright © 2019 安永博. All rights reserved.
//

#import "JKAlertTransformLandscapeViewController.h"
#import "JKAlertX/JKAlertX.h"

@interface JKAlertTransformLandscapeViewController ()

/** testLabel */
@property (nonatomic, weak) UILabel *testLabel;
@end

@implementation JKAlertTransformLandscapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = [UIApplication sharedApplication].delegate.window.bounds;
    
    UILabel *testLabel = [[UILabel alloc] initWithFrame:rect];
    testLabel.textAlignment = NSTextAlignmentCenter;
    testLabel.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
    testLabel.text = @"TransformLandscape";
    //testLabel.hidden = YES;
    testLabel.userInteractionEnabled = YES;
    [self.view insertSubview:testLabel atIndex:0];
    _testLabel = testLabel;
    
    self.testLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
    testLabel.frame = rect;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    //self.testLabel.frame = self.view.bounds;
}

- (IBAction)customCollectionActionView:(id)sender {
    
    CGFloat itemWidth = (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25;
    
    [JKAlertView alertViewWithTitle:@"customCollectionActionView" message:nil style:(JKAlertStyleCollectionSheet)].makeCustomSuperView(self.testLabel).makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6)).addAction([JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^(JKAlertAction *action) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是自定义的view~~";
        
        return label;
        
    }).setNormalImage([UIImage imageNamed:@"Share_WeChat"])).addAction([JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^(JKAlertAction *action) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我也是自定义的view~~";
        
        return label;
        
    }).setNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])).makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customCollectionActionView" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)customPlainAction:(id)sender {
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好你好" style:(JKAlertStylePlain)].makeCustomSuperView(self.testLabel);
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^(JKAlertAction *action) {
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        button.frame = CGRectMake(0, 0, 0, 200);
        
        [button setTitle:@"我是自定义的view~~" forState:(UIControlStateNormal)];
        button.backgroundColor = [UIColor orangeColor];
        
        __weak typeof(action) weakAction = action;
        [button JKAlertX_addClickOperation:^(UIButton *control) {
            
            weakAction.alertView.dismiss();
        }];
        
        return button;
    })];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customPlainAction" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)plain:(UIButton *)sender {
    
    JKAlertView.show(@"定位服务未开启", @"请进入系统「设置」->「隐私」->「定位服务」中打开开关，并允许妙菜使用定位服务", JKAlertStylePlain, ^(JKAlertView *alertView) {
        
        // 点击空白处也退出
        // alertView.setclickBlankDismiss(YES);
        
        // title和message之间加分隔线
        alertView.makeCustomSuperView(self.testLabel).makeTitleMessageSeparatorLineHidden(NO).makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
            
            UIEdgeInsets insets = originalInsets;
            
            insets.top = 15;
            insets.bottom = 15;
            
            return insets;
            
        }).makeMessageInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
            
            UIEdgeInsets insets = originalInsets;
            
            insets.top = 15;
            insets.bottom = 15;
            
            return insets;
            
        }).makeMessageMinHeight(80);
        
        // 配置关闭按钮
        alertView.makePlainCloseButtonConfiguration(^(UIButton *closeButton) {
            
            [closeButton setTitle:@"x" forState:(UIControlStateNormal)];
            [closeButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            closeButton.backgroundColor = [UIColor orangeColor];
            closeButton.layer.cornerRadius = closeButton.frame.size.width * 0.5;
        });
        
        [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleCancel) handler:^(JKAlertAction *action) {
            
        }]];
        
        [alertView addAction:[JKAlertAction actionWithTitle:@"更新" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
            
            if (action.autoDismiss) { return; }
            
            action.setAutoDismiss(YES).resetTitle(@"知道了").setTitleColor([UIColor redColor]).alertView.resetAlertTitle(@"UI已更新").resetMessage(@"再次点击确定退出...").makeMessageMinHeight(60).makePlainCloseButtonConfiguration(^(UIButton *closeButton) {
                
                closeButton.hidden = YES;
                
            }).relayout(YES);
            
        }].setAutoDismiss(NO)];
        
        // 向上偏移100
        //alertView.setPlainCenterOffsetY(-100);
        
        // 自定义展示动画
        alertView.makeCustomShowAnimationHandler(^(JKAlertView *innerView, UIView *animationView) {
            
            innerView.window.userInteractionEnabled = YES;
            
            animationView.transform = CGAffineTransformMakeScale(0.3, 0.3);
            
            [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:15.0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations:^{
                
                animationView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                
            } completion:^(BOOL finished) {
                
                innerView.showAnimationDidComplete();
            }];
            
        });
        
        // 自定义消失动画
        alertView.makeCustomDismissAnimationHandler(^(JKAlertView *innerView, UIView *animationView) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                animationView.frame = CGRectMake(animationView.frame.origin.x, [UIScreen mainScreen].bounds.size.height, animationView.frame.size.width, animationView.frame.size.height);
                
            } completion:^(BOOL finished) {
                
                innerView.dismissAnimationDidComplete();
            }];
        });
        
        // 显示动画完毕后，向上偏移150
        alertView.makeDidShowHandler(^(JKAlertView *view) {
            
            //        view.movePlainCenterOffsetY(-150, YES);
        });
        
        alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
            
            [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [sender setTitle:@"plain" forState:(UIControlStateNormal)];
            });
        });
    });
}

- (IBAction)textField:(id)sender {
    
    //    __weak typeof(self) weakSelf = self;
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"请输入帐号密码" style:(JKAlertStylePlain)].makeCustomSuperView(self.testLabel);
    
    alertView.addAction([JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleCancel) handler:^(JKAlertAction *action) {
        
    }]);
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    alertView.addTextFieldWithConfigurationHandler(^(JKAlertView *view, UITextField *textField) {
        
        textField.placeholder = @"帐号";
    });
    
    [alertView addTextFieldWithConfigurationHandler:^(JKAlertView *view, UITextField *textField) {
        
        textField.placeholder = @"密码";
    }];
    
    //    [alertView addTextFieldWithConfigurationHandler:^(JKAlertView *view, UITextField *textField) {
    //
    //        textField.hidden = YES;
    //        textField.frame = CGRectMake(0, 0, 0, 300);
    //
    //        textField.superview.backgroundColor = [UIColor orangeColor];
    //
    //        UILabel *label = [[UILabel alloc] init];
    //        label.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    //        label.textColor = [UIColor redColor];
    //        label.text = @"隐私政策";
    //        [textField.superview addSubview:label];
    //
    //        [label sizeToFit];
    //
    //        // textField之间的间距是1，默认高度30，和其superView的上下左右间距也是1，290是默认的plain样式宽度，20是是默认的的左右间距
    //        label.frame = CGRectMake(0, 1 + 30 + 1 + 30 + 1 + 15, 290 - 20 * 2, label.bounds.size.height);
    //    }];
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"textField" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)actionSheet:(id)sender {
    
    //    JKAlertView *alertView = [JKAlertView alertViewWithTitle:nil message:nil Style:(JKAlertStyleActionSheet)];
    
    //    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    //    para.alignment = NSTextAlignmentCenter;
    
    //    JKAlertView *alertView = [JKAlertView alertViewWithAttributedTitle:nil attributedMessage:[[NSAttributedString alloc] initWithString:@"你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好" attributes:@{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSParagraphStyleAttributeName : para}] style:(JKAlertStyleActionSheet)];
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好" style:(JKAlertStyleActionSheet)].makeCustomSuperView(self.testLabel);
    //    JKAlertView *alertView = [JKAlertView alertViewWithTitle:nil message:nil style:(JKAlertStyleActionSheet)];
    
    alertView.makeAlertContentViewConfiguration(^(UIView *alertContentView) {
        
        // 加个圆角
        [alertContentView JKAlertX_clipRoundWithRadius:8 corner:(UIRectCornerTopLeft | UIRectCornerTopRight) borderWidth:0 borderColor:nil];
    });
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定1" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Twitter"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定2" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Facebook"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"更新message" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        if (action.isAutoDismiss) { return; }
        
        action.setAutoDismiss(YES).setCustomView(^UIView *(JKAlertAction *action) {
            
            return [UIView new];
            
            // TODO: JKTODO <#注释#>
        }).alertView.resetMessage(@"message已更新");//.makeMessageColor([JKAlertMultiColor colorWithSameColor:[UIColor redColor]]).relayout(YES);
        
    }].setAutoDismiss(NO)];
    
    //    alertView.setCancelAction([JKAlertAction actionWithTitle:@"cancel" style:(JKAlertActionStyleDestructive) handler:nil]);
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"actionSheet" forState:(UIControlStateNormal)];
        });
    });
}

// use customSuperView
- (IBAction)collectionSheet:(id)sender {
    
    CGFloat itemWidth = ((MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25);
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)].makeCustomSuperView(self.testLabel).makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6)).makeCollectionSheetCombined(YES).makeCollectionSheetPagingEnabled(YES).makeBottomButtonMargin(10);
    
    // 第1组
    alertView.makeCollectionSheetAction([JKAlertAction actionWithTitle:@"更新title并取消底部间距" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        if (action.autoDismiss) { return; }
        
        action.setAutoDismiss(YES).setCustomView(^UIView *(JKAlertAction *action) {
            
            return [UIView new];
            
        }).setTitleColor([UIColor redColor]).alertView.resetAlertTitle(@"title is updated").makeTitleColor([UIColor redColor]).makeBottomButtonMargin(0.5).relayout(YES);
        
    }].setAutoDismiss(NO)).makeCollectionSheetPageControlHidden(NO);
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"微信收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Collection"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"QQ" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_QQ"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"微博" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Sina"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"信息" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Message"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"Email" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Email"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"复制链接" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Copylink"])];
    
    // 第2组
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微博" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Sina"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"信息" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Message"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"Email" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Email"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"复制链接" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Copylink"])];
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"collectionSheet" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)testShare:(UIButton *)sender {
    
    CGFloat itemWidth = (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25;
    
    [JKAlertView alertViewWithTitle:@"分享到" message:nil style:(JKAlertStyleCollectionSheet)].makeCustomSuperView(self.testLabel).makeTitleAlignment(NSTextAlignmentLeft).makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6)).makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
        
        UIEdgeInsets insets = originalInsets;
        
        insets.left = 4;
        insets.right = 4;
        
        return insets;
        
    }).makeMessageInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
        
        UIEdgeInsets insets = originalInsets;
        
        insets.left = 4;
        insets.right = 4;
        
        return insets;
        
    }).addAction([JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat"])).addAction([JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])).makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"testShare" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)customActionSheetView:(id)sender {
    
    [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好" style:(JKAlertStyleActionSheet)].makeCustomSuperView(self.testLabel).addAction([JKAlertAction actionWithTitle:nil style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^(JKAlertAction *action) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是自定义的view~~";
        
        return label;
        
    })).addAction([JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]).makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customActionSheetView" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)HUD:(id)sender {
    
    JKAlertView.showHUDWithTitle(@"你好你好你好你好", ^(JKAlertView *alertView) {
        
        alertView.makeCustomSuperView(self.testLabel).makeHudHeight(100).makeHudDismissTimeInterval(2).makeDeallocLogEnabled(YES).makeDidDismissHandler(^{
            
            [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [sender setTitle:@"HUD" forState:(UIControlStateNormal)];
            });
        });
    });
    
    /* or use like following
     [JKAlertView alertViewWithTitle:@"你好你好你好你好" message:nil style:(JKAlertStyleHUD)].setDismissTimeInterval(2).makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
     
     [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
     
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     
     [sender setTitle:@"HUD" forState:(UIControlStateNormal)];
     });
     }); //*/
}

- (IBAction)customHUD:(id)sender{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) * 0.7, 200)];
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是自定义的view~~";
    
    JKAlertView.showCustomHUD(^UIView *{
        
        return label;
        
    }, ^(JKAlertView *alertView) {
        
        alertView.makeCustomSuperView(self.testLabel).makeHudDismissTimeInterval(2).makeDeallocLogEnabled(YES).makeDidDismissHandler(^{
            
            [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [sender setTitle:@"customHUD" forState:(UIControlStateNormal)];
            });
        });
    });
}

- (IBAction)customCollectionTitle:(id)sender {
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.alignment = NSTextAlignmentCenter;
    
    CGFloat itemWidth = (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25;
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)].makeCustomSuperView(self.testLabel).makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6)).makeCollectionSheetCombined(YES).makeCollectionSheetPagingEnabled(YES);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) * 0.7, 100)];
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是自定义的view~~";
    
    alertView.makeCollectionSheetCustomTitleView(^{
        
        return label;
    });
    
    alertView.makeCollectionSheetAction([JKAlertAction actionWithTitle:@"收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]).makeCollectionSheetPageControlHidden(NO);
    
    // 第1组
    [alertView addAction:[JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"微信收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Collection"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"QQ" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_QQ"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"微博" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Sina"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"信息" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Message"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"Email" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Email"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"复制链接" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Copylink"])];
    
    // 第2组
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微信收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Collection"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"QQ" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_QQ"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微博" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Sina"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"信息" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Message"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"Email" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Email"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"复制链接" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Copylink"])];
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customCollectionTitle" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)customPlainTitle:(id)sender {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) * 0.7, 200)];
    //    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是自定义的view~~";
    label.attributedText = [[NSAttributedString alloc] initWithString:@"我是自定义的view~~" attributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好你好" style:(JKAlertStylePlain)].makeCustomSuperView(self.testLabel);
    
    // 显示title和message之间的分隔线
    alertView.makeTitleMessageSeparatorLineHidden(NO);
    
    // 设置YES表示仅自定义message
    alertView.makeCustomMessageView(^UIView *{
        
        return label;
    });
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customPlainTitle" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)customCollectionButton:(id)sender {
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.alignment = NSTextAlignmentCenter;
    
    CGFloat itemWidth = (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25;
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)].makeCustomSuperView(self.testLabel).makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6)).makeCollectionSheetCombined(YES).makeCollectionSheetPagingEnabled(YES);
    
    // 第1组
    alertView.makeCollectionSheetAction([JKAlertAction actionWithTitle:@"收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^(JKAlertAction *action) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是自定义的view~~";
        label.userInteractionEnabled = YES;
        
        __weak typeof(action) weakAction = action;
        UITapGestureRecognizer *tap = [UITapGestureRecognizer JKAlertX_gestureWithOperation:^(UITapGestureRecognizer *gesture) {
            
            if (gesture.state == UIGestureRecognizerStateEnded) {
                
                [weakAction.alertView dismiss];
            }
        }];
        
        [label addGestureRecognizer:tap];
        
        return label;
        
    })).makeCollectionSheetPageControlHidden(NO).makeCancelAction([JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^(JKAlertAction *action) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我也是自定义的view~~";
        
        return label;
        
    }));
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"微信收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Collection"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"QQ" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_QQ"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"微博" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Sina"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"信息" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Message"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"Email" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Email"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"复制链接" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Copylink"])];
    
    // 第2组
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微博" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Sina"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"信息" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Message"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"Email" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Email"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"复制链接" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Copylink"])];
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customCollectionButton" forState:(UIControlStateNormal)];
        });
    });
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
