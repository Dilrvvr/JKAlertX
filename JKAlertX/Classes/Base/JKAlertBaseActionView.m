//
//  JKAlertBaseActionView.m
//  JKAlertX
//
//  Created by albertcc on 2020/5/10.
//  Copyright © 2020 安永博. All rights reserved.
//

#import "JKAlertBaseActionView.h"
#import "JKAlertAction.h"
#import "JKAlertUtility.h"
#import "JKAlertVisualFormatConstraintManager.h"

@interface JKAlertBaseActionView ()
{
    __weak UIView *_selectedBackgroundView;
}

/** containerView */
@property (nonatomic, weak) UIView *containerView;

/** customView */
@property (nonatomic, weak) UIView *customView;
@end

@implementation JKAlertBaseActionView

#pragma mark
#pragma mark - Public Methods

- (void)setAction:(JKAlertAction *)action {
    _action = action;
    
    self.titleLabel.text = nil;
    self.titleLabel.attributedText = nil;
    
    self.iconImageView.image = nil;
    self.iconImageView.highlightedImage = nil;
    
    if (self.customView &&
        self.customView.superview == self.contentView) {
        
        [self.customView removeFromSuperview];
        self.customView = nil;
    }
    
    [self updateAppearanceWithAction:action];
    
    if (action.customView) {
        
        self.containerView.hidden = YES;
        
        self.customView = action.customView;
        
        [self.contentView addSubview:action.customView];
        
        return;
    }
    
    self.containerView.hidden = NO;
    
    self.titleLabel.font = action.titleFont;
    
    if (action.attributedTitle) {
        
        self.titleLabel.attributedText = action.attributedTitle;
        
    } else if (action.title) {
        
        self.titleLabel.text = action.title;
    }
    
    self.iconImageView.image = action.normalImage;
    self.iconImageView.highlightedImage = action.hightlightedImage;
    
    [self setNeedsLayout];
}

- (void)setSeleted:(BOOL)seleted {
    _seleted = seleted;
    
    self.backgroundView.hidden = seleted;
    self.selectedBackgroundView.hidden = !self.backgroundView.hidden;
}

- (void)setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    
    self.backgroundView.hidden = highlighted;
    self.selectedBackgroundView.hidden = !self.backgroundView.hidden;
    
    self.contentView.alpha = highlighted ? 0.5 : 1.0;
    
    self.iconImageView.highlighted = highlighted;
    
    [self setNeedsLayout];
}

#pragma mark
#pragma mark - Override

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.frame.size.width < JKAlertKeyWindow().frame.size.width - 1.0) {
        
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.action.rowHeight);
        
    } else {
        
        UIEdgeInsets safeAreaInset = JKAlertSafeAreaInset();
        
        self.contentView.frame = CGRectMake(safeAreaInset.left, 0, self.frame.size.width - safeAreaInset.left - safeAreaInset.right, self.action.rowHeight);
    }
    
    self.containerView.frame = self.contentView.bounds;
    
    if (self.customView) {
        
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        self.customView.frame = self.contentView.bounds;
    }
}

#pragma mark
#pragma mark - Private Methods

- (void)updateAppearanceWithAction:(JKAlertAction *)action {
    
    if (!action) { return; }
    
    self.backgroundView.backgroundColor = action.backgroundColor;
    self.selectedBackgroundView.backgroundColor = action.seletedBackgroundColor;
    
    self.titleLabel.textColor = action.titleColor;
}

#pragma mark
#pragma mark - Private Selector



#pragma mark
#pragma mark - Custom Delegates



#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 交给子类重写 super自动调用该方法 */
- (void)initializeProperty {
    [super initializeProperty];
    
    self.userInteractionEnabled = NO;
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
}

/** 创建UI 交给子类重写 super自动调用该方法 */
- (void)createUI {
    [super createUI];
    
    UIView *containerView = [[UIView alloc] init];
    [self.contentView addSubview:containerView];
    _containerView = containerView;
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self.containerView addSubview:iconImageView];
    _iconImageView = iconImageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self.containerView addSubview:titleLabel];
    _titleLabel = titleLabel;
}

/** 布局UI 交给子类重写 super自动调用该方法 */
- (void)layoutUI {
    [super layoutUI];
    
    [JKAlertVisualFormatConstraintManager addZeroEdgeConstraintsWithTargetView:self.selectedBackgroundView constraintsView:self];
}

/** 初始化UI数据 交给子类重写 super自动调用该方法 */
- (void)initializeUIData {
    [super initializeUIData];
    
}

#pragma mark
#pragma mark - Private Property

- (UIView *)selectedBackgroundView {
    if (!_selectedBackgroundView) {
        UIView *selectedBackgroundView = [[UIView alloc] init];
        selectedBackgroundView.userInteractionEnabled = NO;
        selectedBackgroundView.hidden = YES;
        [self insertSubview:selectedBackgroundView aboveSubview:self.backgroundView];
        _selectedBackgroundView = selectedBackgroundView;
    }
    return _selectedBackgroundView;
}

@end
