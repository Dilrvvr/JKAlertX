//
//  JKAlertTextContainerView.h
//  JKAlertX
//
//  Created by Albert on 2020/5/30.
//

#import "JKAlertBaseView.h"
#import "JKAlertTextView.h"

@interface JKAlertTextContainerView : JKAlertBaseView

/** textView */
@property (nonatomic, weak, readonly) JKAlertTextView *textView;

/** 计算frame */
- (CGRect)calculateFrameWithContentWidth:(CGFloat)contentWidth
                               minHeight:(CGFloat)minHeight;
@end
