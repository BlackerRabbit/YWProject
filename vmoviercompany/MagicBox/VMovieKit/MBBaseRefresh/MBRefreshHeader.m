//
//  MBRefreshHeader.m
//  pulldownDemo
//
//  Created by 李国志 on 15/11/11.
//  Copyright © 2015年 LGZ. All rights reserved.
//

#import "MBRefreshHeader.h"
//#import <VMovieKit/UIColor+VMColor.h>


@interface MBRefreshHeader ()

@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIImageView *gifImageView;

@end

@implementation MBRefreshHeader

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
    
    // 设置控件的高度
    self.mj_h = 70;
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    
    // 添加label
//    UILabel *label = [[UILabel alloc] init];
//    label.textColor = UICOLOR_RGB_Alpha(0x999999, 1);
//    label.font = [UIFont boldSystemFontOfSize:16];
//    label.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:label];
//    self.label = label;
//    self.label.text = self.lastUpdatedTimeLabel.text;
    
    UIImageView *gifImageView = [[UIImageView alloc] init];
//    gifImageView.contentMode = UIViewContentModeScaleAspectFit;
    gifImageView.image = [UIImage imageNamed:@"loding_icon"];
    [self addSubview:gifImageView];
    self.gifImageView = gifImageView;

    // 设置普通状态的动画图片
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=60; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
//        [idleImages addObject:image];
//    }
//    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [refreshingImages addObject:image];
//    }
//    _gifImageView.animationImages = refreshingImages;
//    _gifImageView.animationDuration = .5f;
//    [_gifImageView startAnimating];
    
    CABasicAnimation *freshAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    freshAnimation.toValue = [NSNumber numberWithFloat:M_PI *4.0];
    freshAnimation.duration = 2.0;
    freshAnimation.cumulative = YES;
    freshAnimation.repeatCount = MAXFLOAT;
    freshAnimation.removedOnCompletion = NO;
    
    [_gifImageView.layer addAnimation:freshAnimation forKey:@"rotationAnimation"];
    _gifImageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [self addSubview:_gifImageView];
//    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
//    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = CGRectMake(0, self.mj_h-35, self.mj_w, 30);
    
    self.gifImageView.bounds = CGRectMake(0, 0, 50, 50);
    self.gifImageView.center = CGPointMake(self.mj_w * 0.5, 35);

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
//            self.label.text = @"赶紧下拉吖";
            [self.gifImageView stopAnimating];
            self.label.text = self.lastUpdatedTimeLabel.text;
            break;
        case MJRefreshStatePulling:
//            self.label.text = @"赶紧放开我吧"
            [self.gifImageView startAnimating];
            self.label.text = self.lastUpdatedTimeLabel.text;
            break;
        case MJRefreshStateRefreshing:
//            self.label.text = @"加载数据中";
            [self.gifImageView startAnimating];
            self.label.text = self.lastUpdatedTimeLabel.text;
            break;
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
}

@end
