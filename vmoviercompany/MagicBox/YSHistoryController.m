//
//  YSHistoryController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/28.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSHistoryController.h"
#import "YSIndexController.h"
#import "YSDataCenter.h"
#import "YSCoverInputView.h"
#import "AppDelegate.h"
#import "UIViewController+VMKit.h"

@interface YSHistoryController ()

@property (nonatomic, strong, readwrite) YSDataCenter *dataCenter;
@property (nonatomic, strong, readwrite) NSMutableArray *dataAry;
@property (nonatomic, assign, readwrite) BOOL canModify;
@end

@implementation YSHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    [self useMethodToFindBlackLineAndHind];
//    0.6, 0.4, 0.2
    self.tableView.backgroundColor = WHITE;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.dataAry = [@[]mutableCopy];
    
    self.dataCenter = [YSDataCenter shareDataCenter];
    NSArray *allBoks = [self.dataCenter allBooksInTheList];
    [self.dataAry addObjectsFromArray:allBoks];
    
    [self.tableView reloadData];
    
    UIFont *titleFont = [UIFont systemFontOfSize:14];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(0, 0, 40, 30)];
    [leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundColor:CLEAR];
    [leftBtn setTitleColor:COLORA(60, 60, 60) forState:UIControlStateNormal];
    leftBtn.titleLabel.font = titleFont;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"复制" forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 40, 30)];
    [rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundColor:CLEAR];
    [rightBtn setTitleColor:COLORA(60, 60, 60)  forState:UIControlStateNormal];
    rightBtn.titleLabel.font = titleFont;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self indentiferNavBack];
}

//方法二.当设置navigationBar的背景图片或背景色时，使用该方法都可移除黑线，且不会使translucent属性失效
-(void)useMethodToFindBlackLineAndHind
{
    UIImageView* blackLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    //隐藏黑线（在viewWillAppear时隐藏，在viewWillDisappear时显示）
    blackLineImageView.hidden = YES;
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions ------

-(void)leftBtnClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if (self.tableView.editing) {
        [btn setTitle:@"完成" forState:UIControlStateNormal];
    }else
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
}

-(void)rightBtnClicked:(id)sender{

    YSIndexController *indexVC = [[YSIndexController alloc]init];
    [self.navigationController pushViewController:indexVC animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAry.count + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (2.f/16.f)*SCREEN_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCellReuseidentifer"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistoryCellReuseidentifer"];
        cell.backgroundColor = tableView.backgroundColor;
        cell.contentView.backgroundColor = cell.backgroundColor;
        //cover
        UIImageView *coverImg = [[UIImageView alloc]initWithFrame:CGRectMake(30, 12, (((2.f/16.f)*SCREEN_HEIGHT) - 24) / 1.6, ((2.f/16.f)*SCREEN_HEIGHT) - 30)];
        coverImg.tag = 1111;
        [cell addSubview:coverImg];
        
        //label
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(coverImg.right + 10, coverImg.top, self.tableView.width - coverImg.right - 10 - 30, coverImg.height)];
        name.backgroundColor = self.tableView.backgroundColor;
        name.font = [UIFont systemFontOfSize:16];
        name.textColor = COLORA(60, 60, 60);
        name.tag = 2222;
        [cell addSubview:name];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UIImageView *coverImg = (UIImageView *)[cell viewWithTag:1111];
    UILabel *label = (UILabel *)[cell viewWithTag:2222];
    NSString *labelName = nil;
    if (indexPath.row == 0) {
        [coverImg setImage:[UIImage imageNamed:@"create_new_small"]];
        labelName = @"新建";
    }else{
        NSDictionary *data = self.dataAry[indexPath.row - 1];
        labelName = data[@"book_name"];
        [coverImg setImage:[UIImage imageNamed:@"small_book_icon"]];
    }
    
    label.text = labelName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        YSCoverInputView *coverView = [[YSCoverInputView alloc]initWithFrame:window.bounds];
        coverView.alpha = 0;
        [self.navigationController.view addSubview:coverView];
        [UIView animateWithDuration:.3 animations:^{
            coverView.alpha = 1;
        }];
        WEAKSELF;
        coverView.handler = ^(NSString *name){
            
            AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
            appdele.rootVC.currentBook.bookName = name;
          
            appdele.rootVC.currentBook = [YSBookObject createNewBook];
            YSIndexController *indexVC = [[YSIndexController alloc]init];
            indexVC.title = name;
            [weakSelf.navigationController pushViewController:indexVC animated:YES];
        };
        
    }else{
        
        NSString *name = [[self.dataAry objectAtIndex:indexPath.row - 1] objectForKey:@"book_name"];
        YSIndexController *indexVC = [[YSIndexController alloc]init];
        indexVC.title = name;
        [self.navigationController pushViewController:indexVC animated:YES];
        
        AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appdele.rootVC.currentBook.bookName = name;
        [appdele.rootVC.currentBook bookLoadInfoFromDic:[self.dataAry objectAtIndex:indexPath.row - 1]];
    }
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.row == 0) {
        return NO;
    }
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataAry removeObjectAtIndex:indexPath.row - 1];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
