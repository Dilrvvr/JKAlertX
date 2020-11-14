//
//  JKAlertBaseView.m
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseView.h"
#import "JKAlertConstraintManager.h"

@interface JKAlertBaseView ()
{
    __weak UIView *_backgroundView;
    
    __weak UIView *_contentView;
}
@end

@implementation JKAlertBaseView

#pragma mark
#pragma mark - Public Methods



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
    
}

/** 布局UI 交给子类重写 super自动调用该方法 */
- (void)layoutUI {
    
    if (!self.autoAddBasicViews) { return; }
    
    if (self.backgroundView) {
        
        [JKAlertConstraintManager addZeroEdgeConstraintsWithTargetView:self.backgroundView constraintsView:self];
    }
    
    if (self.contentView) {
        
        [JKAlertConstraintManager addZeroEdgeConstraintsWithTargetView:self.contentView constraintsView:self];
    }
}

/** 初始化UI数据 交给子类重写 super自动调用该方法 */
- (void)initializeUIData {
    
}

#pragma mark
#pragma mark - Private Property

- (BOOL)autoAddBasicViews {
    
    return YES;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.userInteractionEnabled = NO;
        [self insertSubview:backgroundView atIndex:0];
        _backgroundView = backgroundView;
    }
    return _backgroundView;
}

- (UIView *)contentView {
    if (!_contentView) {
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}
@end
