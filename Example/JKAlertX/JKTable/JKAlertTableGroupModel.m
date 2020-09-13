//
//  JKAlertTableGroupModel.m
//  JKAlertX_Example
//
//  Created by albert on 2020/9/13.
//  Copyright © 2020 jkayb123cool@gmail.com. All rights reserved.
//

#import "JKAlertTableGroupModel.h"

@interface JKAlertTableGroupModel ()

{
    NSMutableArray *_sectionArray;
}
@end

@implementation JKAlertTableGroupModel

+ (JKAlertTableGroupModel *)groupWithTitle:(NSString *)title
                             configuration:(void (^)(JKAlertTableGroupModel *group))configuration {
    
    JKAlertTableGroupModel *group = [JKAlertTableGroupModel new];
    
    group.title = title;
    
    !configuration ? : configuration(group);
    
    return group;
}

- (NSMutableArray *)sectionArray {
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}
@end
