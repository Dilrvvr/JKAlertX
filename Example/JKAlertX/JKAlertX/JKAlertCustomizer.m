//
//  JKAlertCustomizer.m
//  JKAlertX
//
//  Created by albert on 2018/10/17.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "JKAlertCustomizer.h"
#import "JKAlertView.h"

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

- (instancetype)initWithAlertView:(JKAlertView *)alertView{
    
    if (![alertView isKindOfClass:[JKAlertView class]]) { return nil; }
    
    if (self = [super init]) {
        _alertView = alertView;
    }
    return self;
}

- (JKAlertCustomizerCommon *)common{
    if (!_common) {
        _common = [[JKAlertCustomizerCommon alloc] initWithCustomizer:self];
    }
    return _common;
}

- (JKAlertCustomizerPlain *)plain{
    if (!_plain) {
        _plain = [[JKAlertCustomizerPlain alloc] initWithCustomizer:self];
    }
    return _plain;
}

- (JKAlertCustomizerHUD *)HUD{
    if (!_HUD) {
        _HUD = [[JKAlertCustomizerHUD alloc] initWithCustomizer:self];
    }
    return _HUD;
}

- (JKAlertCustomizerActionSheet *)actionSheet{
    if (!_actionSheet) {
        _actionSheet = [[JKAlertCustomizerActionSheet alloc] initWithCustomizer:self];
    }
    return _actionSheet;
}

- (JKAlertCustomizerCollectionSheet *)collectionSheet{
    if (!_collectionSheet) {
        _collectionSheet = [[JKAlertCustomizerCollectionSheet alloc] initWithCustomizer:self];
    }
    return _collectionSheet;
}

- (void)dealloc{
    
    _plain = nil;
    _HUD = nil;
    _actionSheet = nil;
    _collectionSheet = nil;
    
    if (self.common.deallocLogEnabled) {
        
        NSLog(@"%d, %s", __LINE__, __func__);
    }
    
    _common = nil;
}
@end
