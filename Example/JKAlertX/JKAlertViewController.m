//
//  JKAlertCompareSystemViewController.m
//  JKAlertX
//
//  Created by albert on 2018/4/10.
//  Copyright © 2018年 Albert. All rights reserved.
//

#import "JKAlertViewController.h"
#import "JKAlertX.h"
#import "JKAlertTableModel.h"
#import "JKAlertTableGroupModel.h"
#import "JKAlertTransformLandscapeViewController.h"
#import "JKAlertCompareSystemViewController.h"
#import "JKAlertVerticalSlideToDismissView.h"

@interface JKAlertViewController ()

@end

@implementation JKAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)loadData {
    
    [self.dataArray removeAllObjects];
    
    __weak typeof(self) weakSelf = self;
    
    
    
    // alert/plain样式
    
    [self.dataArray addObject:[JKAlertTableGroupModel groupWithTitle:@"alert/plain样式" configuration:^(JKAlertTableGroupModel *group) {
        
        [JKAlertTableModel modelWithTitle:@"alert with basic style" group:group executeHandler:^(JKAlertTableModel *model) {
            
            JKAlertView.alertView(@"标题", @"内容内容\n内容内容内容\n内容内容内容内容", JKAlertStyleAlert)
            .makeCustomSuperView(weakSelf.customSuperView)
            .addAction(JKAlertAction.action(@"取消", JKAlertActionStyleCancel, ^(JKAlertAction *action) {
                
            }))
            .addAction(JKAlertAction.action(@"确定", JKAlertActionStyleDefaultBlue, ^(JKAlertAction *action) {
                
            }))
            .show();
        }];
        
        [JKAlertTableModel modelWithTitle:@"alert with custom animation" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf plain:model];
        }];
        
        [JKAlertTableModel modelWithTitle:@"alert with custom message" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf customPlainTitle:model];
        }];
        
        [JKAlertTableModel modelWithTitle:@"alert with textField" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf textField:model];
        }];
        
        [JKAlertTableModel modelWithTitle:@"alert with custom action" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf customPlainAction:model];
        }];
    }]];
    
    
    
    // HUD样式
    
    [self.dataArray addObject:[JKAlertTableGroupModel groupWithTitle:@"HUD样式" configuration:^(JKAlertTableGroupModel *group) {
        
        [JKAlertTableModel modelWithTitle:@"HUD with basic style" group:group executeHandler:^(JKAlertTableModel *model) {
            
            JKAlertView.showHUDWithTitle(@"你好你好你好", ^(JKAlertView *alertView) {
                alertView.makeCustomSuperView(weakSelf.customSuperView)
                .makeHudAllowUserInteractionEnabled(YES);
            });
        }];
        
        [JKAlertTableModel modelWithTitle:@"HUD with custom size" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf HUD:model];
        }];
        
        [JKAlertTableModel modelWithTitle:@"HUD with custom view" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf customHUD:model];
        }];
    }]];
    
    
    
    // action sheet样式
    
    [self.dataArray addObject:[JKAlertTableGroupModel groupWithTitle:@"action sheet样式" configuration:^(JKAlertTableGroupModel *group) {
        
        [JKAlertTableModel modelWithTitle:@"action sheet with basic style" group:group executeHandler:^(JKAlertTableModel *model) {
            
            JKAlertView.alertView(@"提示", @"你好你好你好", JKAlertStyleActionSheet)
            .makeCustomSuperView(weakSelf.customSuperView)
            .addAction(JKAlertAction.action(@"确定1", JKAlertActionStyleDefault, ^(JKAlertAction *action) {
                
            })).addAction(JKAlertAction.action(@"确定2", JKAlertActionStyleDefault, ^(JKAlertAction *action) {
                
            })).show();
        }];
        
        [JKAlertTableModel modelWithTitle:@"action sheet with pierced style" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf actionSheet:model];
        }];
        
        [JKAlertTableModel modelWithTitle:@"action sheet with custom action" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf customActionSheetView:model];
        }];
    }]];
    
    
    
    // collection sheet样式
    
    [self.dataArray addObject:[JKAlertTableGroupModel groupWithTitle:@"collection sheet样式" configuration:^(JKAlertTableGroupModel *group) {
        
        [JKAlertTableModel modelWithTitle:@"collection sheet with basic style" group:group executeHandler:^(JKAlertTableModel *model) {
            
            JKAlertView *alertView = JKAlertView.alertView(@"collectionSheet", nil, JKAlertStyleCollectionSheet);
            
            [weakSelf addCollectionActionsWithAlertView:alertView];

            CGFloat itemWidth = [self itemWidthWithLeftRightMargin:0];
            
            alertView.makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6))
            .makeCustomSuperView(weakSelf.customSuperView)
            .makeCollectionSheetMinimumLineSpacing(0.0)
            .makeCollectionSheetSectionInset(UIEdgeInsetsZero)
            /** 分页 */
            .makeCollectionSheetPagingEnabled(YES)
            /** 两个collectionView合并，同时滚动 */
            .makeCollectionSheetCombined(YES)
            /** 显示pageControl */
            .makeCollectionSheetPageControlHidden(NO).show();
        }];
        
        [JKAlertTableModel modelWithTitle:@"collection sheet with pierced style" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf collectionSheet:model];
        }];
        
        [JKAlertTableModel modelWithTitle:@"collection sheet with custom title" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf customCollectionTitle:model];
        }];
        
        [JKAlertTableModel modelWithTitle:@"collection sheet with share example" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf testShare:model];
        }];
        
        [JKAlertTableModel modelWithTitle:@"collection sheet with custom bottom" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf customCollectionButton:model];
        }];
        
        [JKAlertTableModel modelWithTitle:@"collection sheet with custom action" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf customCollectionActionView:model];
        }];
    }]];
    
    
    
    // 自定义
    
    [self.dataArray addObject:[JKAlertTableGroupModel groupWithTitle:@"自定义" configuration:^(JKAlertTableGroupModel *group) {
        
        [JKAlertTableModel modelWithTitle:@"custom alert" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf customAlert];
        }];
        
        [JKAlertTableModel modelWithTitle:@"custom action sheet" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf customSheet];
        }];
        
        [JKAlertTableModel modelWithTitle:@"custom action sheet slide to dismiss" group:group executeHandler:^(JKAlertTableModel *model) {
            
            [weakSelf customSheetSlideToDismiss];
        }];
    }]];
    
    
    
    // 其它
    
    if ([self isMemberOfClass:[JKAlertViewController class]]) {
        
        [self.dataArray addObject:[JKAlertTableGroupModel groupWithTitle:@"其它" configuration:^(JKAlertTableGroupModel *group) {
            
            [JKAlertTableModel modelWithTitle:@"transform旋转横屏" group:group executeHandler:^(JKAlertTableModel *model) {
                
                JKAlertTransformLandscapeViewController *vc = [JKAlertTransformLandscapeViewController new];
                
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }];
            
            [JKAlertTableModel modelWithTitle:@"与系统弹框比较" group:group executeHandler:^(JKAlertTableModel *model) {
                
                JKAlertCompareSystemViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass([JKAlertCompareSystemViewController class])];
                
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }];
        }]];
    }
    
    [self.tableView reloadData];
}

