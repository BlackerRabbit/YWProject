//
//  YSSelectTableViewController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/23.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSSelectTableViewController.h"
#import "UIViewController+VMKit.h"

@interface YSSelectTableViewController ()
@property (nonatomic, strong, readwrite) NSString *selectedString;
@end

@implementation YSSelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self indentiferNavBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    if (self.block) {
        self.block(self.selectedString);
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reusetIdentifer"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reusetIdentifer"];
    }
    cell.textLabel.text = self.dataAry[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.selectedString = self.dataAry[indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
