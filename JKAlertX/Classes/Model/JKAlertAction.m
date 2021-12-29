//
//  JKAlertAction.m
//  TestVideoAndPicture
//
//  Created by albert on 2017/4/18.
//  Copyright © 2017年 Albert. All rights reserved.
//

#import "JKAlertAction.h"
#import "JKAlertTheme.h"

@interface JKAlertAction ()
{
    CGFloat _rowHeight;
}
@end

@implementation JKAlertAction

#pragma mark
#pragma mark - Public

/**
 * 实例化action
 * title: 标题
 * style: 样式
 * handler: 点击的操作
 */
+ (instancetype)actionWithTitle:(NSString *)title
                          style:(JKAlertActionStyle)style
                        handler:(void (^)(JKAlertAction *action))handler {
    
    return [self actionWithTitle:title
                 attributedTitle:nil
                           style:style
                         handler:handler];
}

/**
 * 实例化action
 * attributedTitle: 富文本标题
 * handler: 点击的操作
 */
+ (instancetype)actionWithAttributedTitle:(NSAttributedString *)attributedTitle
                                  handler:(void (^)(JKAlertAction *action))handler {
    
    return [self actionWithTitle:nil
                 attributedTitle:attributedTitle
                           style:JKAlertActionStyleDefault
                         handler:handler];
}

/**
 * 链式实例化action
 * title: 标题
 * style: 样式
 * handler: 点击的操作
 */
+ (JKAlertAction *(^)(NSString *title, JKAlertActionStyle style, void (^handler)(JKAlertAction *action)))action {
    
    return ^(NSString *title, JKAlertActionStyle style, void (^handler)(JKAlertAction *action)) {
        
        return [JKAlertAction actionWithTitle:title
                                        style:style
                                      handler:handler];
    };
}

/**
 * 链式实例化action
 * attributedTitle: 富文本标题
 * handler: 点击的操作
 */
+ (JKAlertAction *(^)(NSAttributedString *attributedTitle, void (^handler)(JKAlertAction *action)))actionAttributed {
    
    return ^(NSAttributedString *attributedTitle, void (^handler)(JKAlertAction *action)) {
        
        return [JKAlertAction actionWithAttributedTitle:attributedTitle
                                                handler:handler];
    };
}

/**
 * 可以在这个block内自定义其它属性
 */
- (JKAlertAction *(^)(void (^handler)(JKAlertAction *innerAction)))makeCustomizePropertyHandler {
    
    return ^(void (^handler)(JKAlertAction *innerAction)) {
        
        !handler ? : handler(self);
        
        return self;
    };
}

/**
 * sheet样式cell行高
 * 默认4寸屏46，以上53
 * customView有值则取customView的bounds高度
 */
- (JKAlertAction *(^)(CGFloat rowHeight))makeRowHeight {
    
    return ^(CGFloat rowHeight) {
        
        [self setRowHeight:rowHeight];
        
        return self;
    };
}

/**
 * 执行操作后是否自动消失
 */
- (JKAlertAction *(^)(BOOL autoDismiss))makeAutoDismiss {
    
    return ^(BOOL autoDismiss) {
        
        self.autoDismiss = autoDismiss;
        
        return self;
    };
}

/**
 * 修改title
 */
- (JKAlertAction *(^)(NSString *title))remakeTitle {
    
    return ^(NSString *title) {
        
        [self setTitle:title];
        
        return self;
    };
}

/**
 * 修改attributedTitle
 */
- (JKAlertAction *(^)(NSAttributedString *attributedTitle))remakeAttributedTitle {
    
    return ^(NSAttributedString *attributedTitle) {
        
        [self setAttributedTitle:attributedTitle];
        
        return self;
    };
}

/**
 * 修改style
 */
- (JKAlertAction *(^)(JKAlertActionStyle style))remakeActionStyle {
    
    return ^(JKAlertActionStyle style) {
        
        [self setActionStyle:style];
        
        return self;
    };
}

