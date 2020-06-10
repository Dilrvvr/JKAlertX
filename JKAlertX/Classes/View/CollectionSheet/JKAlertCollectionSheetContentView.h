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

/** actionArray2 */
@property (nonatomic, strong) NSArray *actionArray2;

/** title底部分隔线是否隐藏 默认YES */
@property (nonatomic, assign) BOOL titleSeparatorLineHidden;

/** 两个collectionView直接的分隔线是否隐藏 默认YES */
@property (nonatomic, assign) BOOL collectionSeparatorLineHidden;
@end
