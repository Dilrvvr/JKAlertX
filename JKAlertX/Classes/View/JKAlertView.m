//
//  JKAlertView.m
//  TestVideoAndPicture
//
//  Created by albert on 2017/4/18.
//  Copyright © 2017年 安永博. All rights reserved.
//

#import "JKAlertView.h"
#import "JKAlertCollectionViewCell.h"
#import "JKAlertTableViewCell.h"
#import "UIView+JKAlertX.h"
#import "JKAlertPlainActionButton.h"
#import "JKAlertView+PrivateProperty.h"
#import "JKAlertVisualFormatConstraintManager.h"
#import "JKAlertView+Public.h"
#import "JKAlertView+HUD.h"
// TODO: - JKTODO delete
#import "JKAlertView+ActionSheet.h"
#import "JKAlertThemeManager.h"

@interface JKAlertView () <JKAlertBaseAlertContentViewDelegate>

@end

@implementation JKAlertView

#pragma mark
#pragma mark - 类方法

+ (instancetype)alertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                             style:(JKAlertStyle)style {
    
    JKAlertView *alertView = [self alertViewWithStyle:style];
    
    alertView.currentTextContentView.alertTitle = [title copy];
    alertView.currentTextContentView.alertMessage = [message copy];
    
    return alertView;
}

/** 链式实例化 */
+ (JKAlertView *(^)(NSString *title, NSString *message, JKAlertStyle style))alertView {
    
    return ^(NSString *title, NSString *message, JKAlertStyle style) {
        
        return [JKAlertView alertViewWithTitle:title message:message style:style];
    };
}

+ (instancetype)alertViewWithAttributedTitle:(NSAttributedString *)attributedTitle
                           attributedMessage:(NSAttributedString *)attributedMessage
                                       style:(JKAlertStyle)style {
    
    JKAlertView *alertView = [self alertViewWithStyle:style];
    
    alertView.currentTextContentView.alertAttributedTitle = [attributedTitle copy];
    alertView.currentTextContentView.attributedMessage = [attributedMessage copy];
    
    return alertView;
}

/** 函数式类方法 */
+ (JKAlertView *(^)(NSString *title, NSString *message, JKAlertStyle style, void (^)(JKAlertView *alertView)))show {
    
    return ^(NSString *title, NSString *message, JKAlertStyle style, void(^configuration)(JKAlertView *alertView)) {
        
        JKAlertView *view = [self alertViewWithTitle:title message:message style:style];
        
        !configuration ? : configuration(view);
        
        [view show];
        
        return view;
    };
}

/** 链式实例化 */
+ (JKAlertView *(^)(NSAttributedString *attributedTitle, NSAttributedString *attributedMessage, JKAlertStyle style))alertViewAttributed {
    
    return ^(NSAttributedString *attributedTitle, NSAttributedString *attributedMessage, JKAlertStyle style) {
        
        return [JKAlertView alertViewWithAttributedTitle:attributedTitle attributedMessage:attributedMessage style:style];
    };
}

/** 显示文字HUD */
+ (void (^)(NSString *title, void(^configuration)(JKAlertView *alertView)))showHUDWithTitle {
    
    return ^(NSString *title, void(^configuration)(JKAlertView *alertView)) {
        
        JKAlertView *alertView = [JKAlertView alertViewWithTitle:title message:nil style:(JKAlertStyleHUD)];
        
        !configuration ? : configuration(alertView);
        
        [alertView show];
    };
}

/** 显示富文本HUD */
+ (void (^)(NSAttributedString *attributedTitle, void(^configuration)(JKAlertView *alertView)))showHUDWithAttributedTitle {
    
    return ^(NSAttributedString *attributedTitle, void(^configuration)(JKAlertView *alertView)) {
        
        JKAlertView *alertView = [JKAlertView alertViewWithAttributedTitle:attributedTitle attributedMessage:nil style:(JKAlertStyleHUD)];
        
        !configuration ? : configuration(alertView);
        
        [alertView show];
    };
}

/**
 * 显示自定义HUD
 * 注意使用点语法调用，否则莫名报错 JKAlertView.showCustomHUD
 * customHUD尺寸将完全由自定义控制，默认显示在屏幕中间
 * 注意自己计算好自定义HUD的size，以避免横竖屏出现问题
 */
+ (void (^)(UIView *(^customHUD)(void), void(^configuration)(JKAlertView *alertView)))showCustomHUD {
    
    return ^(UIView *(^customHUD)(void), void(^configuration)(JKAlertView *alertView)) {
        
        JKAlertView *alertView = [JKAlertView alertViewWithTitle:nil message:nil style:(JKAlertStyleHUD)];
        
        UIView *customView = !customHUD ? nil : customHUD();
        
        !configuration ? : configuration(alertView);
        
        alertView.customHUD = customView;
        
        [alertView show];
    };
}

#pragma mark
#pragma mark - Private Initialization

+ (instancetype)alertViewWithStyle:(JKAlertStyle)style {
    
    JKAlertView *alertView = [[JKAlertView alloc] init];
    
    alertView.alertStyle = style;
    
    return alertView;
}

- (void)setAlertStyle:(JKAlertStyle)alertStyle {
    _alertStyle = alertStyle;
    
    _tapBlankDismiss = NO;
    
    switch (_alertStyle) {
        case JKAlertStyleHUD:
        {
            _currentAlertContentView = self.hudContentView;
            _currentTextContentView = self.hudContentView.textContentView;
            
            self.makeFullBackgroundColor(nil);
        }
            break;
            
        case JKAlertStyleActionSheet:
        {
            _tapBlankDismiss = YES;
            
            _currentAlertContentView = self.actionsheetContentView;
            _currentTextContentView = self.actionsheetContentView.textContentView;
        }
            break;
            
        case JKAlertStyleCollectionSheet:
        {
            _tapBlankDismiss = YES;
            
            _currentAlertContentView = self.collectionsheetContentView;
            _currentTextContentView = self.collectionsheetContentView.textContentView;
        }
            break;
            
        default: // 默认为JKAlertStylePlain样式
        {
            _alertStyle = JKAlertStylePlain;
            
            _autoAdaptKeyboard = YES;
            
            _currentAlertContentView = self.plainContentView;
            _currentTextContentView = self.plainContentView.textContentView;
            
            [self addKeyboardWillChangeFrameNotification];
        }
            break;
    }
}

#pragma mark
#pragma mark - 显示

