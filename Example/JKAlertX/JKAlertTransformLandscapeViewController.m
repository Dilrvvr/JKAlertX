//
//  JKAlertTransformLandscapeViewController.m
//  JKAlertX
//
//  Created by albert on 2019/5/8.
//  Copyright © 2019 Albert. All rights reserved.
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
    
    CGRect rect = JKAlertUtility.keyWindow.bounds;
    
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

#pragma mark
#pragma mark - Plain

- (IBAction)plain:(UIButton *)sender {
    
    JKAlertView.show(@"定位服务未开启", @"请进入系统「设置」->「隐私」->「定位服务」中打开开关，并允许妙菜使用定位服务", JKAlertStyleAlert, ^(JKAlertView *alertView) {
        
        alertView.makeCustomSuperView(self.testLabel);
        
        // 点击空白处也退出
        // alertView.setclickBlankDismiss(YES);
        
        // 自动缩小宽度以适应屏幕宽度
        //alertView.makePlainWidth(500).makePlainAutoReduceWidth(YES);
        
        // title和message之间加分隔线
        alertView.makeTitleMessageSeparatorLineHidden(NO);
        
        // title和message间距
        alertView.makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
            
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
            
            action.makeAutoDismiss(YES).remakeTitle(@"知道了").makeTitleColor([UIColor redColor]).alertView.remakeAlertTitle(@"UI已更新").remakeMessage(@"再次点击确定退出...").makeMessageMinHeight(60).makePlainCloseButtonConfiguration(^(UIButton *closeButton) {
                
                closeButton.hidden = YES;
                
            }).relayout(YES);
            
        }].makeAutoDismiss(NO)];
        
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
            
            //view.movePlainCenterOffsetY(-150, YES);
        });
        
        alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
            
            [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [sender setTitle:@"plain" forState:(UIControlStateNormal)];
            });
        });
    });
}

#pragma mark
#pragma mark - customPlainTitle

- (IBAction)customPlainTitle:(id)sender {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) * 0.7, 190)];
    //label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是自定义的view~~";
    label.attributedText = [[NSAttributedString alloc] initWithString:@"我是自定义的view~~" attributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好你好" style:(JKAlertStyleAlert)];
    
    alertView.makeCustomSuperView(self.testLabel);
    
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

#pragma mark
#pragma mark - HUD

- (IBAction)HUD:(id)sender {
    
    JKAlertView.showHUDWithTitle(@"你好你好你好你好", ^(JKAlertView *alertView) {
        
        alertView.makeCustomSuperView(self.testLabel);
        
        alertView.makeHudAllowUserInteractionEnabled(YES)
        .makeHudHeight(60)
        .makeHudWidth(200)
        .makeHudCenterOffset(CGPointMake(0, 100))
        .makeHudDismissTimeInterval(5)
        .makeDeallocLogEnabled(YES)
        .makeDidDismissHandler(^{
            
            [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [sender setTitle:@"HUD" forState:(UIControlStateNormal)];
            });
        });
    });
    
    /* or use like following
    [JKAlertView alertViewWithTitle:@"你好你好你好你好" message:nil style:(JKAlertStyleHUD)]
    .makeCustomSuperView(self.testLabel);
    .makeHudHeight(60)
    .makeHudWidth(200)
    .makeHudCenterOffset(CGPointMake(0, 100))
    .makeHudDismissTimeInterval(5)
    .makeDeallocLogEnabled(YES)
    .show()
    .makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"HUD" forState:(UIControlStateNormal)];
        });
    }); //*/
}

#pragma mark
#pragma mark - customHUD

- (IBAction)customHUD:(id)sender {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是自定义的view~~";
    
    JKAlertView.showCustomHUD(^UIView *{
        
        return label;
        
    }, ^(JKAlertView *alertView) {
        
        alertView.makeCustomSuperView(self.testLabel);
        
        alertView.makeHudAllowUserInteractionEnabled(YES)
        .makeHudDismissTimeInterval(2)
        .makeDeallocLogEnabled(YES)
        .makeDidDismissHandler(^{
            
            [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [sender setTitle:@"customHUD" forState:(UIControlStateNormal)];
            });
        });
    });
}

#pragma mark
#pragma mark - textField

- (IBAction)textField:(id)sender {
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"请输入帐号密码" style:(JKAlertStyleAlert)];
    
    alertView.makeCustomSuperView(self.testLabel);
    
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
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"textField" forState:(UIControlStateNormal)];
        });
    });
}

