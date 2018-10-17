//
//  JKAlertBaseCustomizer.m
//  JKAlertX
//
//  Created by albert on 2018/10/17.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "JKAlertBaseCustomizer.h"
#import "JKAlertView.h"

@interface JKAlertBaseCustomizer ()
{
    /** 是否允许dealloc打印，用于检查循环引用 */
    BOOL _deallocLogEnabled;
}
@end

@implementation JKAlertBaseCustomizer

/** 设置alerView */
- (void(^)(JKAlertView *alertView))setAlertView{
    
    return ^(JKAlertView *alertView){
        
        if (![alertView isKindOfClass:[JKAlertView class]]) { return; }
        
        self->_alertView = alertView;
    };
}

/** 设置是否允许dealloc打印，用于检查循环引用 */
- (JKAlertBaseCustomizer *(^)(BOOL enabled))setDeallocLogEnabled{
    
    return ^(BOOL enabled){
        
        self->_deallocLogEnabled = enabled;
        
        return self;
    };
}

//- (void)dealloc{
//    
//    if (!_deallocLogEnabled) { return; }
//    
//    NSLog(@"%d, %s", __LINE__, __func__);
//}
@end
