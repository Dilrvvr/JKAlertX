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

/** customView */
@property (nonatomic, weak) UIView *customView;
@end

@implementation JKAlertCollectionViewCell

- (UIButton *)imageButton{
    if (!_imageButton) {
        
        UIButton *imageButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        imageButton.userInteractionEnabled = NO;
        [self.contentView addSubview:imageButton];
        
        imageButton.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *imageButtonTopCons = [NSLayoutConstraint constraintWithItem:imageButton attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeTop) multiplier:1 constant:0];
        NSLayoutConstraint *imageButtonLeftCons = [NSLayoutConstraint constraintWithItem:imageButton attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeLeft) multiplier:1 constant:15];
        NSLayoutConstraint *imageButtonRightCons = [NSLayoutConstraint constraintWithItem:imageButton attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeRight) multiplier:1 constant:-15];
        NSLayoutConstraint *imageButtonHeightCons = [NSLayoutConstraint constraintWithItem:imageButton attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:imageButton attribute:(NSLayoutAttributeWidth) multiplier:1 constant:0];
        [self.contentView addConstraints:@[imageButtonTopCons, imageButtonLeftCons, imageButtonRightCons, imageButtonHeightCons]];
        
        _imageButton = imageButton;
    }
    return _imageButton;
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
    
    _imageButton.highlighted = selected;
    
    _titleLabel.highlighted = selected;
}

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
    _imageButton.highlighted = highlighted;
    
    _titleLabel.highlighted = highlighted;
}

- (void)setAction:(JKAlertAction *)action{
    _action = action;
    
    _titleLabel.hidden = NO;
    _imageButton.hidden = _titleLabel.hidden;
    
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
        _imageButton.hidden = _titleLabel.hidden;
        
        self.customView.hidden = NO;
        
        return;
    }
    
    _customView.hidden = YES;
    
    if (_action.titleColor == nil) {
        
        switch (_action.alertActionStyle) {
            case JKAlertActionStyleDefault:
                
                _action.setTitleColor([UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]);
                break;
                
            case JKAlertActionStyleCancel:
                
                _action.setTitleColor([UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1]);
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
    
    [self.imageButton setBackgroundImage:_action.normalImage forState:(UIControlStateNormal)];
    [self.imageButton setBackgroundImage:_action.hightlightedImage forState:(UIControlStateHighlighted)];
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
