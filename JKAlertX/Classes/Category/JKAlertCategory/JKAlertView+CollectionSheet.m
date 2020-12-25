//
//  JKAlertView+CollectionSheet.m
//  JKAlertX
//
//  Created by albert on 2020/6/8.
//

#import "JKAlertView+CollectionSheet.h"
#import "JKAlertView+Public.h"
#import "JKAlertView+PrivateProperty.h"
#import "JKAlertTheme.h"

@implementation JKAlertView (CollectionSheet)

/**
 * collection样式顶部的背景色
 * pierced镂空样式时，表示上部分的颜色，包括title和collectionView
 */
- (JKAlertView *(^)(UIColor *color))makeCollectionSheetTopBackgroundColor {
    
    return ^(UIColor *color) {
        
        return [self checkCollectionSheetStyleHandler:^{
            
            [self.collectionsheetContentView.topContainerView.jkalert_themeProvider removeProvideHandlerForKey:NSStringFromSelector(@selector(backgroundColor))];
            
            self.collectionsheetContentView.topContainerView.backgroundColor = color;
        }];
    };
}

/**
 * actionSheet样式底部按钮的颜色
 * 默认无
 */
- (JKAlertView *(^)(UIColor *color))makeCollectionSheetBottomButtonBackgroundColor {
    
    return ^(UIColor *color) {
        
        return [self checkCollectionSheetStyleHandler:^{
            
            [self.collectionsheetContentView.collectionButton.jkalert_themeProvider removeProvideHandlerForKey:NSStringFromSelector(@selector(backgroundColor))];
            [self.collectionsheetContentView.cancelButton.jkalert_themeProvider removeProvideHandlerForKey:NSStringFromSelector(@selector(backgroundColor))];
            
            self.collectionsheetContentView.collectionButton.backgroundColor = color;
            self.collectionsheetContentView.cancelButton.backgroundColor = color;
        }];
        
        return self;
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
 * collection的minimumLineSpacing
 * 默认10
 */
- (JKAlertView *(^)(CGFloat minimumLineSpacing))makeCollectionSheetMinimumLineSpacing {
    
    return ^(CGFloat minimumLineSpacing) {
        
        return [self checkCollectionSheetStyleHandler:^{
            
            self.collectionsheetContentView.minimumLineSpacing = minimumLineSpacing;
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
 * collection样式添加自定义的titleView
 * frmae给出高度即可，宽度将自适应
 * 请将该自定义view视为容器view，推荐使用自动布局在其上约束子控件
 */
- (JKAlertView *(^)(UIView *(^customView)(void)))makeCollectionSheetCustomTitleView {
    
    return ^(UIView *(^customView)(void)) {
        
        return [self checkCollectionSheetStyleHandler:^{
            
            if (customView) {
                
                self.collectionsheetContentView.textContentView.customContentView = customView();
            }
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
 * pageControl高度
 */
- (JKAlertView *(^)(CGFloat height))makeCollectionSheetPageControlHeight {
    
    return ^(CGFloat height) {
        
        return [self checkCollectionSheetStyleHandler:^{
            
            self.collectionsheetContentView.pageControlHeight = height;
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
 * colletion样式的底部按钮间距
 * 默认(0, 0, 0, 0)只取左右
 */
- (JKAlertView *(^)(UIEdgeInsets insets))makeCollectionSheetButtonInsets {
    
    return ^(UIEdgeInsets insets) {
        
        return [self checkCollectionSheetStyleHandler:^{
            
            self.collectionsheetContentView.buttonInsets = insets;
        }];
    };
}

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
 * collectionSheet底部取消按钮是否固定在底部
 * 默认NO
 */
- (JKAlertView *(^)(BOOL pinned))makeCollectionSheetBottomButtonPinned {
    
    return ^(BOOL pinned) {
        
        return [self checkCollectionSheetStyleHandler:^{
            
            self.collectionsheetContentView.bottomButtonPinned = pinned;
        }];
    };
}

/**
 * collectionSheet是否镂空
 * 设置为YES后，makeActionSheetBottomButtonPinned将强制为YES
 * piercedInsets : 整体左、右、下间距
 */
- (JKAlertView *(^)(BOOL isPierced, UIEdgeInsets piercedInsets))makeCollectionSheetPierced {
    
    return ^(BOOL isPierced, UIEdgeInsets piercedInsets) {
        
        return [self checkCollectionSheetStyleHandler:^{
            
            self.collectionsheetContentView.isPierced = isPierced;
            self.collectionsheetContentView.piercedInsets = piercedInsets;
        }];
    };
}



/** 添加第二个collectionView的action */
- (void)addSecondCollectionAction:(JKAlertAction *)action {
    
    if (!action) { return; }
    
    [self checkCollectionSheetStyleHandler:^{
        
        [self.collectionsheetContentView.secondActionArray addObject:action];
        
        [self setAlertViewToAction:action];
    }];
}

/** 添加第二个collectionView的action */
- (void)insertSecondCollectionAction:(JKAlertAction *)action atIndex:(NSUInteger)index {
    
    if (!action) { return; }
    
    [self checkCollectionSheetStyleHandler:^{
        
        [self.collectionsheetContentView.secondActionArray insertObject:action atIndex:index];
        
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
@end
