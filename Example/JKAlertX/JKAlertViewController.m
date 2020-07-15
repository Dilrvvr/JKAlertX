//
//  ViewController.m
//  JKAlertX
//
//  Created by albert on 2018/4/10.
//  Copyright © 2018年 安永博. All rights reserved.
//

#import "JKAlertViewController.h"
#import "JKAlertX.h"

@interface JKAlertViewController ()

@end

@implementation JKAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)customCollectionActionView:(id)sender {
    
    CGFloat screenWidth = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    CGFloat itemWidth = screenWidth * 0.25;
    
    [JKAlertView alertViewWithTitle:@"customCollectionActionView" message:nil style:(JKAlertStyleCollectionSheet)].makeGestureDismissEnabled(YES, YES).makeGestureIndicatorHidden(NO).makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6)).makeCollectionSheetMinimumLineSpacing((screenWidth - itemWidth * 2) / 2).makeCollectionSheetSectionInset(UIEdgeInsetsMake(0, ((screenWidth - itemWidth * 2) / 4), 0, ((screenWidth - itemWidth * 2) / 4))).addAction([JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
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
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好你好" style:(JKAlertStyleAlert)];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefaultBlue) handler:^(JKAlertAction *action) {
        
    }].setCustomizePropertyHandler(^(JKAlertAction *customizePropertyAction) {
        
        [JKAlertThemeProvider providerWithOwner:customizePropertyAction handlerKey:nil provideHandler:^(JKAlertThemeProvider *provider, JKAlertAction *providerOwner) {
            
            providerOwner.setTitleColor(JKAlertCheckDarkMode([UIColor redColor], [UIColor greenColor]));
            
            !providerOwner.refreshAppearanceHandler ? : providerOwner.refreshAppearanceHandler(providerOwner);
        }];
    })];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefaultBlue) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^(JKAlertAction *action) {
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        button.frame = CGRectMake(0, 0, 0, 200);
        
        [button setTitle:@"我是自定义的view~~" forState:(UIControlStateNormal)];
        
        [JKAlertThemeProvider providerWithOwner:button handlerKey:nil provideHandler:^(JKAlertThemeProvider *provider, UIButton *providerOwner) {
            
            providerOwner.backgroundColor = JKAlertCheckDarkMode([UIColor orangeColor], [UIColor purpleColor]);
        }];
        
        button.userInteractionEnabled = NO;
        __weak typeof(action) weakAction = action;
        [button JKAlertX_addClickOperation:^(UIButton *control) {
            
            weakAction.alertView.dismiss();
        }];
        
        return button;
    })];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefaultBlue) handler:^(JKAlertAction *action) {
        
    }]];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefaultBlue) handler:^(JKAlertAction *action) {
        
    }]];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefaultBlue) handler:^(JKAlertAction *action) {
        
    }]];
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customPlainAction" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)plain:(UIButton *)sender {
    
    JKAlertView.show(@"定位服务未开启", @"请进入系统「设置」->「隐私」->「定位服务」中打开开关，并允许妙菜使用定位服务", JKAlertStyleAlert, ^(JKAlertView *alertView) {
        
        // 点击空白处也退出
        // alertView.setclickBlankDismiss(YES);
        
        // 自动缩小宽度以适应屏幕宽度
        //alertView.makePlainWidth(500).makePlainAutoReduceWidth(YES);
        
        // title和message之间加分隔线
        alertView.makeTitleMessageSeparatorLineHidden(NO).makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
            
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
        
        // 向上偏移50
        alertView.makePlainCenterOffset(CGPointMake(0, -50));
        
        // 配置关闭按钮
        alertView.makePlainCloseButtonConfiguration(^(UIButton *closeButton) {
            
            [closeButton setTitle:@"x" forState:(UIControlStateNormal)];
            [closeButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            closeButton.backgroundColor = [UIColor orangeColor];
            closeButton.layer.cornerRadius = closeButton.frame.size.width * 0.5;
        });
        
        [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleCancel) handler:^(JKAlertAction *action) {
            
        }]];
        
        [alertView addAction:[JKAlertAction actionWithTitle:@"更新" style:(JKAlertActionStyleDefaultBlue) handler:^(JKAlertAction *action) {
            
            if (action.autoDismiss) { return; }
            
            action.setAutoDismiss(YES).resetTitle(@"知道了").setTitleColor([UIColor redColor]).alertView.resetAlertTitle(@"UI已更新").resetMessage(@"再次点击确定退出...").makeMessageMinHeight(60).makePlainCloseButtonConfiguration(^(UIButton *closeButton) {
                
                closeButton.hidden = YES;
                
            }).relayout(YES);
            
        }].setAutoDismiss(NO)];
        
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
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"请输入帐号密码" style:(JKAlertStyleAlert)];
    
    alertView.addAction([JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleCancel) handler:^(JKAlertAction *action) {
        
    }]);
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefaultBlue) handler:^(JKAlertAction *action) {
        
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
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好" style:(JKAlertStyleActionSheet)].makeGestureDismissEnabled(YES, YES).makeGestureIndicatorHidden(NO);
    //    JKAlertView *alertView = [JKAlertView alertViewWithTitle:nil message:nil style:(JKAlertStyleActionSheet)];
    
    alertView.makeVibrateEnabled(YES);
    // 固定底部取消按钮
    //alertView.setPinCancelButton(YES);
    
    alertView.makeBottomButtonMargin(8);//.makeHomeIndicatorAdapted(NO);
    
    alertView.makeActionSheetPierced(YES, UIEdgeInsetsMake(0, 15, 0, 15));
    
    [JKAlertThemeProvider providerWithOwner:alertView handlerKey:nil provideHandler:^(JKAlertThemeProvider *provider, JKAlertView *providerOwner) {
        
        providerOwner.makeActionSheetTopBackgroundColor(JKAlertCheckDarkMode([UIColor whiteColor], [UIColor blackColor]));
        
        providerOwner.getCancelAction.setBackgroundColor(JKAlertCheckDarkMode([UIColor whiteColor], [UIColor blackColor]));
        
        !providerOwner.getCancelAction.refreshAppearanceHandler ? : providerOwner.getCancelAction.refreshAppearanceHandler(providerOwner.getCancelAction);
    }];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定1" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Twitter"]).setBackgroundColor(nil)];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定2" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Facebook"]).setBackgroundColor(nil)];
    
    
    
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"更新message" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        if (action.isAutoDismiss) { return; }
        
        action.alertView.getActionArrayFrom(NO, ^(NSArray *actionArray) {
            
            JKAlertAction *action = actionArray.count > 2 ? [actionArray objectAtIndex:(actionArray.count - 2)] : nil;
            
            if (action) {
                
                action.separatorLineHidden = YES;
            }
        });
        
        action.alertView.getCancelOrCollectionAction(YES, ^(JKAlertAction *action) {
            
            if (!action) { return; }
            
            action.resetTitle(@"关闭").setTitleColor([UIColor redColor]);
        });
        
        action.setAutoDismiss(YES).setCustomView(^UIView *(JKAlertAction *action) {
            
            return [UIView new];
            
        }).alertView.resetMessage(@"message已更新").makeMessageColor([UIColor redColor]).relayout(YES);
        
    }].setBackgroundColor(nil).setAutoDismiss(NO)];
    
    //    alertView.setCancelAction([JKAlertAction actionWithTitle:@"cancel" style:(JKAlertActionStyleDestructive) handler:nil]);
    
    //alertView.setAutoAdjustHomeIndicator(NO);
    
    //    alertView.setCancelAction(JKAlertAction.action(nil, JKAlertActionStyleDefault, nil).setCustomView(^UIView *(JKAlertAction *action) {
    //        return [UIView new];
    //    }));
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"actionSheet" forState:(UIControlStateNormal)];
        });
    });
}