/** 显示 */
- (JKAlertView *(^)(void))show {
    
    [JKAlertKeyWindow() endEditing:YES];
    
    if (self.isShowed) { return ^{ return self; }; }
    
    // TODO: - JKTODO delete
    if (JKAlertStyleActionSheet == self.alertStyle ||
        JKAlertStyleCollectionSheet == self.alertStyle) {
        __weak typeof(self) weakSelf = self;
        [self addAction:[JKAlertAction actionWithTitle:@"Debug" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
            [weakSelf debugWithAlertView:action.alertView];
        }].makeAutoDismiss(NO)];
    }
    
    self.isShowed = YES;
    
    [self calculateUI];
    
    !self.alertContentViewConfiguration ? : self.alertContentViewConfiguration(self.alertContentView);
    
    // customSuperView没有则默认keyWindow
    [self.customSuperView addSubview:self];
    
    
    
    
    // TODO: - JKTODO delete
    UIButton *refreshButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    refreshButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    //refreshButton.backgroundColor = [UIColor blackColor];
    if (@available(iOS 13.0, *)) {
        [refreshButton setTitle:[self themeStyleStringWithStyle:[JKAlertThemeManager sharedManager].themeStyle] forState:(UIControlStateNormal)];
    }
    [refreshButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    refreshButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:refreshButton];
    NSString *verticalFormat = [NSString stringWithFormat:@"V:|-0-[view(%.0f)]", JKAlertIsDeviceX() ? 90.0 : 65.0];
    [JKAlertVisualFormatConstraintManager addConstraintsWithHorizontalFormat:@"H:|-80-[view]-80-|" verticalFormat:verticalFormat viewKeyName:@"view" targetView:refreshButton constraintsView:self];
    [refreshButton addTarget:self action:@selector(refreshButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    
    return ^{ return self; };
}

- (void)debugWithAlertView:(JKAlertView *)alertView {
    
    JKAlertView *view = [JKAlertView alertViewWithTitle:@"Debug" message:nil style:(JKAlertStyleActionSheet)].makeActionSheetBottomButtonPinned(YES);
    
    JKAlertBaseSheetContentView *sheet = [alertView checkSheetContentView];
    
    [view addAction:[JKAlertAction actionWithTitle:[NSString stringWithFormat:@"Adapt Home Indicator: %@", sheet.autoAdjustHomeIndicator ? @"YES" : @"NO"] style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        sheet.autoAdjustHomeIndicator = !sheet.autoAdjustHomeIndicator;
        
        alertView.relayout(YES);
    }]];
    
    [view addAction:[JKAlertAction actionWithTitle:[NSString stringWithFormat:@"Fill Home Indicator: %@", sheet.fillHomeIndicator ? @"YES" : @"NO"] style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        sheet.fillHomeIndicator = !sheet.fillHomeIndicator;
        
        alertView.relayout(YES);
    }]];
    
    [view addAction:[JKAlertAction actionWithTitle:[NSString stringWithFormat:@"Pinned: %@", sheet.bottomButtonPinned ? @"YES" : @"NO"] style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        sheet.bottomButtonPinned = !sheet.bottomButtonPinned;
        
        alertView.relayout(YES);
    }]];
    
    [view addAction:[JKAlertAction actionWithTitle:@"--------------------------------" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeAutoDismiss(NO).makeTitleColor([UIColor redColor])];
    
    
    
    [view addAction:[JKAlertAction actionWithTitle:@"Long Title" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        alertView.resetAlertTitle(@"Long Title");
        alertView.makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
           
            UIEdgeInsets insets = originalInsets;
            insets.top = 1000;
            return insets;
        });
        
        alertView.relayout(YES);
    }]];
    
    [view addAction:[JKAlertAction actionWithTitle:@"Normal Title" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        alertView.resetAlertTitle(@"Normal Title");
        alertView.makeTitleInsets(^UIEdgeInsets(UIEdgeInsets originalInsets) {
           
            UIEdgeInsets insets = originalInsets;
            insets.top = 20;
            return insets;
        });
        
        alertView.relayout(YES);
    }]];
    
    [view addAction:[JKAlertAction actionWithTitle:@"Clear Title" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        alertView.resetAlertTitle(nil);
        alertView.resetMessage(nil);
        
        alertView.relayout(YES);
    }]];
    
    
    
    
    [view addAction:[JKAlertAction actionWithTitle:@"--------------------------------" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeAutoDismiss(NO).makeTitleColor([UIColor redColor])];
    
    
    
    if (JKAlertStyleCollectionSheet == alertView.alertStyle) {

        [view addAction:[JKAlertAction actionWithTitle:@"Long Collection" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
            
            if (alertView.getCollectionAction) {
                
                alertView.getCollectionAction.makeCustomView(^UIView *(JKAlertAction *action) {
                    
                    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1000)];
                    v.backgroundColor = [UIColor orangeColor];
                    return v;
                });
            }
            
            alertView.relayout(YES);
        }]];
        
        [view addAction:[JKAlertAction actionWithTitle:@"Normal Collection" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
            
            if (alertView.getCollectionAction) {
                
                alertView.getCollectionAction.makeCustomView(^UIView *(JKAlertAction *action) {
                    
                    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 60)];
                    v.backgroundColor = [UIColor orangeColor];
                    return v;
                });
            }
            
            alertView.relayout(YES);
        }]];
        
        [view addAction:[JKAlertAction actionWithTitle:@"Clear Collection" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
            
            if (alertView.getCollectionAction) {
                
                alertView.getCollectionAction.makeCustomView(^UIView *(JKAlertAction *action) {
                    
                    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                    v.backgroundColor = [UIColor orangeColor];
                    return v;
                });
            }
            
            alertView.relayout(YES);
        }]];
        
    } else {

        [view addAction:[JKAlertAction actionWithTitle:@"Long Table" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
            
            JKAlertAction *last = alertView.actions.lastObject;
            [alertView.actions removeAllObjects];
            
            for (NSInteger i = 0; i < 30; i++) {
                
                [alertView addAction:[JKAlertAction actionWithTitle:@(i + 1).stringValue style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
                    
                }]];
            }
            [alertView addAction:last];
            
            alertView.relayout(YES);
        }]];
        
        [view addAction:[JKAlertAction actionWithTitle:@"Normal Table" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
            
            JKAlertAction *last = alertView.actions.lastObject;
            [alertView.actions removeAllObjects];
            
            for (NSInteger i = 0; i < 3; i++) {
                
                [alertView addAction:[JKAlertAction actionWithTitle:@(i + 1).stringValue style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
                    
                }]];
            }
            
            [alertView addAction:last];
            
            alertView.relayout(YES);
        }]];
        
        [view addAction:[JKAlertAction actionWithTitle:@"Clear Table" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
            
            [alertView.actions removeAllObjects];
            
            alertView.relayout(YES);
        }]];
    }
    
    
    
    
    [view addAction:[JKAlertAction actionWithTitle:@"--------------------------------" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeAutoDismiss(NO).makeTitleColor([UIColor redColor])];
    
    
    
    
    [view addAction:[JKAlertAction actionWithTitle:@"Long Cancel" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        if (alertView.getCancelAction) {
            
            alertView.getCancelAction.makeCustomView(^UIView *(JKAlertAction *action) {
                
                UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1000)];
                v.backgroundColor = [UIColor orangeColor];
                return v;
            });
        }
        
        alertView.relayout(YES);
    }]];
    
    [view addAction:[JKAlertAction actionWithTitle:@"Normal Cancel" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        if (alertView.getCancelAction) {
            
            alertView.getCancelAction.makeCustomView(^UIView *(JKAlertAction *action) {
                
                UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 60)];
                v.backgroundColor = [UIColor orangeColor];
                return v;
            });
        }
        
        alertView.relayout(YES);
    }]];
    
    [view addAction:[JKAlertAction actionWithTitle:@"Clear Cancel" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
        if (alertView.getCancelAction) {
            
            alertView.getCancelAction.makeCustomView(^UIView *(JKAlertAction *action) {
                
                UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                v.backgroundColor = [UIColor orangeColor];
                return v;
            });
        }
        
        alertView.relayout(YES);
    }]];
    
    
    
    [view addAction:[JKAlertAction actionWithTitle:@"--------------------------------" style:(JKAlertActionStyleDefault) handler:^(JKAlertAction *action) {
        
    }].makeAutoDismiss(NO).makeTitleColor([UIColor redColor])];
    
    [view show];
}

