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

+ (instancetype)actionWithAttributeTitle:(NSAttributedString *)attributeTitle handler:(void(^)(JKAlertAction *action))handler{
    
    JKAlertAction *action = [[JKAlertAction alloc] init];
    
    action->_attributeTitle = attributeTitle;
    action->_handler = handler;
    action->_alertActionStyle = JKAlertActionStyleDefault;
    
    return action;
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
}

- (JKAlertAction *(^)(UIImage *image))setNormalImage{
    
    return ^(UIImage *image){
        
        self.normalImage = image;
        
        return self;
    };
}

- (JKAlertAction *(^)(UIImage *image))setHightlightedImage{
    
    return ^(UIImage *image){
        
        self.hightlightedImage = image;
        
        return self;
    };
}

/** 设置是否隐藏分隔线 */
- (JKAlertAction *(^)(BOOL hidden))setSeparatorLineHidden{
    
    return ^(BOOL hidden){
        
        self.separatorLineHidden = hidden;
        
        return self;
    };
}

/**
 * 自定义的view
 * 注意要自己计算好frame
 */
- (JKAlertAction *(^)(UIView *(^customView)(void)))setCustomView{
    
    return ^(UIView *(^customView)(void)){
        
        self.customView = !customView ? nil : customView();
        
        return self;
    };
}

- (BOOL)isEmpty{
    
    return self.title == nil &&
    self.attributeTitle == nil &&
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
