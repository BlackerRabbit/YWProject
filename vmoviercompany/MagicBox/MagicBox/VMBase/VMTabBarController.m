//
//  VMTabBarController.m
//  MagicBox
//
//  Created by 蒋正峰 on 15/11/18.
//  Copyright © 2015年 蒋正峰. All rights reserved.
//

#import "VMTabBarController.h"

@interface VMTabBarController ()

@end

@implementation VMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}
- (BOOL)shouldAutorotate
{
    return self.selectedViewController.shouldAutorotate;
}

-(void)setTabBarHindden:(BOOL)isHidden animoted:(BOOL)animoted completion:(CompletionBlocks)callBack
{
    return;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat height = screenHeight - self.tabBar.frame.size.height;
    if (isHidden) {
        height = screenHeight;
    }
    else
    {
        self.tabBar.hidden = NO;
    }
    __block UIView * view = self.tabBar;
    CGFloat timeInterval = .5;
    if (!animoted) {
        timeInterval = 0;
    }
    [UIView animateWithDuration:timeInterval animations:^{
        
        [view setFrame:CGRectMake(view.frame.origin.x, height, view.frame.size.width , view.frame.size.height)];
            
    } completion:^(BOOL finished) {
        if (callBack) {
            callBack(nil);
        }
        
    }];
}





@end


