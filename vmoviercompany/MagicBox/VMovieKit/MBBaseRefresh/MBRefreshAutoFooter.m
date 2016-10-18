//
//  MBRefreshBackFooter.m
//  pulldownDemo
//
//  Created by 李国志 on 15/11/11.
//  Copyright © 2015年 LGZ. All rights reserved.
//

#import "MBRefreshAutoFooter.h"

@interface MBRefreshAutoFooter()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIImageView *gifImageView;
@end

@implementation MBRefreshAutoFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    self.triggerAutomaticallyRefreshPercent = -4;
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = @"正在加载...";
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    self.stateLabel.hidden = YES;
    
    // logo
    
//    UIImageView *gifImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
//    gifImageView.contentMode = UIViewContentModeScaleAspectFit;
//    [self addSubview:gifImageView];
//    self.gifImageView = gifImageView;
    
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [refreshingImages addObject:image];
//    }
//    self.gifImageView.animationImages = refreshingImages;
//    self.gifImageView.animationDuration = .5f;
//    [self.gifImageView startAnimating];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = CGRectMake(0, 0, self.mj_w, self.mj_h);
    
    self.gifImageView.bounds = CGRectMake(0, 0, 50, 50);
    self.gifImageView.center = CGPointMake(self.mj_w * 0.5, 30);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
//            self.label.text = @"赶紧上拉吖";
            break;
        case MJRefreshStatePulling:
//            self.label.text = @"赶紧放开我吧";
            break;
        case MJRefreshStateRefreshing:
//            self.label.text = @"加载数据中";
            break;
        case MJRefreshStateNoMoreData:
            [self.gifImageView stopAnimating];
            self.label.center = self.gifImageView.center;
            self.label.text = @"木有数据了";
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
//    CGFloat red = 1.0 - pullingPercent * 0.5;
//    CGFloat green = 0.5 - 0.5 * pullingPercent;
//    CGFloat blue = 0.5 * pullingPercent;
//    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

-(void)endRefreshing
{
    [super endRefreshing];
//    [self.gifImageView stopAnimating];
}

@end