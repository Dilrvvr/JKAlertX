//
//  JKAlertBaseCustomizer.m
//  JKAlertX
//
//  Created by albert on 2018/10/17.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "JKAlertBaseCustomizer.h"
#import "JKAlertView.h"
#import "JKAlertCustomizer.h"

@interface JKAlertBaseCustomizer ()

@end

@implementation JKAlertBaseCustomizer

- (instancetype)initWithCustomizer:(JKAlertCustomizer *)customizer{
    
    if (![customizer isKindOfClass:[customizer class]]) { return nil; }
    
    if (![customizer.alertView isKindOfClass:[JKAlertView class]]) { return nil; }
    
    if (self = [super init]) {
        _customizer = customizer;
    }
    return self;
}

/** 函数式类方法
+ (__kindof JKAlertBaseCustomizer *(^)(JKAlertView *alertView))customizer{
    
    return ^(JKAlertView *alertView){
        
        return [[self alloc] initWithAlertView:alertView];
    };
} //*/

- (JKAlertCustomizerCommon *)common{
    
    return self.customizer.common;
}

- (JKAlertCustomizerPlain *)plain{
    
    return self.customizer.plain;
}

- (JKAlertCustomizerHUD *)HUD{
    
    return self.customizer.HUD;
}

- (JKAlertCustomizerActionSheet *)actionSheet{
    
    return self.customizer.actionSheet;
}

- (JKAlertCustomizerCollectionSheet *)collectionSheet{
    
    return self.customizer.collectionSheet;
}

- (JKAlertView *)alertView{
    
    return self.customizer.alertView;
}
@end
