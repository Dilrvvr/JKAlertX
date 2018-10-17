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
@end
