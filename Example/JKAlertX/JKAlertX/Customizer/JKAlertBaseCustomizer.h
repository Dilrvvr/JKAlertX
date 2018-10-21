//
//  JKAlertBaseCustomizer.h
//  JKAlertX
//
//  Created by albert on 2018/10/17.
//  Copyright © 2018 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JKAlertView, JKAlertCustomizer, JKAlertCustomizerCommon, JKAlertCustomizerPlain, JKAlertCustomizerHUD, JKAlertCustomizerActionSheet, JKAlertCustomizerCollectionSheet;

@interface JKAlertBaseCustomizer : NSObject

/** alertView */
@property (nonatomic, weak, readonly) JKAlertView *alertView;

/** 通用 */
@property (nonatomic, weak, readonly) JKAlertCustomizerCommon *common;

/** plain */
@property (nonatomic, weak, readonly) JKAlertCustomizerPlain *plain;

/** HUD */
@property (nonatomic, weak, readonly) JKAlertCustomizerHUD *HUD;

/** actionSheet */
@property (nonatomic, weak, readonly) JKAlertCustomizerActionSheet *actionSheet;

/** collectionSheet */
@property (nonatomic, weak, readonly) JKAlertCustomizerCollectionSheet *collectionSheet;




/** customizer */
@property (nonatomic, weak, readonly) JKAlertCustomizer *customizer;


/** 实例化 */
- (instancetype)initWithCustomizer:(JKAlertCustomizer *)customizer;
@end
