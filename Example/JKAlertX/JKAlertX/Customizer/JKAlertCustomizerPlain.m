//
//  JKAlertCustomizerPlain.m
//  JKAlertX
//
//  Created by albert on 2018/10/17.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "JKAlertCustomizerPlain.h"
#import "JKAlertCustomizer.h"

@implementation JKAlertCustomizerPlain

- (instancetype)initWithCustomizer:(JKAlertCustomizer *)customizer{
    if (self = [super initWithCustomizer:customizer]) {
        [self initialization];
    }
    return self;
}

- (void)initialization{
}
@end