/**
 * 字体颜色
 */
- (JKAlertAction *(^)(UIColor *color))makeTitleColor {
    
    return ^(UIColor *color) {
        
        [self.jkalert_themeProvider removeProvideHandlerForKey:NSStringFromSelector(@selector(titleColor))];
        
        self.titleColor = color;
        
        return self;
    };
}

/**
 * 字体
 */
- (JKAlertAction *(^)(UIFont *font))makeTitleFont {
    
    return ^(UIFont *font) {
        
        self.titleFont = font;
        
        return self;
    };
}

/**
 * 背景颜色
 * 仅 actionSheet 与 collectionSheet的底部按钮 有效
 */
- (JKAlertAction *(^)(UIColor *backgroundColor))makeBackgroundColor {
    
    return ^(UIColor *backgroundColor) {
        
        [self.jkalert_themeProvider removeProvideHandlerForKey:NSStringFromSelector(@selector(backgroundColor))];
        
        self.backgroundColor = backgroundColor;
        
        return self;
    };
}

/**
 * 高亮背景颜色
 * 仅 actionSheet 与 collectionSheet的底部按钮 有效
 */
- (JKAlertAction *(^)(UIColor *seletedBackgroundColor))makeSeletedBackgroundColor {
    
    return ^(UIColor *seletedBackgroundColor) {
        
        [self.jkalert_themeProvider removeProvideHandlerForKey:NSStringFromSelector(@selector(seletedBackgroundColor))];
        
        self.seletedBackgroundColor = seletedBackgroundColor;
        
        return self;
    };
}

/**
 * 普通状态图片
 */
- (JKAlertAction *(^)(UIImage *image))makeNormalImage {
    
    return ^(UIImage *image) {
        
        self.normalImage = image;
        
        return self;
    };
}

/**
 * 高亮状态图片
 */

- (JKAlertAction *(^)(UIImage *image))makeHightlightedImage {
    
    return ^(UIImage *image) {
        
        self.hightlightedImage = image;
        
        return self;
    };
}

/**
 * 图片的ContentMode
 * 默认UIViewContentModeScaleAspectFill
 */
- (JKAlertAction *(^)(UIViewContentMode contentMode))makeImageContentMode {
    
    return ^(UIViewContentMode contentMode) {
        
        self.imageContentMode = contentMode;
        
        return self;
    };
}

/**
 * 是否隐藏分隔线
 */
- (JKAlertAction *(^)(BOOL hidden))makeSeparatorLineHidden {
    
    return ^(BOOL hidden) {
        
        self.separatorLineHidden = hidden;
        
        return self;
    };
}

/**
 * 分隔线颜色 默认nil 自动设置深/浅色
 */
- (JKAlertAction *(^)(UIColor *color))makeSeparatorLineColor {
    
    return ^(UIColor *color) {
        
        self.separatorLineColor = color;
        
        return self;
    };
}

/**
 * 分隔线内间距 目前仅取左右 默认zero
 */
- (JKAlertAction *(^)(UIEdgeInsets inset))makeSeparatorLineInset {
    
    return ^(UIEdgeInsets inset) {
        
        self.separatorLineInset = inset;
        
        return self;
    };
}

/**
 * 自定义view
 * 注意要自己计算好frame
 * action.customView将会自动适应宽度，所以frame给出高度即可
 * actionSheet样式的行高rowHeight将取决于action.customView的高度
 * 自定义时请将action.customView视为一个容器view
 * 推荐使用自动布局在action.customView约束子控件
 * 若自定义的view挡住了原有action交互，推荐使用action.alertView.dismiss();来移除当前的JKAlertView
 */
- (JKAlertAction *(^)(UIView *(^handler)(JKAlertAction *innerAction)))makeCustomView {
    
    return ^(UIView *(^handler)(JKAlertAction *innerAction)) {
        
        self.customView = !handler ? nil : handler(self);
        
        return self;
    };
}

