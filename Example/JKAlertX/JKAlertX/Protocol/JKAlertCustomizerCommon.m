//
//  JKAlertCustomizerCommon.m
//  JKAlertX
//
//  Created by albert on 2018/10/17.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "JKAlertCustomizerCommon.h"

@interface JKAlertCustomizerCommon ()

@end

@implementation JKAlertCustomizerCommon

- (instancetype)init{
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}

- (void)initialization{
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.clipsToBounds = YES;
    _backgroundView = toolbar;
}

/**
 * 设置自定义的父控件
 * 默认添加到keywindow上
 * customSuperView在show之前有效
 * customSuperViewsize最好和屏幕大小一致，否则可能出现问题
 */
- (JKAlertCustomizerCommon *(^)(UIView *customSuperView))setCustomSuperView{
    
    return ^(UIView *customSuperView){
        
        self->_customSuperView = customSuperView;
        
        return self;
    };
}




/**
 * 设置背景view
 * 默认是一个UIToolbar
 */
- (JKAlertCustomizerCommon *(^)(UIView *(^backgroundViewBlock)(void)))setBackgroundView{
    
    return ^(UIView *(^backgroundViewBlock)(void)){
        
        [self->_backgroundView removeFromSuperview];
        
        self->_backgroundView = nil;
        
        self->_backgroundView = !backgroundViewBlock ? nil : backgroundViewBlock();
        
        return self;
    };
}




/**
  * 设置全屏背景view 默认nil
  */
- (JKAlertCustomizerCommon *(^)(UIView *(^backgroundViewBlock)(void)))setFullScreenBackgroundView{
    
    return ^(UIView *(^backgroundViewBlock)(void)){
        
        [self->_fullScreenBackgroundView removeFromSuperview];
        
        self->_fullScreenBackgroundView = nil;
        
        self->_fullScreenBackgroundView = !backgroundViewBlock ? nil : backgroundViewBlock();
        
        return self;
    };
}

- (void)dealloc{
    
    if (!self.deallocLogEnabled) { return; }
    
    NSLog(@"%d, %s", __LINE__, __func__);
}
@end
