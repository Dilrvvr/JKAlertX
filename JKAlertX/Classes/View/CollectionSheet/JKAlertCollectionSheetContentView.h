//
//  JKAlertCollectionSheetContentView.h
//  JKAlertX
//
//  Created by albert on 2020/6/4.
//

#import "JKAlertBaseAlertContentView.h"
#import "JKAlertCollectionSheetTextContentView.h"

@interface JKAlertCollectionSheetContentView : JKAlertBaseAlertContentView

/** textContentView */
@property (nonatomic, weak, readonly) JKAlertCollectionSheetTextContentView *textContentView;
@end
