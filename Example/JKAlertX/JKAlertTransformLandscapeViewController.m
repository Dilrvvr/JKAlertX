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
    
    [JKAlertView alertViewWithTitle:@"customCollectionActionView" message:nil style:(JKAlertStyleCollectionSheet)].setCustomSuperView(self.testLabel).setTitleTextViewAlignment(NSTextAlignmentCenter).setFlowlayoutItemWidth((MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25).addAction([JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
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
        
    }).setNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])).enableDeallocLog(YES).show().setDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customCollectionActionView" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)customPlainAction:(id)sender {
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好你好" style:(JKAlertStylePlain)].setCustomSuperView(self.testLabel);
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^(JKAlertAction *action) {
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        button.frame = CGRectMake(0, 0, 0, 200);
        
        [button setTitle:@"我是自定义的view~~" forState:(UIControlStateNormal)];
        button.backgroundColor = [UIColor orangeColor];
        
        [button JKAlertX_addClickOperation:^(UIButton *control) {
            
            action.alertView.dismiss();
        }];
        
        return button;
    })];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    alertView.enableDeallocLog(YES).show().setDidDismissHandler(^{
        
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
        alertView.setCustomSuperView(self.testLabel).setPlainTitleMessageSeparatorHidden(NO, 0).
        setTextViewTopBottomMargin(15).setTitleMessageMargin(0).setMessageMinHeight(100);
        
        // 配置关闭按钮
        alertView.setPlainCloseButtonConfig(^(UIButton *closeButton) {
            
            [closeButton setTitle:@"x" forState:(UIControlStateNormal)];
            [closeButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            closeButton.backgroundColor = [UIColor orangeColor];
            closeButton.layer.cornerRadius = closeButton.frame.size.width * 0.5;
        });
        
        [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleCancel) handler:^(JKAlertAction *action) {
            
        }]];
        
        [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
            
            if (action.autoDismiss) { return; }
            
            action.setAutoDismiss(YES).resetTitle(@"知道了").setTitleColor([UIColor redColor]).alertView.resetAlertTitle(@"UI已更新").resetMessage(@"再次点击确定退出...").setMessageMinHeight(80).setPlainCloseButtonConfig(^(UIButton *closeButton) {
                
                closeButton.hidden = YES;
                
            }).relayout(YES);
            
        }].setAutoDismiss(NO)];
        
        // 向上偏移100
        //alertView.setPlainCenterOffsetY(-100);
        
        // 自定义展示动画
        alertView.setCustomShowAnimationBlock(^(JKAlertView *view, UIView *animationView) {
            
            view.window.userInteractionEnabled = YES;
            
            animationView.transform = CGAffineTransformMakeScale(0.3, 0.3);
            
            [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:15.0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations:^{
                
                animationView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                
            } completion:^(BOOL finished) {
                
                view.showAnimationDidComplete();
            }];
            
        });
        
        // 自定义消失动画
        alertView.setCustomDismissAnimationBlock(^(JKAlertView *view, UIView *animationView) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                animationView.frame = CGRectMake(animationView.frame.origin.x, [UIScreen mainScreen].bounds.size.height, animationView.frame.size.width, animationView.frame.size.height);
                
            } completion:^(BOOL finished) {
                
                view.dismissAnimationDidComplete();
            }];
        });
        
        // 显示动画完毕后，向上偏移150
        alertView.setDidShowHandler(^(JKAlertView *view) {
            
            //        view.movePlainCenterOffsetY(-150, YES);
        });
        
        alertView.enableDeallocLog(YES).show().setDidDismissHandler(^{
            
            [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [sender setTitle:@"plain" forState:(UIControlStateNormal)];
            });
        });
    });
}

- (IBAction)textField:(id)sender {
    
    //    __weak typeof(self) weakSelf = self;
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"请输入帐号密码" style:(JKAlertStylePlain)].setCustomSuperView(self.testLabel);
    
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
    
    alertView.enableDeallocLog(YES).show().setDidDismissHandler(^{
        
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
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好" style:(JKAlertStyleActionSheet)].setCustomSuperView(self.testLabel);
    //    JKAlertView *alertView = [JKAlertView alertViewWithTitle:nil message:nil style:(JKAlertStyleActionSheet)];
    
    alertView.setContainerViewConfig(^(UIView *containerView) {
        
        // 加个圆角
        [containerView JKAlertX_clipRoundWithRadius:8 corner:(UIRectCornerTopLeft | UIRectCornerTopRight) borderWidth:0 borderColor:nil];
    });
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定1" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Twitter"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定2" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Facebook"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"更新message" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        if (action.isAutoDismiss) { return; }
        
        action.setAutoDismiss(YES).setCustomView(^UIView *(JKAlertAction *action) {
            
            return [UIView new];
            
        }).alertView.resetMessage(@"message已更新").setMessageTextColor([UIColor redColor]).relayout(YES);
        
    }].setAutoDismiss(NO)];
    
    //    alertView.setCancelAction([JKAlertAction actionWithTitle:@"cancel" style:(JKAlertActionStyleDestructive) handler:nil]);
    
    alertView.enableDeallocLog(YES).show().setDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"actionSheet" forState:(UIControlStateNormal)];
        });
    });
}

