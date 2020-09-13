//
//  JKAlertTableGroupModel.h
//  JKAlertX_Example
//
//  Created by albert on 2020/9/13.
//  Copyright © 2020 jkayb123cool@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKAlertTableGroupModel : NSObject

/** title */
@property (nonatomic, copy) NSString *title;

+ (JKAlertTableGroupModel *)groupWithTitle:(NSString *)title
                             configuration:(void (^)(JKAlertTableGroupModel *group))configuration;

/** sectionArray */
@property (nonatomic, strong, readonly) NSMutableArray *sectionArray;
@end
