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

/** titleLabelHeightCons */
@property (nonatomic, strong) NSLayoutConstraint *titleLabelHeightCons;
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
//        NSArray *labelCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[label]-15-|" options:0 metrics:nil views:@{@"label" : label}];
//        [self addConstraints:labelCons1];
        
//        NSArray *labelCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|" options:0 metrics:nil views:@{@"label" : label}];
//        [self addConstraints:labelCons2];
        
        NSLayoutConstraint *consLeft = [NSLayoutConstraint constraintWithItem:label attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeLeft) multiplier:1 constant:0];
        [self addConstraint:consLeft];
        
        NSLayoutConstraint *consRight = [NSLayoutConstraint constraintWithItem:label attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeRight) multiplier:1 constant:0];
        [self addConstraint:consRight];
        
        NSLayoutConstraint *consTop = [NSLayoutConstraint constraintWithItem:label attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeTop) multiplier:1 constant:0];
        [self addConstraint:consTop];
        
        _titleLabelHeightCons = [NSLayoutConstraint constraintWithItem:label attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1 constant:0];
        [self addConstraint:_titleLabelHeightCons];
        
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
    
    _titleLabel.hidden = NO;
    
    self.customView.hidden = YES;
    self.customView = _action.customView;
    
    if (_action.customView != nil) {
        
        _titleLabel.hidden = YES;
        self.customView.hidden = NO;
        
        return;
    }
    
    if (_action.titleColor == nil) {
        
        switch (_action.alertActionStyle) {
            case JKAlertActionStyleDefault:
                
                _action.setTitleColor([UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]);
                break;
                
            case JKAlertActionStyleCancel:
                
                _action.setTitleColor([UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1]);
                break;
                
            case JKAlertActionStyleDestructive:
                
                _action.setTitleColor([UIColor redColor]);
                break;
                
            default:
                break;
        }
    }
    
    if (_action.titleFont == nil) {
        
        _action.setTitleFont([UIFont systemFontOfSize:17]);
    }
    
    self.titleLabel.font = _action.titleFont;
    
    self.titleLabel.textColor = _action.titleColor;
    
    self.titleLabel.attributedText = _action.attributedTitle;
    
    self.titleLabel.text = _action.title;
    
    _titleLabelHeightCons.constant = _action.rowHeight;
}

- (void)setCustomView:(UIView *)customView{
    _customView = customView;
    
    if (_customView == nil) { return; }
    
    [self.contentView insertSubview:customView atIndex:0];
    
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