#pragma mark
#pragma mark - customPlainAction

- (IBAction)customPlainAction:(id)sender {
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好你好" style:(JKAlertStyleAlert)];
    
    alertView.makeCustomSuperView(self.testLabel);
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefaultBlue) handler:^(JKAlertAction *action) {
        
    }].makeCustomizePropertyHandler(^(JKAlertAction *customizePropertyAction) {
        
        // 深色/浅色模式切换时更新字体颜色
        [JKAlertThemeProvider providerWithOwner:customizePropertyAction handlerKey:nil provideHandler:^(JKAlertThemeProvider *provider, JKAlertAction *providerOwner) {
            
            providerOwner.makeTitleColor(JKAlertCheckDarkMode([UIColor redColor], [UIColor greenColor]));
            
            !providerOwner.refreshAppearanceHandler ? : providerOwner.refreshAppearanceHandler(providerOwner);
        }];
    })];
    
    [alertView addAction:[JKAlertAction actionWithTitle:nil style:(JKAlertActionStyleDefaultBlue) handler:^(JKAlertAction *action) {
        
    }].makeCustomView(^(JKAlertAction *action) {
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.userInteractionEnabled = NO;
        button.frame = CGRectMake(0, 0, 0, 200);
        [button setTitle:@"我是自定义的view~~" forState:(UIControlStateNormal)];
        
        // 深色/浅色模式切换时更新背景色
        [JKAlertThemeProvider providerWithOwner:button handlerKey:nil provideHandler:^(JKAlertThemeProvider *provider, UIButton *providerOwner) {
            
            providerOwner.backgroundColor = JKAlertCheckDarkMode([UIColor orangeColor], [UIColor purpleColor]);
        }];
        
        __weak typeof(action) weakAction = action;
        [button JKAlertX_addClickOperation:^(UIButton *control) {
            
            if (weakAction.alertView) {
                
                weakAction.alertView.dismiss();
            }
        }];
        
        return button;
    })];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleCancel) handler:^(JKAlertAction *action) {
        
    }]];
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customPlainAction" forState:(UIControlStateNormal)];
        });
    });
}

#pragma mark
#pragma mark - actionSheet

- (IBAction)actionSheet:(id)sender {
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好" style:(JKAlertStyleActionSheet)]
    .makeGestureDismissEnabled(YES, YES)
    .makeGestureIndicatorHidden(NO)
    .makeShowScaleAnimated(YES);
    
    alertView.makeCustomSuperView(self.testLabel);
    
    // 展示时振动一下
    alertView.makeVibrateEnabled(YES);
    
    // 固定底部取消按钮
    //alertView.setPinCancelButton(YES);
    
    alertView.makeBottomButtonMargin(8);
    //.makeHomeIndicatorAdapted(NO);
    
    alertView.makeActionSheetPierced(YES, UIEdgeInsetsMake(0, 15, (JKAlertUtility.isDeviceX ? 0 : 24), 15));
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定1" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        
    }].makeNormalImage([UIImage imageNamed:@"Share_Twitter"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定2" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        
    }].makeNormalImage([UIImage imageNamed:@"Share_Facebook"])];
    
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
            
            action.remakeTitle(@"关闭").makeTitleColor([UIColor redColor]);
        });
        
        action.makeAutoDismiss(YES).makeCustomView(^UIView *(JKAlertAction *action) {
            
            return [UIView new];
            
        }).alertView.remakeMessage(@"message已更新").makeMessageColor([UIColor redColor]).relayout(YES);
        
    }].makeAutoDismiss(NO)];
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"actionSheet" forState:(UIControlStateNormal)];
        });
    });
}

#pragma mark
#pragma mark - customActionSheetView

- (IBAction)customCollectionActionView:(id)sender {
    
    [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好" style:(JKAlertStyleActionSheet)]
    .makeHomeIndicatorFilled(YES)
    .makeGestureDismissEnabled(YES, YES)
    .makeGestureIndicatorHidden(NO)
    .makeShowScaleAnimated(YES)
    .makeCustomSuperView(self.testLabel)
    .addAction([JKAlertAction actionWithTitle:nil style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeCustomView(^(JKAlertAction *action) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        label.textColor = [UIColor redColor];
        //label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是自定义的view~~";
        
        return label;
        
    })).addAction([JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]).addAction([JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]).makeDeallocLogEnabled(YES).makeActionSheetBottomButtonPinned(NO).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customActionSheetView" forState:(UIControlStateNormal)];
        });
    });
}

