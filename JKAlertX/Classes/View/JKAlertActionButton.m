//
//  JKAlertActionButton.m
//  JKAlertX
//
//  Created by Albert on 2020/5/10.
//  Copyright © 2020 Albert. All rights reserved.
//

#import "JKAlertActionButton.h"
#import "JKAlertTableActionView.h"
#import "JKAlertAction.h"

@interface JKAlertActionButton ()

/** actionView */
@property (nonatomic, weak) JKAlertTableActionView *actionView;

/** customView */
@property (nonatomic, weak) UIView *customView;
@end

@implementation JKAlertActionButton

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
    
    if (self.customView &&
        self.customView.superview == self) {
        
        [self.customView removeFromSuperview];
        self.customView = nil;
    }
    
    if (action.customView) {
        
        [self addSubview:action.customView];
        self.customView = action.customView;
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    [self.actionView setHighlighted:highlighted];
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
    
    self.actionView.frame = self.bounds;
    
    if (self.customView) {
        
        self.customView.frame = self.bounds;
    }
}

#pragma mark
#pragma mark - Private Methods



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
    
    JKAlertTableActionView *actionView = [[JKAlertTableActionView alloc] init];
    [self addSubview:actionView];
    _actionView = actionView;
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