#pragma mark
#pragma mark - Plain

- (void)plain:(JKAlertTableModel *)sender {
    
    JKAlertView.show(@"定位服务未开启", @"请进入系统「设置」-「隐私」-「定位服务」中打开开关，并允许APP使用定位服务", JKAlertStyleAlert, ^(JKAlertView *alertView) {
        
        alertView.makeCustomSuperView(self.customSuperView);
        
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
        alertView.makeCustomShowAnimationHandler(^(JKAlertView *innerAlertView, UIView *animationView) {
            
            animationView.transform = CGAffineTransformMakeScale(0.3, 0.3);
            
            [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:15.0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations:^{
                
                animationView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                
            } completion:^(BOOL finished) {
                
                innerAlertView.showAnimationDidComplete();
            }];
        });
        
        // 自定义消失动画
        alertView.makeCustomDismissAnimationHandler(^(JKAlertView *innerAlertView, UIView *animationView) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                animationView.frame = CGRectMake(animationView.frame.origin.x, [UIScreen mainScreen].bounds.size.height, animationView.frame.size.width, animationView.frame.size.height);
                
            } completion:^(BOOL finished) {
                
                innerAlertView.dismissAnimationDidComplete();
            }];
        });
        
        // 显示动画完毕后，向上偏移150
        alertView.makeDidShowHandler(^(JKAlertView *view) {
            
            //view.movePlainCenterOffsetY(-150, YES);
        });
        
        alertView.makeDeallocLogEnabled(YES).show();
    });
}

