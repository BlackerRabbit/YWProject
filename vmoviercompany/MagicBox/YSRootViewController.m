//
//  YSRootViewController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/6/29.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSRootViewController.h"
#import "YSGaoFeiCell.h"
#import "YSBookViewController.h"
#import "VMNavigationController.h"
#import "YSPaperView.h"
#import "YSPaperSizeLabel.h"
#import "YSBookKSize.h"

#import "YSADViewController.h"


@interface YSRootViewController ()


@end

@implementation YSRootViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


-(YSBookObject *)currentBook{
    if (_currentBook == nil) {
        _currentBook = [[YSBookObject alloc]init];
    }
    return _currentBook;
}

-(YSGongJiaObject *)standGongJia{
    if (_standGongJia == nil) {
        _standGongJia = [YSGongJiaObject standGongJia];
    }
    return _standGongJia;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     width / height = 1.4
     */

    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.width,self.view.width / (1.4) + 30)];
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = WHITE;
    NSArray *array = [YSBookKSize allValidkSize];
    scrollView.contentSize = CGSizeMake(self.view.width * array.count, 0);
    float xoffset = 0;

    for (int i = 0; i < array.count; i++) {
        YSPaperView *paper = [[YSPaperView alloc]initWithFrame:CGRectMake(xoffset, 0, self.view.width,(self.view.width / (1.4)))];
        xoffset += self.view.width;
        [paper showWithkSize:array[i]];
        paper.backgroundColor = WHITE;
        [scrollView addSubview:paper];
    }
//    [self.view addSubview:scrollView];
    
    scrollView.height += 10;
    
    
    YSPaperView *paper = [[YSPaperView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.width / (1.4))];
    paper.backgroundColor = WHITE;
//    [paper showWithkSize:[YSBookKSize KSizeEightFourHengShu]];
//    [self.view addSubview:paper];

    
    YSBookViewController *bookVC = [[YSBookViewController alloc]init];
    VMNavigationController *bookNAV = [[VMNavigationController alloc]initWithRootViewController:bookVC];
    [self addChildViewController:bookNAV];
    [self.view addSubview:bookNAV.view];
    
    YSADViewController *adVC = [[YSADViewController alloc]init];
    VMNavigationController *adNAV = [[VMNavigationController alloc]initWithRootViewController:adVC];
    adVC.view.backgroundColor = WHITE;
    [self addChildViewController:adNAV];
    [self.view addSubview:adNAV.view];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- YSManagerView delegate and datasource ------

-(UITableViewCell *)cellFortableView:(UITableView *)tableView atIndex:(NSInteger)index cellIndexPath:(NSIndexPath *)indexpath{
    switch (index) {
        case 0:return [YSGaoFeiCell gaoFeiCellAtIndexpath:indexpath];break;
        case 1:break;
        case 2:break;
        case 3:break;
        case 4:break;
        default:
            break;
    }
    return [UITableViewCell new];
}





@end
