//
//  JKAlertBaseTextContentView.h
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseView.h"
#import "JKAlertTextContainerView.h"

@interface JKAlertBaseTextContentView : JKAlertBaseView

/** titleTextView */
@property (nonatomic, weak, readonly) JKAlertTextContainerView *titleTextView;

/** messageTextView */
@property (nonatomic, weak, readonly) JKAlertTextContainerView *messageTextView;

/** separatorLineView */
@property (nonatomic, weak) UIView *separatorLineView;

/** title和message之间的分隔线是否隐藏 默认YES */
@property (nonatomic, assign) BOOL separatorLineHidden;

/** contentWidth */
@property (nonatomic, assign) CGFloat contentWidth;

/** screenSafeInsets */
@property (nonatomic, assign) UIEdgeInsets screenSafeInsets;

/** titleInsets 默认(20, 20, 3.5, 20) */
@property (nonatomic, assign) UIEdgeInsets titleInsets;

/** messageInsets 默认(3.5, 20, 20, 20) */
@property (nonatomic, assign) UIEdgeInsets messageInsets;

/** separatorLineInsets 默认全部为0 */
@property (nonatomic, assign) UIEdgeInsets separatorLineInsets;

/** title最小高度(不含inset) 默认0 */
@property (nonatomic, assign) CGFloat titleMinHeight;

/** message最小高度(不含inset) 默认0 */
@property (nonatomic, assign) CGFloat messageMinHeight;

/** 仅有title或message时的最小高度 默认0 */
@property (nonatomic, assign) CGFloat singleMinHeight;


/** customContentView */
@property (nonatomic, weak) UIView *customContentView;

/** customTitleView */
@property (nonatomic, weak) UIView *customTitleView;

/** customMessageView */
@property (nonatomic, weak) UIView *customMessageView;


/** 标题 */
@property (nonatomic, copy) NSString *alertTitle;

/** 富文本标题 */
@property (nonatomic, copy) NSAttributedString *alertAttributedTitle;

/** 提示信息 */
@property (nonatomic, copy) NSString *alertMessage;

/** 富文本提示信息 */
@property (nonatomic, copy) NSAttributedString *attributedMessage;


- (void)calculateUI NS_REQUIRES_SUPER;
@end
