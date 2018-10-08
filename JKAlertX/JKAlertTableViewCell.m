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

/** titleButton */
@property (nonatomic, weak) UIButton *titleButton;

/** 底部分隔线 */
@property (nonatomic, weak) UIView *bottomLineView;

/** 自定义view */
@property (nonatomic, weak) UIView *customView;

/** titleButtonHeightCons */
@property (nonatomic, strong) NSLayoutConstraint *titleButtonHeightCons;
@end

@implementation JKAlertTableViewCell

- (UIButton *)titleButton{
    if (!_titleButton) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.userInteractionEnabled = NO;
        
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self.contentView insertSubview:button atIndex:0];
        
        button.translatesAutoresizingMaskIntoConstraints = NO;
        //        NSArray *labelCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[label]-15-|" options:0 metrics:nil views:@{@"label" : label}];
        //        [self addConstraints:labelCons1];
        
        //        NSArray *labelCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|" options:0 metrics:nil views:@{@"label" : label}];
        //        [self addConstraints:labelCons2];
        
        NSLayoutConstraint *consLeft = [NSLayoutConstraint constraintWithItem:button attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeLeft) multiplier:1 constant:0];
        [self addConstraint:consLeft];
        
        NSLayoutConstraint *consRight = [NSLayoutConstraint constraintWithItem:button attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeRight) multiplier:1 constant:0];
        [self addConstraint:consRight];
        
        NSLayoutConstraint *consTop = [NSLayoutConstraint constraintWithItem:button attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeTop) multiplier:1 constant:0];
        [self addConstraint:consTop];
        
        _titleButtonHeightCons = [NSLayoutConstraint constraintWithItem:button attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1 constant:0];
        [self addConstraint:_titleButtonHeightCons];
        
        _titleButton = button;
    }
    return _titleButton;
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
    
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:0.3];
    
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
    
    _titleButton.hidden = NO;
    
    /*
    if (self.customView && self.customView.superview != self.contentView) {
        
        NSLog(@"指向错误-->%p", self.customView.superview.superview);
        NSLog(@"%p-->%@", self, _action.title);
        NSLog(@"");
    }; //*/
    
    // 重用时有个莫名其妙的问题，需要判断一下
    if (self.customView.superview == self.contentView) {
        
        self.customView.hidden = YES;
    }
    
    self.customView = _action.customView;
    
    if (_action.customView != nil) {
        
        _titleButton.hidden = YES;
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
    
    self.titleButton.titleLabel.font = _action.titleFont;
    
    [self.titleButton setTitleColor:_action.titleColor forState:(UIControlStateNormal)];
    [self.titleButton setTitleColor:[_action.titleColor colorWithAlphaComponent:0.5] forState:(UIControlStateHighlighted)];
    
    [self.titleButton setAttributedTitle:_action.attributedTitle forState:(UIControlStateNormal)];
    [self.titleButton setTitle:_action.title forState:(UIControlStateNormal)];
    
    [self.titleButton setImage:action.normalImage forState:(UIControlStateNormal)];
    [self.titleButton setImage:action.hightlightedImage forState:(UIControlStateHighlighted)];
    
    _titleButtonHeightCons.constant = _action.rowHeight;
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

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    
    _titleButton.highlighted = highlighted;
}
@end
