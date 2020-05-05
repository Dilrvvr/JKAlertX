//
//  JKAlertBaseTableViewCell.m
//  JKAlertX
//
//  Created by albert on 2020/5/5.
//  Copyright © 2020 安永博. All rights reserved.
//

#import "JKAlertBaseTableViewCell.h"
#import "JKAlertAction.h"
#import "JKAlertConst.h"

@interface JKAlertBaseTableViewCell ()

@end

@implementation JKAlertBaseTableViewCell

#pragma mark
#pragma mark - 初始化

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initialization];
    }
    return self;
}

/** 初始化自身属性 交给子类重写 super自动调用该方法 */
- (void)initializeProperty{
    
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization{
    
    [self initializeProperty];
    [self createUI];
    [self layoutUI];
    [self initializeUIData];
}

/** 创建UI 交给子类重写 super自动调用该方法 */
- (void)createUI{
    
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = JKAlertGlobalHighlightedBackgroundColor();
    
    UIButton *titleButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    titleButton.userInteractionEnabled = NO;
    titleButton.titleLabel.font = [UIFont systemFontOfSize:17];
    titleButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self.contentView insertSubview:titleButton atIndex:0];
    _titleButton = titleButton;
    
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = JKAlertAdaptColor([[UIColor blackColor] colorWithAlphaComponent:0.2], [[UIColor whiteColor] colorWithAlphaComponent:0.2]);
    [self.contentView addSubview:bottomLineView];
    _bottomLineView = bottomLineView;
}

/** 布局UI 交给子类重写 super自动调用该方法 */
- (void)layoutUI{
    
    self.bottomLineView.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *bottomLineViewCons1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bottomLineView]-0-|" options:0 metrics:nil views:@{@"bottomLineView" : self.bottomLineView}];
    [self addConstraints:bottomLineViewCons1];
    
    NSArray *bottomLineViewCons2 = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[bottomLineView(0.5)]-0-|"] options:0 metrics:nil views:@{@"bottomLineView" : self.bottomLineView}];
    [self addConstraints:bottomLineViewCons2];
}

/** 初始化UI数据 交给子类重写 super自动调用该方法 */
- (void)initializeUIData{
    
    self.backgroundView = nil;
    self.backgroundColor = nil;
    self.contentView.backgroundColor = nil;
}

#pragma mark
#pragma mark - Override

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    
    self.selectedBackgroundView.frame = self.contentView.frame;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    
    _titleButton.highlighted = highlighted;
    
    if (@available(iOS 13.0, *)) {
        
        self.contentView.alpha = highlighted ? 0.5 : 1;
    }
}

#pragma mark
#pragma mark - 点击事件


#pragma mark
#pragma mark - 赋值

- (void)setAction:(JKAlertAction *)action{
    _action = action;
    
    self.selectionStyle = _action.isEmpty ? UITableViewCellSelectionStyleNone : UITableViewCellSelectionStyleDefault;
    self.bottomLineView.hidden = _action.separatorLineHidden;
    
    self.titleButton.hidden = NO;
    
    self.contentView.backgroundColor = action.backgroundColor;
    self.selectedBackgroundView.backgroundColor = action.seletedBackgroundColor;
    
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
    
    if (_action.customView != nil) {
        
        self.titleButton.hidden = YES;
        self.customView.hidden = NO;
        
        return;
    }
    
    if (_action.titleColor == nil) {
        
        switch (_action.alertActionStyle) {
            case JKAlertActionStyleDefault:
                
                _action.setTitleColor(JKAlertAdaptColor(JKAlertSameRGBColor(51), JKAlertSameRGBColor(204)));
                break;
                
            case JKAlertActionStyleCancel:
                
                _action.setTitleColor(JKAlertAdaptColor(JKAlertSameRGBColor(153), JKAlertSameRGBColor(102)));
                break;
                
            case JKAlertActionStyleDestructive:
                
                _action.setTitleColor(JKAlertSystemRedColor);
                break;
                
            default:
                break;
        }
    }
    
    if (_action.titleFont == nil) {
        
        _action.setTitleFont([UIFont systemFontOfSize:17]);
    }
    
    self.titleButton.titleLabel.font = _action.titleFont;
    
    [self.titleButton setTitleColor:_action.titleColor forState:(UIControlStateNormal)];
    [self.titleButton setTitleColor:[_action.titleColor colorWithAlphaComponent:0.5] forState:(UIControlStateHighlighted)];
    
    [self.titleButton setAttributedTitle:_action.attributedTitle forState:(UIControlStateNormal)];
    [self.titleButton setTitle:_action.title forState:(UIControlStateNormal)];
    
    [self.titleButton setImage:action.normalImage forState:(UIControlStateNormal)];
    [self.titleButton setImage:action.hightlightedImage forState:(UIControlStateHighlighted)];
}

- (void)setCustomView:(UIView *)customView{
    
    if (_customView) {
        
        [_customView removeFromSuperview];
    }
    
    _customView = customView;
    
    if (_customView == nil) { return; }
    
    [self.contentView insertSubview:customView atIndex:0];
}


#pragma mark
#pragma mark - Property



@end
