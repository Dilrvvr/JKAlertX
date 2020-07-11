//
//  JKAlertPlainTextContentView.m
//  JKAlertX
//
//  Created by albert on 2020/5/28.
//

#import "JKAlertPlainTextContentView.h"
#import "JKAlertTextContainerView.h"

@implementation JKAlertPlainTextContentView

#pragma mark
#pragma mark - Public Methods

- (void)calculateUI {
    [super calculateUI];
    
}

#pragma mark
#pragma mark - Override



#pragma mark
#pragma mark - Private Methods



#pragma mark
#pragma mark - Private Selector



#pragma mark
#pragma mark - Custom Delegates



#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 */
- (void)initializeProperty {
    [super initializeProperty];
    
    self.titleTextView.textView.font = [UIFont boldSystemFontOfSize:17];
    self.messageTextView.textView.font = [UIFont systemFontOfSize:14];
    
    // TODO: JKTODO <#注释#>
//    self.titleTextColor = [JKAlertMultiColor colorWithLightColor:JKAlertSameRGBColor(25.5) darkColor:JKAlertSameRGBColor(229.5)];
//    self.messageTextColor = [JKAlertMultiColor colorWithLightColor:JKAlertSameRGBColor(140.25) darkColor:JKAlertSameRGBColor(114.75)];
}

/** 构造函数初始化时调用 注意调用super */
- (void)initialization {
    [super initialization];
    
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
    
    //self.titleTextView.font = self.alertStyle == JKAlertStylePlain ? [UIFont boldSystemFontOfSize:17] : [UIFont systemFontOfSize:17];
    //self.messageTextView.font = self.alertStyle == JKAlertStylePlain ? [UIFont systemFontOfSize:14] : [UIFont systemFontOfSize:13];
    
    //self.titleTextView.textColor = self.alertStyle == JKAlertStylePlain ? JKAlertAdaptColor(JKAlertSameRGBColor(25.5), JKAlertSameRGBColor(229.5)) : JKAlertAdaptColor(JKAlertSameRGBColor(89.25), JKAlertSameRGBColor(165.75));
    //self.messageTextView.textColor = self.alertStyle == JKAlertStyleActionSheet ? JKAlertAdaptColor(JKAlertSameRGBColor(140.25), JKAlertSameRGBColor(114.75)) : JKAlertAdaptColor(JKAlertSameRGBColor(76.5), JKAlertSameRGBColor(178.5));
    
    // TODO: JKTODO delete
    
    //self.titleTextView.backgroundColor = [UIColor orangeColor];
    //self.messageTextView.backgroundColor = [UIColor orangeColor];
}

#pragma mark
#pragma mark - Private Property




@end
