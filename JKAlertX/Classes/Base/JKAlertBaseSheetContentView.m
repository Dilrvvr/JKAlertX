//
//  JKAlertBaseSheetContentView.m
//  JKAlertX
//
//  Created by albert on 2020/6/29.
//

#import "JKAlertBaseSheetContentView.h"
#import "JKAlertPanGestureRecognizer.h"
#import "JKAlertView.h"
#import "JKAlertTheme.h"

@interface JKAlertBaseSheetContentView () <UIGestureRecognizerDelegate>

@end

@implementation JKAlertBaseSheetContentView

#pragma mark
#pragma mark - Public Methods

- (void)setIsPierced:(BOOL)isPierced {
    _isPierced = isPierced;
    
    self.backgroundView.hidden = isPierced;
}

- (void)setHorizontalGestureDismissDirection:(JKAlertSheetHorizontalGestureDismissDirection)horizontalGestureDismissDirection {
    _horizontalGestureDismissDirection = horizontalGestureDismissDirection;
    
    _horizontalGestureDismissEnabled = YES;
    
    switch (horizontalGestureDismissDirection) {
        case JKAlertSheetHorizontalGestureDismissDirectionHorizontal:
        {
            self.horizontalDismissPanGesture.direction = JKAlertPanGestureDirectionHorizontal;
        }
            break;
        case JKAlertSheetHorizontalGestureDismissDirectionToLeft:
        {
            self.horizontalDismissPanGesture.direction = JKAlertPanGestureDirectionToLeft;
        }
            break;
        case JKAlertSheetHorizontalGestureDismissDirectionToRight:
        {
            self.horizontalDismissPanGesture.direction = JKAlertPanGestureDirectionToRight;
        }
            break;
            
        default:
        {
            _horizontalGestureDismissEnabled = NO;
        }
            break;
    }
    
    self.horizontalDismissPanGesture.enabled = _horizontalGestureDismissEnabled;
}

- (void)setVerticalGestureDismissEnabled:(BOOL)verticalGestureDismissEnabled {
    _verticalGestureDismissEnabled = verticalGestureDismissEnabled;
    
    self.verticalDismissPanGesture.enabled = _verticalGestureDismissEnabled;
}

#pragma mark
#pragma mark - Override



#pragma mark
#pragma mark - Private Methods

- (void)checkVerticalSlideDirection {

    currentContainerY = self.frame.origin.y;
    
    if (currentContainerY < lastContainerY) { // 上滑
        
        if (beginScrollDirection == JKAlertScrollDirectionNone) {
            
            beginScrollDirection = JKAlertScrollDirectionUp;
        }
        
        endScrollDirection = JKAlertScrollDirectionUp;
    }
    
    if (currentContainerY > lastContainerY) { // 下滑
        
        if (beginScrollDirection == JKAlertScrollDirectionNone) {
            
            beginScrollDirection = JKAlertScrollDirectionDown;
        }
        
        endScrollDirection = JKAlertScrollDirectionDown;
    }
    
    lastContainerY = currentContainerY;
}

- (void)checkHorizontalSlideDirection {

    currentContainerX = self.frame.origin.x;
    
    if (currentContainerX < lastContainerX) {
        
        if (beginScrollDirection == JKAlertScrollDirectionNone) {
            
            beginScrollDirection = JKAlertScrollDirectionLeft;
        }
        
        endScrollDirection = JKAlertScrollDirectionLeft;
        
        //JKLog("左滑-------")
    }
    
    if (currentContainerX > lastContainerX) {
        
        //JKLog("右滑-------")
        
        if (beginScrollDirection == JKAlertScrollDirectionNone) {
            
            beginScrollDirection = JKAlertScrollDirectionRight;
        }
        
        endScrollDirection = JKAlertScrollDirectionRight;
    }
    
    lastContainerX = currentContainerX;
}

- (void)checkVerticalSlideShouldDismiss {
    
    CGFloat correctSheetContainerY = self.correctFrame.origin.y;
    
    CGFloat currentSheetContainerY = self.frame.origin.y;
    
    CGFloat delta = currentSheetContainerY - correctSheetContainerY;
    
    if ((delta > self.frame.size.height * 0.5) &&
        beginScrollDirection == endScrollDirection) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(alertContentViewExecuteGestureDismiss:dismissType:)]) {
            
            [self.delegate alertContentViewExecuteGestureDismiss:self dismissType:JKAlertSheetDismissAnimationTypeToBottom];
        }
        
    } else {
        
        //self.relayout(YES);
        
        [self relayoutSheetContainerView];
    }
}

