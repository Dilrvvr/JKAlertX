//
//  JKAlertTableViewCell.m
//  TestVideoAndPicture
//
//  Created by albert on 2017/4/19.
//  Copyright © 2017年 安永博. All rights reserved.
//

#import "JKAlertTableViewCell.h"
#import "JKAlertAction.h"

@interface JKAlertTableViewCell ()

/** titleLabel */
@property (nonatomic, weak) UILabel *titleLabel;

/** 底部分隔线 */
@property (nonatomic, weak) UIView *bottomLineView;

/** 自定义view */
@property (nonatomic, weak) UIView *customView;
@end

@implementation JKAlertTableViewCell

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:17];
        label.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self.contentView insertSubview:label atIndex:0];
        
        label.translatesAutoresizingMaskIntoConstraints = NO;
        NSArray *labelCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[label]-15-|" options:0 metrics:nil views:@{@"label" : label}];
        [self addConstraints:labelCons1];
        
        NSArray *labelCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|" options:0 metrics:nil views:@{@"label" : label}];
        [self addConstraints:labelCons2];
        
        _titleLabel = label;
    }
    return _titleLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialization];
    }
    return self;
}

- (void)initialization{
    
    self.backgroundColor = nil;//[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:0.7];
    self.contentView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:0.7];//nil;//self.backgroundColor;
    
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [self.contentView addSubview:bottomLineView];
    self.bottomLineView = bottomLineView;
    
    bottomLineView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *bottomLineViewCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bottomLineView]-0-|" options:0 metrics:nil views:@{@"bottomLineView" : bottomLineView}];
    [self addConstraints:bottomLineViewCons1];
    
    NSArray *bottomLineViewCons2 = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[bottomLineView(0.5)]-0-|"] options:0 metrics:nil views:@{@"bottomLineView" : bottomLineView}];
    [self addConstraints:bottomLineViewCons2];
}

- (void)setAction:(JKAlertAction *)action{
    _action = action;
    
    self.selectionStyle = _action.isEmpty ? UITableViewCellSelectionStyleNone : UITableViewCellSelectionStyleDefault;
    self.bottomLineView.hidden = _action.separatorLineHidden;
    
    _titleLabel.hidden = action.customView;
    
    if (action.customView) {
        
        self.customView = action.customView;
        
        _customView.hidden = NO;
        
        return;
    }
    
    _customView.hidden = YES;
    
    self.titleLabel.textColor = (action.alertActionStyle == JKAlertActionStyleDefault) ? [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] : [UIColor redColor];
    
    self.titleLabel.attributedText = action.attributeTitle;
    
    self.titleLabel.text = action.title;
}

- (void)setCustomView:(UIView *)customView{
    
    if (_customView == customView) { return; }
    
    [_customView removeFromSuperview];
    
    _customView = customView;
    
    [self.contentView insertSubview:_customView atIndex:0];
    
    customView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *customViewCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[customView]-0-|" options:0 metrics:nil views:@{@"customView" : customView}];
    [self addConstraints:customViewCons1];
    
    NSArray *customViewCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[customView]-0-|" options:0 metrics:nil views:@{@"customView" : customView}];
    [self addConstraints:customViewCons2];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.selectedBackgroundView.frame = self.contentView.frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
