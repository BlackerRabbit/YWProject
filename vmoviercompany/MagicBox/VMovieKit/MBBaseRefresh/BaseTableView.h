//
//  BaseTableView.h
//  pulldownDemo
//
//  Created by 李国志 on 15/11/10.
//  Copyright © 2015年 LGZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MJRefresh/MJRefresh.h>
#import "MBRefreshHeader.h"
#import "MBRefreshAutoFooter.h"

#import "MBRefreshShockFooter.h"

//#import "UIScrollView+MJRefresh.h"

@class BaseTableView;

typedef void (^PullDownBlock)(BaseTableView *tableView);
typedef void (^PullUpBlock)(BaseTableView *tableView);

@interface BaseTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) PullDownBlock pullDownBlock;
@property (nonatomic, copy) PullUpBlock   pullUpBlock;

@end
