//
//  JKAlertTableModel.h
//  JKAlertX_Example
//
//  Created by albert on 2020/9/13.
//  Copyright © 2020 jkayb123cool@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JKAlertTableGroupModel;

@interface JKAlertTableModel : NSObject

/** title */
@property (nonatomic, copy) NSString *title;

/** executeHandler */
@property (nonatomic, copy) void (^executeHandler)(JKAlertTableModel *model);

/** refreshHandler */
@property (nonatomic, copy) void (^refreshHandler)(JKAlertTableModel *model);

+ (JKAlertTableModel *)modelWithTitle:(NSString *)title
                                group:(JKAlertTableGroupModel *)group
                       executeHandler:(void (^)(JKAlertTableModel *model))executeHandler;
@end
