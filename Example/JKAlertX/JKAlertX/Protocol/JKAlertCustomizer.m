//
//  JKAlertCustomizer.m
//  JKAlertX
//
//  Created by albert on 2018/10/17.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "JKAlertCustomizer.h"

@interface JKAlertCustomizer ()
{
    /** 通用 */
    JKAlertCustomizerCommon *_common;
    
    /** plain */
    JKAlertCustomizerPlain *_plain;
    
    /** HUD */
    JKAlertCustomizerHUD *_HUD;
    
    /** actionSheet */
    JKAlertCustomizerActionSheet *_actionSheet;
    
    /** collectionSheet */
    JKAlertCustomizerCollectionSheet *_collectionSheet;
}
@end

@implementation JKAlertCustomizer

- (JKAlertCustomizerCommon *)common{
    if (!_common) {
        _common = [[JKAlertCustomizerCommon alloc] init];
        _common.setAlertView(self.alertView);
    }
    return _common;
}

- (JKAlertCustomizerPlain *)plain{
    if (!_plain) {
        _plain = [[JKAlertCustomizerPlain alloc] init];
        _plain.setAlertView(self.alertView);
    }
    return _plain;
}

- (JKAlertCustomizerHUD *)HUD{
    if (!_HUD) {
        _HUD = [[JKAlertCustomizerHUD alloc] init];
        _HUD.setAlertView(self.alertView);
    }
    return _HUD;
}

- (JKAlertCustomizerActionSheet *)actionSheet{
    if (!_actionSheet) {
        _actionSheet = [[JKAlertCustomizerActionSheet alloc] init];
        _actionSheet.setAlertView(self.alertView);
    }
    return _actionSheet;
}

- (JKAlertCustomizerCollectionSheet *)collectionSheet{
    if (!_collectionSheet) {
        _collectionSheet = [[JKAlertCustomizerCollectionSheet alloc] init];
        _collectionSheet.setAlertView(self.alertView);
    }
    return _collectionSheet;
}
@end
