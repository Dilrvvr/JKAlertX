//
//  JKAlertActionButton.m
//  JKAlertX
//
//  Created by albertcc on 2020/5/10.
//  Copyright © 2020 安永博. All rights reserved.
//

#import "JKAlertActionButton.h"
#import "JKAlertTableActionView.h"

@interface JKAlertActionButton ()

/** actionView */
@property (nonatomic, weak) JKAlertTableActionView *actionView;
@end

@implementation JKAlertActionButton

#pragma mark
#pragma mark - Public Methods

- (void)setPiercedBackgroundColor:(UIColor *)piercedBackgroundColor {
    _piercedBackgroundColor = piercedBackgroundColor;
    
    [self updatePierced];
}

- (void)setAction:(JKAlertAction *)action {
    _action = action;
    
    self.actionView.action = action;
    
    [self updatePierced];
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
}

#pragma mark
#pragma mark - Private Methods

- (void)updatePierced {
    
    if (_piercedBackgroundColor) {
        
        self.actionView.backgroundView.backgroundColor = _piercedBackgroundColor;
        self.actionView.selectedBackgroundView.backgroundColor = _piercedBackgroundColor;
    }
}

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
