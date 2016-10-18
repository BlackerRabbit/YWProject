//
//  VMTabBarController.h
//  MagicBox
//
//  Created by 蒋正峰 on 15/11/18.
//  Copyright © 2015年 蒋正峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletionBlocks)(id object);


@interface VMTabBarController : UITabBarController


- (void)setTabBarHindden:(BOOL)isHidden animoted:(BOOL)animoted completion:(CompletionBlocks)callBack;

@end
