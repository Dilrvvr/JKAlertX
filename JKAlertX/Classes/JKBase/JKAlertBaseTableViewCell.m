//
//  JKAlertBaseTableViewCell.m
//  JKAlertX
//
//  Created by albert on 2020/5/5.
//  Copyright © 2020 安永博. All rights reserved.
//

#import "JKAlertBaseTableViewCell.h"
#import "JKAlertTableActionView.h"
#import "JKAlertAction.h"
#import "JKAlertConst.h"

@interface JKAlertBaseTableViewCell ()

@end

@implementation JKAlertBaseTableViewCell

#pragma mark
#pragma mark - 初始化

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initialization];
    }
    return self;
}

/** 初始化自身属性 交给子类重写 super自动调用该方法 */
- (void)initializeProperty{
    
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization{
    
    [self initializeProperty];
    [self createUI];
    [self layoutUI];
    [self initializeUIData];
}

/** 创建UI 交给子类重写 super自动调用该方法 */
- (void)createUI{
    
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = nil;
    
    JKAlertTableActionView *actionView = [[JKAlertTableActionView alloc] init];
    [self.contentView addSubview:actionView];
    _actionView = actionView;
    
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = JKAlertAdaptColor([[UIColor blackColor] colorWithAlphaComponent:0.2], [[UIColor whiteColor] colorWithAlphaComponent:0.2]);
    [self.contentView addSubview:bottomLineView];
    _bottomLineView = bottomLineView;
}

/** 布局UI 交给子类重写 super自动调用该方法 */
- (void)layoutUI{
    
    self.bottomLineView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *bottomLineViewCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bottomLineView]-0-|" options:0 metrics:nil views:@{@"bottomLineView" : self.bottomLineView}];
    [self.contentView addConstraints:bottomLineViewCons1];
    
    NSArray *bottomLineViewCons2 = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[bottomLineView(0.5)]-0-|"] options:0 metrics:nil views:@{@"bottomLineView" : self.bottomLineView}];
    [self addConstraints:bottomLineViewCons2];
    
    self.actionView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *actionViewCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[actionView]-0-|" options:0 metrics:nil views:@{@"actionView" : self.actionView}];
    [self.contentView addConstraints:actionViewCons1];
    
    NSArray *actionViewCons2 = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[actionView]-0-|"] options:0 metrics:nil views:@{@"actionView" : self.actionView}];
    [self.contentView addConstraints:actionViewCons2];
}

/** 初始化UI数据 交给子类重写 super自动调用该方法 */
- (void)initializeUIData{
    
    self.backgroundView = nil;
    self.backgroundColor = nil;
    self.contentView.backgroundColor = nil;
}

#pragma mark
#pragma mark - Override

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    
    [self.actionView setHighlighted:highlighted];
    
    self.bottomLineView.backgroundColor = JKAlertAdaptColor([[UIColor blackColor] colorWithAlphaComponent:0.2], [[UIColor whiteColor] colorWithAlphaComponent:0.2]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.bottomLineView.backgroundColor = JKAlertAdaptColor([[UIColor blackColor] colorWithAlphaComponent:0.2], [[UIColor whiteColor] colorWithAlphaComponent:0.2]);
}

#pragma mark
#pragma mark - 点击事件


#pragma mark
#pragma mark - 赋值

- (void)setAction:(JKAlertAction *)action{
    _action = action;
    
    self.actionView.action = action;
    
    self.bottomLineView.hidden = action.separatorLineHidden;
}

#pragma mark
#pragma mark - Property



@end
