//
//  VMBaseViewController.h
//  MagicBox
//
//  Created by 蒋正峰 on 15/11/18.
//  Copyright © 2015年 蒋正峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VM_NAV_DIRECTION) {
    VM_NAV_DIRECTION_LEFT      = 0,
    VM_NAV_DIRECTION_RIGHT     = 1
    
};

@interface VMBaseViewController : UIViewController
@property(nonatomic,strong) UIColor* navbarColor;
-(void)setNavigationBar:(UINavigationItem*)navigationItem
             withButton:(UIButton*)button
            onDirection:(VM_NAV_DIRECTION)direction;

-(void)setNavigationBarButton:(UIButton*)button
                  onDirection:(VM_NAV_DIRECTION)direction;
@end
