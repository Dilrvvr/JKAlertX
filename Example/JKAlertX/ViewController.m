//
//  ViewController.m
//  JKAlert
//
//  Created by albert on 2018/4/3.
//  Copyright © 2018年 安永博. All rights reserved.
//

#import "ViewController.h"
#import "JKAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)customCollectionActionView:(id)sender {
    
    [JKAlertView alertViewWithTitle:@"customCollectionActionView" message:nil style:(JKAlertStyleCollectionSheet)].setTitleTextViewAlignment(NSTextAlignmentCenter).setFlowlayoutItemWidth((MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25).addAction([JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^{
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是自定义的view~~";
        
        return label;
        
    }).setNormalImage([UIImage imageNamed:@"Share_WeChat"])).addAction([JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^{
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我也是自定义的view~~";
        
        return label;
        
    }).setNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])).enableDeallocLog(YES).show().setDismissComplete(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customCollectionActionView" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)customPlainAction:(id)sender {
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好你好" style:(JKAlertStylePlain)];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^{
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是自定义的view~~";
        
        return label;
    })];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    alertView.enableDeallocLog(YES).show().setDismissComplete(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customPlainAction" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)plain:(UIButton *)sender {
    
    //    __weak typeof(self) weakSelf = self;
    
    //    JKAlertView *alertView = [JKAlertView alertViewWithTitle:nil message:nil Style:(JKAlertStylePlain)];
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.alignment = NSTextAlignmentCenter;
    
    //    JKAlertView *alertView = [JKAlertView alertViewWithAttributedTitle:[[NSAttributedString alloc] initWithString:@"你好你好" attributes:@{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSParagraphStyleAttributeName : para}] attributedMessage:[[NSAttributedString alloc] initWithString:@"你好你好你好你好你好你好" attributes:@{NSForegroundColorAttributeName : [UIColor cyanColor], NSFontAttributeName : [UIFont systemFontOfSize:15], NSParagraphStyleAttributeName : para}] style:(JKAlertStylePlain)];
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好你好你好" style:(JKAlertStylePlain)];
    
//    JKAlertView *alertView = [JKAlertView alertViewWithAttributedTitle:nil attributedMessage:[[NSAttributedString alloc] initWithString:@"你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好" attributes:@{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSParagraphStyleAttributeName : para}] style:(JKAlertStylePlain)];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    alertView.enableDeallocLog(YES).show().setDismissComplete(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"plain" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)actionSheet:(id)sender {
    
    //    JKAlertView *alertView = [JKAlertView alertViewWithTitle:nil message:nil Style:(JKAlertStyleActionSheet)];
    
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
        para.alignment = NSTextAlignmentCenter;
    
        JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好" style:(JKAlertStyleActionSheet)];
    
//    JKAlertView *alertView = [JKAlertView alertViewWithAttributedTitle:nil attributedMessage:[[NSAttributedString alloc] initWithString:@"你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好" attributes:@{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSParagraphStyleAttributeName : para}] style:(JKAlertStyleActionSheet)];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
//    alertView.setCancelAction([JKAlertAction actionWithTitle:@"cancel" style:(JKAlertActionStyleDestructive) handler:nil]);
    
    alertView.enableDeallocLog(YES).show().setDismissComplete(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"actionSheet" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)collectionSheet:(id)sender {
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.alignment = NSTextAlignmentCenter;
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)].setFlowlayoutItemWidth((MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25).setCompoundCollection(YES).setCollectionPagingEnabled(YES).setBottomButtonMargin(10);
    
    // 第1组
    alertView.setCollectionAction([JKAlertAction actionWithTitle:@"收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]).setShowPageControl(YES);
    
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
//    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
//
//    }].setNormalImage([UIImage imageNamed:@"Share_WeChat"])];
//
//    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
//
//    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])];
//
//    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微信收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
//
//    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Collection"])];
//
//    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"QQ" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
//
//    }].setNormalImage([UIImage imageNamed:@"Share_QQ"])];

    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微博" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {

    }].setNormalImage([UIImage imageNamed:@"Share_Sina"])];

    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"信息" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {

    }].setNormalImage([UIImage imageNamed:@"Share_Message"])];

    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"Email" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {

    }].setNormalImage([UIImage imageNamed:@"Share_Email"])];

    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"复制链接" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {

    }].setNormalImage([UIImage imageNamed:@"Share_Copylink"])];
    
    alertView.enableDeallocLog(YES).show().setDismissComplete(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"collectionSheet" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)testShare:(UIButton *)sender {
    
    [JKAlertView alertViewWithTitle:@"分享到" message:nil style:(JKAlertStyleCollectionSheet)].setTitleTextViewAlignment(NSTextAlignmentLeft).setTextViewLeftRightMargin(4).setFlowlayoutItemWidth((MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25).addAction([JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat"])).addAction([JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])).enableDeallocLog(YES).show().setDismissComplete(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"testShare" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)customActionSheetView:(id)sender {
    
    [JKAlertView alertViewWithTitle:@"提示" message:@"这是action样式的customView，想自定义titleView的话可以将title和message赋值nil，并将第一个action设为空action，然后给这个空action赋值customView即可" style:(JKAlertStyleActionSheet)].addAction([JKAlertAction actionWithTitle:nil style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^{
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是自定义的view~~";
        
        return label;
        
    })).addAction([JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]).enableDeallocLog(YES).show().setDismissComplete(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customActionSheetView" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)HUD:(id)sender {
    
    JKAlertView.showHUDWithTitle(@"你好你好你好你好").setDismissTimeInterval(2).enableDeallocLog(YES).setDismissComplete(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"HUD" forState:(UIControlStateNormal)];
        });
    });
    
    /* or use like following
    [JKAlertView alertViewWithTitle:@"你好你好你好你好" message:nil style:(JKAlertStyleHUD)].setDismissTimeInterval(2).enableDeallocLog(YES).show().setDismissComplete(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"HUD" forState:(UIControlStateNormal)];
        });
    }); */
}