- (void)checkHorizontalSlideShouldDismiss {
    
    CGFloat correctSheetContainerX = self.correctFrame.origin.x;
    
    CGFloat currentSheetContainerX = self.frame.origin.x;
    
    CGFloat delta = currentSheetContainerX - correctSheetContainerX;
    
    if ((delta > self.frame.size.width * 0.5) &&
        beginScrollDirection == endScrollDirection) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(alertContentViewExecuteGestureDismiss:dismissType:)]) {
            
            [self.delegate alertContentViewExecuteGestureDismiss:self dismissType:JKAlertSheetDismissAnimationTypeToRight];
        }
        
    } else {
        
        //self.relayout(YES);
        
        [self relayoutSheetContainerView];
    }
}

- (void)relayoutSheetContainerView {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame = self.correctFrame;
    }];
}

#pragma mark
#pragma mark - Private Selector

- (void)verticalPanGestureAction:(UIPanGestureRecognizer *)panGesture {
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            beginScrollDirection = JKAlertScrollDirectionNone;
            endScrollDirection = JKAlertScrollDirectionNone;
            
            lastContainerY = self.frame.origin.y;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            // 获取偏移
            CGPoint point = [panGesture translationInView:self];
            
            CGRect frame = self.frame;
            
            if (self.tapBlankDismiss) {
                
                if (frame.origin.y <= self.correctFrame.origin.y) {
                    
                    frame.origin.y += (point.y * 0.01);
                    
                } else {
                    
                    frame.origin.y += point.y;
                }
                
            } else {
                
                frame.origin.y += (point.y * 0.01);
            }
            
            frame.origin.y = MAX(frame.origin.y, self.correctFrame.origin.y - 5);
            
            self.frame = frame;
            
            // 归零
            [panGesture setTranslation:CGPointZero inView:self];
            
            [self checkVerticalSlideDirection];
        }
            break;
            
        default:
        {
            if (!self.tapBlankDismiss) {
                
                [self relayoutSheetContainerView];
                
                return;
            }
            
            CGPoint velocity = [panGesture velocityInView:panGesture.view];
            CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
            CGFloat slideMult = magnitude / 200;
            
            float slideFactor = 0.1 * slideMult;
            CGPoint finalPoint = CGPointMake(0, self.frame.origin.y + (velocity.y * slideFactor));
            
            BOOL isSlideHalf = (finalPoint.y - self.correctFrame.origin.y > self.frame.size.height * 0.5);
            
            if (isSlideHalf &&
                self.tapBlankDismiss &&
                (endScrollDirection == JKAlertScrollDirectionDown)) {
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(alertContentViewExecuteGestureDismiss:dismissType:)]) {
                        
                        [self.delegate alertContentViewExecuteGestureDismiss:self dismissType:JKAlertSheetDismissAnimationTypeToBottom];
                    }
                
            } else {
                
                [self relayoutSheetContainerView];
            }
        }
            break;
    }
}

- (void)horizontalPanGestureAction:(UIPanGestureRecognizer *)panGesture {
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            beginScrollDirection = JKAlertScrollDirectionNone;
            endScrollDirection = JKAlertScrollDirectionNone;
            
            lastContainerX = self.frame.origin.x;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            // 获取偏移
            CGPoint point = [panGesture translationInView:self.contentView];
            
            CGPoint center = self.center;
            
            if (self.tapBlankDismiss) {
                
                CGFloat piercedWidth = (self.isPierced ? self.piercedInsets.left + self.piercedInsets.right : 0.0);
                
                switch (self.horizontalGestureDismissDirection) {
                    case JKAlertSheetHorizontalGestureDismissDirectionHorizontal:
                    {
                        center.x += point.x;
                    }
                        break;
                    case JKAlertSheetHorizontalGestureDismissDirectionToLeft:
                    {
                        if (center.x >= ((self.alertWidth + piercedWidth) * 0.5)) {
                            
                            center.x += (point.x * 0.01);
                            
                        } else {
                            
                            center.x += point.x;
                        }
                    }
                        break;
                    case JKAlertSheetHorizontalGestureDismissDirectionToRight:
                    {
                        if (center.x <= ((self.alertWidth + piercedWidth) * 0.5)) {
                            
                            center.x += (point.x * 0.01);
                            
                        } else {
                            
                            center.x += point.x;
                        }
                    }
                        break;
                        
                    default:
                        break;
                }
                
            } else {
                
                center.x += (point.x * 0.01);
            }
            
            self.center = center;
            
            // 归零
            [panGesture setTranslation:CGPointZero inView:self.contentView];
            
            [self checkHorizontalSlideDirection];
        }
            break;
            
        default:
        {
            if (!self.tapBlankDismiss) {
                
                [self relayoutSheetContainerView];
                
                return;
            }
            
            CGPoint velocity = [panGesture velocityInView:panGesture.view];
            CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
            CGFloat slideMult = magnitude / 200;
            
            float slideFactor = 0.1 * slideMult;
            CGPoint finalPoint = CGPointMake(self.center.x + (velocity.x * slideFactor), self.center.y + (velocity.y * slideFactor));
            
            BOOL isSlideToRightHalf = finalPoint.x > self.frame.size.width;
            BOOL isSlideToLeftHalf = finalPoint.x < 0;
            
            if (isSlideToRightHalf &&
                self.tapBlankDismiss &&
                beginScrollDirection == endScrollDirection) {
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(alertContentViewExecuteGestureDismiss:dismissType:)]) {
                        
                        [self.delegate alertContentViewExecuteGestureDismiss:self dismissType:JKAlertSheetDismissAnimationTypeToRight];
                    }
                
            } else if (isSlideToLeftHalf &&
                       self.tapBlankDismiss &&
                       beginScrollDirection == endScrollDirection) {
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(alertContentViewExecuteGestureDismiss:dismissType:)]) {
                    
                    [self.delegate alertContentViewExecuteGestureDismiss:self dismissType:JKAlertSheetDismissAnimationTypeToLeft];
                }
                
            } else {
                
                [self relayoutSheetContainerView];
            }
        }
            break;
    }
}

