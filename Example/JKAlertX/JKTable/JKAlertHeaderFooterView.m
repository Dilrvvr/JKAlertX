//
//  JKAlertHeaderFooterView.m
//  JKAlertX_Example
//
//  Created by albert on 2020/9/13.
//  Copyright © 2020 jkayb123cool@gmail.com. All rights reserved.
//

#import "JKAlertHeaderFooterView.h"

@interface JKAlertHeaderFooterView ()

/** dotView */
@property (nonatomic, weak) UIView *dotView;
@end

@implementation JKAlertHeaderFooterView

#pragma mark
#pragma mark - Public Methods



#pragma mark
#pragma mark - Override

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
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
    
    //self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, (self.frame.size.height - self.textLabel.frame.size.height) * 0.5, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    
    self.dotView.frame = CGRectMake((self.textLabel.frame.origin.x - [self dotWH]) * 0.5, self.textLabel.frame.origin.y + (self.textLabel.frame.size.height - [self dotWH]) * 0.5, [self dotWH], [self dotWH]);
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
    
    UIView *dotView = [[UIView alloc] init];
    dotView.userInteractionEnabled = NO;
    dotView.layer.cornerRadius = [self dotWH] * 0.5;
    dotView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:dotView];
    _dotView = dotView;
}

/** 布局UI 交给子类重写 super自动调用该方法 */
- (void)layoutUI {
    
}

/** 初始化UI数据 交给子类重写 super自动调用该方法 */
- (void)initializeUIData {
    
    //self.contentView.backgroundColor = [UIColor redColor];
}

#pragma mark
#pragma mark - Private Property

- (CGFloat)dotWH {
    
    return 6.0;
}
@end
