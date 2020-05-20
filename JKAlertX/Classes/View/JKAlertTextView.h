//
//  JKAlertTextView.h
//  JKAlert
//
//  Created by albert on 2018/4/7.
//  Copyright © 2018年 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKAlertTextView : UITextView

/** 是否可以选择文字 */
@property (nonatomic, assign) BOOL shouldSelectText;

/** 计算frame */
- (CGRect)calculateFrameWithMaxWidth:(CGFloat)maxWidth
                           minHeight:(CGFloat)minHeight
                             originY:(CGFloat)originY
                           superView:(UIView *)superView;
@end
