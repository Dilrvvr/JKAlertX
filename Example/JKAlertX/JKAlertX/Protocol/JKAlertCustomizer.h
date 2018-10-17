//
//  JKAlertCustomizer.h
//  JKAlertX
//
//  Created by albert on 2018/10/17.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "JKAlertBaseCustomizer.h"

#import "JKAlertCustomizerCommon.h"
#import "JKAlertCustomizerPlain.h"
#import "JKAlertCustomizerHUD.h"
#import "JKAlertCustomizerActionSheet.h"
#import "JKAlertCustomizerCollectionSheet.h"

@interface JKAlertCustomizer : JKAlertBaseCustomizer

/** 通用 */
@property (nonatomic, strong, readonly) JKAlertCustomizerCommon *common;

/** plain */
@property (nonatomic, strong, readonly) JKAlertCustomizerPlain *plain;

/** HUD */
@property (nonatomic, strong, readonly) JKAlertCustomizerHUD *HUD;

/** actionSheet */
@property (nonatomic, strong, readonly) JKAlertCustomizerActionSheet *actionSheet;

/** collectionSheet */
@property (nonatomic, strong, readonly) JKAlertCustomizerCollectionSheet *collectionSheet;
@end
