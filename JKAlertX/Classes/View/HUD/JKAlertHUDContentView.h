//
//  JKAlertHUDContentView.h
//  JKAlertX
//
//  Created by Albert on 2020/5/31.
//

#import "JKAlertBaseAlertContentView.h"
#import "JKAlertHUDTextContentView.h"

@interface JKAlertHUDContentView : JKAlertBaseAlertContentView

/** textContentView */
@property (nonatomic, weak, readonly) JKAlertHUDTextContentView *textContentView;

/** 默认深色样式 */
@property (nonatomic, assign) BOOL defaultDarkStyle;

/**
 * HUD样式高度，不包含customHUD
 * 小于等于0将没有效果，默认0
 */
@property (nonatomic, assign) CGFloat hudHeight;
@end
