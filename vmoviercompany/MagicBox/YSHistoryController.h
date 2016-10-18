//
//  YSHistoryController.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/28.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSBookViewController;
@interface YSHistoryController : UITableViewController

@property (nonatomic, weak, readwrite)  YSBookViewController *currentBookVC;


@end