- (NSString *)themeStyleStringWithStyle:(JKAlertThemeStyle)themeStyle {
    // TODO: - JKTODO delete
    
    switch (themeStyle) {
        case JKAlertThemeStyleSystem:
            return @"JKAlertThemeStyleSystem";
            break;
        case JKAlertThemeStyleLight:
            return @"JKAlertThemeStyleLight";
            break;
        case JKAlertThemeStyleDark:
            return @"JKAlertThemeStyleDark";
            break;
            
        default:
            return @"JKAlertThemeStyleSystem";
            break;
    }
    
    return @"JKAlertThemeStyleSystem";
}

- (void)refreshButtonClick:(UIButton *)button {
    
    // TODO: - JKTODO delete
    
    switch ([JKAlertThemeManager sharedManager].themeStyle) {
        case JKAlertThemeStyleSystem:
            self.makeThemeStyle(JKAlertThemeStyleLight);
            break;
        case JKAlertThemeStyleLight:
            self.makeThemeStyle(JKAlertThemeStyleDark);
            break;
        case JKAlertThemeStyleDark:
            self.makeThemeStyle(JKAlertThemeStyleSystem);
            break;

        default:
            self.makeThemeStyle(JKAlertThemeStyleSystem);
            break;
    }
    
    if (@available(iOS 13.0, *)) {
        [button setTitle:[self themeStyleStringWithStyle:[JKAlertThemeManager sharedManager].themeStyle] forState:(UIControlStateNormal)];
    }
}

#pragma mark
#pragma mark - 计算布局

- (void)calculateUI {
    
    self.frame = CGRectMake(0, 0, JKAlertScreenW, JKAlertScreenH);
    
    switch (self.alertStyle) {
        case JKAlertStylePlain:
        {
            [self calculatePlainUI];
        }
            break;
            
        case JKAlertStyleActionSheet:
        {
            [self calculateActionSheetUI];
        }
            break;
            
        case JKAlertStyleCollectionSheet:
        {
            [self calculateCollectionSheetUI];
        }
            break;
            
        case JKAlertStyleHUD:
        {
            [self calculateHudUI];
        }
            break;
            
        default:
            break;
    }
}

- (void)calculatePlainUI {
    
    [self updatePlainWidth];
    
    // TODO: - JKTODO <#注释#>
    
    self.plainContentView.actionArray = self.actions;
    self.plainContentView.textFieldArray = self.textFieldArr;
    
    self.plainContentView.contentWidth = PlainViewWidth;
    self.plainContentView.maxHeight = JKAlertPlainViewMaxH;
    [self.plainContentView calculateUI];
    
    self.plainContentView.center = CGPointMake(JKAlertScreenW * 0.5 + self.plainCenterOffset.x, JKAlertScreenH * 0.5 + self.plainCenterOffset.y);
}

- (void)calculateHudUI {
    
    if (self.customHUD) {
        
        self.hudContentView.textContentView.customContentView = self.customHUD;
    }
    
    [self updatePlainWidth];
    
    
    // TODO: - JKTODO <#注释#>
    self.hudContentView.contentWidth = PlainViewWidth;
    self.hudContentView.maxHeight = JKAlertPlainViewMaxH;
    [self.hudContentView calculateUI];
    
    self.hudContentView.center = CGPointMake(JKAlertScreenW * 0.5 + self.plainCenterOffset.x, JKAlertScreenH * 0.5 + self.plainCenterOffset.y);
}

- (void)calculateActionSheetUI {
    
    [self.actions.lastObject setSeparatorLineHidden:YES];
    
    self.actionsheetContentView.actionArray = self.actions;
    
    self.actionsheetContentView.tapBlankDismiss = self.tapBlankDismiss;
    
    UIEdgeInsets safeAreaInsets = [self checkSuperViewSafeAreaInsets];
    
    safeAreaInsets.top = 0;
    
    self.actionsheetContentView.screenSafeInsets = safeAreaInsets;
    
    CGFloat contentWidth = JKAlertScreenW;
    
    if (self.actionsheetContentView.isPierced) {
        
        contentWidth -= (self.actionsheetContentView.piercedInsets.left + self.actionsheetContentView.piercedInsets.right + self.actionsheetContentView.screenSafeInsets.left + self.actionsheetContentView.screenSafeInsets.right);
    }
    
    // TODO: - JKTODO <#注释#>
    self.actionsheetContentView.contentWidth = contentWidth;
    self.actionsheetContentView.maxHeight = JKAlertSheetMaxH;
    [self.actionsheetContentView calculateUI];
    
    CGRect frame = self.actionsheetContentView.frame;
    frame.origin.x = self.actionsheetContentView.isPierced ? self.actionsheetContentView.screenSafeInsets.left + self.actionsheetContentView.piercedInsets.left : 0;
    frame.origin.y = JKAlertScreenH - frame.size.height;
    self.actionsheetContentView.frame = frame;
    
    self.actionsheetContentView.correctFrame = frame;
}

