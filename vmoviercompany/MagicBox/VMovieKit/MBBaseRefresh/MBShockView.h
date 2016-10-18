//
//  MBShockView.h
//  VMovieKit
//
//  Created by 刘冲 on 15/12/10.
//  Copyright © 2015年 蒋正峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+VMColor.h"

@interface MBShockView : UIView

/**
 *  @refreshing 判断是否正在加载
 */
@property (nonatomic,assign,getter=isRefreshing)BOOL refreshing;
/**
 *  开始加载
 */
-(void)beginLoading;
/**
 *  停止加载
 */
-(void)stopLoading;

@end
