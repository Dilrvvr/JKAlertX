//
//  JKAlertCollectionSheetContentView.h
//  JKAlertX
//
//  Created by albert on 2020/6/4.
//

#import "JKAlertBaseAlertContentView.h"
#import "JKAlertCollectionSheetTextContentView.h"

@class JKAlertAction;

@interface JKAlertCollectionSheetContentView : JKAlertBaseAlertContentView

/** textContentView */
@property (nonatomic, weak, readonly) JKAlertCollectionSheetTextContentView *textContentView;

/** 默认的取消action，不需要自带的可以自己设置，不可置为nil */
@property (nonatomic, strong) JKAlertAction *cancelAction;

/** collection样式默认有一个取消按钮，设置这个可以在取消按钮的上面再添加一个按钮 */
@property (nonatomic, strong) JKAlertAction *collectionAction;

/** actionArray2 */
@property (nonatomic, strong) NSArray *actionArray2;

/** title底部分隔线是否隐藏 默认YES */
@property (nonatomic, assign) BOOL titleSeparatorLineHidden;

/** 两个collectionView直接的分隔线是否隐藏 默认YES */
@property (nonatomic, assign) BOOL collectionSeparatorLineHidden;

/** autoAdjustHomeIndicator */
@property (nonatomic, assign) BOOL autoAdjustHomeIndicator;

/** fillHomeIndicator */
@property (nonatomic, assign) BOOL fillHomeIndicator;

/** fillHomeIndicator */
@property (nonatomic, assign) CGFloat cancelMargin;

/** isPierced */
@property (nonatomic, assign) BOOL isPierced;

/** 镂空效果间距 只取左右下 */
@property (nonatomic, assign) UIEdgeInsets piercedInsets;

/** 镂空整体圆角 */
@property (nonatomic, assign) CGFloat piercedCornerRadius;

/** piercedBackgroundColor */
@property (nonatomic, strong) JKAlertMultiColor *piercedBackgroundColor;

/** textContentBackgroundColor */
@property (nonatomic, strong) JKAlertMultiColor *textContentBackgroundColor;

/** pageControlHidden */
@property (nonatomic, assign) BOOL pageControlHidden;

/** pageControlHeight 默认30 */
@property (nonatomic, assign) CGFloat pageControlHeight;

/**
 * 是否将两个collection合体
 * 设为YES可让两个collection同步滚动
 * 设置YES时会自动让两个collection的action数量保持一致，即向少的一方添加空的action
 */
@property (nonatomic, assign) BOOL compoundCollection;

/** collection是否分页 */
@property (nonatomic, assign) BOOL collectionPagingEnabled;

/** itemSize 默认(76, 70) */
@property (nonatomic, assign) CGSize itemSize;

/** cell类名 必须是或继承自JKAlertCollectionViewCell */
@property (nonatomic, copy) NSString *cellClassName;

/** minimumLineSpacing 默认0 */
@property (nonatomic, assign) CGFloat minimumLineSpacing;

/**
 * collection的itemSize的宽度
 * 最大不可超过屏幕宽度的一半
 * 注意图片的宽高是设置的宽度-30，即图片在cell中是左右各15的间距
 * 自动计算item之间间距，最小为0，可自己计算该值设置每屏显示个数
 * 默认的高度是宽度-6，暂不支持自定义高度
 */
@property (nonatomic, assign) CGFloat flowlayoutItemWidth;

/**
 * collection列数（每行数量）
 * 默认0，自动设置，不得大于自动设置的数量
 */
@property (nonatomic, assign) NSInteger columnCount;

/**
 * 设置collection的水平（左右方向）的sectionInset
 * 只取左右   默认0，为0时自动设置为item间距的一半 
 */
@property (nonatomic, assign) UIEdgeInsets collectionHorizontalInset;

/** collection的title下分隔线是否隐藏 */
//@property (nonatomic, assign) BOOL collectionTitleSeparatorHidden;

/**
 * 设置两个collectionView之间的间距
 * 有第二个collectionView时有效 默认0, 最小为0
 */
@property (nonatomic, assign) CGFloat collectionViewMargin;

/**
 * collection是否显示pageControl
 * 如果只有一组collection，则必须设置分页为YES才有效
 * 如果有两组collection，则仅在分页和合体都为YES时才有效
 * 注意自己计算好每页显示的个数相等
 * 可以添加空的action来保证每页显示个数相等
 * JKAlertAction使用类方法初始化时每个参数传nil或者直接自己实例化一个即为空action
 */
@property (nonatomic, assign) BOOL showPageControl;

/** colletion样式的底部按钮左右间距 */
@property (nonatomic, assign) CGFloat collectionButtonLeftRightMargin;
@end