- (void)calculateCollectionSheetUI {
    
    self.collectionsheetContentView.actionArray = self.actions;
    self.collectionsheetContentView.actionArray2 = self.actions2;
    
    self.collectionsheetContentView.tapBlankDismiss = self.tapBlankDismiss;
    
    UIEdgeInsets safeAreaInsets = [self checkSuperViewSafeAreaInsets];
    
    safeAreaInsets.top = 0;
    
    self.collectionsheetContentView.screenSafeInsets = safeAreaInsets;
    
    CGFloat contentWidth = JKAlertScreenW;
    
    if (self.collectionsheetContentView.isPierced) {
        
        contentWidth -= (self.collectionsheetContentView.piercedInsets.left + self.collectionsheetContentView.piercedInsets.right + self.collectionsheetContentView.screenSafeInsets.left + self.collectionsheetContentView.screenSafeInsets.right);
    }
    
    // TODO: - JKTODO <#注释#>
    self.collectionsheetContentView.contentWidth = contentWidth;
    self.collectionsheetContentView.maxHeight = JKAlertSheetMaxH;
    
    [self.collectionsheetContentView calculateUI];
    
    CGRect frame = self.collectionsheetContentView.frame;
    frame.origin.x = self.collectionsheetContentView.isPierced ? self.collectionsheetContentView.screenSafeInsets.left + self.collectionsheetContentView.piercedInsets.left : 0;
    frame.origin.y = JKAlertScreenH - frame.size.height;
    self.collectionsheetContentView.frame = frame;
    
    self.collectionsheetContentView.correctFrame = frame;
}

/// 检查获取superView的安全区域
- (UIEdgeInsets)checkSuperViewSafeAreaInsets {
    
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    
    if (@available(iOS 11.0, *)) {
        
        safeAreaInsets = self.customSuperView.safeAreaInsets;
        
        UIWindow *keyWindow = JKAlertKeyWindow();
        
        UIEdgeInsets windowSafeAreaInsets = keyWindow.safeAreaInsets;
        
        CGFloat safeWidth = keyWindow.frame.size.width - windowSafeAreaInsets.left - windowSafeAreaInsets.right;
        
        if (self.customSuperView.frame.size.width > safeWidth - 1) {
            
            safeAreaInsets.left = windowSafeAreaInsets.left;
            safeAreaInsets.right = windowSafeAreaInsets.right;
        }
    }
    
    return safeAreaInsets;
}

- (void)updatePlainWidth {
    
    if (!self.autoReducePlainWidth) { return; }
    
    CGFloat safeAreaInset = 0;
    
    if (@available(iOS 11.0, *)) {
        
        safeAreaInset = MAX(self.customSuperView.safeAreaInsets.left, self.customSuperView.safeAreaInsets.right);
    }
    
    PlainViewWidth = MIN(OriginalPlainWidth, JKAlertScreenW - safeAreaInset * 2);
}

/**
 * 更新plain样式Y值
 */
- (void)updatePlainFrameY:(CGFloat)frameY animated:(BOOL)animated {
    
    CGRect frame = self.alertContentView.frame;
    
    frame.origin.y = frameY;
    
    if (!animated) {
        
        self.alertContentView.frame = frame;
        
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alertContentView.frame = frame;
    }];
}

#pragma mark
#pragma mark - Setter

- (void)setAlertViewToAction:(JKAlertAction *)action {
    
    action.alertView = self;
    
    if (JKAlertStyleActionSheet == self.alertStyle) {
        
        // TODO: - JKTODO <#注释#>
        action.isPierced = self.actionsheetContentView.isPierced;
        
    } else if (JKAlertStyleCollectionSheet == self.alertStyle) {
        
        // TODO: - JKTODO <#注释#>
        action.isPierced = self.collectionsheetContentView.isPierced;
    }
}

- (void)setCustomHUD:(UIView *)customHUD {
    
    if (self.alertStyle != JKAlertStyleHUD) { return; }
    
    _customHUD = customHUD;
    
    // TODO: - JKTODO <#注释#>
    if (self.customHUD.frame.size.width <= 0) { return; }
    
    PlainViewWidth = self.customHUD.frame.size.width;
    
    OriginalPlainWidth = PlainViewWidth;
}

#pragma mark
#pragma mark - 监听屏幕旋转

- (void)orientationChanged:(NSNotification *)note {
    
    !self.orientationDidChangeHandler ? : self.orientationDidChangeHandler(self, [UIApplication sharedApplication].statusBarOrientation);
    
    [self updateWidthHeight];
    
    self.relayout(NO);
}

#pragma mark
#pragma mark - 添加action

