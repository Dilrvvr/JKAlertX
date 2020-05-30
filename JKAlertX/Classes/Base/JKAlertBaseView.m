//
//  JKAlertBaseView.m
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertBaseView.h"
#import "JKAlertVisualFormatConstraintManager.h"

@interface JKAlertBaseView ()

@end

@implementation JKAlertBaseView

#pragma mark
#pragma mark - Public Methods

- (void)setUserInterfaceStyle:(JKAlertUserInterfaceStyle)userInterfaceStyle {
    _userInterfaceStyle = userInterfaceStyle;
    
    [self solveUserInterfaceStyleDidChange];
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

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    [self solveUserInterfaceStyleDidChange];
}

#pragma mark
#pragma mark - Private Methods

/// 添加更新页面样式的通知
- (void)addUpdateUserInterfaceStyleNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInterfaceStyleNotification:) name:JKAlertUpdateUserInterfaceStyleNotification object:nil];
}

/// 收到更新页面样式的通知
- (void)updateUserInterfaceStyleNotification:(NSNotification *)notification {
    
    self.userInterfaceStyle = [notification.object unsignedIntegerValue];
}

/// 处理页面样式变更
- (void)solveUserInterfaceStyleDidChange {
    
    switch (self.userInterfaceStyle) {
        case JKAlertUserInterfaceStyleSystem: // 跟随系统
        {
            BOOL isLight = YES;
            
            if (@available(iOS 13.0, *)) {
                
                isLight = (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight);
            }
            
            if (isLight) {
                
                [self checkupdateLightModetUI];
                
            } else {
                
                [self checkUpdateDarkModeUI];
            }
        }
            break;
        case JKAlertUserInterfaceStyleLight: // 浅色模式
        {
            [self checkupdateLightModetUI];
        }
            break;
        case JKAlertUserInterfaceStyleDark: // 深色模式
        {
            [self checkUpdateDarkModeUI];
        }
            break;
            
        default: // 其它默认浅色模式
        {
            [self checkupdateLightModetUI];
        }
            break;
    }
}

/// 检查变更为浅色模式
- (void)checkupdateLightModetUI {
    
    // 当前已经是浅色模式，不处理
    if (_currentUserInterfaceStyle == JKAlertUserInterfaceStyleLight) { return; }
    
    _currentUserInterfaceStyle = JKAlertUserInterfaceStyleLight;
    
    [self updateLightModetUI];
}

/// 检查变更为深色模式
- (void)checkUpdateDarkModeUI {
    
    // 当前已经是深色模式，不处理
    if (_currentUserInterfaceStyle == JKAlertUserInterfaceStyleDark) { return; }
    
    _currentUserInterfaceStyle = JKAlertUserInterfaceStyleDark;
    
    [self updateDarkModeUI];
}

/// 变更为浅色模式
- (void)updateLightModetUI {
    
}

/// 变更为深色模式
- (void)updateDarkModeUI {
    
}

#pragma mark
#pragma mark - Private Selector



#pragma mark
#pragma mark - Custom Delegates



#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 交给子类重写 super自动调用该方法 */
- (void)initializeProperty {
    
    // 默认跟随系统
    _userInterfaceStyle = JKAlertUserInterfaceStyleSystem;
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    
    [self initializeProperty];
    [self createUI];
    [self layoutUI];
    [self initializeUIData];
    
    [self addUpdateUserInterfaceStyleNotification];
}

/** 创建UI 交给子类重写 super自动调用该方法 */
- (void)createUI {
    
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.userInteractionEnabled = NO;
    [self addSubview:backgroundView];
    _backgroundView = backgroundView;
    
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    _contentView = contentView;
}

/** 布局UI 交给子类重写 super自动调用该方法 */
- (void)layoutUI {
    
    [JKAlertVisualFormatConstraintManager addZeroEdgeConstraintsWithTargetView:self.backgroundView constraintsView:self];
    
    [JKAlertVisualFormatConstraintManager addZeroEdgeConstraintsWithTargetView:self.contentView constraintsView:self];
}

/** 初始化UI数据 交给子类重写 super自动调用该方法 */
- (void)initializeUIData {
    
}

#pragma mark
#pragma mark - Private Property



@end
