//
//  JKShareManager.h
//  JKShare
//
//  Created by albert on 16/8/27.
//  Copyright © 2016年 albert. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    JKShareTypeWechatSession = 0,   // 微信朋友
    JKShareTypeWechatTimeline = 1,  // 微信朋友圈
    JKShareTypeWechatFavorite = 2,  // 微信收藏
    JKShareTypeMobileQQ = 3,        // QQ
    JKShareTypeQzone = 4,           // QQ空间
    JKShareTypeTypeSina = 5,        // 新浪微博
} JKShareType;

@interface JKShareManager : NSObject

/** 显示分享面板 */
+ (void)showShareViewWithUrl:(NSString *)url title:(NSString *)title description:(NSString *)description imageUrl:(NSString *)imageUrl;

/**
 *  通过第三方分享内容
 *
 *  url:         分享的链接
 *  text:        分享的标题
 *  description: 分享的详情描述
 *  imageUrl:    分享中图片的url （微博分享中，这个url的图片大小不能超过32k）
 *  shareType:        分享的途径或方式
 */
+ (void)shareUrl:(NSString *)url text:(NSString *)text description:(NSString *)description imageUrl:(NSString *)imageUrl shareType:(JKShareType)shareType;
@end
