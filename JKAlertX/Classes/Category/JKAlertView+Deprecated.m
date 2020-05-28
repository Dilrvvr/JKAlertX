//
//  JKAlertView+Deprecated.m
//  JKAlertX
//
//  Created by albert on 2020/5/20.
//

#import "JKAlertView+Deprecated.h"
#import "JKAlertView+PrivateProperty.h"

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
@end
