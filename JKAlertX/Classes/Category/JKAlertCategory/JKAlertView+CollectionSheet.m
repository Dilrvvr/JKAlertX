//
//  JKAlertView+CollectionSheet.m
//  JKAlertX
//
//  Created by albert on 2020/6/8.
//

#import "JKAlertView+CollectionSheet.h"
#import "JKAlertView+Public.h"
#import "JKAlertView+PrivateProperty.h"

@implementation JKAlertView (CollectionSheet)

/**
 * collection样式默认有一个取消按钮，设置这个可以在取消按钮的上面再添加一个按钮
 */
- (JKAlertView *(^)(JKAlertAction *action))makeCollectionSheetAction {
    
    return ^(JKAlertAction *action) {
        
        return [self checkCollectionSheetStyleHandler:^{
            
            self.collectionsheetContentView.collectionAction = action;
            
            [self setAlertViewToAction:self.collectionsheetContentView.collectionAction];
        }];
    };
}

/**
 * collection的itemSize
 * 注意图片的宽高是设置的宽度-30，即图片在cell中是左右各15的间距
 * 默认(76, 70)，建议高度是宽度-6
 */
- (JKAlertView *(^)(CGSize itemSize))makeCollectionSheetItemSize {
    
    return ^(CGSize itemSize) {
        
        return [self checkCollectionSheetStyleHandler:^{
            
            self.collectionsheetContentView.itemSize = itemSize;
        }];
    };
}

/**
 * collection列数（每行数量）
 * 默认0，自动设置，不得大于自动设置的数量
 */
 - (JKAlertView *(^)(NSInteger columnCount))makeCollectionSheetColumnCount {
     
     return ^(NSInteger columnCount) {
         
         return [self checkCollectionSheetStyleHandler:^{
             
             self.collectionsheetContentView.columnCount = columnCount;
         }];
     };
 }

 /**
  * collection的水平（左右方向）的sectionInset
  * 默认(0, 10, 0, 10)，只取左右
  */
 - (JKAlertView *(^)(UIEdgeInsets inset))makeCollectionSheetSectionInset {
     
     return ^(UIEdgeInsets inset) {
         
         return [self checkCollectionSheetStyleHandler:^{
             
             self.collectionsheetContentView.sectionInset = inset;
         }];
     };
 }

 /**
  * collection的title下分隔线是否隐藏
  * 默认YES
  */
 - (JKAlertView *(^)(BOOL hidden))makeCollectionSheetTitleSeparatorLineHidden {
     
     return ^(BOOL hidden) {
         
         return [self checkCollectionSheetStyleHandler:^{
             
             self.collectionsheetContentView.titleSeparatorLineHidden = hidden;
         }];
     };
 }

/**
 * 是否将两个collectionView合体
 * 设为YES可让两个collectionView同步滚动
 * 设为YES时请保证让两个collection的action数量保持一致
 */
- (JKAlertView *(^)(BOOL combined))makeCollectionSheetCombined {
    
    return ^(BOOL combined) {
        
        return [self checkCollectionSheetStyleHandler:^{
            
            self.collectionsheetContentView.combined = combined;
        }];
    };
}

/**
 * collection是否分页
 */
- (JKAlertView *(^)(BOOL pagingEnabled))makeCollectionSheetPagingEnabled {
    
    return ^(BOOL pagingEnabled) {
        
        return [self checkCollectionSheetStyleHandler:^{
          
            self.collectionsheetContentView.collectionPagingEnabled = pagingEnabled;
        }];
    };
}

/**
 * collection是否隐藏pageControl
 * 如果只有一组collection，则必须设置分页为YES才有效
 * 如果有两组collection，则仅在分页和合体都为YES时才有效
 * 注意自己计算好每页显示的个数相等
 * 可以添加空的action来保证每页显示个数相等
 * JKAlertAction使用类方法初始化时每个参数传nil或者直接自己实例化一个即为空action
 */
- (JKAlertView *(^)(BOOL hidden))makeCollectionSheetPageControlHidden {
    
    return ^(BOOL hidden) {
        
        return [self checkCollectionSheetStyleHandler:^{
            
            self.collectionsheetContentView.pageControlHidden = hidden;
        }];
    };
}

/**
 * 配置pageControl
 */
- (JKAlertView *(^)(void (^)(UIPageControl *pageControl)))makeCollectionSheetPageControlConfiguration {
    
    return ^(void (^configuration)(UIPageControl *pageControl)) {
        
        return [self checkCollectionSheetStyleHandler:^{
          
            !configuration ? : configuration(self.collectionsheetContentView.pageControl);
        }];
    };
}

/**
 * collection样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 */
- (JKAlertView *(^)(UIView *(^customView)(void)))makeCollectionSheetCustomTitleView {
    
    return ^(UIView *(^customView)(void)) {
        
        return [self checkCollectionSheetStyleHandler:^{
          
            self.collectionsheetContentView.textContentView.customContentView = !customView ? nil : customView();
        }];
    };
}

/**
 * 两个collectionView之间的间距
 * 有第二个collectionView时有效 默认10
 */
- (JKAlertView *(^)(CGFloat margin))makeCollectionSheetCollectionViewMargin {
    
    return ^(CGFloat margin) {
        
        return [self checkCollectionSheetStyleHandler:^{
            
            self.collectionsheetContentView.collectionViewMargin = margin;
        }];
    };
}