/** 添加action */
- (JKAlertView *(^)(JKAlertAction *action))addAction {
    
    return ^(JKAlertAction *action) {
        
        [self addAction:action];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(JKAlertAction *action))removeAction {
    
    return ^(JKAlertAction *action) {
        
        [self removeAction:action];
        
        return self;
    };
}

/** 链式添加action */
- (JKAlertView *(^)(JKAlertAction *action, NSUInteger atIndex))insertAction {
    
    return ^(JKAlertAction *action, NSUInteger atIndex) {
        
        [self insertAction:action atIndex:atIndex];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(NSUInteger index))removeActionAtIndex {
    
    return ^(NSUInteger index) {
        
        [self removeActionAtIndex:index];
        
        return self;
    };
}

/** 链式获取action */
- (JKAlertView *(^)(NSUInteger index, void (^)(JKAlertAction *action)))getActionAtIndex {
    
    return ^(NSUInteger index, void(^getAction)(JKAlertAction *action)) {
        
        JKAlertAction *action = [self getActionAtIndex:index];
        
        !getAction ? : getAction(action);
        
        return self;
    };
}

/** 添加action */
- (void)addAction:(JKAlertAction *)action {
    
    if (!action) { return; }
    
    [self setAlertViewToAction:action];
    
    [self.actions addObject:action];
}

/** 移除action */
- (void)removeAction:(JKAlertAction *)action {
    
    if (!action || ![self.actions containsObject:action]) { return; }
    
    [self.actions removeObject:action];
}

/** 添加action */
- (void)insertAction:(JKAlertAction *)action atIndex:(NSUInteger)index {
    
    if (!action) { return; }
    
    [self setAlertViewToAction:action];
    
    [self.actions insertObject:action atIndex:index];
}

/** 移除action */
- (void)removeActionAtIndex:(NSUInteger)index {
    
    if (index < 0 || index >= self.actions.count) { return; }
    
    [self.actions removeObjectAtIndex:index];
}

/** 获取action */
- (JKAlertAction *)getActionAtIndex:(NSUInteger)index {
    
    if (index < 0 || index >= self.actions.count) { return nil; }
    
    JKAlertAction *action = [self.actions objectAtIndex:index];
    
    return action;
}


#pragma mark
#pragma mark - action数组操作

/** 添加action */
- (JKAlertView *(^)(JKAlertAction *action, BOOL isSecondCollection))addActionTo {
    
    return ^(JKAlertAction *action, BOOL isSecondCollection) {
        
        [self addAction:action isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(JKAlertAction *action, BOOL isSecondCollection))removeActionFrom {
    
    return ^(JKAlertAction *action, BOOL isSecondCollection) {
        
        [self removeAction:action isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式添加action */
- (JKAlertView *(^)(JKAlertAction *action, NSUInteger atIndex, BOOL isSecondCollection))insertActionTo {
    
    return ^(JKAlertAction *action, NSUInteger atIndex, BOOL isSecondCollection) {
        
        [self insertAction:action atIndex:atIndex isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式移除action */
- (JKAlertView *(^)(NSUInteger index, BOOL isSecondCollection))removeActionAtIndexFrom {
    
    return ^(NSUInteger index, BOOL isSecondCollection) {
        
        [self removeActionAtIndex:index isSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 链式获取action */
- (JKAlertView *(^)(NSUInteger index, BOOL isSecondCollection, void (^)(JKAlertAction *action)))getActionAtIndexFrom {
    
    return ^(NSUInteger index, BOOL isSecondCollection, void(^getAction)(JKAlertAction *action)) {
        
        JKAlertAction *action = [self getActionAtIndex:index isSecondCollection:isSecondCollection];
        
        !getAction ? : getAction(action);
        
        return self;
    };
}

/** 链式获取cancelAction或collectionAction */
- (JKAlertView *(^)(BOOL isCancelAction, void (^)(JKAlertAction *action)))getCancelOrCollectionAction {
    
    return ^(BOOL isCancelAction, void(^getAction)(JKAlertAction *action)) {
        
        JKAlertAction *action = isCancelAction ? [self getCancelAction] : [self getCollectionAction];
        
        !getAction ? : getAction(action);
        
        return self;
    };
}

/** 链式获取action数组 */
- (JKAlertView *(^)(BOOL isSecondCollection, void (^)(NSArray *actionArray)))getActionArrayFrom {
    
    return ^(BOOL isSecondCollection, void(^getActionArray)(NSArray *actionArray)) {
        
        !getActionArray ? : getActionArray([self getActionArrayIsSecondCollection:isSecondCollection]);
        
        return self;
    };
}

/** 链式清空action数组 */
- (JKAlertView *(^)(BOOL isSecondCollection))clearActionArrayFrom {
    
    return ^(BOOL isSecondCollection) {
        
        [self clearActionArrayIsSecondCollection:isSecondCollection];
        
        return self;
    };
}

/** 添加action */
- (void)addAction:(JKAlertAction *)action isSecondCollection:(BOOL)isSecondCollection {
    
    if (!action) { return; }
    
    [self setAlertViewToAction:action];
    
    if (isSecondCollection) {
        
        [self.actions2 addObject:action];
        
    } else {
        
        [self.actions addObject:action];
    }
}

/** 移除action */
- (void)removeAction:(JKAlertAction *)action isSecondCollection:(BOOL)isSecondCollection {
    
    if (!action) { return; }
    
    if (isSecondCollection) {
        
        if ([self.actions2 containsObject:action]) {
            
            [self.actions2 removeObject:action];
        }
        
    } else {
        
        if ([self.actions containsObject:action]) {
            
            [self.actions removeObject:action];
        }
    }
}

/** 添加action */
- (void)insertAction:(JKAlertAction *)action atIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection {
    
    if (!action) { return; }
    
    [self setAlertViewToAction:action];
    
    if (isSecondCollection) {
        
        [self.actions2 insertObject:action atIndex:index];
        
    } else {
        
        [self.actions insertObject:action atIndex:index];
    }
}

/** 移除action */
- (void)removeActionAtIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection {
    
    if (index < 0) { return; }
    
    if (isSecondCollection) {
        
        if (index >= self.actions2.count) { return; }
        
        [self.actions2 removeObjectAtIndex:index];
        
    } else {
        
        if (index >= self.actions.count) { return; }
        
        [self.actions removeObjectAtIndex:index];
    }
}

/** 获取action */
- (JKAlertAction *)getActionAtIndex:(NSUInteger)index isSecondCollection:(BOOL)isSecondCollection {
    
    if (index < 0) { return nil; }
    
    JKAlertAction *action = nil;
    
    if (isSecondCollection) {
        
        if (index >= self.actions2.count) { return nil; }
        
        action = [self.actions2 objectAtIndex:index];
        
    } else {
        
        if (index >= self.actions.count) { return nil; }
        
        action = [self.actions objectAtIndex:index];
    }
    
    return action;
}

/** 获取cancelAction */
- (JKAlertAction *)getCancelAction {
    
    return self.currentAlertContentView.cancelAction;
}

/** 获取collectionAction */
- (JKAlertAction *)getCollectionAction {
    
    __block JKAlertAction *action = nil;
    
    [self checkCollectionSheetStyleHandler:^{
        
        action = self.collectionsheetContentView.collectionAction;
    }];
    
    return action;
}

/** 获取action数组 */
- (NSArray *)getActionArrayIsSecondCollection:(BOOL)isSecondCollection {
    
    if (isSecondCollection) {
        
        return [self.actions2 copy];
        
    } else {
        
        return [self.actions copy];
    }
}

/** 清空action数组 */
- (void)clearActionArrayIsSecondCollection:(BOOL)isSecondCollection {
    
    if (isSecondCollection) {
        
        [_actions2 removeAllObjects];
        
    } else {
        
        [_actions removeAllObjects];
    }
}



#pragma mark
#pragma mark - 添加textField

/**
 * 添加textField 默认高度30
 * textField之间的间距是1，和其superView的上下左右间距也是1
 * textField可以直接对其superView进行一些属性修改，如背景色
 * block中的参数view用于调用dismiss()来移除当前弹框
 */
- (void)addTextFieldWithConfigurationHandler:(void (^)(JKAlertView *view, UITextField *textField))configurationHandler {
    
    UITextField *tf = [[UITextField alloc] init];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 1)];
    tf.leftView = leftView;
    tf.leftViewMode = UITextFieldViewModeAlways;
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 1)];
    tf.rightView = rightView;
    tf.rightViewMode = UITextFieldViewModeAlways;
    tf.font = [UIFont systemFontOfSize:13];
    
    // TODO: - JKTODO <#注释#>
    [JKAlertThemeProvider providerWithOwner:tf handlerKey:NSStringFromSelector(@selector(backgroundColor)) provideHandler:^(JKAlertThemeProvider *provider, UITextField *providerOwner) {

        providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertGlobalLightBackgroundColor(), JKAlertGlobalDarkBackgroundColor());
    }];
    
    [self.textFieldArr addObject:tf];
    
    if (self.currentTextField == nil) {
        
        self.currentTextField = tf;
    }
    
    !configurationHandler ? : configurationHandler(self, tf);
}

/**
 * 链式添加textField 默认高度30
 * textField之间的间距是1，和其superView的上下左右间距也是1
 * textField可以直接对其superView进行一些属性修改，如背景色
 * block中的参数view用于调用dismiss()来移除当前弹框
 */
- (JKAlertView *(^)(void (^)(JKAlertView *view, UITextField *textField)))addTextFieldWithConfigurationHandler {
    
    return ^(void (^configurationHandler)(JKAlertView *view, UITextField *textField)) {
        
        [self addTextFieldWithConfigurationHandler:configurationHandler];
        
        return self;
    };
}

/** 显示并监听JKAlertView消失动画完成 */
- (void (^)(void (^handler)(void)))showWithDidDismissHandler {
    
    return ^(void(^handler)(void)) {
        
        [self show];
        
        self.didDismissHandler = handler;
    };
}

#pragma mark
#pragma mark - KVO

- (void)checkObserver {
    
    if (self.observerSuperView &&
        self.observerSuperView != self.superview) {
        
        [self removeAllOberserver];
    }
    
    [self addAllObserver];
}

- (void)addAllObserver {
    
    if (ObserverAdded) { return; }
    
    self.observerSuperView = self.superview;
    
    [self.superview addObserver:self forKeyPath:@"frame" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:nil];
    
    ObserverAdded = YES;
}

- (void)removeAllOberserver {
    
    if (ObserverAdded) {
        
        [self.observerSuperView removeObserver:self forKeyPath:@"frame"];
    }
    
    ObserverAdded = NO;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    if (object == self.superview && [keyPath isEqualToString:@"frame"]) {
        
        CGRect oldFrame = [[change objectForKey:NSKeyValueChangeOldKey] CGRectValue];
        CGRect currentFrame = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue];
        
        if (CGSizeEqualToSize(oldFrame.size, currentFrame.size) ||
            (oldFrame.size.width == currentFrame.size.height &&
             oldFrame.size.height == currentFrame.size.width)) {
            
            // 屏幕旋转由屏幕旋转处理
            
            return;
        }
        
        [self updateWidthHeight];
        
        self.relayout(YES);
    }
}

#pragma mark
#pragma mark - 动画弹出来

- (void)solveDidMoveToSuperview {
    
    if (!self.superview) { return; }
    
    self.frame = self.superview.bounds;
    
    if (self.vibrateEnabled) {
        
        JKAlertVibrateDevice();
    }
    
    [self startShowAnimation];
    
    [self checkObserver];
}

- (void)startShowAnimation{
    
    self.window.userInteractionEnabled = NO;
    
    !self.willShowHandler ? : self.willShowHandler(self);
    
    JKAlertBaseSheetContentView *sheetContentView = nil;
    
    if (self.customShowAnimationBlock) {
        
        self.customShowAnimationBlock(self, self.alertContentView);
        
    } else {
        
        switch (self.alertStyle) {
            case JKAlertStyleHUD:
            case JKAlertStylePlain:
            {
                self.alertContentView.alpha = 0;
                self.alertContentView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            }
                break;
            case JKAlertStyleActionSheet:
            {
                sheetContentView = self.actionsheetContentView;
            }
                break;
            case JKAlertStyleCollectionSheet:
            {
                sheetContentView = self.collectionsheetContentView;
            }
                break;
                
            default:
                break;
        }
        
        if (sheetContentView) {
            
            CGRect frame = sheetContentView.frame;
            frame.origin.y = JKAlertScreenH;
            sheetContentView.frame = frame;
            
            if (sheetContentView.showScaleAnimated) {
                
                sheetContentView.layer.anchorPoint = CGPointMake(0.5, 1);
            }
        }
    }
    
    self.backgroundView.alpha = 0;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        self.backgroundView.alpha = 1;
        
        [self showAnimationOperation];
        
    } completion:^(BOOL finished) {
        
        if (self.customShowAnimationBlock) { return; }
        
        if (sheetContentView &&
            sheetContentView.showScaleAnimated) {
            
            sheetContentView.verticalDismissPanGesture.enabled = NO;
            
            self.window.userInteractionEnabled = YES;
            
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowUserInteraction  animations:^{
                [UIView setAnimationCurve:(UIViewAnimationCurveEaseInOut)];
                
                sheetContentView.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                
                sheetContentView.verticalDismissPanGesture.enabled = YES;
                
                self.showAnimationDidComplete();
            }];
            
        } else {
            
            self.showAnimationDidComplete();
        }
    }];
}

- (void)showAnimationOperation {
    
    if (self.customShowAnimationBlock) { return; }
    
    JKAlertBaseSheetContentView *sheetContentView = nil;
    
    switch (self.alertStyle) {
        case JKAlertStyleHUD:
        case JKAlertStylePlain:
        {
            self.alertContentView.transform = CGAffineTransformIdentity;
            self.alertContentView.alpha = 1;
        }
            break;
        case JKAlertStyleActionSheet:
        {
            sheetContentView = self.actionsheetContentView;
            
        }
            break;
        case JKAlertStyleCollectionSheet:
        {
            sheetContentView = self.collectionsheetContentView;
        }
            
        default:
            break;
    }
    
    if (!sheetContentView) { return; }
    
    CGRect frame = sheetContentView.frame;
    frame.origin.y = JKAlertScreenH - frame.size.height;
    sheetContentView.frame = frame;
    
    if (sheetContentView.showScaleAnimated) {
        
        [UIView setAnimationCurve:(UIViewAnimationCurveEaseOut)];
        
        sheetContentView.transform = CGAffineTransformMakeScale(1, (sheetContentView.frame.size.height + JKAlertSheetSpringHeight) / sheetContentView.frame.size.height);
    }
}

- (JKAlertBaseSheetContentView *)checkSheetContentView {
    
    if ((JKAlertStyleActionSheet != self.alertStyle) &&
        (JKAlertStyleCollectionSheet != self.alertStyle)) {
        
        return nil;
    }
    
    if ([self.currentAlertContentView isKindOfClass:[JKAlertBaseSheetContentView class]]) {
        
        return (JKAlertBaseSheetContentView *)self.currentAlertContentView;
    }
    
    switch (self.alertStyle) {
        case JKAlertStyleActionSheet:
            
            return self.actionsheetContentView;
            
            break;
            
        case JKAlertStyleCollectionSheet:
            
            return self.collectionsheetContentView;
            
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (void (^)(void))showAnimationDidComplete {
    
    self.window.userInteractionEnabled = YES;
    
    !self.didShowHandler ? : self.didShowHandler(self);
    
    if (_plainContentView.autoShowKeyboard && self.currentTextField) {
        
        if (!self.currentTextField.hidden) {
            
            if (!self.currentTextField.isFirstResponder) {
                
                [self.currentTextField becomeFirstResponder];
            }
            
        } else {
            
            for (UITextField *tf in _textFieldArr) {
                
                if (tf.hidden) { continue; }
                
                if (!tf.isFirstResponder) {
                    
                    [tf becomeFirstResponder];
                }
                
                break;
            }
        }
    }
    
    if (self.dismissTimeInterval > 0 &&
        (JKAlertStyleHUD == self.alertStyle ||
         nil != self.customHUD)) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.dismissTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismiss];
        });
    }
    
    return ^{};
}

#pragma mark
#pragma mark - 监听键盘

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    
    if (JKAlertStylePlain != self.alertStyle) { return; }
    
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect frame = self.alertContentView.frame;
    
    NSNumber *curve = notification.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    
    NSInteger animationCurve = (curve ? [curve integerValue] : 7);
    
    if (keyboardFrame.origin.y >= JKAlertScreenH) { // 退出键盘
        
        JKAlertPlainViewMaxH = JKAlertScreenH - 100;
        
        [self calculateUI];
        
        [UIView animateWithDuration:0.25 animations:^{
            [UIView setAnimationCurve:animationCurve];
            
            [self layoutIfNeeded];
        }];
        
    } else { // 弹出键盘
        
        CGFloat maxH = JKAlertScreenH - (JKAlertIsDeviceX() ? 44 : 20) - keyboardFrame.size.height - 40;
        
        BOOL lockKeyboardMargin = (self.plainKeyboardMargin > 0);
        
        if ([self isLandScape]) {
            
            maxH = JKAlertScreenH - 5 - keyboardFrame.size.height - 5;
            
        } else if (lockKeyboardMargin) {
            
            maxH = maxH + 20 - self.plainKeyboardMargin;
        }
        
        if (frame.size.height <= maxH) {
            
            frame.origin.y = (JKAlertIsDeviceX() ? 44 : 20) + (maxH - frame.size.height) * 0.5;
            
            if (lockKeyboardMargin) {
                
                frame.origin.y = keyboardFrame.origin.y - self.plainKeyboardMargin - frame.size.height;
            }
            
            if ([self isLandScape]) {
                
                frame.origin.y = 5 + (maxH - frame.size.height) * 0.5;
            }
            
            [self updatePlainFrameY:frame.origin.y animated:YES];
            
            return;
        }
        
        JKAlertPlainViewMaxH = maxH;
        
        [self calculateUI];
        
        frame = self.alertContentView.frame;
        
        if ([self isLandScape]) {
            
            frame.origin.y = 5;
            
        } else if (lockKeyboardMargin) {
            
            frame.origin.y = keyboardFrame.origin.y - self.plainKeyboardMargin - frame.size.height;
            
            frame.origin.y = MAX(frame.origin.y, (JKAlertIsDeviceX() ? 44 : 20));
            
        } else {
            
            frame.origin.y = (JKAlertIsDeviceX() ? 44 : 20);
        }
        
        self.alertContentView.frame = frame;
        
        [UIView animateWithDuration:0.25 animations:^{
            [UIView setAnimationCurve:animationCurve];
            
            [self layoutIfNeeded];
        }];
    }
}

#pragma mark
#pragma mark - 退出

- (void)dismissButtonClick:(UIButton *)button {
    
    [JKAlertKeyWindow() endEditing:YES];
    
    !self.blankClickBlock ? : self.blankClickBlock();
    
    !self.tapBlankHandler ? : self.tapBlankHandler(self);
    
    if (_tapBlankDismiss) {
        
        self.dismiss();
        
        return;
    }
    
    JKAlertBaseSheetContentView *sheetContentView = [self checkSheetContentView];
    
    if (!sheetContentView) { return; }
    
    if (!sheetContentView.verticalGestureDismissEnabled &&
        !sheetContentView.horizontalGestureDismissEnabled) {
        
        return;
    }
    
    if ([sheetContentView.layer animationForKey:JKAlertDismissFailedShakeAnimationKey]) { return; }
    
    // 动画抖一下
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.repeatCount = 1;
    animation.values = @[@(-2), @(-4), @(-6), @(3), @0];
    animation.duration = 0.5;
    [sheetContentView.layer addAnimation:animation forKey:JKAlertDismissFailedShakeAnimationKey];
}

// 通过通知来dismiss
- (void)dismissAllNotification:(NSNotification *)note {
    
    if (self.isDismissAllNoneffective) { return; }
    
    self.dismiss();
}

// 通过key通知来dismiss
- (void)dismissForKeyNotification:(NSNotification *)note {
    
    if (!self.dismissKey) { return; }
    
    if ([note.object isKindOfClass:[NSString class]] &&
        [note.object isEqualToString:self.dismissKey]) {
        
        self.dismiss();
    }
}

// 通过category通知来dismiss
- (void)dismissForCategoryNotification:(NSNotification *)note {
    
    if (!self.dismissCategory) { return; }
    
    if ([note.object isKindOfClass:[NSString class]] &&
        [note.object isEqualToString:self.dismissCategory]) {
        
        self.dismiss();
    }
}

// 通过通知来dismiss
- (void)clearAllNotification:(NSNotification *)note {
    
    self.dismiss();
}

- (void (^)(void))dismiss {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self startDismissAnimation];
    
    return ^{};
}

