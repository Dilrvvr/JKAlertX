//
//  JKAlertVerticalSlideToDismissView.m
//  JKAlertX_Example
//
//  Created by AlbertCC on 2021/4/13.
//  Copyright © 2021 jkayb123cool@gmail.com. All rights reserved.
//

#import "JKAlertVerticalSlideToDismissView.h"
#import "JKAlertUITableView.h"

@interface JKAlertVerticalSlideToDismissView () <UITableViewDataSource, UITableViewDelegate>

/// tableView
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation JKAlertVerticalSlideToDismissView

@synthesize jkalert_verticalSlideToDismissDelegate;

#pragma mark
#pragma mark - Public Methods



#pragma mark
#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

#pragma mark
#pragma mark - Private Methods



#pragma mark
#pragma mark - Private Selector



#pragma mark
#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.jkalert_verticalSlideToDismissDelegate scrollViewDidScroll:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.jkalert_verticalSlideToDismissDelegate scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    [self.jkalert_verticalSlideToDismissDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self.jkalert_verticalSlideToDismissDelegate scrollViewDidEndDecelerating:scrollView];
}

#pragma mark
#pragma mark - Custom Delegates



#pragma mark
#pragma mark - Initialization & Build UI

/// 初始化自身属性 交给子类重写 super自动调用该方法
- (void)initializeProperty {
    
}

/// 构造函数初始化时调用 注意调用super
- (void)initialization {
    
    [self initializeProperty];
    [self createUI];
    [self layoutUI];
    [self initializeUIData];
}

/// 创建UI 交给子类重写 super自动调用该方法
- (void)createUI {
    
    UITableView *tableView = [[JKAlertUITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    tableView.backgroundColor = nil;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self addSubview:tableView];
    _tableView = tableView;
}

/// 布局UI 交给子类重写 super自动调用该方法
- (void)layoutUI {
    
}

/// 初始化UI数据 交给子类重写 super自动调用该方法
- (void)initializeUIData {
    
}

#pragma mark
#pragma mark - Private Property



@end
