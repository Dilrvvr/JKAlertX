//
//  JKAlertTableActionView.m
//  JKAlertX
//
//  Created by Albert on 2020/5/10.
//  Copyright © 2020 Albert. All rights reserved.
//

#import "JKAlertTableActionView.h"

@interface JKAlertTableActionView ()

@end

@implementation JKAlertTableActionView

#pragma mark
#pragma mark - Public Methods

#pragma mark
#pragma mark - Override

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    
    CGFloat imageWH = 0;
    
    CGFloat titleImageInset = 0;
    
    if (self.iconImageView.highlighted &&
        self.iconImageView.highlightedImage) {
        
        imageWH = 30;
        
        titleImageInset = 5;
        
    } else if (self.iconImageView.image) {
        
        imageWH = 30;
        
        titleImageInset = 5;
    }
    
    CGFloat titleLabelWidth = MIN(self.contentView.frame.size.width - imageWH - titleImageInset, self.titleLabel.frame.size.width);
    
    self.titleLabel.frame = CGRectMake((self.contentView.frame.size.width - titleLabelWidth + imageWH + titleImageInset) * 0.5, 0, titleLabelWidth, self.contentView.frame.size.height);
    
    if (!self.iconImageView.hidden) {

        self.iconImageView.frame = CGRectMake(self.titleLabel.frame.origin.x - titleImageInset - imageWH, (self.titleLabel.frame.size.height - imageWH) * 0.5, imageWH, imageWH);
    }
}

#pragma mark
#pragma mark - Private Methods



#pragma mark
#pragma mark - Private Selector



#pragma mark
#pragma mark - Custom Delegates



#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 */
- (void)initializeProperty {
    [super initializeProperty];
    
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
}

/** 创建UI */
- (void)createUI {
    [super createUI];
    
}

/** 布局UI */
- (void)layoutUI {
    [super layoutUI];
    
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
}

#pragma mark
#pragma mark - Private Property





@end
