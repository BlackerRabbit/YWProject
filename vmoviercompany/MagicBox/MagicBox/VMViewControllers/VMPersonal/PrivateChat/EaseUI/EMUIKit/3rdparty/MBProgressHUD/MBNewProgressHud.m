//
//  MBNewProgressHud.m
//  MagicBox
//
//  Created by 刘冲 on 16/3/29.
//  Copyright © 2016年 蒋正峰. All rights reserved.
//

#import "MBNewProgressHud.h"

@interface MBProgressHUD ()

//类似内存管理应用计数
@property (nonatomic,assign)NSInteger count;

@end

@implementation MBProgressHudManager

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (hud) {
        //应用计数+1
        hud.count = hud.count + 1;
    }else{
        //初始化
        [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.labelText = message;
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        // YES代表需要蒙版效果
        hud.dimBackground = NO;
        //第一次初始化，需要将引用计数置为1
        hud.count = 1;
    }
    return hud;
}

+(NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated
{
    MBProgressHUD * hud = [MBProgressHUD HUDForView:view];
    if (hud.count == 1) {
        return [MBProgressHUD hideAllHUDsForView:view animated:YES];
    }
    hud.count = hud.count - 1;
    NSArray *huds = [MBProgressHUD allHUDsForView:view];
    return huds.count;
}

@end
