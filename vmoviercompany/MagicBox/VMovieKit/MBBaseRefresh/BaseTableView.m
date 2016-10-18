//
//  BaseTableView.m
//  pulldownDemo
//
//  Created by 李国志 on 15/11/10.
//  Copyright © 2015年 LGZ. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self subviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)awakeFromNib {
    [self initSubViews];
}

- (void)initSubViews {
    
    self.dataSource = self;
    self.delegate = self;
    
    WEAKSELF;
    self.mj_header = [MBRefreshHeader headerWithRefreshingBlock:^{
        if (weakSelf.pullDownBlock) {
            weakSelf.pullDownBlock(weakSelf);
        }
        [weakSelf.mj_footer resetNoMoreData];
    }];
    
    self.mj_footer = [MBRefreshShockFooter footerWithRefreshingBlock:^{
        if (weakSelf.pullUpBlock) {
            weakSelf.pullUpBlock(weakSelf);
        }
    }];
    self.mj_footer.backgroundColor = [UIColor clearColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"默认下拉";
    
    return cell;
}

@end
