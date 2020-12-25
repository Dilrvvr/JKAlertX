//
//  JKAlertView+CollectionSheet.h
//  JKAlertX
//
//  Created by albert on 2020/6/8.
//

#import "JKAlertView.h"

@interface JKAlertView (CollectionSheet)

/**
 * collection样式顶部的背景色
 * pierced镂空样式时，表示上部分的颜色，包括title和collectionView
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetTopBackgroundColor)(UIColor *color);

/**
 * actionSheet样式底部按钮的颜色
 * 默认无
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetBottomButtonBackgroundColor)(UIColor *color);

/**
 * collection的itemSize
 * 注意图片的宽高是设置的宽度-30，即图片在cell中是左右各15的间距
 * 默认(76, 70)，建议高度是宽度-6
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetItemSize)(CGSize itemSize);

/**
 * collection的minimumLineSpacing
 * 默认10
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetMinimumLineSpacing)(CGFloat minimumLineSpacing);

/**
 * collection列数（每行数量）
 * 默认0，自动设置，不得大于自动设置的数量
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetColumnCount)(NSInteger columnCount);

/**
 * collection样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetCustomTitleView)(UIView *(^customView)(void));

/**
 * collection的title下分隔线是否隐藏
 * 默认YES
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetTitleSeparatorLineHidden)(BOOL hidden);

/**
 * collection的水平（左右方向）的sectionInset
 * 默认(0, 10, 0, 10)，只取左右
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetSectionInset)(UIEdgeInsets inset);

/**
 * 两个collectionView之间的间距
 * 有第二个collectionView时有效 默认10, 最小为0
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetCollectionViewMargin)(CGFloat margin);

/**
 * 是否将两个collectionView合体
 * 设为YES可让两个collectionView同步滚动
 * 设为YES时请保证让两个collection的action数量保持一致
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetCombined)(BOOL combined);

/**
 * collection是否分页
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetPagingEnabled)(BOOL pagingEnabled);

/**
 * collection是否隐藏pageControl
 * 如果只有一组collection，则必须设置分页为YES才有效
 * 如果有两组collection，则仅在分页和合体都为YES时才有效
 * 注意自己计算好每页显示的个数相等
 * 可以添加空的action来保证每页显示个数相等
 * JKAlertAction使用类方法初始化时每个参数传nil或者直接自己实例化一个即为空action
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetPageControlHidden)(BOOL hidden);

/**
 * pageControl高度
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetPageControlHeight)(CGFloat height);

/**
 * 配置pageControl
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetPageControlConfiguration)(void (^)(UIPageControl *pageControl));

/**
 * colletion样式的底部按钮间距
 * 默认(0, 0, 0, 0)只取左右
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetButtonInsets)(UIEdgeInsets insets);

/**
 * collection样式默认有一个取消按钮，设置这个可以在取消按钮的上面再添加一个按钮
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetAction)(JKAlertAction *action);

/**
 * collectionSheet底部按钮是否固定在底部
 * 默认NO
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetBottomButtonPinned)(BOOL pinned);

/**
 * collectionSheet是否镂空
 * 设置为YES后，makeActionSheetBottomButtonPinned将强制为YES
 * piercedInsets : 整体左、右、下间距
 */
@property (nonatomic, copy, readonly) JKAlertView *(^makeCollectionSheetPierced)(BOOL isPierced, UIEdgeInsets piercedInsets);



/** collection添加第二个collectionView的action */
- (void)addSecondCollectionAction:(JKAlertAction *)action;

/** 添加第二个collectionView的action */
- (void)insertSecondCollectionAction:(JKAlertAction *)action atIndex:(NSUInteger)index;

/** collection链式添加第二个collectionView的action */
@property (nonatomic, copy, readonly) JKAlertView *(^addSecondCollectionAction)(JKAlertAction *action);

/** collection链式添加第二个collectionView的action */
@property (nonatomic, copy, readonly) JKAlertView *(^insertSecondCollectionAction)(JKAlertAction *action, NSUInteger atIndex);
@end
