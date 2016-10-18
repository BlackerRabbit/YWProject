//
//  MBShockView.m
//  VMovieKit
//
//  Created by 刘冲 on 15/12/10.
//  Copyright © 2015年 蒋正峰. All rights reserved.
//

#import "MBShockView.h"

#define kSCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define kSCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define kViewInterval 12
#define kViewDiameter 6

//动画宏
#define kLineTime 0.5
#define kLineHeight self.frame.size.height - 5
#define kShockTime 0.5
#define kShockHeight 14
#define kMiddleTimeMultiple 1.2
#define kRightTimeMultiple 1.39


//程序退出时发送的消息
#define kStopLoading @"StopLoading"

@implementation MBShockView
{
    //1.声明三个视图，并实例化
    UIView * _leftView;
    UIView * _middleView;
    UIView * _rightView;
    
    
}
#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nsnotificationStopLoading) name:kStopLoading object:nil];
        [self initData];
        [self initUI];
    }
    return self;
}
-(void)initData
{
    self.refreshing = NO;
}
-(void)initUI
{
    CGFloat leftViewTop = (CGRectGetHeight(self.frame) + 20 );
    
    
    _leftView = [[UIView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/2 - kViewInterval, leftViewTop, kViewDiameter, kViewDiameter)];
    _leftView.layer.masksToBounds = YES;
    _leftView.layer.cornerRadius = CGRectGetWidth(_leftView.frame)/2;
    _leftView.backgroundColor = UICOLOR_RGB_Alpha(0x999999, 1);
    _leftView.hidden = YES;
    [self addSubview:_leftView];
    
    _middleView = [[UIView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/2 , leftViewTop *kMiddleTimeMultiple, kViewDiameter, kViewDiameter)];
    _middleView.backgroundColor = UICOLOR_RGB_Alpha(0x999999, 1);
    _middleView.layer.masksToBounds = YES;
    _middleView.layer.cornerRadius = CGRectGetWidth(_middleView.frame)/2;
    _middleView.hidden = YES;
    [self addSubview:_middleView];
    
    _rightView = [[UIView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/2 + kViewInterval, leftViewTop *kRightTimeMultiple, kViewDiameter, kViewDiameter)];
    _rightView.backgroundColor = UICOLOR_RGB_Alpha(0x999999, 1);
    _rightView.layer.masksToBounds = YES;
    _rightView.layer.cornerRadius = CGRectGetWidth(_rightView.frame)/2;
    _rightView.hidden = YES;
    [self addSubview:_rightView];
    
    
}
#pragma mark - 加载方法
/**
 *  开始加载
 */
-(void)beginLoading
{
    if (self.isRefreshing == YES) {
        return;
    }
    
    NSLog(@"开始加载");
    self.refreshing = YES;
    
    [self lineAnimotedFromBottomToTopWithView:_leftView];
    [self lineAnimotedFromBottomToTopWithView:_middleView];
    [self lineAnimotedFromBottomToTopWithView:_rightView];
    
    
   
}
/**
 *  停止加载
 */
-(void)stopLoading
{
    self.refreshing = NO;
    _leftView.hidden = YES;
    _rightView.hidden = YES;
    _middleView.hidden = YES;
    CGFloat leftViewTop = (CGRectGetHeight(self.frame) + 20 );
    _leftView.frame = CGRectMake(kSCREEN_WIDTH/2 - kViewInterval, leftViewTop, kViewDiameter, kViewDiameter);
    _middleView.frame = CGRectMake(kSCREEN_WIDTH/2 , leftViewTop * kMiddleTimeMultiple, kViewDiameter, kViewDiameter);
    _rightView.frame = CGRectMake(kSCREEN_WIDTH/2 + kViewInterval, leftViewTop * kRightTimeMultiple, kViewDiameter, kViewDiameter);
}

#pragma mark - 动画的具体实现
-(void)lineAnimotedFromBottomToTopWithView:(UIView *)view
{
    view.hidden = NO;
    
    NSTimeInterval timeInterVal = kLineTime;
    if (view == _middleView) {
        timeInterVal = kLineTime * kMiddleTimeMultiple;
    }
    if (view == _rightView) {
        timeInterVal = kLineTime * kRightTimeMultiple;
    }
    
    [UIView animateWithDuration:timeInterVal animations:^{
        CGRect frame = view.frame;
        frame.origin.y = 15;
        view.frame = frame;
    } completion:^(BOOL finished) {
        [self newShockWithView:view];
    }];
}
-(void)shockAnimotedFromTopToBottomWithView:(UIView *)view
{
    
    if (!self.isRefreshing) {
        return;
    }
    [UIView animateWithDuration:kShockTime animations:^{
        CGRect frame = view.frame;
        frame.origin.y += kShockHeight;
        view.frame = frame;
    } completion:^(BOOL finished) {
        [self shockAnimotedFromBottomToTopWithView:view];
    }];
    
}
-(void)shockAnimotedFromBottomToTopWithView:(UIView *)view
{
        [UIView animateWithDuration:kShockTime animations:^{
        CGRect frame = view.frame;
        frame.origin.y -= kShockHeight;
        view.frame = frame;
    } completion:^(BOOL finished) {
        [self shockAnimotedFromTopToBottomWithView:view];
    }];
}

-(void)layoutSubviews{

}

-(void)drawRect:(CGRect)rect{

}

#pragma mark - new shock
-(void)newShockWithView:(UIView *)view
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(view.frame.origin.x + view.frame.size.width/2, view.frame.origin.y + view.frame.size.height/2)];
    [path addLineToPoint:CGPointMake(view.frame.origin.x + view.frame.size.width/2,26)];
    //            [path addLineToPoint:CGPointMake(20, 400)];
    [path addLineToPoint:CGPointMake(view.frame.origin.x + view.frame.size.width/2, view.frame.origin.y + view.frame.size.height/2)];
    CAKeyframeAnimation *keyframe = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyframe.path = path.CGPath;
    keyframe.duration = kShockTime*1.2;
    keyframe.repeatCount = MAXFLOAT;
    [view.layer addAnimation:keyframe forKey:@"AnimationKey"];
}
#pragma mark - NSNotificationCenter
-(void)nsnotificationStopLoading
{
    [self stopLoading];
}



@end
