//
//  YSRootViewController.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/6/29.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSBookObject.h"
#import "YSGongJiaObject.h"

@interface YSRootViewController : UIViewController
@property (nonatomic, strong, readwrite) YSBookObject *currentBook;
@property (nonatomic, strong, readwrite) YSGongJiaObject *standGongJia;
@end