- (void)startDismissAnimation {
    
    self.window.userInteractionEnabled = NO;
    
    // 即将消失
    !self.willDismissHandler ? : self.willDismissHandler();
    
    if (!self.isSheetDismissHorizontal || (self.alertStyle != JKAlertStyleActionSheet && self.alertStyle != JKAlertStyleCollectionSheet)) {
        
        // 自定义消失动画
        !self.customDismissAnimationBlock ? : self.customDismissAnimationBlock(self, self.alertContentView);
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backgroundView.alpha = 0;
        
        [self dismissAnimationOperation];
        
    } completion:^(BOOL finished) {
        
        if (self.customDismissAnimationBlock) { return; }
        
        self.dismissAnimationDidComplete();
    }];
}

- (void)dismissAnimationOperation {
    
    if (self.customDismissAnimationBlock) {
        
        if (self.isSheetDismissHorizontal) {
            
            // TODO: - JKTODO <#注释#>
            /*
             CGRect rect = _sheetContainerView.frame;
             rect.origin.x = JKAlertScreenW;
             _seetContainerView.frame = rect; */
        }
        
        return;
    }
    
    CGRect frame = self.currentAlertContentView.frame;
    
    if (self.isSheetDismissHorizontal) {
        
        frame.origin.x = JKAlertScreenW;
        
        self.currentAlertContentView.frame = frame;
        
        return;
    }
    
    switch (self.alertStyle) {
        case JKAlertStyleHUD:
        case JKAlertStylePlain:
        {
            self.alertContentView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            self.alertContentView.alpha = 0;
        }
            break;
        case JKAlertStyleActionSheet:
        case JKAlertStyleCollectionSheet:
        {
            frame.origin.y = JKAlertScreenH;
            self.currentAlertContentView.frame = frame;
        }
            break;
            
        default:
            break;
    }
}

