//
//  JKAlertCollectionSheetContentView.h
//  JKAlertX
//
//  Created by albert on 2020/6/4.
//

#import "JKAlertBaseSheetContentView.h"
#import "JKAlertCollectionSheetTextContentView.h"

@class JKAlertAction, JKAlertActionButton;

@interface JKAlertCollectionSheetContentView : JKAlertBaseSheetContentView

/** topContainerView */
@property (nonatomic, weak, readonly) UIView *topContainerView;

/** textContentView */
@property (nonatomic, weak, readonly) JKAlertCollectionSheetTextContentView *textContentView;

/** cancelButton */
@property (nonatomic, weak, readonly) JKAlertActionButton *cancelButton;

/** collectionButton */
@property (nonatomic, weak, readonly) JKAlertActionButton *collectionButton;

/** collection样式默认有一个取消按钮，设置这个可以在取消按钮的上面再添加一个按钮 */
@property (nonatomic, strong) JKAlertAction *collectionAction;

/** secondActionArray */
@property (nonatomic, strong) NSMutableArray *secondActionArray;

/** buttonInsets */
@property (nonatomic, assign) UIEdgeInsets buttonInsets;





/** title底部分隔线是否隐藏 默认YES */
@property (nonatomic, assign) BOOL titleSeparatorLineHidden;

/** 两个collectionView直接的分隔线是否隐藏 默认YES */
@property (nonatomic, assign) BOOL collectionSeparatorLineHidden;

/** pageControl */
@property (nonatomic, weak, readonly) UIPageControl *pageControl;

/** pageControlHidden */
@property (nonatomic, assign) BOOL pageControlHidden;

/** pageControlHeight 默认30 */
@property (nonatomic, assign) CGFloat pageControlHeight;

/**
 * 是否将两个collection合体
 * 设为YES可让两个collection同步滚动
 */
@property (nonatomic, assign) BOOL combined;

/** collection是否分页 */
@property (nonatomic, assign) BOOL collectionPagingEnabled;

/** itemSize 默认(76, 70) */
@property (nonatomic, assign) CGSize itemSize;

/** cell类名 必须是或继承自JKAlertCollectionViewCell */
@property (nonatomic, copy) NSString *cellClassName;

/** minimumLineSpacing 默认10 */
@property (nonatomic, assign) CGFloat minimumLineSpacing;

/**
 * collection列数（每行数量）
 * 默认0，自动设置，不得大于自动设置的数量
 */
@property (nonatomic, assign) NSInteger columnCount;

/**
 * 设置collection的水平（左右方向）的sectionInset
 * 只取左右   默认0，为0时自动设置为item间距的一半 
 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;

/**
 * 设置两个collectionView之间的间距
 * 有第二个collectionView时有效 默认0, 最小为0
 */
@property (nonatomic, assign) CGFloat collectionViewMargin;

/** colletion样式的底部按钮左右间距 */
@property (nonatomic, assign) CGFloat collectionButtonLeftRightMargin;
@end
