//
//  JKShareView.h
//  JKShare
//
//  Created by albert on 16/8/26.
//  Copyright © 2016年 albert. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class JKPostModel;

@interface JKShareView : UIView
/** 显示分享界面 */
+ (void)showWithShareUrl:(NSString *)url title:(NSString *)title;

/** 详情页 显示分享界面 */
//+ (void)showWithModel:(JKPostModel *)model;
@end