// use customSuperView
- (IBAction)collectionSheet:(id)sender {
    
    CGFloat itemWidth = (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) - 30) * 0.25;
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)].makeGestureDismissEnabled(YES, YES).makeGestureIndicatorHidden(NO).makeCollectionSheetCombined(YES).makeCollectionSheetPagingEnabled(YES).makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6)).makeBottomButtonMargin(10).makeCustomSuperView(self.view);
    
    //alertView.setCollectionTitleSeparatorHidden(NO);
    
    alertView.makeCollectionSheetPierced(YES, UIEdgeInsetsMake(0, 15, 24, 15));
    
    alertView.makeCollectionSheetActionButtonPinned(YES).makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
        
        UIEdgeInsets insets = originalInsets;
        
        insets.top = 10;
        
        return insets;
        
    }).makeMessageInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
        
        UIEdgeInsets insets = originalInsets;
        
        insets.bottom = 10;
        
        return insets;
        
    }).makeCollectionSheetSectionInset(UIEdgeInsetsZero).makeCollectionSheetMinimumLineSpacing(0);
    /*
     alertView.makeCancelAction([JKAlertAction actionWithTitle:nil style:(JKAlertActionStyleDefault) handler:nil].setCustomView(^UIView *(JKAlertAction *action) {
     
     return [UIView new];
     })); //*/
    
    //alertView.makeCollectionSheetPierced(YES, UIEdgeInsetsMake(0, 15, 24, 15), 10, [JKAlertMultiColor colorWithLightColor:[UIColor whiteColor] darkColor:[UIColor blackColor]]);
    
    ///* 第1组
    alertView.makeCollectionSheetAction([JKAlertAction actionWithTitle:@"更新title并取消底部间距" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        if (action.autoDismiss) { return; }
        
        action.setAutoDismiss(YES).setCustomView(^UIView *(JKAlertAction *action) {
            
            return [UIView new];
            
        }).setTitleColor([UIColor redColor]).alertView.resetAlertTitle(@"title is updated").makeTitleColor([UIColor redColor]).makeBottomButtonMargin(0.25).relayout(YES);
        
    }].setAutoDismiss(NO)).makeCollectionSheetPageControlHidden(NO); //*/
    
    [JKAlertThemeProvider providerWithOwner:alertView handlerKey:nil provideHandler:^(JKAlertThemeProvider *provider, JKAlertView *providerOwner) {
        
        providerOwner.makeCollectionSheetTopBackgroundColor(JKAlertCheckDarkMode([UIColor whiteColor], [UIColor blackColor]));
        
        providerOwner.getCancelAction.setBackgroundColor(JKAlertCheckDarkMode([UIColor whiteColor], [UIColor blackColor]));
        
        !providerOwner.getCancelAction.refreshAppearanceHandler ? : providerOwner.getCancelAction.refreshAppearanceHandler(providerOwner.getCancelAction);
        
        if (providerOwner.getCollectionAction) {
            
            providerOwner.getCollectionAction.setBackgroundColor(JKAlertCheckDarkMode([UIColor whiteColor], [UIColor blackColor]));
            
            !providerOwner.getCollectionAction.refreshAppearanceHandler ? : providerOwner.getCollectionAction.refreshAppearanceHandler(providerOwner.getCollectionAction);
        }
    }];
    
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
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微信收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Collection"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"QQ" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_QQ"])];
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"collectionSheet" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)testShare:(UIButton *)sender {
    
    CGFloat screenWidth = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    CGFloat itemWidth = screenWidth * 0.25;
    
    [JKAlertView alertViewWithTitle:@"分享到" message:nil style:(JKAlertStyleCollectionSheet)].makeGestureDismissEnabled(YES, YES).makeGestureIndicatorHidden(NO).makeTitleAlignment(NSTextAlignmentLeft).makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6)).makeCollectionSheetMinimumLineSpacing((screenWidth - itemWidth * 2) / 2).makeCollectionSheetSectionInset(UIEdgeInsetsMake(0, ((screenWidth - itemWidth * 2) / 4), 0, ((screenWidth - itemWidth * 2) / 4))).makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
        
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
    
    [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好" style:(JKAlertStyleActionSheet)].makeHomeIndicatorFilled(YES).makeGestureDismissEnabled(YES, YES).makeGestureIndicatorHidden(NO).addAction([JKAlertAction actionWithTitle:nil style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^(JKAlertAction *action) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        label.textColor = [UIColor redColor];
        //label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是自定义的view~~";
        
        return label;
        
    })).addAction([JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]).addAction([JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]).makeDeallocLogEnabled(YES).makeActionSheetCancelButtonPinned(NO).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customActionSheetView" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)HUD:(id)sender {
    
    JKAlertView.showHUDWithTitle(@"你好你好你好你好", ^(JKAlertView *alertView) {
        
        alertView.makeHudHeight(60).makeHudWidth(200).makeHudCenterOffset(CGPointMake(0, 100)).makeHudDismissTimeInterval(5).makeDeallocLogEnabled(YES).makeDidDismissHandler(^{
            
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是自定义的view~~";
    
    JKAlertView.showCustomHUD(^UIView *{
        
        return label;
        
    }, ^(JKAlertView *alertView) {
        
        alertView.makeHudDismissTimeInterval(2).makeDeallocLogEnabled(YES).makeDidDismissHandler(^{
            
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
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)].makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6)).makeCollectionSheetCombined(YES).makeCollectionSheetPagingEnabled(YES).makeGestureDismissEnabled(YES, YES).makeGestureIndicatorHidden(NO).makeCollectionSheetSectionInset(UIEdgeInsetsZero).makeCollectionSheetMinimumLineSpacing(0.0);
    
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
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好你好" style:(JKAlertStyleAlert)];
    
    // 显示title和message之间的分隔线
    alertView.makeTitleMessageSeparatorLineHidden(NO);
    
    // 设置YES表示仅自定义message
    alertView.makeCustomMessageView(^UIView *{
        
        return label;
    });
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefaultBlue) handler:^(JKAlertAction *action) {
        
    }]];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefaultBlue) handler:^(JKAlertAction *action) {
        
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
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)].makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6)).makeCollectionSheetCombined(YES).makeCollectionSheetPagingEnabled(YES).makeGestureDismissEnabled(YES, YES).makeGestureIndicatorHidden(NO).makeCollectionSheetSectionInset(UIEdgeInsetsZero).makeCollectionSheetMinimumLineSpacing(0.0);
    
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
    
    alertView.addSecondCollectionAction([JKAlertAction new]).addSecondCollectionAction([JKAlertAction new]).addSecondCollectionAction([JKAlertAction new]).addSecondCollectionAction([JKAlertAction new]);
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customCollectionButton" forState:(UIControlStateNormal)];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)themeStyleStringWithStyle:(JKAlertThemeStyle)themeStyle {
    // TODO: - JKTODO delete
    
    switch (themeStyle) {
        case JKAlertThemeStyleSystem:
            return @"JKAlertThemeStyleSystem";
            break;
        case JKAlertThemeStyleLight:
            return @"JKAlertThemeStyleLight";
            break;
        case JKAlertThemeStyleDark:
            return @"JKAlertThemeStyleDark";
            break;
            
        default:
            return @"JKAlertThemeStyleSystem";
            break;
    }
    
    return @"JKAlertThemeStyleSystem";
}

- (void)refreshButtonClick:(UIButton *)button {
    
    // TODO: - JKTODO delete
    
//    switch ([JKAlertThemeManager sharedManager].themeStyle) {
//        case JKAlertThemeStyleSystem:
//            JKAlertView.makeThemeStyle(JKAlertThemeStyleLight);
//            break;
//        case JKAlertThemeStyleLight:
//            JKAlertView.makeThemeStyle(JKAlertThemeStyleDark);
//            break;
//        case JKAlertThemeStyleDark:
//            JKAlertView.makeThemeStyle(JKAlertThemeStyleSystem);
//            break;
//
//        default:
//            JKAlertView.makeThemeStyle(JKAlertThemeStyleSystem);
//            break;
//    }
//
//    NSString *title = [weakSelf themeStyleStringWithStyle:[JKAlertThemeManager sharedManager].themeStyle];
//
//    JKAlertView.showHUDWithTitle(title, ^(JKAlertView *alertView) {
//
//    });
}

- (void)dealloc{
    
    NSLog(@"%d, %s",__LINE__, __func__);
}
@end
