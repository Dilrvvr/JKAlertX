//
//  JKAlertPiercedTableViewCell.m
//  JKAlertX
//
//  Created by albert on 2020/5/5.
//  Copyright © 2020 安永博. All rights reserved.
//

#import "JKAlertPiercedTableViewCell.h"

@implementation JKAlertPiercedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    
    if (@available(iOS 11.0, *)) {
        
        safeAreaInsets = self.alertSuperView.safeAreaInsets;
    }
    
    self.contentView.frame = self.bounds;
    
    self.selectedBackgroundView.frame = self.contentView.frame;
    
    self.titleButton.frame = self.contentView.bounds;
    
    self.customView.frame = self.contentView.bounds;
}

- (void)setAction:(JKAlertAction *)action{
    [super setAction:action];
    
    self.contentView.backgroundColor = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
