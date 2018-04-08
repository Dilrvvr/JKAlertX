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
/** imageButton */
@property (nonatomic, weak) UIButton *imageButton;

/** titleLabel */
@property (nonatomic, weak) UILabel *titleLabel;
@end

@implementation JKAlertCollectionViewCell

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
    
//    self.selectedBackgroundView = [[UIView alloc] init];
//    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0/255.0 alpha:1];
    
    UIButton *imageButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    imageButton.userInteractionEnabled = NO;
//    imageButton.contentMode = UIViewContentModeScaleToFill;
//    imageButton.imageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:imageButton];
    _imageButton = imageButton;
    
    imageButton.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *imageButtonTopCons = [NSLayoutConstraint constraintWithItem:imageButton attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeTop) multiplier:1 constant:0];
    NSLayoutConstraint *imageButtonLeftCons = [NSLayoutConstraint constraintWithItem:imageButton attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeLeft) multiplier:1 constant:15];
    NSLayoutConstraint *imageButtonRightCons = [NSLayoutConstraint constraintWithItem:imageButton attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeRight) multiplier:1 constant:-15];
    NSLayoutConstraint *imageButtonHeightCons = [NSLayoutConstraint constraintWithItem:imageButton attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:imageButton attribute:(NSLayoutAttributeWidth) multiplier:1 constant:0];
    [self.contentView addConstraints:@[imageButtonTopCons, imageButtonLeftCons, imageButtonRightCons, imageButtonHeightCons]];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    NSLayoutConstraint *titleLabelTopCons = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeTop) multiplier:1 constant:0];
    NSLayoutConstraint *titleLabelLeftCons = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeLeft) multiplier:1 constant:0];
    NSLayoutConstraint *titleLabelRightCons = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeRight) multiplier:1 constant:0];
    NSLayoutConstraint *titleLabelBottomCons = [NSLayoutConstraint constraintWithItem:titleLabel attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeBottom) multiplier:1 constant:0];
    [self.contentView addConstraints:@[titleLabelLeftCons, titleLabelRightCons, titleLabelBottomCons]];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    
//    self.contentView.backgroundColor = [UIColor orangeColor];
//    imageButton.backgroundColor = [UIColor redColor];
//    titleLabel.backgroundColor = [UIColor greenColor];
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    self.imageButton.highlighted = selected;
    
    if (!selected) {
        
        self.titleLabel.textColor = (self.action.alertActionStyle == JKAlertActionStyleDefault) ? [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1] : [UIColor redColor];
        
        return;
    }
    
    self.titleLabel.textColor = (self.action.alertActionStyle == JKAlertActionStyleDefault) ? [UIColor colorWithRed:186.0/255.0 green:186.0/255.0 blue:186.0/255.0 alpha:1] : [[UIColor redColor] colorWithAlphaComponent:0.5];
}

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
    self.imageButton.highlighted = highlighted;
    
    if (!highlighted) {
        
        self.titleLabel.textColor = (self.action.alertActionStyle == JKAlertActionStyleDefault) ? [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1] : [UIColor redColor];
        
        return;
    }
    
    self.titleLabel.textColor = (self.action.alertActionStyle == JKAlertActionStyleDefault) ? [UIColor colorWithRed:186.0/255.0 green:186.0/255.0 blue:186.0/255.0 alpha:1] : [[UIColor redColor] colorWithAlphaComponent:0.5];
}

- (void)setAction:(JKAlertAction *)action{
    _action = action;
    
    self.titleLabel.textColor = (action.alertActionStyle == JKAlertActionStyleDefault) ? [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1] : [UIColor redColor];
    
    self.titleLabel.attributedText = action.attributeTitle;
    
    self.titleLabel.text = action.title;
    
    [self.imageButton setBackgroundImage:_action.normalImage forState:(UIControlStateNormal)];
    [self.imageButton setBackgroundImage:_action.hightlightedImage forState:(UIControlStateHighlighted)];
}
@end
