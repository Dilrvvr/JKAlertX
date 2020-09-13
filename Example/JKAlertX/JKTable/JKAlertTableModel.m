//
//  JKAlertTableModel.m
//  JKAlertX_Example
//
//  Created by albert on 2020/9/13.
//  Copyright © 2020 jkayb123cool@gmail.com. All rights reserved.
//

#import "JKAlertTableModel.h"
#import "JKAlertTableGroupModel.h"

@implementation JKAlertTableModel

+ (JKAlertTableModel *)modelWithTitle:(NSString *)title
                                group:(JKAlertTableGroupModel *)group
                       executeHandler:(void (^)(JKAlertTableModel *model))executeHandler {
    
    JKAlertTableModel *model = [JKAlertTableModel new];
    
    model.title = title;
    model.executeHandler = executeHandler;
    
    [group.sectionArray addObject:model];
    
    return model;
}
@end