#pragma mark
#pragma mark - customPlainTitle

- (void)customPlainTitle:(JKAlertTableModel *)sender {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) * 0.7, 190)];
    //label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是自定义的view~~";
    label.attributedText = [[NSAttributedString alloc] initWithString:@"我是自定义的view~~" attributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好你好" style:(JKAlertStyleAlert)];
    
    alertView.makeCustomSuperView(self.customSuperView);
    
    // 显示title和message之间的分隔线
    alertView.makeTitleMessageSeparatorLineHidden(NO);
    
    // 设置YES表示仅自定义message
    alertView.makeCustomMessageView(^UIView *(JKAlertView *innerAlertView) {
        
        return label;
    });
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefaultBlue) handler:^(JKAlertAction *action) {
        
    }]];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefaultBlue) handler:^(JKAlertAction *action) {
        
    }]];
    
    alertView.makeDeallocLogEnabled(YES).show();
}

#pragma mark
#pragma mark - HUD

- (void)HUD:(JKAlertTableModel *)sender {
    
    JKAlertView.showHUDWithTitle(@"你好你好你好你好", ^(JKAlertView *alertView) {
        
        alertView.makeCustomSuperView(self.customSuperView);
        
        alertView.makeHudAllowUserInteractionEnabled(YES)
        .makeHudHeight(60)
        .makeHudWidth(200)
        .makeHudCenterOffset(CGPointMake(0, 100))
        .makeHudDismissTimeInterval(1)
        .makeDeallocLogEnabled(YES);
    });
    
    /* or use like following
     [JKAlertView alertViewWithTitle:@"你好你好你好你好" message:nil style:(JKAlertStyleHUD)]
     .makeHudHeight(60)
     .makeHudWidth(200)
     .makeHudCenterOffset(CGPointMake(0, 100))
     .makeHudDismissTimeInterval(1)
     .makeDeallocLogEnabled(YES)
     .show(); //*/
}

#pragma mark
#pragma mark - customHUD

- (void)customHUD:(JKAlertTableModel *)sender {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是自定义的view~~";
    
    JKAlertView.showCustomHUD(^UIView *{
        
        return label;
        
    }, ^(JKAlertView *alertView) {
        
        alertView.makeCustomSuperView(self.customSuperView);
        
        alertView.makeHudAllowUserInteractionEnabled(YES)
        .makeHudDismissTimeInterval(2)
        .makeDeallocLogEnabled(YES);
    });
}

#pragma mark
#pragma mark - textField

- (void)textField:(JKAlertTableModel *)sender {
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"请输入帐号密码" style:(JKAlertStyleAlert)];
    
    alertView.makeCustomSuperView(self.customSuperView);
    
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
    
    alertView.makeDeallocLogEnabled(YES).show();
}

#pragma mark
#pragma mark - customPlainAction

- (void)customPlainAction:(JKAlertTableModel *)sender {
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好你好" style:(JKAlertStyleAlert)];
    
    alertView.makeCustomSuperView(self.customSuperView);
    
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
    
    alertView.makeDeallocLogEnabled(YES).show();
}

#pragma mark
#pragma mark - actionSheet

- (void)actionSheet:(JKAlertTableModel *)sender {
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好" style:(JKAlertStyleActionSheet)]
    .makeVerticalGestureDismissEnabled(YES)
    .makeHorizontalGestureDismissDirection(JKAlertSheetHorizontalGestureDismissDirectionHorizontal)
    .makeGestureIndicatorHidden(NO)
    .makeShowScaleAnimated(YES);
    
    alertView.makeCustomSuperView(self.customSuperView);
    
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
    
    alertView.makeDeallocLogEnabled(YES).show();
}

