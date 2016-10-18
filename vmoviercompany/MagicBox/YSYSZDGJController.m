//
//  YSYSZDGJController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/29.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSYSZDGJController.h"
#import "YSTableInofView.h"
#import "AppDelegate.h"
#import "YSBookObject.h"
#import "YSHuiZongView.h"

@interface YSYSZDGJController ()

@property (nonatomic, strong, readwrite) YSTableInofView *yinShuaTable;

@property (nonatomic, strong, readwrite) YSTableInofView *jzGongJiaTable;

@property (nonatomic, strong, readwrite) YSBookObject *bookObj;

@end

@implementation YSYSZDGJController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE;
    
    UIButton *jiSuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jiSuanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [jiSuanBtn setTitle:@"计算" forState:UIControlStateNormal];
    [jiSuanBtn setTitleColor:COLORA(45, 45, 45) forState:UIControlStateNormal];
    [jiSuanBtn setFrame:CGRectMake(0, 0, 40, 30)];
    [jiSuanBtn addTarget:self action:@selector(jiSuanBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setFrame:CGRectMake(0, 0, 40, 30)];
    [saveBtn setTitleColor:COLORA(45, 45, 45) forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *jsItem = [[UIBarButtonItem alloc]initWithCustomView:jiSuanBtn];
    UIBarButtonItem *saItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    
    
    NSArray *itemArys = @[saItem,jsItem];
    self.navigationItem.rightBarButtonItems = itemArys;

    

    self.yinShuaTable = [[YSTableInofView alloc]initWithFrame:CGRectMake(20, 20, self.view.width - 40, 300)];
    [self.yinShuaTable loadTitles:@[@"项目",@"单价",@"",@""]];
    [self.yinShuaTable loadRowTitles:@[@"单色",@"双色",@"四色",@"晒上版"]];
    [self.yinShuaTable loadSecondRowTitles:@[@"10",@"18",@"24",@"90"]];
    [self.view addSubview:self.yinShuaTable];
    [self.view addSubview:self.jzGongJiaTable];
    

    
    [self.jzGongJiaTable loadTitles:@[@"项目",@"数量",@"单价",@"金额"]];
    [self.jzGongJiaTable loadRowTitles:@[@"装订",@"上封",@"堵头布",@"荷兰板",@"环衬",@"圆脊"]];
    [self.jzGongJiaTable loadSecondRowTitles:[self numberAry]];
    [self.jzGongJiaTable loadThirdRowTitles:[self perRowPrices]];
    [self.jzGongJiaTable loadForthRowTitles:[self jingZhuangGongJiaJinE]];
    
}

-(void)jiSuanBtnClicked:(id)sender{

}

-(void)saveBtnClicked:(id)sender{

}


-(NSArray *)numberAry{
    
    //装订的数量 印张＊印量
    NSInteger yinZhang = [self.bookObj.yinzhangNum integerValue];
    NSInteger yinLiang = [self.bookObj.yinLiangNum integerValue];
    NSInteger zhuangDingNum = yinZhang * yinLiang;
    NSInteger kSize = [self.bookObj.kSize integerValue];
    NSInteger hlbNum = yinLiang / kSize;
    NSInteger hcNum = (yinLiang / kSize) * 2;
    
    //数量
    NSString *zhuangDingNumStr = [@(zhuangDingNum) stringValue];
    
    //上封
    NSString *shangfengNum = self.bookObj.yinLiangNum;
    
    //堵头布
    NSString *dutoubuNum = self.bookObj.yinLiangNum;
    
    //荷兰板
    NSString *helanbanNum = [@(hlbNum) stringValue];
    
    //环衬
    NSString *huanchenNum = [@(hcNum)stringValue];
    
    //圆脊
    NSString *yuanJiNum = self.bookObj.yinLiangNum;
    
    return @[
             zhuangDingNumStr,
             shangfengNum,
             dutoubuNum,
             helanbanNum,
             huanchenNum,
             yuanJiNum
             ];
}

-(NSArray *)perRowPrices{
    return @[
             @"0.03",
             @"2",
             @"0.2",
             @"13",
             @"2",
             @"1"
             ];
}

-(NSArray *)jingZhuangGongJiaJinE{
    NSArray *num = [self numberAry];
    NSArray *perRowPrice = [self perRowPrices];
    NSMutableArray *jinEAry = [@[]mutableCopy];
    for (int i = 0; i < num.count; i++) {
        NSInteger number = [[num objectAtIndex:i] integerValue];
        CGFloat price = [[perRowPrice objectAtIndex:i] floatValue];
        CGFloat wholePric = number * price;
        [jinEAry addObject:[NSString stringWithFormat:@"%.2f",wholePric]];
    }
    return [jinEAry copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - infotable view lazying acitons ------

-(YSTableInofView *)jzGongJiaTable{
    if (_jzGongJiaTable == nil) {
        _jzGongJiaTable = [[YSTableInofView alloc]initWithFrame:CGRectMake(20, self.yinShuaTable.bottom + 60, self.view.width - 40, 200)];
    }
    return _jzGongJiaTable;
}

-(YSBookObject *)bookObj{
    if (_bookObj == nil) {
        AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _bookObj = appdele.rootVC.currentBook;
    }
    return _bookObj;
}


@end
