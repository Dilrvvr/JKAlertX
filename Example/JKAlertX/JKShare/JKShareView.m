//
//  JKShareView.m
//  JKShare
//
//  Created by albert on 16/8/26.
//  Copyright © 2016年 albert. All rights reserved.
//

#import "JKShareView.h"
//#import "SVProgressHUD.h"
//#import "JKTopWindowViewController.h"
#import "JKShareManager.h"
//#import "NewsDetailModel.h"
#import <MessageUI/MessageUI.h>
//#import "SQLiteManager.h"
//#import "JKPostModel.h"

@interface JKShareView () <UIScrollViewDelegate, MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *shareContainerView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelTopCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shareContainerBottomCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shareViewHCons;

/** 分享的url */
@property (nonatomic, copy) NSString *shareUrl;

/** 分享的url */
@property (nonatomic, copy) NSString *shareTitle;

/** 详情模型数据 */
//@property (nonatomic, strong) JKPostModel *model;

/** 当前状态栏样式 */
@property (nonatomic, assign) UIStatusBarStyle currentStatusBarStyle;
@end

@implementation JKShareView

#pragma mark - 外部调用
/** 显示分享界面 */
+ (void)showWithShareUrl:(NSString *)url title:(NSString *)title{
    
    JKShareView *shareV = [[JKShareView alloc] init];
    shareV.shareUrl = url;
    shareV.shareTitle = title;
    shareV.frame = [UIScreen mainScreen].bounds;
    shareV.cancelTopCons.constant = -38;
    shareV.shareContainerBottomCons.constant = -53;
    shareV.collectionBtn.hidden = YES;
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:shareV];
}

/** 详情页 显示分享界面 */
//+ (void)showWithModel:(JKPostModel *)model{
//
//    JKShareView *shareV = [[JKShareView alloc] init];
//    shareV.model = model;
//    shareV.frame = [UIScreen mainScreen].bounds;
//    shareV.cancelTopCons.constant = -38;
//    shareV.shareContainerBottomCons.constant = -53;
//    shareV.collectionBtn.hidden = YES;
//    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:shareV];
//}

#pragma mark - 初始化
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    self.scrollView.delegate = self;
    
    [self.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    
//    self.shareContainerView.y = JKScreenH;
    
//    self.shareViewHCons.constant = 350 + (JKIsIphoneX ? 34 : 0);
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    if (!self.superview) {
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 0.5;
//        self.shareContainerView.y = JKScreenH - self.shareViewHCons.constant;
    }];
}

- (IBAction)copyUrlClick:(id)sender {
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = self.shareUrl;
//    [JKProgressHUD showSuccessWithStatus:@"复制成功！"];
}

- (IBAction)shareToWXSession:(id)sender {
    [self shareWithType:JKShareTypeWechatSession];
}

- (IBAction)shareToWXTimeline:(id)sender {
    [self shareWithType:JKShareTypeWechatTimeline];
}

- (IBAction)shareToWeibo:(id)sender {
    [self shareWithType:(JKShareTypeTypeSina)];
}

- (IBAction)WXCollection:(id)sender {
    [self shareWithType:JKShareTypeWechatFavorite];
}

- (IBAction)shareToMessage:(id)sender {
    // 判断能否发送短信
    if (![MFMessageComposeViewController canSendText]) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"当前无法发送短信！" preferredStyle:UIAlertControllerStyleAlert];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVc animated:YES completion:nil];
        return;
    }
    
    // 要想设置短信内容，我们使用MessageUI
    // 创建
    MFMessageComposeViewController *msgVc = [[MFMessageComposeViewController alloc] init];
    
    // 设置电话
    //msgVc.recipients = @[@"10086",@"10010"];
    
    // 设置内容
    msgVc.body = [NSString stringWithFormat:@"【%@】（分享自Baisi-ayb）%@", self.shareTitle, self.shareUrl];
    
    // 设置代理 点击取消或发送之后返回页面
    // 使用这个代理 messageComposeDelegate
    msgVc.messageComposeDelegate = self;
    
    // 显示短信界面
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:msgVc animated:YES completion:^{
        self.currentStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
        //[[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault)];
    }];
}