#pragma mark
#pragma mark - Private Method

+ (instancetype)actionWithTitle:(NSString *)title
                attributedTitle:(NSAttributedString *)attributedTitle
                          style:(JKAlertActionStyle)style
                        handler:(void (^)(JKAlertAction *action))handler {
    
    JKAlertAction *action = [[JKAlertAction alloc] init];
    
    [action setTitle:title];
    [action setAttributedTitle:attributedTitle];
    [action setActionStyle:style];
    [action setHandler:handler];
    
    [JKAlertThemeProvider providerWithOwner:action handlerKey:NSStringFromSelector(@selector(refreshAppearanceHandler)) provideHandler:^(JKAlertThemeProvider *provider, JKAlertAction *providerOwner) {
        
        !providerOwner.refreshAppearanceHandler ? : providerOwner.refreshAppearanceHandler(providerOwner);
    }];
    
    return action;
}

#pragma mark
#pragma mark - Private Setter

- (void)setTitle:(NSString *)title {
    _title = [title copy];
}

- (void)setAttributedTitle:(NSAttributedString *)attributedTitle {
    _attributedTitle = [attributedTitle copy];
}

- (void)setHandler:(void (^)(JKAlertAction *))handler {
    _handler = [handler copy];
}

- (void)setActionStyle:(JKAlertActionStyle)actionStyle {
    _actionStyle = actionStyle;
    
    NSString *handlerKey = NSStringFromSelector(@selector(titleColor));
    
    switch (actionStyle) {
        case JKAlertActionStyleCancel:
        {
            [JKAlertThemeProvider providerWithOwner:self handlerKey:handlerKey provideHandler:^(JKAlertThemeProvider *provider, JKAlertAction *providerOwner) {
                
                providerOwner.titleColor = JKAlertCheckDarkMode(JKAlertSameRGBColor(153), JKAlertSameRGBColor(102));
            }];
        }
            break;
        case JKAlertActionStyleDestructive:
        {
            [self.jkalert_themeProvider removeProvideHandlerForKey:handlerKey];
            self.titleColor = JKAlertSystemRedColor;
        }
            break;
        case JKAlertActionStyleDefaultBlue:
        {
            [self.jkalert_themeProvider removeProvideHandlerForKey:handlerKey];
            self.titleColor = JKAlertSystemBlueColor;
        }
            break;
        default:
        {
            [JKAlertThemeProvider providerWithOwner:self handlerKey:handlerKey provideHandler:^(JKAlertThemeProvider *provider, JKAlertAction *providerOwner) {
                
                providerOwner.titleColor = JKAlertCheckDarkMode(JKAlertSameRGBColor(51), JKAlertSameRGBColor(204));
            }];
        }
            break;
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
}

- (void)setSeletedBackgroundColor:(UIColor *)seletedBackgroundColor {
    _seletedBackgroundColor = seletedBackgroundColor;
}

- (void)setRowHeight:(CGFloat)rowHeight {
    _rowHeight = rowHeight;
}

#pragma mark
#pragma mark - Override



#pragma mark
#pragma mark - Initialization

- (instancetype)init {
    if (self = [super init]) {
        
        [self initialization];
    }
    return self;
}

- (void)initialization {
    
    _rowHeight = -1;
    
    _separatorLineHidden = NO;
    
    _autoDismiss = YES;
    
    _imageContentMode = UIViewContentModeScaleAspectFill;
    
    _titleFont = [UIFont systemFontOfSize:17];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    _rowHeight = self.customView ? self.customView.frame.size.height : ((MIN(screenSize.width, screenSize.height) > 321) ? 53 : 46);
    
    [JKAlertThemeProvider providerBackgroundColorWithOwner:self provideHandler:^(JKAlertThemeProvider *provider, JKAlertAction *providerOwner) {
        
        providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertUtility.lightBackgroundColor, JKAlertUtility.darkBackgroundColor);
    }];
    
    [JKAlertThemeProvider providerWithOwner:self handlerKey:NSStringFromSelector(@selector(seletedBackgroundColor)) provideHandler:^(JKAlertThemeProvider *provider, JKAlertAction *providerOwner) {
        
        providerOwner.seletedBackgroundColor = JKAlertCheckDarkMode(JKAlertUtility.highlightedLightBackgroundColor, JKAlertUtility.highlightedDarkBackgroundColor);
    }];
}