- (IBAction)customHUD:(id)sender{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) * 0.7, 200)];
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是自定义的view~~";
    
    JKAlertView.showCustomHUD(^{
        
        return label;
        
    }).setDismissTimeInterval(2).enableDeallocLog(YES).setDismissComplete(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customHUD" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)customCollectionTitle:(id)sender {
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.alignment = NSTextAlignmentCenter;
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)].setFlowlayoutItemWidth((MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25).setCompoundCollection(YES).setCollectionPagingEnabled(YES);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) * 0.7, 100)];
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是自定义的view~~";
    
    alertView.addCustomCollectionTitleView(^{
        
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
    
    alertView.enableDeallocLog(YES).show().setDismissComplete(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customCollectionTitle" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)customPlainTitle:(id)sender {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) * 0.7, 200)];
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我是自定义的view~~";
    label.attributedText = [[NSAttributedString alloc] initWithString:@"我是自定义的view~~" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"提示" message:@"你好你好你好你好你好你好你好" style:(JKAlertStylePlain)];
    
    alertView.addCustomPlainTitleView(^{
        
        return label;
    });
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    [alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }]];
    
    alertView.enableDeallocLog(YES).show().setDismissComplete(^{
        
        [sender setTitle:@"dismissed" forState:(UIControlStateNormal)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sender setTitle:@"customPlainTitle" forState:(UIControlStateNormal)];
        });
    });
}

- (IBAction)customCollectionButton:(id)sender {
    
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.alignment = NSTextAlignmentCenter;
    
    JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"collectionSheet" message:nil style:(JKAlertStyleCollectionSheet)].setFlowlayoutItemWidth((MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25).setCompoundCollection(YES).setCollectionPagingEnabled(YES);
    
    // 第1组
    alertView.setCollectionAction([JKAlertAction actionWithTitle:@"收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^{
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        label.backgroundColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是自定义的view~~";
        
        return label;
        
    })).setShowPageControl(YES).setCancelAction([JKAlertAction actionWithTitle:@"取消" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setCustomView(^{
        
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
    //    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微信好友" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
    //
    //    }].setNormalImage([UIImage imageNamed:@"Share_WeChat"])];
    //
    //    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
    //
    //    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])];
    //
    //    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微信收藏" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
    //
    //    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Collection"])];
    //
    //    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"QQ" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
    //
    //    }].setNormalImage([UIImage imageNamed:@"Share_QQ"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"微博" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Sina"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"信息" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Message"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"Email" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Email"])];
    
    [alertView addSecondCollectionAction:[JKAlertAction actionWithTitle:@"复制链接" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].setNormalImage([UIImage imageNamed:@"Share_Copylink"])];
    
    alertView.enableDeallocLog(YES).show().setDismissComplete(^{
        
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


@end
