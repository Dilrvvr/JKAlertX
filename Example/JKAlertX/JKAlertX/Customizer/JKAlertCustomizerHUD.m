//
//  JKAlertCustomizerHUD.m
//  JKAlertX
//
//  Created by albert on 2018/10/17.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "JKAlertCustomizerHUD.h"
#import "JKAlertCustomizer.h"

@implementation JKAlertCustomizerHUD

- (instancetype)initWithCustomizer:(JKAlertCustomizer *)customizer{
    if (self = [super initWithCustomizer:customizer]) {
        [self initialization];
    }
    return self;
}

- (void)initialization{
    
    _dismissInterval = 1;
    
    _HUDHeight = -1;
}




/**
 * 设置HUD样式dismiss的时间，默认1s
 * 小于等于0表示不自动隐藏
 */
- (JKAlertCustomizerHUD *(^)(CGFloat dismissInterval))setDismissInterval{
    
    return ^(CGFloat dismissInterval){
        
        self->_dismissInterval = dismissInterval;
        
        return self;
    };
}




/**
 * 设置HUD样式高度，不包含customHUD
 * 小于0将没有效果，默认-1
 */
- (JKAlertCustomizerHUD *(^)(CGFloat height))setHUDHeight{
    
    return ^(CGFloat height){
        
        self->_HUDHeight = height;
        
        return self;
    };
}
@end