#pragma mark
#pragma mark - collectionSheet

- (IBAction)collectionSheet:(id)sender {
    
    CGFloat itemWidth = (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) - 30) * 0.25;
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)];
    
    alertView.makeCustomSuperView(self.testLabel);
    
    /** 允许手势滑动退出 */
    alertView.makeGestureDismissEnabled(YES, YES)
    /** 显示顶部手势指示横条 */
    .makeGestureIndicatorHidden(NO)
    /** 弹出时缩放动画 */
    .makeShowScaleAnimated(YES)
    /** 两个collectionView合并，同时滚动 */
    .makeCollectionSheetCombined(YES)
    /** 分页 */
    .makeCollectionSheetPagingEnabled(YES)
    /** 显示pageControl */
    .makeCollectionSheetPageControlHidden(NO)
    /** collectionView的itemSize */
    .makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6))
    /** 底部按钮上下之间的间距 */
    .makeBottomButtonMargin(10);
    /** 自定义superView */
    //.makeCustomSuperView(self.view);
    
    // 镂空样式
    alertView.makeCollectionSheetPierced(YES, UIEdgeInsetsMake(0, 15, (JKAlertUtility.isDeviceX ? 0 : 24), 15));
    
    // 固定底部取消按钮 镂空样式时该值始终为YES
    //alertView.makeCollectionSheetBottomButtonPinned(YES);
    
    // 顶部标题的间距
    alertView.makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
        
        UIEdgeInsets insets = originalInsets;
        
        insets.top = 10;
        
        return insets;
        
    }).makeMessageInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
        
        UIEdgeInsets insets = originalInsets;
        
        insets.bottom = 10;
        
        return insets;
        
    });
    
    // sectionInset & minimumLineSpacing(水平方向即左右滚动时minimumLineSpacing表示左右两个item直接的间距)
    alertView.makeCollectionSheetSectionInset(UIEdgeInsetsZero).makeCollectionSheetMinimumLineSpacing(0);
    
    // 添加action
    [self addCollectionActionsWithAlertView:alertView];
    
    // 自定义底部按钮一些内容
    alertView.makeCollectionSheetAction([JKAlertAction actionWithTitle:@"更新title并取消底部间距" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        if (action.autoDismiss) { return; }
        
        action.makeAutoDismiss(YES).makeCustomView(^UIView *(JKAlertAction *action) {
            
            return [UIView new];
            
        }).makeTitleColor([UIColor redColor]).alertView.remakeAlertTitle(@"title is updated").makeTitleColor([UIColor redColor]).makeBottomButtonMargin(0.25).relayout(YES);
        
    }].makeAutoDismiss(NO));
    
    /* 自定义最底部取消按钮
     alertView.makeCancelAction([JKAlertAction actionWithTitle:nil style:(JKAlertActionStyleDefault) handler:nil].makeCustomView(^UIView *(JKAlertAction *action) {
     
     return [UIView new];
     })); //*/
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"collectionSheet" forState:(UIControlStateNormal)];
        });
    });
}

#pragma mark
#pragma mark - customCollectionTitle

- (IBAction)customCollectionTitle:(id)sender {
    
    CGFloat itemWidth = (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25;
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)]
    .makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6))
    .makeCollectionSheetCombined(YES)
    .makeCollectionSheetPagingEnabled(YES)
    .makeGestureDismissEnabled(YES, YES)
    .makeGestureIndicatorHidden(NO)
    .makeShowScaleAnimated(YES)
    .makeCollectionSheetSectionInset(UIEdgeInsetsZero)
    .makeCollectionSheetMinimumLineSpacing(0.0);
    
    alertView.makeCustomSuperView(self.testLabel);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) * 0.7, 100)];
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是自定义的view~~";
    
    alertView.makeCollectionSheetCustomTitleView(^{
        
        return label;
    });
    
    // 添加action
    [self addCollectionActionsWithAlertView:alertView];
    
    alertView.makeCollectionSheetAction([JKAlertAction actionWithTitle:@"收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]).makeCollectionSheetPageControlHidden(NO);
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customCollectionTitle" forState:(UIControlStateNormal)];
        });
    });
}

#pragma mark
#pragma mark - testShare

