//
//  JKAlertCustomizerCommon.m
//  JKAlertX
//
//  Created by albert on 2018/10/17.
//  Copyright © 2018 安永博. All rights reserved.
//

#import "JKAlertCustomizerCommon.h"
#import "JKAlertCustomizer.h"

@interface JKAlertCustomizerCommon ()

@end

@implementation JKAlertCustomizerCommon

- (instancetype)initWithCustomizer:(JKAlertCustomizer *)customizer{
    if (self = [super initWithCustomizer:customizer]) {
        [self initialization];
    }
    return self;
}

- (void)initialization{
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.clipsToBounds = YES;
    _backgroundView = toolbar;
    
    _textViewUserInteractionEnabled = YES;
    _titleTextViewAlignment = NSTextAlignmentCenter;
    _messageTextViewAlignment = NSTextAlignmentCenter;
}

/**
 * 设置自定义的父控件
 * 默认添加到keywindow上
 * customSuperView在show之前有效
 * customSuperViewsize最好和屏幕大小一致，否则可能出现问题
 */
- (JKAlertCustomizerCommon *(^)(UIView *customSuperView))setCustomSuperView{
    
    return ^(UIView *customSuperView){
        
        self->_customSuperView = customSuperView;
        
        return self;
    };
}




/**
 * 设置背景view
 * 默认是一个UIToolbar
 */
- (JKAlertCustomizerCommon *(^)(UIView *(^backgroundViewBlock)(void)))setBackgroundView{
    
    return ^(UIView *(^backgroundViewBlock)(void)){
        
        [self->_backgroundView removeFromSuperview];
        
        self->_backgroundView = nil;
        
        self->_backgroundView = !backgroundViewBlock ? nil : backgroundViewBlock();
        
        return self;
    };
}




/**
  * 设置全屏背景view 默认nil
  */
- (JKAlertCustomizerCommon *(^)(UIView *(^backgroundViewBlock)(void)))setFullScreenBackgroundView{
    
    return ^(UIView *(^backgroundViewBlock)(void)){
        
        [self->_fullScreenBackgroundView removeFromSuperview];
        
        self->_fullScreenBackgroundView = nil;
        
        self->_fullScreenBackgroundView = !backgroundViewBlock ? nil : backgroundViewBlock();
        
        return self;
    };
}




/** 设置title和message是否可以响应事件，默认YES 如无必要不建议设置为NO */
- (JKAlertCustomizerCommon *(^)(BOOL userInteractionEnabled))setTextViewUserInteractionEnabled{
    
    return ^(BOOL userInteractionEnabled){
        
        self->_textViewUserInteractionEnabled = userInteractionEnabled;
        
        return self;
    };
}




/** 设置title和message是否可以选择文字，默认NO */
- (JKAlertCustomizerCommon *(^)(BOOL canselectText))setTextViewCanSelectText{
    
    return ^(BOOL canSelectText){
        
        self->_textViewCanSelectText = canSelectText;
        
        return self;
    };
}




/**
 * 设置title文字颜色
 * plain默认RGB都为0.1，其它0.35
 */
- (JKAlertCustomizerCommon *(^)(UIColor *textColor))setTitleTextColor{
    
    return ^(UIColor *textColor){
        
        self->_titleTextColor = textColor;
        
        return self;
    };
}




/**
 * 设置title文字 字体
 * plain默认 bold 17，其它17
 */
- (JKAlertCustomizerCommon *(^)(UIFont *font))setTitleTextFont{
    
    return ^(UIFont *font){
        
        self->_titleFont = font;
        
        return self;
    };
}




/**
 * 设置message文字颜色
 * plain默认RGB都为0.55，其它0.3
 */
- (JKAlertCustomizerCommon *(^)(UIColor *textColor))setMessageTextColor{
    
    return ^(UIColor *textColor){
        
        self->_messageTextColor = textColor;
        
        return self;
    };
}




/**
 * 设置message文字 字体
 * plain默认14，其它13
 * action样式在没有title的时候，自动改为15，设置该值后将始终为该值，不自动修改
 */
- (JKAlertCustomizerCommon *(^)(UIFont *font))setMessageTextFont{
    
    return ^(UIFont *font){
        
        self->_messageFont = font;
        
        return self;
    };
}




/** 设置titleTextViewDelegate */
- (JKAlertCustomizerCommon *(^)(id<UITextViewDelegate> delegate))setTitleTextViewDelegate{
    
    return ^(id<UITextViewDelegate> delegate){
        
        self->_titleTextViewDelegate = delegate;
        
        return self;
    };
}

/** 设置messageTextViewDelegate */
- (JKAlertCustomizerCommon *(^)(id<UITextViewDelegate> delegate))setMessageTextViewDelegate{
    
    return ^(id<UITextViewDelegate> delegate){
        
        self->_messageTextViewDelegate = delegate;
        
        return self;
    };
}




/** 设置titleTextView的文字水平样式 */
- (JKAlertCustomizerCommon *(^)(NSTextAlignment textAlignment))setTitleTextViewAlignment{
    
    return ^(NSTextAlignment textAlignment){
        
        self->_titleTextViewAlignment = textAlignment;
        
        return self;
    };
}




/** 设置messageTextView的文字水平样式 */
- (JKAlertCustomizerCommon *(^)(NSTextAlignment textAlignment))setMessageTextViewAlignment{
    
    return ^(NSTextAlignment textAlignment){
        
        self->_messageTextViewAlignment = textAlignment;
        
        return self;
    };
}




/** 设置是否允许dealloc打印，用于检查循环引用 */
- (JKAlertBaseCustomizer *(^)(BOOL enabled))setDeallocLogEnabled{
    
    return ^(BOOL enabled){
        
        self->_deallocLogEnabled = enabled;
        
        return self;
    };
}
@end
