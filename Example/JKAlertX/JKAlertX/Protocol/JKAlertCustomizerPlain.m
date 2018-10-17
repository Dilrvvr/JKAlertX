//
//  JKAlertCustomizerPlain.m
//  JKAlertX
//
//  Created by albert on 2018/10/17.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "JKAlertCustomizerPlain.h"

@implementation JKAlertCustomizerPlain


- (void)dealloc{
    
    if (!self.deallocLogEnabled) { return; }
    
    NSLog(@"%d, %s", __LINE__, __func__);
}
@end
