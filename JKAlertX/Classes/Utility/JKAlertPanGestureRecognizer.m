//
//  JKAlertPanGestureRecognizer.m
//  JKAlertX
//
//  Created by albert on 2019/12/18.
//  Copyright © 2019 Albert. All rights reserved.
//

#import "JKAlertPanGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface JKAlertPanGestureRecognizer ()
{
    BOOL panGestureDidDelayBlockExecute;
}

@property (assign, nonatomic) CGPoint beganLocation;
@property (strong, nonatomic) UIEvent *event;
@property (assign, nonatomic) NSTimeInterval beganTime;

/** judgedDirection */
@property (nonatomic, assign) BOOL judgedDirection;
@end

@implementation JKAlertPanGestureRecognizer

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    if (self = [super initWithTarget:target action:action]) {
        _maxRecognizeTime = 0.3;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    _judgedDirection = NO;
    
    UITouch *touch = [touches anyObject];
    
    self.beganLocation = [touch locationInView:self.view];
    self.event = event;
    self.beganTime = event.timestamp;
    
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!_judgedDirection) {
        
        UITouch *touch = [touches anyObject];
        
        CGPoint location = [touch locationInView:self.view];
        
        if (!CGPointEqualToPoint(location, self.beganLocation)) {
            
            switch (_direction) {
                case JKAlertPanGestureDirectionToLeft:
                {
                    if (location.x >= self.beganLocation.x ||
                        (fabs(self.beganLocation.x - location.x) < fabs(self.beganLocation.y - location.y))) {
                        
                        self.state = UIGestureRecognizerStateFailed;
                        
                        _judgedDirection = YES;
                        
                        return;
                    }
                }
                    break;
                case JKAlertPanGestureDirectionToRight:
                {
                    if (location.x <= self.beganLocation.x ||
                        (fabs(self.beganLocation.x - location.x) < fabs(self.beganLocation.y - location.y))) {
                        
                        self.state = UIGestureRecognizerStateFailed;
                        
                        _judgedDirection = YES;
                        
                        return;
                    }
                }
                    break;
                case JKAlertPanGestureDirectionToTop:
                {
                    if (location.y <= self.beganLocation.y ||
                        (fabs(self.beganLocation.x - location.x) > fabs(self.beganLocation.y - location.y))) {
                        
                        self.state = UIGestureRecognizerStateFailed;
                        
                        _judgedDirection = YES;
                        
                        return;
                    }
                }
                    break;
                case JKAlertPanGestureDirectionToBottom:
                {
                    if (location.y >= self.beganLocation.y ||
                        (fabs(self.beganLocation.x - location.x) > fabs(self.beganLocation.y - location.y))) {
                        
                        self.state = UIGestureRecognizerStateFailed;
                        
                        _judgedDirection = YES;
                        
                        return;
                    }
                }
                    break;
                case JKAlertPanGestureDirectionHorizontal:
                {
                    if (fabs(self.beganLocation.x - location.x) < fabs(self.beganLocation.y - location.y)) {
                        
                        self.state = UIGestureRecognizerStateFailed;
                        
                        _judgedDirection = YES;
                        
                        return;
                    }
                }
                    break;
                case JKAlertPanGestureDirectionVertical:
                {
                    if (fabs(self.beganLocation.x - location.x) > fabs(self.beganLocation.y - location.y)) {
                        
                        self.state = UIGestureRecognizerStateFailed;
                        
                        _judgedDirection = YES;
                        
                        return;
                    }
                }
                    break;
                    
                default:
                    break;
            }
            
            _judgedDirection = YES;
        }
    }
    
    /*
    if (self.shouldDelay &&
        self.state == UIGestureRecognizerStateBegan &&
        event.timestamp - self.beganTime < 0.2) {
        
        self.state = UIGestureRecognizerStateFailed;
        
        return;
    }
    
    if (!panGestureDidDelayBlockExecute && event.timestamp - self.beganTime > 0.2) {
        
        panGestureDidDelayBlockExecute = YES;
        
        !self.panGestureDidDelayBlock ? : self.panGestureDidDelayBlock(self);
    } //*/
    
    if (self.maxRecognizeTime > 0) {
        
        UITouch *touch = [touches anyObject];
        
        CGPoint location = [touch locationInView:self.view];
        
        if (self.minDistance > 0 &&
            fabs(self.beganLocation.x - location.x) < self.minDistance &&
            fabs(self.beganLocation.y - location.y) < self.minDistance) {
            
            self.state = UIGestureRecognizerStateFailed;
            
            return;
        }
        
        if (self.state == UIGestureRecognizerStatePossible &&
            event.timestamp - self.beganTime > self.maxRecognizeTime) {
            
            self.state = UIGestureRecognizerStateFailed;
            
            return;
        }
    }
    
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    panGestureDidDelayBlockExecute = NO;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    
    panGestureDidDelayBlockExecute = NO;
}

- (void)reset {
    self.beganLocation = CGPointZero;
    self.event = nil;
    self.beganTime = 0;
    [super reset];
}

- (CGPoint)beganLocationInView:(UIView *)view {
    return [view convertPoint:self.beganLocation fromView:self.view];
}
@end
