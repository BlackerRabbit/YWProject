//
//  YSWebViewController.h
//  MagicBox
//
//  Created by 蒋正峰 on 2016/10/16.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSWebViewController : UIViewController
@property (nonatomic, strong, readwrite) NSString *url;
@property (nonatomic, assign, readwrite) BOOL shouldNotHasRightBar;

@end
