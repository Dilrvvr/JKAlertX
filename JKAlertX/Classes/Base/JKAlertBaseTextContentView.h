//
//  JKAlertBaseTextContentView.h
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseView.h"
#import "JKAlertTextContainerView.h"

@class JKAlertMultiColor;

// TODO: JKTODO 需外界赋值的属性拎出来

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

/** safeInsets */
@property (nonatomic, assign) UIEdgeInsets safeInsets;

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

/** 仅有title或message时的最小高度 默认30 */
@property (nonatomic, assign) CGFloat singleMinHeight;


/** customContentView */
@property (nonatomic, weak) UIView *customContentView;

/** customTitleView */
@property (nonatomic, weak) UIView *customTitleView;

/** customMessageView */
@property (nonatomic, weak) UIView *customMessageView;


/** titleTextColor */
@property (nonatomic, strong) JKAlertMultiColor *titleTextColor;

/** messageTextColor */
@property (nonatomic, strong) JKAlertMultiColor *messageTextColor;


/** 标题 */
@property (nonatomic, copy) NSString *alertTitle;

/** 富文本标题 */
@property (nonatomic, copy) NSAttributedString *alertAttributedTitle;

/** 提示信息 */
@property (nonatomic, copy) NSString *alertMessage;

/** 富文本提示信息 */
@property (nonatomic, copy) NSAttributedString *attributedMessage;


/** title和message是否可以响应事件，默认YES 如无必要不建议设置为NO */
//@property (nonatomic, assign) BOOL textViewUserInteractionEnabled;

/** title和message是否可以选择文字，默认NO */
//@property (nonatomic, assign) BOOL textViewShouldSelectText;

/** titleFont */
//@property (nonatomic, strong) UIFont *titleFont;
//
///** messageFont */
//@property (nonatomic, strong) UIFont *messageFont;


/** titleTextViewDelegate */
//@property (nonatomic, weak) id<UITextViewDelegate> titleTextViewDelegate;
//
///** messageTextViewDelegate */
//@property (nonatomic, weak) id<UITextViewDelegate> messageTextViewDelegate;
//
//
///** titleTextViewAlignment 默认NSTextAlignmentCenter */
//@property (nonatomic, assign) NSTextAlignment titleTextViewAlignment;
//
///** messageTextViewAlignment 默认NSTextAlignmentCenter */
//@property (nonatomic, assign) NSTextAlignment messageTextViewAlignment;


- (void)calculateUI NS_REQUIRES_SUPER;
@end
