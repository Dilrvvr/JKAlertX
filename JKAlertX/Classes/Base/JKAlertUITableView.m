//
//  JKAlertUITableView.m
//  JKAlertX
//
//  Created by yb.an on 2021/4/14.
//

#import "JKAlertUITableView.h"

@implementation JKAlertUITableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self jkalert_initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self jkalert_initialization];
    }
    return self;
}

- (void)jkalert_initialization {
    
    self.rowHeight = 44.0;
    self.sectionFooterHeight = 0.0;
    self.sectionHeaderHeight = 0.0;
    
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1.0, CGFLOAT_MIN)];
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1.0, CGFLOAT_MIN)];
    
    if (@available(iOS 11.0, *)) {
        
        self.estimatedRowHeight = 0.0;
        self.estimatedSectionHeaderHeight = 0.0;
        self.estimatedSectionFooterHeight = 0.0;
        
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    if (@available(iOS 13.0, *)) {
        
        self.automaticallyAdjustsScrollIndicatorInsets = NO;
    }
}
@end
