//
//  MBNewProgressHud.h
//  MagicBox
//
//  Created by 刘冲 on 16/3/29.
//  Copyright © 2016年 蒋正峰. All rights reserved.
//

//#import <MBProgressHUD/MBProgressHUD.h>
#import "MBProgressHUD.h"

@interface MBProgressHudManager : NSObject

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;

+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated;

@end