- (IBAction)testShare:(UIButton *)sender {
    
    CGFloat screenWidth = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    CGFloat itemWidth = screenWidth * 0.25;
    
    UIEdgeInsets sectionInset = UIEdgeInsetsMake(0, ((screenWidth - itemWidth * 2) / 4), 0, ((screenWidth - itemWidth * 2) / 4));
    
    [JKAlertView alertViewWithTitle:@"分享到" message:nil style:(JKAlertStyleCollectionSheet)]
    .makeCustomSuperView(self.testLabel)
    .makeGestureDismissEnabled(YES, YES)
    .makeGestureIndicatorHidden(NO)
    .makeShowScaleAnimated(YES)
    .makeTitleAlignment(NSTextAlignmentLeft)
    .makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6))
    .makeCollectionSheetMinimumLineSpacing((screenWidth - itemWidth * 2) / 2)
    .makeCollectionSheetSectionInset(sectionInset)
    .makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
        
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
        
    }].makeNormalImage([UIImage imageNamed:@"Share_WeChat"])).addAction([JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])).makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"testShare" forState:(UIControlStateNormal)];
        });
    });
}

#pragma mark
#pragma mark - customCollectionButton

- (IBAction)customCollectionButton:(id)sender {
    
    CGFloat itemWidth = (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25;
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)];
    
    alertView.makeCustomSuperView(self.testLabel);
    
    alertView.makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6))
    .makeCollectionSheetCombined(YES)
    .makeCollectionSheetPagingEnabled(YES)
    .makeCollectionSheetPageControlHidden(NO)
    .makeGestureDismissEnabled(YES, YES)
    .makeGestureIndicatorHidden(NO)
    .makeShowScaleAnimated(YES)
    .makeCollectionSheetSectionInset(UIEdgeInsetsZero)
    .makeCollectionSheetMinimumLineSpacing(0.0);
    
    // 添加action
    [self addCollectionActionsWithAlertView:alertView];
    
    alertView.makeCollectionSheetAction([JKAlertAction actionWithTitle:@"收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeCustomView(^(JKAlertAction *action) {
        
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
        
    })).makeCancelAction([JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeCustomView(^(JKAlertAction *action) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我也是自定义的view~~";
        
        return label;
    }));
    
    alertView.makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customCollectionButton" forState:(UIControlStateNormal)];
        });
    });
}

#pragma mark
#pragma mark - customCollectionActionView

- (IBAction)customActionSheetView:(id)sender {
    
    CGFloat screenWidth = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    CGFloat itemWidth = screenWidth * 0.25;
    
    [JKAlertView alertViewWithTitle:@"customCollectionActionView" message:nil style:(JKAlertStyleCollectionSheet)]
    .makeCustomSuperView(self.testLabel)
    .makeGestureDismissEnabled(YES, YES)
    .makeGestureIndicatorHidden(NO)
    .makeShowScaleAnimated(YES)
    .makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6))
    .makeCollectionSheetMinimumLineSpacing((screenWidth - itemWidth * 2) / 2)
    .makeCollectionSheetSectionInset(UIEdgeInsetsMake(0, ((screenWidth - itemWidth * 2) / 4), 0, ((screenWidth - itemWidth * 2) / 4)))
    .addAction([JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeCustomView(^(JKAlertAction *action) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是自定义的view~~1";
        
        return label;
        
    }).makeNormalImage([UIImage imageNamed:@"Share_WeChat"]))
    .addAction([JKAlertAction actionWithTitle:nil style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeCustomView(^(JKAlertAction *action) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我也是自定义的view~~2";
        
        return label;
        
    }).makeNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])).makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customCollectionActionView" forState:(UIControlStateNormal)];
        });
    });
}

#pragma mark
#pragma mark - Private Method

- (void)addCollectionActionsWithAlertView:(JKAlertView *)alertView {
    
    if (!alertView) { return; }
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_WeChat"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"微信收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_WeChat_Collection"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"QQ" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_QQ"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"微博" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_Sina"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"信息" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_Message"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"Email" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_Email"])];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"复制链接" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_Copylink"])];
    
    // 第2组
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微博" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_Sina"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"信息" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_Message"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"Email" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_Email"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"复制链接" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_Copylink"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_WeChat"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微信收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_WeChat_Collection"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"QQ" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeNormalImage([UIImage imageNamed:@"Share_QQ"])];
}
@end
