//
//  JKAlertBaseTextContentView.h
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseView.h"

@class JKAlertTextView;

@interface JKAlertBaseTextContentView : JKAlertBaseView

/** titleTextView */
@property (nonatomic, weak, readonly) JKAlertTextView *titleTextView;

/** messageTextView */
@property (nonatomic, weak, readonly) JKAlertTextView *messageTextView;
@end
