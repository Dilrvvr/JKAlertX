//
//  JKAlertActionView.m
//  JKAlertX
//
//  Created by albertcc on 2020/5/10.
//  Copyright © 2020 安永博. All rights reserved.
//

#import "JKAlertActionView.h"
#import "JKAlertAction.h"

@interface JKAlertActionView ()

@end

@implementation JKAlertActionView

#pragma mark
#pragma mark - Public Methods

- (void)setAction:(JKAlertAction *)action {
    _action = action;
    
    self.titleLabel.text = nil;
    
    self.titleLabel.attributedText = nil;
    
    self.titleLabel.font = action.titleFont;
    self.titleLabel.textColor = action.titleColor;
    
    if (action.attributedTitle) {
        
        self.titleLabel.attributedText = action.attributedTitle;
        
    } else if (action.title) {
        
        self.titleLabel.text = action.title;
    }
    
    [self setNeedsLayout];
}

#pragma mark
#pragma mark - Override

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}

#pragma mark
#pragma mark - Private Methods



#pragma mark
#pragma mark - Private Selector



#pragma mark
#pragma mark - UITableViewDataSource & UITableViewDelegate



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