// use customSuperView
- (IBAction)collectionSheet:(id)sender {
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)].setCustomSuperView(self.testLabel).setFlowlayoutItemWidth((MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25).setCompoundCollection(YES).setCollectionPagingEnabled(YES).setBottomButtonMargin(10);
    
    // 第1组
    alertView.setCollectionAction([JKAlertAction actionWithTitle:@"更新title并取消底部间距" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        if (action.autoDismiss) { return; }
        
        action.setAutoDismiss(YES).setCustomView(^UIView *(JKAlertAction *action) {
            
            return [UIView new];
            
        }).setTitleColor([UIColor redColor]).alertView.resetAlertTitle(@"title is updated").setTitleTextColor([UIColor redColor]).setBottomButtonMargin(0.5).relayout(YES);
        
    }].setAutoDismiss(NO)).setShowPageControl(YES);
    
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
    
    alertView.enableDeallocLog(YES).show().setDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"collectionSheet" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)testShare:(UIButton *)sender {
    
    [JKAlertView alertViewWithTitle:@"分享到" message:nil style:(JKAlertStyleCollectionSheet)].setCustomSuperView(self.testLabel).setTitleTextViewAlignment(NSTextAlignmentLeft).setTextViewLeftRightMargin(4).setFlowlayoutItemWidth((MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25).setOrientationChangeBlock(^(JKAlertView *view, UIInterfaceOrientation orientation) {
        
    }).addAction([JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat"])).addAction([JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])).enableDeallocLog(YES).show().setDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"testShare" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)customActionSheetView:(id)sender {
    
    [JKAlertView alertViewWithTitle:@"提示" message:@"这是action样式的customView\n想自定义titleView并固定在顶部的话可以使用setCustomActionSheetTitleView\n想自定义titleView并跟随tableView滚动的话可以将title和message赋值nil，并将第一个JKAlertAction设为空action，然后给这个空action赋值customView即可" style:(JKAlertStyleActionSheet)].setCustomSuperView(self.testLabel).addAction([JKAlertAction actionWithTitle:nil style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^(JKAlertAction *action) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是自定义的view~~";
        
        return label;
        
    })).addAction([JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]).enableDeallocLog(YES).show().setDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customActionSheetView" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)HUD:(id)sender {
    
    JKAlertView.showHUDWithTitle(@"你好你好你好你好", ^(JKAlertView *alertView) {
        
        alertView.setCustomSuperView(self.testLabel).setHUDHeight(100).setDismissTimeInterval(2).enableDeallocLog(YES).setDidDismissHandler(^{
            
            [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [sender setTitle:@"HUD" forState:(UIControlStateNormal)];
            });
        });
    });
    
    /* or use like following
     [JKAlertView alertViewWithTitle:@"你好你好你好你好" message:nil style:(JKAlertStyleHUD)].setDismissTimeInterval(2).enableDeallocLog(YES).show().setDidDismissHandler(^{
     
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
        
        alertView.setCustomSuperView(self.testLabel).setDismissTimeInterval(2).enableDeallocLog(YES).setDidDismissHandler(^{
            
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
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)].setCustomSuperView(self.testLabel).setFlowlayoutItemWidth((MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25).setCompoundCollection(YES).setCollectionPagingEnabled(YES);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) * 0.7, 100)];
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是自定义的view~~";
    
    alertView.setCustomCollectionTitleView(^{
        
        return label;
    });
    
    alertView.setCollectionAction([JKAlertAction actionWithTitle:@"收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]).setShowPageControl(YES);
    
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
    
    alertView.enableDeallocLog(YES).show().setDidDismissHandler(^{
        
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
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好你好" style:(JKAlertStylePlain)].setCustomSuperView(self.testLabel);
    
    // 显示title和message之间的分隔线
    alertView.setPlainTitleMessageSeparatorHidden(NO, 0);
    
    // 设置YES表示仅自定义message
    alertView.setCustomPlainTitleView(YES, ^UIView *(JKAlertView *view) {
        
        return label;
    });
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    alertView.enableDeallocLog(YES).show().setDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customPlainTitle" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)customCollectionButton:(id)sender {
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.alignment = NSTextAlignmentCenter;
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)].setCustomSuperView(self.testLabel).setFlowlayoutItemWidth((MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25).setCompoundCollection(YES).setCollectionPagingEnabled(YES);
    
    // 第1组
    alertView.setCollectionAction([JKAlertAction actionWithTitle:@"收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^(JKAlertAction *action) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是自定义的view~~";
        label.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap =[UITapGestureRecognizer JKAlertX_gestureWithOperation:^(UITapGestureRecognizer *gesture) {
            
            if (gesture.state == UIGestureRecognizerStateEnded) {
                
                action.alertView.dismiss();
            }
        }];
        
        [label addGestureRecognizer:tap];
        
        return label;
        
    })).setShowPageControl(YES).setCancelAction([JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
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
    
    alertView.enableDeallocLog(YES).show().setDidDismissHandler(^{
        
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
