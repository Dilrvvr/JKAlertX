//
//  JKAlertView+Deprecated.m
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertView+Deprecated.h"
#import "JKAlertView+PrivateProperty.h"
#import "JKAlertView+Public.h"

@implementation JKAlertView (Deprecated)

/** 设置title和message是否可以选择文字，默认NO */
- (JKAlertView *(^)(BOOL canselectText))setTextViewCanSelectText {
    
    return ^(BOOL canSelectText) {
        
        self.textViewShouldSelectText = canSelectText;
        
        return self;
    };
}

- (JKAlertView * (^)(void(^willShowAnimation)(JKAlertView *view)))setWillShowAnimation {
    
    return ^(void(^willShowAnimation)(JKAlertView *view)) {
        
        self.willShowHandler = willShowAnimation;
        
        return self;
    };
}

- (JKAlertView * (^)(void(^showAnimationComplete)(JKAlertView *view)))setShowAnimationComplete {
    
    return ^(void(^showAnimationComplete)(JKAlertView *view)) {
        
        self.didShowHandler = showAnimationComplete;
        
        return self;
    };
}

- (JKAlertView * (^)(void(^willDismiss)(void)))setWillDismiss {
    
    return ^JKAlertView * (void(^willDismiss)(void)) {
        
        self.willDismissHandler = willDismiss;
        
        return self;
    };
}

- (JKAlertView * (^)(void(^dismissComplete)(void)))setDismissComplete {
    
    return ^(void(^dismissComplete)(void)) {
        
        self.didDismissHandler = dismissComplete;
        
        return self;
    };
}

/** 准备重新布局 */
- (JKAlertView * (^)(void))prepareToRelayout {
    
    return ^{ return self; };
}

/** 重新设置其它属性，调用该方法返回JKAlertView，设置好其它属性后，再调用relayout即可 */
- (JKAlertView * (^)(void))resetOther {
    
    return ^{
        
        return self;
    };
}


#pragma mark
#pragma mark - 公共部分

/** 在这个block内自定义其它属性 */
- (JKAlertView *(^)(void(^customizePropertyHandler)(JKAlertView *customizePropertyAlertView)))setCustomizePropertyHandler {
    
    return ^(void(^customizePropertyHandler)(JKAlertView *customizePropertyAlertView)) {
        
        !customizePropertyHandler ? : customizePropertyHandler(self);
        
        return self;
    };
}

/**
 * 设置自定义的父控件
 * 默认添加到keywindow上
 * customSuperView在show之前有效
 * customSuperViewsize最好和屏幕大小一致，否则可能出现问题
 */
- (JKAlertView *(^)(UIView *customSuperView))setCustomSuperView {
    
    return ^(UIView *customSuperView) {
        
        self.customSuperView = customSuperView;
        
        if (!customSuperView) { return self; }
        
        CGFloat rotation = [[self.customSuperView.layer valueForKeyPath:@"transform.rotation.z"] floatValue];
        
        if ((rotation > 1.57 && rotation < 1.58) ||
            (rotation > -1.58 && rotation < -1.57)) {
            
            self->JKAlertScreenW = self.customSuperView.frame.size.height;//MAX(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
            self->JKAlertScreenH = self.customSuperView.frame.size.width;//MIN(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
            
            [self updateMaxHeight];
            
        } else  {
            
            //self->JKAlertScreenW = MIN(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
            //self->JKAlertScreenH = MAX(self.customSuperView.frame.size.width, self.customSuperView.frame.size.height);
            
            [self updateWidthHeight];
        }
        
        return self;
    };
}

/**
 * 设置点击空白处是否消失，plain默认NO，其它YES
 */
- (JKAlertView *(^)(BOOL shouldDismiss))setClickBlankDismiss {
    
    return ^(BOOL shouldDismiss) {
        
        self.tapBlankDismiss = shouldDismiss;
        
        return self;
    };
}

/** 设置监听点击空白处的block */
- (JKAlertView * (^)(void(^blankClickBlock)(void)))setBlankClickBlock{
    
    return ^(void(^blankClickBlock)(void)) {
        
        self.blankClickBlock = blankClickBlock;
        
        return self;
    };
}

/**
 * 配置弹出视图的容器view，加圆角等
 */
- (JKAlertView *(^)(void (^containerViewConfig)(UIView *containerView)))setContainerViewConfig{
    
    return ^(void (^containerViewConfig)(UIView *containerView)) {
        
        self.alertContentViewConfiguration = containerViewConfig;
        
        return self;
    };
}
@end
