//
//  JKShareManager.m
//  JKShare
//
//  Created by albert on 16/8/27.
//  Copyright © 2016年 albert. All rights reserved.
//

#import "JKShareManager.h"
#import "JKAlertX.h"
//#import "WXApi.h"
//#import "WechatAuthSDK.h"
//#import <TencentOpenAPI/TencentApiInterface.h>
//#import <TencentOpenAPI/TencentMessageObject.h>
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//#import "WeiboSDK.h"
//#import "SVProgressHUD.h"

@interface JKShareManager ()
/** 分享到微信实例化对象 */
//@property (nonatomic, strong) SendMessageToWXReq *sendToWXReq;
@end

@implementation JKShareManager

/** 显示分享面板 */
+ (void)showShareViewWithUrl:(NSString *)url title:(NSString *)title description:(NSString *)description imageUrl:(NSString *)imageUrl{
    
//    if (![WXApi isWXAppInstalled] || ![WXApi isWXAppSupportApi]) {
//
//        return;
//    }

    CGFloat itemWidth = (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)) * 0.25;
    
    [JKAlertView alertViewWithTitle:@"分享到" message:nil style:(JKAlertStyleCollectionSheet)].makeTitleAlignment(NSTextAlignmentLeft).makeCollectionSheetItemSize(CGSizeMake(itemWidth, itemWidth - 6)).makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
        
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
        
        [JKShareManager shareUrl:url text:title description:description imageUrl:imageUrl shareType:(JKShareTypeWechatSession)];
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat"])).addAction([JKAlertAction actionWithTitle:@"朋友圈" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        [JKShareManager shareUrl:url text:title description:description imageUrl:imageUrl shareType:(JKShareTypeWechatTimeline)];
        
    }].setNormalImage([UIImage imageNamed:@"Share_WeChat_Moments"])).makeDeallocLogEnabled(YES).show().makeDidDismissHandler(^{
        
        
    });
}

+ (void)shareUrl:(NSString *)url text:(NSString *)text description:(NSString *)description imageUrl:(NSString *)imageUrl shareType:(JKShareType)shareType{
    
    switch (shareType) {/*
        case JKShareTypeWechatSession:  // 发送给朋友
            [[[self alloc] init] shareToWeiChat:url text:text description:description image:imageUrl shareType:WXSceneSession];
            break;
            
        case JKShareTypeWechatTimeline: // 发送到朋友圈
            [[[self alloc] init] shareToWeiChat:url text:text description:description image:imageUrl shareType:WXSceneTimeline];
            break;
        case JKShareTypeWechatFavorite: // 发送到微信收藏
            [[[self alloc] init] shareToWeiChat:url text:text description:description image:imageUrl shareType:WXSceneFavorite];
            break;
        case JKShareTypeTypeSina:       // 发送到新浪微博
            [[[self alloc] init] shareToSina:url text:text description:description image:imageUrl];
            break;
        case JKShareTypeMobileQQ:       // 发送到QQ
            [[[self alloc] init] shareToQzone:url text:text description:description image:imageUrl];
            break;
        case JKShareTypeQzone:          // 发送到QQ空间
            [[[self alloc] init] shareToQQ:url text:text description:description image:imageUrl];
            break; */
            
        default:
            break;
    }
}

/*
- (void)shareToWeiChat:(NSString *)url text:(NSString *)text description:(NSString *)description image:(NSString *)imageUrl shareType:(int)type {
    
    // 未安装或api不支持
    if (![WXApi isWXAppInstalled] || ![WXApi isWXAppSupportApi]) {
        
        return;
    }
        
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = text;
    message.description = description;
    message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    
    if (imageUrl) {
        
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        
        if (imgData.length < 32 * 1024) {
            
            [message setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]]];
        }
    }
    
    WXWebpageObject *webpage = [WXWebpageObject object];
    webpage.webpageUrl = url;
    message.mediaObject = webpage;
    
    self.sendToWXReq = nil;
    self.sendToWXReq = [[SendMessageToWXReq alloc] init];
    self.sendToWXReq.bText = NO;
    self.sendToWXReq.message = message;
    
    self.sendToWXReq.scene = type;
    
    [WXApi sendReq:self.sendToWXReq];
}

- (void)shareToSina:(NSString *)url text:(NSString *)text description:(NSString *)description image:(NSString *)imageUrl {
//    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:JKWeiboAppKey];
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"http://weibo.com/1849434443/profile?topnav=1&wvr=6";
    request.scope = @"all";
    
    WBMessageObject *message = [WBMessageObject message];
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifier1";
    webpage.title = NSLocalizedString(text, nil);
    webpage.description = description;
    
    if (imageUrl) {
        
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        
        if (imgData.length < 32 * 1024) {
            
            webpage.thumbnailData = imgData;
        }
    }
    
    webpage.webpageUrl = url;
    message.mediaObject = webpage;
    
    WBSendMessageToWeiboRequest *sendMessagerequest = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:request access_token:nil];
    sendMessagerequest.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                                    @"Other_Info_1": [NSNumber numberWithInt:123],
                                    @"Other_Info_2": @[@"obj1", @"obj2"],
                                    @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    
    [WeiboSDK sendRequest:sendMessagerequest];
}

- (void)shareToQQ:(NSString *)url text:(NSString *)text description:(NSString *)description image:(NSString *)imageUrl {
    [[TencentOAuth alloc] initWithAppId:kQqAppId andDelegate:(id<TencentSessionDelegate>)self];
    
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL :[NSURL URLWithString:url]
                                title: text
                                description :description
                                previewImageURL:[NSURL URLWithString:imageUrl]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    //将内容分享到qq
    //QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    //将内容分享到qzone
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    
    [self handleSendResult:sent];
    
}

- (void)shareToQzone:(NSString *)url text:(NSString *)text description:(NSString *)description image:(NSString *)imageUrl {
    
    [[TencentOAuth alloc] initWithAppId:kQqAppId andDelegate:(id<TencentSessionDelegate>)self];
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL :[NSURL URLWithString:url]
                                title: text
                                description :description
                                previewImageData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    //将内容分享到qq
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    //将内容分享到qzone
    //    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    
    [self handleSendResult:sent];
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            //            [msgbox release];
            
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            //            [msgbox release];
            
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            //            [msgbox release];
            
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            //            [msgbox release];
            
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            //            [msgbox release];
            
            break;
        }
        default:
        {
            break;
        }
    }
} */
@end
