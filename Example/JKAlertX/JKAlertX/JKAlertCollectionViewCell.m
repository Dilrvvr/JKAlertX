//
//  JKAlertCollectionViewCell.m
//  JKAlert
//
//  Created by albert on 2018/4/4.
//  Copyright © 2018年 安永博. All rights reserved.
//

#import "JKAlertCollectionViewCell.h"
#import "JKAlertAction.h"

@interface JKAlertCollectionViewCell ()

/** iconImageView */
@property (nonatomic, weak) UIImageView *iconImageView;

/** titleLabel */
@property (nonatomic, weak) UILabel *titleLabel;

/** customView */
@property (nonatomic, weak) UIView *customView;
@end

@implementation JKAlertCollectionViewCell

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        if (!_iconImageView) {
            
            UIImageView *iconImageView = [[UIImageView alloc] init];
            iconImageView.userInteractionEnabled = NO;
            [self.contentView addSubview:iconImageView];
            
            iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *imageButtonTopCons = [NSLayoutConstraint constraintWithItem:iconImageView attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeTop) multiplier:1 constant:0];
            NSLayoutConstraint *imageButtonLeftCons = [NSLayoutConstraint constraintWithItem:iconImageView attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeLeft) multiplier:1 constant:15];
            NSLayoutConstraint *imageButtonRightCons = [NSLayoutConstraint constraintWithItem:iconImageView attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeRight) multiplier:1 constant:-15];
            NSLayoutConstraint *imageButtonHeightCons = [NSLayoutConstraint constraintWithItem:iconImageView attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:iconImageView attribute:(NSLayoutAttributeWidth) multiplier:1 constant:0];
            [self.contentView addConstraints:@[imageButtonTopCons, imageButtonLeftCons, imageButtonRightCons, imageButtonHeightCons]];
            
            _iconImageView = iconImageView;
        }
        return _iconImageView;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *titleLabelLeftCons = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeLeft) multiplier:1 constant:0];
        NSLayoutConstraint *titleLabelRightCons = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeRight) multiplier:1 constant:0];
        NSLayoutConstraint *titleLabelBottomCons = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeBottom) multiplier:1 constant:0];
        [self.contentView addConstraints:@[titleLabelLeftCons, titleLabelRightCons, titleLabelBottomCons]];
        _titleLabel = titleLabel;
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
    }
    return self;
}

- (void)initialization{
    
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if (self.action.hightlightedImage) {
        
        _iconImageView.alpha = 1;
        
        _iconImageView.highlighted = selected;
        
    } else {
        
        _iconImageView.alpha = selected ? 0.5 : 1;
    }
    
    _titleLabel.highlighted = selected;
}

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
    if (self.action.hightlightedImage) {
        
        _iconImageView.alpha = 1;
        
        _iconImageView.highlighted = highlighted;
        
    } else {
        
        _iconImageView.alpha = highlighted ? 0.5 : 1;
    }
    
    _titleLabel.highlighted = highlighted;
}

- (void)setAction:(JKAlertAction *)action{
    _action = action;
    
    _titleLabel.hidden = NO;
    _iconImageView.hidden = _titleLabel.hidden;
    
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
    
    if (action.customView != nil) {
        
        _titleLabel.hidden = YES;
        _iconImageView.hidden = _titleLabel.hidden;
        
        self.customView.hidden = NO;
        
        return;
    }
    
    _customView.hidden = YES;
    
    if (_action.titleColor == nil) {
        
        switch (_action.alertActionStyle) {
            case JKAlertActionStyleDefault:
                
                _action.setTitleColor(JKALertAdaptColor(JKAlertSameRGBColor(51), JKAlertSameRGBColor(204)));
                break;
                
            case JKAlertActionStyleCancel:
                
                _action.setTitleColor(JKALertAdaptColor(JKAlertSameRGBColor(153), JKAlertSameRGBColor(102)));
                break;
                
            case JKAlertActionStyleDestructive:
                
                _action.setTitleColor(JKAlertSystemRedColor);
                break;
                
            default:
                break;
        }
    }
    
    if (_action.titleFont == nil) {
        
        _action.setTitleFont([UIFont systemFontOfSize:13]);
    }
    
    self.titleLabel.font = _action.titleFont;
    
    self.titleLabel.textColor = _action.titleColor;
    self.titleLabel.highlightedTextColor = [_action.titleColor colorWithAlphaComponent:0.5];
    
    self.titleLabel.attributedText = action.attributedTitle;
    
    self.titleLabel.text = action.title;
    
    
    self.iconImageView.contentMode = action.imageContentMode;
    self.iconImageView.image = _action.normalImage;
    self.iconImageView.highlightedImage = _action.hightlightedImage;
}

- (void)setCustomView:(UIView *)customView{
    _customView = customView;
    
    if (_customView == nil) { return; }
    
    [self.contentView addSubview:customView];
    
    customView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *customViewCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[customView]-0-|" options:0 metrics:nil views:@{@"customView" : customView}];
    [self addConstraints:customViewCons1];
    
    NSArray *customViewCons2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[customView]-0-|" options:0 metrics:nil views:@{@"customView" : customView}];
    [self addConstraints:customViewCons2];
}
@end
