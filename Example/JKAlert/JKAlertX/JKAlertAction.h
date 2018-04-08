//
//  JKAlertAction.h
//  TestVideoAndPicture
//
//  Created by albert on 2017/4/18.
//  Copyright © 2017年 安永博. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    JKAlertActionStyleDefault, // 默认黑色字体
    JKAlertActionStyleDestructive, // 红色字体
} JKAlertActionStyle;

@interface JKAlertAction : NSObject

/** attributeTitle */
@property (nonatomic, strong, readonly) NSAttributedString *attributeTitle;

/** title */
@property (nonatomic, copy, readonly) NSString *title;

/** handler */
@property (nonatomic, copy, readonly) void (^handler)(JKAlertAction *action);

/** normalImage */
@property (nonatomic, strong) UIImage *normalImage;

/** hightlightedImage */
@property (nonatomic, strong) UIImage *hightlightedImage;

/**
 * 是否是空的action
 * 以上5个属性都为nil时即为空的action
 * 空action在非plain样式以外，点击将没有任何反应
 */
@property (nonatomic, assign, readonly) BOOL isEmpty;

/** 样式 */
@property (nonatomic, assign, readonly) JKAlertActionStyle alertActionStyle;

/** actionSheet样式cell高度 */
@property (nonatomic, assign, readonly) CGFloat rowHeight;

/** 是否隐藏分隔线 */
@property (nonatomic, assign) BOOL separatorLineHidden;

/**
 * 自定义的view，目前仅在actionSheet适用
 * 注意要自己计算好frame
 */
@property (nonatomic, strong) UIView *customView;

/**
 * 实例化action
 * title: 标题
 * style: 样式
 * handler: 点击的操作
 */
+ (instancetype)actionWithTitle:(NSString *)title style:(JKAlertActionStyle)style handler:(void(^)(JKAlertAction *action))handler;

/**
 * 实例化action
 * attributeTitle: 富文本标题
 * style: 样式
 * handler: 点击的操作
 */
+ (instancetype)actionWithAttributeTitle:(NSAttributedString *)attributeTitle handler:(void(^)(JKAlertAction *action))handler;


/** 设置普通状态图片 */
- (JKAlertAction *(^)(UIImage *image))setNormalImage;

/** 设置高亮状态图片 */
- (JKAlertAction *(^)(UIImage *image))setHightlightedImage;

/** 设置是否隐藏分隔线 */
- (JKAlertAction *(^)(BOOL hidden))setSeparatorLineHidden;

/**
 * 自定义的view，目前仅在actionSheet适用
 * 注意要自己计算好frame
 */
- (JKAlertAction *(^)(UIView *(^customView)(void)))setCustomView;
@end