- (void (^)(void))dismissAnimationDidComplete{
    
    self.window.userInteractionEnabled = YES;
    
    // 消失完成
    !self.didDismissHandler ? : self.didDismissHandler();
    
    [self.actions removeAllObjects];
    self.actions = nil;
    
    [self.actions2 removeAllObjects];
    self.actions2 = nil;
    
    [self removeFromSuperview];
    
    return ^{};
}

#pragma mark
#pragma mark - JKAlertBaseAlertContentViewDelegate

/// 执行action的handler操作
- (void)alertContentView:(JKAlertBaseAlertContentView *)alertContentView executeHandlerOfAction:(JKAlertAction *)action {
    
    if (action.autoDismiss && ![action isEmpty]) {
        
        self.isSheetDismissHorizontal = NO;
        
        [self dismiss];
    }
    
    !action.handler ? : action.handler(action);
}

/// 执行dismiss操作
- (void)alertContentViewExecuteDismiss:(JKAlertBaseAlertContentView *)alertContentView isHorizontal:(BOOL)isHorizontal {

    self.isSheetDismissHorizontal = isHorizontal;
    
    [self dismiss];
}

#pragma mark
#pragma mark - Override

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    [self solveDidMoveToSuperview];
}

#pragma mark
#pragma mark - Private Methods

