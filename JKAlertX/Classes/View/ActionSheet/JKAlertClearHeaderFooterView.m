//
//  JKAlertClearHeaderFooterView.m
//  JKAlertX
//
//  Created by AlbertCC on 2021/5/15.
//

#import "JKAlertClearHeaderFooterView.h"

@implementation JKAlertClearHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    
    self.contentView.backgroundColor = nil;
    
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.backgroundColor = nil;
}
@end