#pragma mark
#pragma mark - customActionSheetView

- (void)customActionSheetView:(JKAlertTableModel *)sender {
    
    [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好" style:(JKAlertStyleActionSheet)]
    .makeCustomSuperView(self.customSuperView)
    .makeHomeIndicatorFilled(YES)
    .makeVerticalGestureDismissEnabled(YES)
    .makeHorizontalGestureDismissDirection(JKAlertSheetHorizontalGestureDismissDirectionHorizontal)
    .makeGestureIndicatorHidden(NO)
    .makeShowScaleAnimated(YES)
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
        
    }]).makeDeallocLogEnabled(YES).makeActionSheetBottomButtonPinned(NO).show();
}

#pragma mark
#pragma mark - collectionSheet

- (void)collectionSheet:(JKAlertTableModel *)sender {
    
    CGFloat itemWidth = [self itemWidthWithLeftRightMargin:15];
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)];
    
    alertView.makeCustomSuperView(self.customSuperView);
    
    /** 允许手势滑动退出 */
    alertView.makeVerticalGestureDismissEnabled(YES)
    .makeHorizontalGestureDismissDirection(JKAlertSheetHorizontalGestureDismissDirectionHorizontal)
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
    
    alertView.makeDeallocLogEnabled(YES).show();
}

#pragma mark
#pragma mark - customCollectionTitle

- (void)customCollectionTitle:(JKAlertTableModel *)sender {
    
    CGFloat itemWidth = [self itemWidthWithLeftRightMargin:0];
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)]
    .makeCustomSuperView(self.customSuperView)
    .makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6))
    .makeCollectionSheetCombined(YES)
    .makeCollectionSheetPagingEnabled(YES)
    .makeVerticalGestureDismissEnabled(YES)
    .makeHorizontalGestureDismissDirection(JKAlertSheetHorizontalGestureDismissDirectionHorizontal)
    .makeGestureIndicatorHidden(NO)
    .makeShowScaleAnimated(YES)
    .makeCollectionSheetSectionInset(UIEdgeInsetsZero)
    .makeCollectionSheetMinimumLineSpacing(0.0);
    
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
    
    alertView.makeDeallocLogEnabled(YES).show();
}

#pragma mark
#pragma mark - testShare

- (void)testShare:(JKAlertTableModel *)sender {
    
    CGFloat itemWidth = [self itemWidthWithLeftRightMargin:0];
    
    CGFloat screenWidth = [self calculateCollectionScreenWidth];
    
    UIEdgeInsets sectionInset = UIEdgeInsetsMake(0, ((screenWidth - itemWidth * 2) / 4), 0, ((screenWidth - itemWidth * 2) / 4));
    
    [JKAlertView alertViewWithTitle:@"分享到" message:nil style:(JKAlertStyleCollectionSheet)]
    .makeCustomSuperView(self.customSuperView)
    .makeVerticalGestureDismissEnabled(YES)
    .makeHorizontalGestureDismissDirection(JKAlertSheetHorizontalGestureDismissDirectionHorizontal)
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
        
    }].makeNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])).makeDeallocLogEnabled(YES).show();
}

#pragma mark
#pragma mark - customCollectionButton

- (void)customCollectionButton:(JKAlertTableModel *)sender {
    
    CGFloat itemWidth = [self itemWidthWithLeftRightMargin:0];
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)];
    
    alertView.makeCustomSuperView(self.customSuperView);
    
    alertView.makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6))
    .makeCollectionSheetCombined(YES)
    .makeCollectionSheetPagingEnabled(YES)
    .makeCollectionSheetPageControlHidden(NO)
    .makeVerticalGestureDismissEnabled(YES)
    .makeHorizontalGestureDismissDirection(JKAlertSheetHorizontalGestureDismissDirectionHorizontal)
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
    
    alertView.makeDeallocLogEnabled(YES).show();
}

