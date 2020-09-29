//
//  JKAlertCollectionViewCell.m
//  JKAlert
//
//  Created by albert on 2018/4/4.
//  Copyright © 2018年 Albert. All rights reserved.
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

#pragma mark
#pragma mark - Public Methods

- (void)setAction:(JKAlertAction *)action {
    _action = action;
    
    __weak typeof(self) weakSelf = self;
    [action setRefreshAppearanceHandler:^(JKAlertAction *refreshAction) {
        
        if (refreshAction != weakSelf.action) { return; }
        
        [weakSelf refreshWithAction:refreshAction];
    }];
    
    [self refreshWithAction:_action];
}

- (void)refreshWithAction:(JKAlertAction *)action {
    
    _titleLabel.hidden = NO;
    _iconImageView.hidden = _titleLabel.hidden;
    
    if (self.customView &&
        self.customView.superview == self.contentView) {
        
        [self.customView removeFromSuperview];
        self.customView = nil;
    }
    
    if (action.customView) {
        
        _titleLabel.hidden = YES;
        _iconImageView.hidden = _titleLabel.hidden;
        
        [self.contentView addSubview:action.customView];
        self.customView = action.customView;
        
        return;
    }
    
    self.titleLabel.font = action.titleFont;
    
    self.titleLabel.textColor = action.titleColor;
    self.titleLabel.highlightedTextColor = [action.titleColor colorWithAlphaComponent:0.5];
    
    self.titleLabel.attributedText = action.attributedTitle;
    
    self.titleLabel.text = action.title;
    
    self.iconImageView.contentMode = action.imageContentMode;
    self.iconImageView.image = action.normalImage;
    self.iconImageView.highlightedImage = action.hightlightedImage;
}

#pragma mark
#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    [self updateHighlighted:selected];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    [self updateHighlighted:highlighted];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.customView) {
        
        self.customView.frame = self.contentView.bounds;
    }
}

#pragma mark
#pragma mark - Private Methods

- (void)updateHighlighted:(BOOL)highlighted {
    
    if (self.customView) {
        
        self.customView.alpha = highlighted ? 0.5 : 1.0;
        
        return;
    }
    
    if (self.action.hightlightedImage) {
        
        _iconImageView.alpha = 1;
        
        _iconImageView.highlighted = highlighted;
        
    } else {
        
        _iconImageView.alpha = highlighted ? 0.5 : 1;
    }
    
    _titleLabel.highlighted = highlighted;
}

#pragma mark
#pragma mark - Private Selector



#pragma mark
#pragma mark - Custom Delegates



#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 交给子类重写 super自动调用该方法 */
- (void)initializeProperty {
    
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

- (UIImageView *)iconImageView {
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

- (UILabel *)titleLabel {
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
@end
