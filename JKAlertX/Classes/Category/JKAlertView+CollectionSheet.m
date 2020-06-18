//
//  JKAlertView+CollectionSheet.m
//  JKAlertX
//
//  Created by albert on 2020/6/8.
//

#import "JKAlertView+CollectionSheet.h"
#import "JKAlertView+Public.h"
#import "JKAlertView+PrivateProperty.h"

@implementation JKAlertView (CollectionSheet)
























/// 不是collectionSheet样式将不执行handler
- (JKAlertView *)checkCollectionSheetStyleHandler:(void(^)(void))handler {
    
    return [self checkAlertStyle:JKAlertStyleCollectionSheet handler:handler];
}
@end