#pragma mark
#pragma mark - 自定义

- (void)customAlert {
    
    [JKAlertCustomizer showCustomAlertWithViewHandler:^UIView *(JKAlertView *innerAlertView) {
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.0, 250.0)];
        customView.backgroundColor = [UIColor orangeColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 290.0, 200.0)];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是自定义的alert~";
        //label.backgroundColor = [UIColor orangeColor];
        [customView addSubview:label];
        
        UIButton *verifyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        verifyButton.backgroundColor = [UIColor blackColor];
        verifyButton.frame = CGRectMake(0.0, 200.0, 290.0, 50.0);
        verifyButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [verifyButton setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        [verifyButton setTitleColor:[[UIColor orangeColor] colorWithAlphaComponent:0.5] forState:(UIControlStateHighlighted)];
        [verifyButton setTitle:@"确定" forState:(UIControlStateNormal)];
        [customView addSubview:verifyButton];
        
        __weak typeof(innerAlertView) weakAlertView = innerAlertView;
        
        [verifyButton JKAlertX_addClickOperation:^(id control) {
            
            [weakAlertView dismiss];
        }];
        
        return customView;
        
    } configurationBeforeShow:^(JKAlertView *innerAlertView) {
        
        innerAlertView.makeCustomSuperView(self.customSuperView);
    }];
}

- (void)customSheet {
    
    [JKAlertCustomizer showCustomSheetWithViewHandler:^UIView *(JKAlertView *innerAlertView) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.0, 300.0 + JKAlertUtility.currentHomeIndicatorHeight)];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = @"我是自定义的sheet~";
        
        label.backgroundColor = [UIColor orangeColor];
        
        return label;
        
    } configurationBeforeShow:^(JKAlertView *innerAlertView) {
        
        innerAlertView.makeCustomSuperView(self.customSuperView);
    }];
}

- (void)customSheetSlideToDismiss {
    
    JKAlertVerticalSlideToDismissView *customView = [[JKAlertVerticalSlideToDismissView alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.0, 300.0)];
    
    [JKAlertCustomizer showCustomSheetWithViewHandler:^UIView *(JKAlertView *innerAlertView) {
        
        return customView;
        
    } clearAlertBackgroundColor:NO clearFullBackgroundColor:NO configurationBeforeShow:^(JKAlertView *innerAlertView) {
        
        innerAlertView.makeCustomSuperView(self.customSuperView)
        .makeAlertBackgroundColor([UIColor orangeColor])
        .makeShowScaleAnimated(YES)
        .makeGestureIndicatorHidden(NO)
        .makeVerticalGestureDismissEnabled(YES)
        .makeActionSheetCustomVerticalSlideToDismiss(customView);
    }];
}

#pragma mark
#pragma mark - customCollectionActionView

- (void)customCollectionActionView:(JKAlertTableModel *)sender {
    
    CGFloat itemWidth = [self itemWidthWithLeftRightMargin:0];
    
    CGFloat screenWidth = [self calculateCollectionScreenWidth];
    
    [JKAlertView alertViewWithTitle:@"customCollectionActionView" message:nil style:(JKAlertStyleCollectionSheet)]
    .makeCustomSuperView(self.customSuperView)
    .makeVerticalGestureDismissEnabled(YES)
    .makeHorizontalGestureDismissDirection(JKAlertSheetHorizontalGestureDismissDirectionHorizontal)
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
        
    }).makeNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])).makeDeallocLogEnabled(YES).show();
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

#pragma mark
#pragma mark - Property

- (UIView *)customSuperView {
    
    return nil;
}

- (CGFloat)calculateCollectionScreenWidth {
    
    CGFloat minWidth = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    minWidth = MIN(minWidth, JKAlertUtility.iPhoneMaxScreenWidth);
    
    return minWidth;
}

- (CGFloat)itemWidthWithLeftRightMargin:(CGFloat)margin {
    
    CGFloat minWidth = [self calculateCollectionScreenWidth];
    
    CGFloat itemWidth = (minWidth - margin * 2.0) * 0.25;
    
    return itemWidth;
}
@end