- (void)shareWithType:(JKShareType)type{
    [self dismiss];
    
//    if (self.model == nil) {
//        [ShareManager shareUrl:self.shareUrl text:self.shareTitle description:nil image:nil shareTyep:(type)];
        return;
//    }
    
//    [ShareManager shareUrl:self.shareUrl text:self.model.text description:[NSString stringWithFormat:@"分享来自@%@", self.model.name] image:self.model.small_image shareTyep:(type)];
}

- (IBAction)collectionClick:(id)sender {
    [self dismiss];
    
//    if ([SQLiteManager queryIsCollectedWithStoryID:self.model.ID]) {
//        [JKProgressHUD showErrorWithStatus:@"您已收藏该文章！"];
//        return;
//    }
//
//    if ([SQLiteManager updateCollectedStatusWithStoryID:self.model.ID collected:YES]) {
//        [JKProgressHUD showSuccessWithStatus:@"收藏成功！"];
//        return;
//    }
//
//    [JKProgressHUD showErrorWithStatus:@"收藏失败！"];
}

// 取消
- (IBAction)dismiss{
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 0;
//        self.shareContainerView.y = JKScreenH;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//- (void)setModel:(JKPostModel *)model{
//    _model = model;
//
//    if (_model.weixin_url) {
//
//        self.shareUrl = [_model.weixin_url containsString:@"?"] ? [_model.weixin_url componentsSeparatedByString:@"?"].firstObject : _model.weixin_url;
//    }
//
//    self.shareTitle = _model.text;
//}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    self.pageControl.currentPage = (scrollView.contentOffset.x >= JKScreenW) ? 1 : 0;
}

#pragma mark - <MFMessageComposeViewControllerDelegate>
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    //MessageComposeResultCancelled,
    //MessageComposeResultSent,
    //MessageComposeResultFailed
    if (result == MessageComposeResultCancelled || result == MessageComposeResultSent) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }
    
    //[[UIApplication sharedApplication] setStatusBarStyle:(self.currentStatusBarStyle)];
    
    [self dismiss];
}

/*
#pragma mark - 更新皮肤
- (void)updateSkin{
    NSString *currentSkinModel = [[NSUserDefaults standardUserDefaults] objectForKey:JKCurrentSkinModelKey];
    
    if ([currentSkinModel isEqualToString:JKNightSkinModelValue]) { // 夜间模式
        self.shareContainerView.backgroundColor = JKNightSkinColor;
        self.titleLabel.textColor = JKColor(218, 218, 218);
        [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"bg_normal_night"] forState:(UIControlStateNormal)];
        [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"bg_normal_night"] forState:(UIControlStateNormal)];
        [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"bg_highlighted_night"] forState:(UIControlStateHighlighted)];
        [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"bg_highlighted_night"] forState:(UIControlStateHighlighted)];
        
        self.pageControl.pageIndicatorTintColor = JKColor(88, 88, 88);
        self.pageControl.currentPageIndicatorTintColor = JKColor(218, 218, 218);
        
    } else { // 日间模式
        self.shareContainerView.backgroundColor = JKColor(237, 237, 237);
        self.titleLabel.textColor = [UIColor blackColor];
        [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"bg_normal_day"] forState:(UIControlStateNormal)];
        [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"bg_normal_day"] forState:(UIControlStateNormal)];
        [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"bg_highlighted_day"] forState:(UIControlStateHighlighted)];
        [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"bg_highlighted_day"] forState:(UIControlStateHighlighted)];
        
        self.pageControl.currentPageIndicatorTintColor = JKColor(88, 88, 88);
        self.pageControl.pageIndicatorTintColor = JKColor(218, 218, 218);
    }
} */

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
