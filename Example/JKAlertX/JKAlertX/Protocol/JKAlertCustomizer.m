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
        _common.setDeallocLogEnabled(self.deallocLogEnabled);
    }
    return _common;
}

- (JKAlertCustomizerPlain *)plain{
    if (!_plain) {
        _plain = [[JKAlertCustomizerPlain alloc] init];
        _plain.setAlertView(self.alertView);
        _plain.setDeallocLogEnabled(self.deallocLogEnabled);
    }
    return _plain;
}

- (JKAlertCustomizerHUD *)HUD{
    if (!_HUD) {
        _HUD = [[JKAlertCustomizerHUD alloc] init];
        _HUD.setAlertView(self.alertView);
        _HUD.setDeallocLogEnabled(self.deallocLogEnabled);
    }
    return _HUD;
}

- (JKAlertCustomizerActionSheet *)actionSheet{
    if (!_actionSheet) {
        _actionSheet = [[JKAlertCustomizerActionSheet alloc] init];
        _actionSheet.setAlertView(self.alertView);
        _actionSheet.setDeallocLogEnabled(self.deallocLogEnabled);
    }
    return _actionSheet;
}

- (JKAlertCustomizerCollectionSheet *)collectionSheet{
    if (!_collectionSheet) {
        _collectionSheet = [[JKAlertCustomizerCollectionSheet alloc] init];
        _collectionSheet.setAlertView(self.alertView);
        _collectionSheet.setDeallocLogEnabled(self.deallocLogEnabled);
    }
    return _collectionSheet;
}

- (JKAlertBaseCustomizer *(^)(BOOL enabled))setDeallocLogEnabled{
    
    return ^(BOOL enabled){
        
        [super setDeallocLogEnabled](enabled);
        
        if (self->_common) { self->_common.setDeallocLogEnabled(enabled); }
        if (self->_plain) { self->_plain.setDeallocLogEnabled(enabled); }
        if (self->_HUD) { self->_HUD.setDeallocLogEnabled(enabled); }
        if (self->_actionSheet) { self->_actionSheet.setDeallocLogEnabled(enabled); }
        if (self->_collectionSheet) { self->_collectionSheet.setDeallocLogEnabled(enabled); }
        
        return self;
    };
}

- (void)dealloc{
    
    if (!self.deallocLogEnabled) { return; }
    
    NSLog(@"%d, %s", __LINE__, __func__);
}
@end
