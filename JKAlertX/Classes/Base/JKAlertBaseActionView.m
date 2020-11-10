//
//  JKAlertBaseActionView.m
//  JKAlertX
//
//  Created by Albert on 2020/5/10.
//  Copyright © 2020 Albert. All rights reserved.
//

#import "JKAlertBaseActionView.h"
#import "JKAlertAction.h"
#import "JKAlertUtility.h"
#import "JKAlertConstraintManager.h"

@interface JKAlertBaseActionView ()
{
    __weak UIView *_selectedBackgroundView;
}

/** containerView */
@property (nonatomic, weak) UIView *containerView;
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
    
    [self updateAppearanceWithAction:action];
    
    self.containerView.hidden = (action.customView != nil);
    
    if (self.containerView.hidden) { return; }
    
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
    
    [self updateAppearanceWithAction:self.action];
}

- (void)setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    
    self.backgroundView.hidden = highlighted;
    self.selectedBackgroundView.hidden = !self.backgroundView.hidden;
    
    self.iconImageView.highlighted = highlighted;
    
    [self updateAppearanceWithAction:self.action];
    
    [self setNeedsLayout];
}

#pragma mark
#pragma mark - Override

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.frame.size.width < JKAlertUtility.keyWindow.frame.size.width - 1.0) {
        
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.action.rowHeight);
        
    } else {
        
        UIEdgeInsets safeAreaInset = JKAlertUtility.safeAreaInset;
        
        self.contentView.frame = CGRectMake(safeAreaInset.left, 0, self.frame.size.width - safeAreaInset.left - safeAreaInset.right, self.action.rowHeight);
    }
    
    self.containerView.frame = self.contentView.bounds;
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
    
    [JKAlertConstraintManager addZeroEdgeConstraintsWithTargetView:self.selectedBackgroundView constraintsView:self];
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