#pragma mark
#pragma mark - Property

- (BOOL)isEmpty {
    
    return self.title == nil &&
    self.attributedTitle == nil &&
    self.handler == nil &&
    self.normalImage == nil &&
    self.hightlightedImage == nil;
}

- (CGFloat)rowHeight {
    
    if (self.customView) {
        
        return self.customView.bounds.size.height;
    }
    
    return _rowHeight;
}

#pragma mark
#pragma mark - Deprecated

/** 在这个block内自定义action的其它属性 */
- (JKAlertAction *(^)(void (^customizePropertyHandler)(JKAlertAction *customizePropertyAction)))setCustomizePropertyHandler {
    
    return [self makeCustomizePropertyHandler];
}

/** 设置执行操作后是否自动消失 */
- (JKAlertAction *(^)(BOOL autoDismiss))setAutoDismiss {
    
    return [self makeAutoDismiss];
}

/** 重新设置title */
- (JKAlertAction *(^)(NSString *title))resetTitle {
    
    return [self remakeTitle];
}

/** 重新设置attributedTitle */
- (JKAlertAction *(^)(NSAttributedString *attributedTitle))resetAttributedTitle {
    
    return [self remakeAttributedTitle];
}

/** 设置titleColor */
- (JKAlertAction *(^)(UIColor *color))setTitleColor {
    
    return [self makeTitleColor];
}

/** 设置titleFont */
- (JKAlertAction *(^)(UIFont *font))setTitleFont {
    
    return [self makeTitleFont];
}

/**
 * 设置backgroundColor
 * 仅 actionSheet 与 collectionSheet的底部按钮 有效
 */
- (JKAlertAction *(^)(UIColor *backgroundColor))setBackgroundColor {
    
    return [self makeBackgroundColor];
}

/**
 * 设置seletedBackgroundColor
 * 仅 actionSheet 与 collectionSheet的底部按钮 有效
 */
- (JKAlertAction *(^)(UIColor *seletedBackgroundColor))setSeletedBackgroundColor {
    
    return [self makeSeletedBackgroundColor];
}

/** 设置普通状态图片 */
- (JKAlertAction *(^)(UIImage *image))setNormalImage {
    
    return [self makeNormalImage];
}

/** 设置高亮状态图片 */
- (JKAlertAction *(^)(UIImage *image))setHightlightedImage {
    
    return [self makeHightlightedImage];
}

/** 设置imageContentMode 默认UIViewContentModeScaleAspectFill */
- (JKAlertAction *(^)(UIViewContentMode contentMode))setImageContentMode {
    
    return [self makeImageContentMode];
}

/** 设置是否隐藏分隔线 */
- (JKAlertAction *(^)(BOOL hidden))setSeparatorLineHidden {
    
    return [self makeSeparatorLineHidden];
}

/**
 * 设置自定义的view
 * 注意要自己计算好frame
 * action.customView将会自动适应宽度，所以frame给出高度即可
 * actionSheet样式的行高rowHeight将取决于action.customView的高度
 * 自定义时请将action.customView视为一个容器view
 * 推荐使用自动布局在action.customView约束子控件
 * 若自定义的view挡住了原有action交互，推荐使用action.alertView.dismiss();来移除当前的JKAlertView
 */
- (JKAlertAction *(^)(UIView *(^customView)(JKAlertAction *action)))setCustomView {
    
    return [self makeCustomView];
}
@end
