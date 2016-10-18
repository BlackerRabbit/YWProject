//
//  MBRefreshShockFooter.m
//  VMovieKit
//
//  Created by 刘冲 on 15/12/10.
//  Copyright © 2015年 蒋正峰. All rights reserved.
//

#import "MBRefreshShockFooter.h"
#import "MBShockView.h"

@interface MBRefreshShockFooter ()

@property (nonatomic,strong)MBShockView * shockView;

@property (nonatomic,strong)UIImageView * noMoreImgView;

@end

@implementation MBRefreshShockFooter
//宏
#define kSCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
     [self setTitle:@"" forState:MJRefreshStateIdle];
    self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0" alpha:1];
    self.triggerAutomaticallyRefreshPercent = -4;
    // 设置控件的高度
    self.mj_h = 50;
//    if (iPhone6plus) {
//        self.mj_h = 55;
//    }
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:16];
    if (iPhone6plus) {
        label.font = [UIFont boldSystemFontOfSize:18];
    }
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.stateLabel.hidden = YES;
    self.stateLabel.font = [UIFont systemFontOfSize:13];
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    self.stateLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
    
    CGFloat top = 19.5;
    if (iPhone6plus) {
//        top = 22;
    }
    self.noMoreImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/2-42, top, 11, 11)];
//    self.noMoreImgView.backgroundColor = [UIColor greenColor];
    self.noMoreImgView.image = [UIImage imageNamed:@"prompt_nomore"];
    self.noMoreImgView.hidden = YES;
    [self addSubview:self.noMoreImgView];
    
    // logo
    
    self.shockView = [[MBShockView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 50)];
    self.shockView.backgroundColor = CLEAR;
    [self addSubview:self.shockView];
    [self sendSubviewToBack:self.shockView];
//    [self.shockView beginLoading];
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    
    self.shockView.bounds = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 50);
    self.shockView.center = CGPointMake(self.mj_w * 0.5, 25);
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
            self.stateLabel.text = @"";
            break;
        case MJRefreshStatePulling:
            //            self.label.text = @"赶紧放开我吧";
            self.stateLabel.text = @"";
            break;
        case MJRefreshStateRefreshing:
            //            self.label.text = @"加载数据中";
            self.stateLabel.text = @"";
            break;
        case MJRefreshStateNoMoreData:
        {
            self.stateLabel.hidden = NO;
            self.noMoreImgView.hidden = YES;
            self.stateLabel.text = @"-End-";
            [self.shockView stopLoading];
//            [self endRefreshing];
        }
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
#pragma mark - 内部方法(重写)
- (void)executeRefreshingCallback
{
    [super executeRefreshingCallback];
    [self.shockView beginLoading];
}

-(void)endRefreshing
{
    [super endRefreshing];
    [self.shockView stopLoading];
}

@end
