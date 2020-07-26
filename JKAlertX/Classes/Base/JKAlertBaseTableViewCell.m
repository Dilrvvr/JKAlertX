//
//  JKAlertBaseTableViewCell.m
//  JKAlertX
//
//  Created by albert on 2020/5/5.
//  Copyright © 2020 安永博. All rights reserved.
//

#import "JKAlertBaseTableViewCell.h"
#import "JKAlertTableActionView.h"
#import "JKAlertAction.h"
#import "JKAlertUtil.h"
#import "JKAlertVisualFormatConstraintManager.h"
#import "JKAlertTheme.h"

@interface JKAlertBaseTableViewCell ()

@end

@implementation JKAlertBaseTableViewCell

#pragma mark
#pragma mark - Public Methods

- (void)setAction:(JKAlertAction *)action {
    _action = action;
    
    __weak typeof(self) weakSelf = self;
    [action setRefreshAppearanceHandler:^(JKAlertAction *refreshAction) {
        
        if (refreshAction != weakSelf.action) { return; }
        
        [weakSelf refreshWithAction:refreshAction];
    }];
    
    [self refreshWithAction:action];
}

- (void)refreshWithAction:(JKAlertAction *)action {
    
    self.actionView.action = action;
    
    self.bottomLineView.hidden = action.separatorLineHidden;
}

#pragma mark
#pragma mark - Override

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    [self.actionView setHighlighted:highlighted];
    
    [self.bottomLineView.jkalert_themeProvider executeProvideHandlerForKey:NSStringFromSelector(@selector(backgroundColor))];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    [self.bottomLineView.jkalert_themeProvider executeProvideHandlerForKey:NSStringFromSelector(@selector(backgroundColor))];
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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initialization];
    }
    return self;
}

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
    
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = nil;
    
    JKAlertTableActionView *actionView = [[JKAlertTableActionView alloc] init];
    [self.contentView addSubview:actionView];
    _actionView = actionView;
    
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.userInteractionEnabled = NO;
    [self addSubview:bottomLineView];
    _bottomLineView = bottomLineView;
}

/** 布局UI 交给子类重写 super自动调用该方法 */
- (void)layoutUI {
    
    CGFloat lineHeight = JKAlertGlobalSeparatorLineThickness();
    
    [JKAlertVisualFormatConstraintManager addConstraintsWithHorizontalFormat:@"H:|-0-[view]-0-|" verticalFormat:[NSString stringWithFormat:@"V:[view(%.2f)]-0-|", lineHeight] viewKeyName:@"view" targetView:self.bottomLineView constraintsView:self];
    
    [JKAlertVisualFormatConstraintManager addZeroEdgeConstraintsWithTargetView:self.actionView constraintsView:self.contentView];
}

/** 初始化UI数据 交给子类重写 super自动调用该方法 */
- (void)initializeUIData {
    
    self.backgroundView = nil;
    self.backgroundColor = nil;
    self.contentView.backgroundColor = nil;
    
    [JKAlertThemeProvider providerWithOwner:self.bottomLineView handlerKey:NSStringFromSelector(@selector(backgroundColor)) provideHandler:^(JKAlertThemeProvider *provider, UIView *providerOwner) {

        providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertGlobalSeparatorLineLightColor(), JKAlertGlobalSeparatorLineDarkColor());
    }];
}

#pragma mark
#pragma mark - Private Property



@end
