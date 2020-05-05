//
//  JKAlertAction.m
//  TestVideoAndPicture
//
//  Created by albert on 2017/4/18.
//  Copyright © 2017年 安永博. All rights reserved.
//

#import "JKAlertAction.h"

@interface JKAlertAction ()
{
    CGFloat _rowHeight;
}
@end

@implementation JKAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(JKAlertActionStyle)style handler:(void(^)(JKAlertAction *action))handler{
    
    JKAlertAction *action = [[JKAlertAction alloc] init];
    
    action->_title = [title copy];
    action->_handler = handler;
    action->_alertActionStyle = style;
    
    return action;
}

/**
 * 链式实例化action
 * title: 标题
 * style: 样式
 * handler: 点击的操作
 */
+ (JKAlertAction *(^)(NSString *title, JKAlertActionStyle style, void(^handler)(JKAlertAction *action)))action{
    
    return ^(NSString *title, JKAlertActionStyle style, void(^handler)(JKAlertAction *action)) {
        
        return [JKAlertAction actionWithTitle:title style:style handler:handler];
    };
}

+ (instancetype)actionWithAttributedTitle:(NSAttributedString *)attributedTitle handler:(void(^)(JKAlertAction *action))handler{
    
    JKAlertAction *action = [[JKAlertAction alloc] init];
    
    action->_attributedTitle = attributedTitle;
    action->_handler = handler;
    action->_alertActionStyle = JKAlertActionStyleDefault;
    
    return action;
}

/**
 * 链式实例化action
 * attributedTitle: 富文本标题
 * style: 样式
 * handler: 点击的操作
 */
+ (JKAlertAction *(^)(NSAttributedString *attributedTitle, void(^handler)(JKAlertAction *action)))actionAttributed{
    
    return ^(NSAttributedString *attributedTitle, void(^handler)(JKAlertAction *action)) {
        
        return [JKAlertAction actionWithAttributedTitle:attributedTitle handler:handler];
    };
}

- (instancetype)init{
    if (self = [super init]) {
        
        [self initialization];
    }
    return self;
}

- (void)initialization{
    
    _rowHeight = -1;
    _separatorLineHidden = NO;
    _autoDismiss = YES;
    
    _imageContentMode = UIViewContentModeScaleAspectFill;
    
    _backgroundColor = JKAlertGlobalBackgroundColor();
    _seletedBackgroundColor = JKAlertGlobalHighlightedBackgroundColor();
    
    // TODO: JKTODO delete
    _isPireced = YES;
}

/** 在这个block内自定义action的其它属性 */
- (JKAlertAction *(^)(void(^customizePropertyHandler)(JKAlertAction *customizePropertyAction)))setCustomizePropertyHandler{
    
    return ^(void(^customizePropertyHandler)(JKAlertAction *customizePropertyAction)) {
        
        !customizePropertyHandler ? : customizePropertyHandler(self);
        
        return self;
    };
}

/** 重新设置title */
- (JKAlertAction *(^)(NSString *title))resetTitle{
    
    return ^(NSString *title) {
        
        self->_title = title;
        
        return self;
    };
}

/** 重新设置attributedTitle */
- (JKAlertAction *(^)(NSAttributedString *attributedTitle))resetAttributedTitle{
    
    return ^(NSAttributedString *attributedTitle) {
        
        self->_attributedTitle = attributedTitle;
        
        return self;
    };
}

- (JKAlertAction *(^)(UIColor *color))setTitleColor{
    
    return ^(UIColor *color) {
        
        self.titleColor = color;
        
        return self;
    };
}

- (JKAlertAction *(^)(UIFont *font))setTitleFont{
    
    return ^(UIFont *font) {
        
        self.titleFont = font;
        
        return self;
    };
}

/**
* 设置backgroundColor 默认JKAlertGlobalBackgroundColor()
* 仅 actionSheet 与 collectionSheet的底部按钮 有效
* */
- (JKAlertAction *(^)(UIColor *backgroundColor))setBackgroundColor{
    
    return ^(UIColor *backgroundColor) {
        
        self.backgroundColor = backgroundColor;
        
        return self;
    };
}

/**
 * 设置seletedBackgroundColor 默认JKAlertGlobalHighlightedBackgroundColor()
 * 仅 actionSheet 与 collectionSheet的底部按钮 有效
 * */
- (JKAlertAction *(^)(UIColor *seletedBackgroundColor))setSeletedBackgroundColor{
    
    return ^(UIColor *seletedBackgroundColor) {
        
        self.seletedBackgroundColor = seletedBackgroundColor;
        
        return self;
    };
}

/** 设置imageContentMode 默认UIViewContentModeScaleAspectFill */
- (JKAlertAction *(^)(UIViewContentMode contentMode))setImageContentMode{
    
    return ^(UIViewContentMode contentMode) {
        
        self.imageContentMode = contentMode;
        
        return self;
    };
}

- (JKAlertAction *(^)(UIImage *image))setNormalImage{
    
    return ^(UIImage *image) {
        
        self.normalImage = image;
        
        return self;
    };
}

- (JKAlertAction *(^)(UIImage *image))setHightlightedImage{
    
    return ^(UIImage *image) {
        
        self.hightlightedImage = image;
        
        return self;
    };
}

/** 设置是否隐藏分隔线 */
- (JKAlertAction *(^)(BOOL hidden))setSeparatorLineHidden{
    
    return ^(BOOL hidden) {
        
        self.separatorLineHidden = hidden;
        
        return self;
    };
}

/** 设置是否镂空 */
- (JKAlertAction *(^)(BOOL isPireced))setPireced{
    
    return ^(BOOL isPireced) {
        
        self.isPireced = isPireced;
        
        return self;
    };
}

/** 设置执行操作后是否自动消失 */
- (JKAlertAction *(^)(BOOL autoDismiss))setAutoDismiss{
    
    return ^(BOOL autoDismiss) {
        
        self.autoDismiss = autoDismiss;
        
        return self;
    };
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
- (JKAlertAction *(^)(UIView *(^customView)(JKAlertAction *action)))setCustomView{
    
    return ^(UIView *(^customView)(JKAlertAction *action)) {
        
        self.customView = !customView ? nil : customView(self);
        
        if (self.customView) {
            
            // 重新计算rowHeight
            self->_rowHeight = -1;
        }
        
        return self;
    };
}

- (BOOL)isEmpty{
    
    return self.title == nil &&
    self.attributedTitle == nil &&
    self.handler == nil &&
    self.normalImage == nil &&
    self.hightlightedImage == nil;
}

- (CGFloat)rowHeight{
    
    if (_rowHeight < 0) {
        
        _rowHeight = self.customView ? self.customView.frame.size.height : (([UIScreen mainScreen].bounds.size.width > 321) ? 53 : 46);
    }
    return _rowHeight;
}
@end
