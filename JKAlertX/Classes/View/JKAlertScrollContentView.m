//
//  JKAlertScrollContentView.m
//  JKAlertX
//
//  Created by albert on 2020/6/16.
//

#import "JKAlertScrollContentView.h"

@implementation JKAlertScrollContentView

- (void)updateContentSize {
    
    self.scrollView.contentSize = CGSizeMake(0, self.frame.size.height);
}

- (void)checkScrollEnabled {
    
    self.scrollView.scrollEnabled = (self.scrollView.contentSize.height > self.frame.size.height);
}
@end