#pragma mark
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer == self.verticalDismissPanGesture) {
        
        return self.verticalGestureDismissEnabled;
    }
    
    if (gestureRecognizer == self.horizontalDismissPanGesture) {
        
        return self.horizontalGestureDismissEnabled;
    }
    
    return YES;
}

#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 */
- (void)initializeProperty {
    [super initializeProperty];
    
    _gestureIndicatorHidden = YES;
    
    _showScaleAnimated = NO;
    
    _autoHideLastActionSeparatorLine = YES;
    
    _autoAdjustHomeIndicator = YES;
    
    _fillHomeIndicator = YES;
    
    _cancelMargin = ((JKAlertScreenWidth > 321) ? 7 : 5);
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
    [self addGestureRecognizer:self.verticalDismissPanGesture];
    [self addGestureRecognizer:self.horizontalDismissPanGesture];
    
    self.verticalDismissPanGesture.enabled = self.verticalGestureDismissEnabled;
    self.horizontalDismissPanGesture.enabled = self.horizontalGestureDismissEnabled;
}

/** 创建UI */
- (void)createUI {
    [super createUI];
    
}

/** 布局UI */
- (void)layoutUI {
    [super layoutUI];
    
}

/** 初始化UI数据 */
- (void)initializeUIData {
    [super initializeUIData];
    
}

#pragma mark
#pragma mark - Private Property

- (UIView *)topGestureIndicatorView {
    if (!_topGestureIndicatorView) {
        UIView *topGestureIndicatorView = [[UIView alloc] init];
        topGestureIndicatorView.hidden = YES;
        topGestureIndicatorView.userInteractionEnabled = NO;
        [self.topContentView addSubview:topGestureIndicatorView];
        _topGestureIndicatorView = topGestureIndicatorView;
        
        UIView *topGestureLineView = [[UIView alloc] init];
        
        topGestureLineView.userInteractionEnabled = NO;
        topGestureLineView.layer.cornerRadius = 2;
        [topGestureIndicatorView addSubview:topGestureLineView];
        
        [JKAlertThemeProvider providerBackgroundColorWithOwner:topGestureLineView provideHandler:^(JKAlertThemeProvider *provider, UIView *providerOwner) {
            
            providerOwner.backgroundColor = JKAlertCheckDarkMode(JKAlertSameRGBColor(208), JKAlertSameRGBColor(47));
        }];
        
        _topGestureLineView = topGestureLineView;
    }
    return _topGestureIndicatorView;
}

- (JKAlertPanGestureRecognizer *)verticalDismissPanGesture {
    if (!_verticalDismissPanGesture) {
        
        _verticalDismissPanGesture = [[JKAlertPanGestureRecognizer alloc] initWithTarget:self action:@selector(verticalPanGestureAction:)];
        _verticalDismissPanGesture.direction = JKAlertPanGestureDirectionVertical;
        _verticalDismissPanGesture.delegate = self;
    }
    return _verticalDismissPanGesture;
}

- (JKAlertPanGestureRecognizer *)horizontalDismissPanGesture {
    if (!_horizontalDismissPanGesture) {
        _horizontalDismissPanGesture = [[JKAlertPanGestureRecognizer alloc] initWithTarget:self action:@selector(horizontalPanGestureAction:)];
        _horizontalDismissPanGesture.direction = JKAlertPanGestureDirectionHorizontal;
        _horizontalDismissPanGesture.delegate = self;
    }
    return _horizontalDismissPanGesture;
}

- (BOOL)bottomButtonPinned {
    
    if (self.isPierced) { return YES; }
    
    return _bottomButtonPinned;
}
@end
