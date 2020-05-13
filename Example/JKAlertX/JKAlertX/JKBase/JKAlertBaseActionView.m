//
//  JKAlertBaseActionView.m
//  JKAlertX
//
//  Created by albertcc on 2020/5/10.
//  Copyright © 2020 安永博. All rights reserved.
//

#import "JKAlertBaseActionView.h"
#import "JKAlertAction.h"
#import "JKAlertConst.h"

@interface JKAlertBaseActionView ()

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
    
    
    
    if (action.isPierced) {
        
        self.backgroundView.backgroundColor = action.piercedBackgroundColor;
        self.selectedBackgroundView.backgroundColor = action.piercedBackgroundColor;
        
    } else {
        
        self.backgroundView.backgroundColor = action.backgroundColor;
        self.selectedBackgroundView.backgroundColor = action.seletedBackgroundColor;
    }
    
    [self.customView removeFromSuperview];
    self.customView = nil;
    
    if (action.customView) {
        
        self.containerView.hidden = YES;
        
        self.customView = action.customView;
        
        [self.contentView addSubview:action.customView];
        
        return;
    }
    
    self.containerView.hidden = NO;
    
    self.titleLabel.font = action.titleFont;
    self.titleLabel.textColor = action.titleColor;
    
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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundView.frame = self.bounds;
    
    self.selectedBackgroundView.frame = self.bounds;
    
    if (self.isFullContentWidth) {
        
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.action.rowHeight);
        
    } else {
        
        UIEdgeInsets safeAreaInset = JKAlertSafeAreaInset();
        
        self.contentView.frame = CGRectMake(safeAreaInset.left, 0, self.frame.size.width - safeAreaInset.left - safeAreaInset.right, self.action.rowHeight);
    }
    
    self.containerView.frame = self.contentView.bounds;
    
    if (self.customView) {
        
        self.customView.frame = self.contentView.bounds;
    }
}

#pragma mark
#pragma mark - Private Methods



#pragma mark
#pragma mark - Private Selector



#pragma mark
#pragma mark - UITableViewDataSource & UITableViewDelegate



#pragma mark
#pragma mark - Custom Delegates



#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 交给子类重写 super自动调用该方法 */
- (void)initializeProperty {
    
    self.userInteractionEnabled = NO;
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
    
    UIView *backgroundView = [[UIView alloc] init];
    [self addSubview:backgroundView];
    _backgroundView = backgroundView;
    
    UIView *selectedBackgroundView = [[UIView alloc] init];
    selectedBackgroundView.hidden = YES;
    [self addSubview:selectedBackgroundView];
    _selectedBackgroundView = selectedBackgroundView;
    
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    _contentView = contentView;
    
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
    
}

/** 初始化UI数据 交给子类重写 super自动调用该方法 */
- (void)initializeUIData {
    
}

#pragma mark
#pragma mark - Private Property





@end