/** 添加第二个collectionView的action */
- (void)addSecondCollectionAction:(JKAlertAction *)action {
    
    if (!action) { return; }
    
    [self checkCollectionSheetStyleHandler:^{
        
        [self.actions2 addObject:action];
        
        [self setAlertViewToAction:action];
    }];
}

/** 添加第二个collectionView的action */
- (void)insertSecondCollectionAction:(JKAlertAction *)action atIndex:(NSUInteger)index {
    
    if (!action) { return; }
    
    [self checkCollectionSheetStyleHandler:^{
        
        [self.actions2 insertObject:action atIndex:index];
        
        [self setAlertViewToAction:action];
    }];
}

/** 添加第二个collectionView的action */
- (JKAlertView *(^)(JKAlertAction *action))addSecondCollectionAction {
    
    return ^(JKAlertAction *action) {
        
        [self addSecondCollectionAction:action];
        
        return self;
    };
}


/** collection链式添加第二个collectionView的action */
- (JKAlertView *(^)(JKAlertAction *action, NSUInteger atIndex))insertSecondCollectionAction {
    
    return ^(JKAlertAction *action, NSUInteger atIndex) {
        
        [self insertSecondCollectionAction:action atIndex:atIndex];
        
        return self;
    };
}

















/** 设置colletion样式的底部按钮左右间距 */
- (JKAlertView *(^)(CGFloat margin))setCollectionButtonLeftRightMargin {
    
    return ^(CGFloat margin) {
        
        self.collectionButtonLeftRightMargin = margin;
        
        return self;
    };
}























/**
 * 设置collection的itemSize的宽度
 * 最大不可超过屏幕宽度的一半
 * 注意图片的宽高是设置的宽度-30，即图片在cell中是左右各15的间距
 * 自动计算item之间间距，最小为0，可自己计算该值设置每屏显示个数
 * 默认的高度是宽度-6，暂不支持自定义高度
 */
- (JKAlertView *(^)(CGFloat width))setFlowlayoutItemWidth {
    
    return ^(CGFloat width) {
        
        return self.makeCollectionSheetItemSize(CGSizeMake(width, width - 6));
    };
}

/**
 * 设置collection列数（每行数量）
 * 默认0，自动设置，不得大于自动设置的数量
 */
- (JKAlertView *(^)(NSInteger columnCount))setCollectionColumnCount {
    
    return [self makeCollectionSheetColumnCount];
}

/**
 * 设置collection的水平（左右方向）的sectionInset
 * 默认0，为0时自动设置为item间距的一半
 */
- (JKAlertView *(^)(CGFloat inset))setCollectionHorizontalInset {
    
    return ^(CGFloat inset) {
        
        return self.makeCollectionSheetSectionInset(UIEdgeInsetsMake(0, inset, 0, inset));
    };
}

/**
 * 设置pageControl
 * 必须setShowPageControl为YES之后才会有值
 */
- (JKAlertView *(^)(void (^)(UIPageControl *pageControl)))setCollectionPageControlConfig{
    
    return [self makeCollectionSheetPageControlConfiguration];
}

/**
 * 设置collection样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 */
- (JKAlertView *(^)(UIView *(^customView)(void)))setCustomCollectionTitleView{
    
    return [self makeCollectionSheetCustomTitleView];
}

/** 设置collection的title下分隔线是否隐藏 默认YES */
- (JKAlertView *(^)(BOOL hidden))setCollectionTitleSeparatorHidden {
    
    return [self makeCollectionSheetTitleSeparatorLineHidden];
}

/**
 * 设置是否将两个collection合体
 * 设为YES可让两个collection同步滚动
 * 设置YES时会自动让两个collection的action数量保持一致，即向少的一方添加空的action
 */
- (JKAlertView *(^)(BOOL compoundCollection))setCompoundCollection {
    
    return [self makeCollectionSheetCombined];
}

/** 设置collection是否分页 */
- (JKAlertView *(^)(BOOL collectionPagingEnabled))setCollectionPagingEnabled {
    
    return [self makeCollectionSheetPagingEnabled];
}

/**
 * 设置是否显示pageControl
 * 如果只有一组collection，则必须设置分页为YES才有效
 * 如果有两组collection，则仅在分页和合体都为YES时才有效
 * 注意自己计算好每页显示的个数相等
 * 可以添加空的action来保证每页显示个数相等
 * JKAlertAction使用类方法初始化时每个参数传nil或者直接自己实例化一个即为空action
 */
- (JKAlertView *(^)(BOOL showPageControl))setShowPageControl {
    
    return ^(BOOL showPageControl) {
        
        return self.makeCollectionSheetPageControlHidden(!showPageControl);
    };
}

/**
 * 设置两个collectionView之间的间距
 * 有第二个collectionView时有效 默认10, 最小为0
 */
- (JKAlertView *(^)(CGFloat margin))setCollectionViewMargin {
    
    return [self makeCollectionSheetCollectionViewMargin];
}



















/** collection样式默认有一个取消按钮，设置这个可以在取消按钮的上面再添加一个按钮 */
- (JKAlertView *(^)(JKAlertAction *action))setCollectionAction {
    
    return [self makeCollectionSheetAction];
}
@end