- (void)addNotifications {
    
    // 屏幕旋转的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    // 移除全部的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissAllNotification:) name:JKAlertDismissAllNotification object:nil];
    
    // 根据key来移除的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissForKeyNotification:) name:JKAlertDismissForKeyNotification object:nil];
    
    // 根据category来移除的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissForCategoryNotification:) name:JKAlertDismissForCategoryNotification object:nil];
    
    // 清空全部的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearAllNotification:) name:JKAlertClearAllNotification object:nil];
}

- (void)addKeyboardWillChangeFrameNotification {
    
    // 键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)removeKeyboardWillChangeFrameNotification {
    
    // 键盘
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 */
- (void)initializeProperty {
    [super initializeProperty];
    
    if (@available(iOS 13.0, *)) {
        
        self.overrideUserInterfaceStyle = (UIUserInterfaceStyle)[JKAlertThemeManager sharedManager].themeStyle;
    }
    
    /** 屏幕宽度 */
    JKAlertScreenW = self.customSuperView.bounds.size.width;
    
    /** 屏幕高度 */
    JKAlertScreenH = self.customSuperView.bounds.size.height;
    
    _isLandScape = [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight;
    
    JKAlertPlainViewMaxH = (JKAlertScreenH - 100);
    
    JKAlertSheetMaxH = (JKAlertScreenH > JKAlertScreenW) ? JKAlertScreenH * 0.85 : JKAlertScreenH * 0.8;
    
    _deallocLogEnabled = NO;
    
    _dismissTimeInterval = 1;
    
    PlainViewWidth = 290;
    OriginalPlainWidth = PlainViewWidth;
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
    [self addNotifications];
}

/** 创建UI */
- (void)createUI {
    [super createUI];
    
}

/** 布局UI */
- (void)layoutUI {
    [super layoutUI];
    
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
}

#pragma mark
#pragma mark - Private Property

- (UIView *)customSuperView {
    
    if (!_customSuperView) {
        
        _customSuperView = JKAlertKeyWindow();
    }
    
    return _customSuperView;
}

- (UIView *)alertContentView {
    
    if (self.currentAlertContentView) {
        
        return self.currentAlertContentView;
    }
    
    UIView *alertContentView = nil;
    
    switch (self.alertStyle) {
        case JKAlertStylePlain:
        {
            alertContentView = self.plainContentView;
        }
            break;
        case JKAlertStyleActionSheet:
        {
            alertContentView = self.actionsheetContentView;
        }
            break;
        case JKAlertStyleCollectionSheet:
        {
            alertContentView = self.collectionsheetContentView;
        }
            break;
        case JKAlertStyleHUD:
        {
            alertContentView = self.hudContentView;
        }
            break;
            
        default:
            break;
    }
    
    return self.currentAlertContentView;
}

- (JKAlertPlainContentView *)plainContentView {
    if (!_plainContentView) {
        JKAlertPlainContentView *plainContentView = [[JKAlertPlainContentView alloc] init];
        plainContentView.delegate = self;
        // TODO: - JKTODO <#注释#>
        //plainContentView.alertView = self;
        [self addSubview:plainContentView];
        _plainContentView = plainContentView;
    }
    return _plainContentView;
}

- (JKAlertHUDContentView *)hudContentView {
    if (!_hudContentView) {
        JKAlertHUDContentView *hudContentView = [[JKAlertHUDContentView alloc] init];
        hudContentView.delegate = self;
        // TODO: - JKTODO <#注释#>
        //hudContentView.alertView = self;
        [self addSubview:hudContentView];
        _hudContentView = hudContentView;
    }
    return _hudContentView;
}

- (JKAlerActionSheetContentView *)actionsheetContentView {
    if (!_actionsheetContentView) {
        JKAlerActionSheetContentView *actionsheetContentView = [[JKAlerActionSheetContentView alloc] init];
        actionsheetContentView.delegate = self;
        // TODO: - JKTODO <#注释#>
        //actionsheetContentView.alertView = self;
        [self addSubview:actionsheetContentView];
        _actionsheetContentView = actionsheetContentView;
    }
    return _actionsheetContentView;
}

- (JKAlertCollectionSheetContentView *)collectionsheetContentView {
    if (!_collectionsheetContentView) {
        JKAlertCollectionSheetContentView *collectionsheetContentView = [[JKAlertCollectionSheetContentView alloc] init];
        collectionsheetContentView.delegate = self;
        // TODO: - JKTODO <#注释#>
        //collectionsheetContentView.alertView = self;
        [self addSubview:collectionsheetContentView];
        _collectionsheetContentView = collectionsheetContentView;
    }
    return _collectionsheetContentView;
}

- (NSMutableArray *)actions {
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    return _actions;
}

- (NSMutableArray *)actions2 {
    if (!_actions2) {
        _actions2 = [NSMutableArray array];
    }
    return _actions2;
}

- (NSMutableArray *)textFieldArr {
    if (!_textFieldArr) {
        _textFieldArr = [NSMutableArray array];
    }
    return _textFieldArr;
}

- (UIButton *)closeButton {
    
    if (_alertStyle != JKAlertStylePlain) { return nil; }
    
    if (!_closeButton) {
        
        UIButton *closeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [closeButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        closeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        closeButton.frame = CGRectMake(PlainViewWidth - 30, 5, 25, 25);
        [self.alertContentView addSubview:closeButton];
        
        [closeButton addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
        
        _closeButton = closeButton;
    }
    return _closeButton;
}

#pragma mark
#pragma mark - dealloc

- (void)dealloc {
    
    [self removeAllOberserver];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.deallocLogEnabled) {
        
        NSLog(@"[ClassName: %@], %d, %s", NSStringFromClass([self class]), __LINE__, __func__);
    }
    
    !self.deallocHandler ? : self.deallocHandler();
}
@end
