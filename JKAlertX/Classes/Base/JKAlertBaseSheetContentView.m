//
//  JKAlertBaseSheetContentView.m
//  JKAlertX
//
//  Created by albert on 2020/6/29.
//

#import "JKAlertBaseSheetContentView.h"
#import "JKAlertPanGestureRecognizer.h"

@implementation JKAlertBaseSheetContentView

#pragma mark
#pragma mark - Public Methods



#pragma mark
#pragma mark - Override

- (void)dealloc {
    
    // TODO: JKTODO delete
    
    NSLog(@"[ClassName: %@], %d, %s", NSStringFromClass([self class]), __LINE__, __func__);
}

#pragma mark
#pragma mark - Private Methods



#pragma mark
#pragma mark - Private Selector



#pragma mark
#pragma mark - UITableViewDataSource & UITableViewDelegate



#pragma mark
#pragma mark - Custom Delegates



#pragma mark
#pragma mark - Initialization & Build UI

/** 初始化自身属性 */
- (void)initializeProperty {
    [super initializeProperty];
    
    _gestureIndicatorHidden = YES;
    
    
    
    // TODO: JKTODO <#注释#>
    _enableVerticalGestureDismiss = YES;
    _enableHorizontalGestureDismiss = YES;
    _gestureIndicatorHidden = NO;
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
    
}

#pragma mark
#pragma mark - Private Property

- (UIView *)topGestureIndicatorView {
    if (!_topGestureIndicatorView) {
        UIView *topGestureIndicatorView = [[UIView alloc] init];
        topGestureIndicatorView.hidden = YES;
        topGestureIndicatorView.userInteractionEnabled = NO;
        [self.topContentView addSubview:topGestureIndicatorView];
        _topGestureIndicatorView = topGestureIndicatorView;
        
        UIView *topGestureLineView = [[UIView alloc] init];
        
        topGestureLineView.userInteractionEnabled = NO;
        topGestureLineView.layer.cornerRadius = 2;
        topGestureLineView.backgroundColor = JKAlertAdaptColor(JKAlertSameRGBColor(208), JKAlertSameRGBColor(47));
        [topGestureIndicatorView addSubview:topGestureLineView];
        
        _topGestureLineView = topGestureLineView;
    }
    return _topGestureIndicatorView;
}

- (JKAlertPanGestureRecognizer *)verticalDismissPanGesture {
    if (!_verticalDismissPanGesture) {
        
        _verticalDismissPanGesture = [[JKAlertPanGestureRecognizer alloc] initWithTarget:self action:@selector(verticalPanGestureAction:)];
        _verticalDismissPanGesture.direction = JKAlertPanGestureDirectionVertical;
        _verticalDismissPanGesture.delegate = self;
    }
    return _verticalDismissPanGesture;
}

- (JKAlertPanGestureRecognizer *)horizontalDismissPanGesture {
    if (!_horizontalDismissPanGesture) {
        _horizontalDismissPanGesture = [[JKAlertPanGestureRecognizer alloc] initWithTarget:self action:@selector(horizontalPanGestureAction:)];
        _horizontalDismissPanGesture.direction = JKAlertPanGestureDirectionToRight;
        _horizontalDismissPanGesture.delegate = self;
    }
    return _horizontalDismissPanGesture;
}

@end
