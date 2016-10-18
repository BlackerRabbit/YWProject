    //
//  VMBaseViewController.m
//  MagicBox
//
//  Created by 蒋正峰 on 15/11/18.
//  Copyright © 2015年 蒋正峰. All rights reserved.
//

#import "VMBaseViewController.h"
#import "AppDelegate.h"

@interface VMBaseViewController ()

@end

@implementation VMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navbarColor = [UIColor whiteColor];
    self.view.backgroundColor = UICOLOR_RGB_Alpha(0xf0f0f0, 1);
    // Do any additional setup after loading the view.

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel* lblView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    lblView.text = title;
    lblView.font = [UIFont boldSystemFontOfSize:15];
    if (iPhone6plus) {
//        lblView.font = [UIFont systemFontOfSize:17];
        lblView.font = [UIFont boldSystemFontOfSize:17];
    }
    
    lblView.backgroundColor = [UIColor clearColor];
//    lblView.textColor = [UIColor blackColor];
    lblView.textColor = [UIColor colorWithHexString:@"#666666"];
//    lblView.textColor = [UIColor colorWithRed:255/255.0f green:125/255.0f blue:168/255.0f alpha:1];
    self.navigationItem.titleView = lblView;
}

-(void)pushViewController:(VMBaseViewController *)viewController{

    if (self.navigationController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.window.rootViewController.navigationController pushViewController:self animated:YES];
    }
}

-(void)popViewController{

    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)setNavigationBar:(UINavigationItem*)navigationItem
             withButton:(UIButton*)button
            onDirection:(VM_NAV_DIRECTION)direction
{
    if(navigationItem == nil)
        return;
    if(direction == VM_NAV_DIRECTION_LEFT)
    {
        navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    else
    {
        navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
}

-(void)setNavigationBarButton:(UIButton*)button onDirection:(VM_NAV_DIRECTION)direction
{
    if(self.navigationItem == nil)
        return;
    if(direction == VM_NAV_DIRECTION_LEFT)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
}

-(void)setNavbarColor:(UIColor *)navbarColor
{
    _navbarColor = navbarColor;
    if(_navbarColor)
    {
        [self.navigationController.navigationBar setBackgroundImage:[_navbarColor image] forBarMetrics:UIBarMetricsDefault];
    }
}



@end
