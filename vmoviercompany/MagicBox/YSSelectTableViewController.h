//
//  YSSelectTableViewController.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/23.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectCompleteBlock)(NSString *value);

@interface YSSelectTableViewController : UITableViewController
@property (nonatomic, strong, readwrite) NSArray *dataAry;
@property (nonatomic, copy, readwrite) SelectCompleteBlock block;

@end
