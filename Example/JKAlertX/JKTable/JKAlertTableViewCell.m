//
//  JKAlertTableViewCell.m
//  JKAlertX_Example
//
//  Created by albert on 2020/9/13.
//  Copyright © 2020 jkayb123cool@gmail.com. All rights reserved.
//

#import "JKAlertTableViewCell.h"
#import "JKAlertTableModel.h"

@interface JKAlertTableViewCell ()

@end

@implementation JKAlertTableViewCell

#pragma mark
#pragma mark - Public Methods

- (void)setModel:(JKAlertTableModel *)model {
    _model = model;
    
    [self updateModel:model];
    
    __weak typeof(self) weakSelf = self;
    [model setRefreshHandler:^(JKAlertTableModel *model) {
        
        if (model == weakSelf.model) {
            
            [weakSelf updateModel:model];
        }
    }];
}

- (void)updateModel:(JKAlertTableModel *)model {
    
    self.textLabel.text = model.title;
    //self.detailTextLabel.text = model.title;
}

#pragma mark
#pragma mark - Override

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        
        [self initialization];
    }
    return self;
}

#pragma mark
#pragma mark - Private Methods



#pragma mark
#pragma mark - Private Selector



#pragma mark
#pragma mark - Custom Delegates



#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 交给子类重写 super自动调用该方法 */
- (void)initializeProperty {
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    
    [self initializeProperty];
    [self createUI];
    [self layoutUI];
    [self initializeUIData];
}

/** 创建UI 交给子类重写 super自动调用该方法 */
- (void)createUI {
    
}

/** 布局UI 交给子类重写 super自动调用该方法 */
- (void)layoutUI {
    
}

/** 初始化UI数据 交给子类重写 super自动调用该方法 */
- (void)initializeUIData {
    
}

#pragma mark
#pragma mark - Private Property



@end
