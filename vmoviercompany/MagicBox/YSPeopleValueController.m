//
//  YSPeopleValueController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/18.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSPeopleValueController.h"
#import "YSTableInofView.h"
#import "UIViewController+VMKit.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "YSBookObject.h"
#import "AppDelegate.h"
#import "YSGongJiaObject.h"

@interface YSPeopleValueController ()<YSTableInfoDelegate>

@property (nonatomic, strong, readwrite) TPKeyboardAvoidingScrollView *mainScrollview;

//印刷工价
@property (nonatomic, strong, readwrite) YSTableInofView *yinShuaTable;

@property (nonatomic, strong, readwrite) YSTableInofView *jzGongJiaTable;

@property (nonatomic, strong, readwrite) YSTableInofView *puGongJiaTable;

@property (nonatomic, strong, readwrite) YSBookObject *currentBook;

@property (nonatomic, strong, readwrite) YSGongJiaObject *currentGongJia;

@property (nonatomic, strong, readwrite) YSTableInofView *gongYiGongJia;

@end

@implementation YSPeopleValueController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工价";
    self.view.backgroundColor = WHITE;
    [self indentiferNavBack];
    
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.currentGongJia = appdele.rootVC.standGongJia;
    
    UIButton *modifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [modifyBtn setTitle:@"保存" forState:UIControlStateNormal];
    modifyBtn.frame = CGRectMake(0, 0, 60, 30);
    modifyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [modifyBtn setTitleColor:COLORA(50, 50, 50) forState:UIControlStateNormal];
    [modifyBtn setTitleColor:COLORA(1, 100, 30) forState:UIControlStateSelected];
    [modifyBtn setTitleColor:COLORA(1, 100, 30) forState:UIControlStateHighlighted];
    [modifyBtn addTarget:self action:@selector(modifyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self rightNavWithView:modifyBtn];
    
    
    self.mainScrollview = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.mainScrollview];
    
    self.yinShuaTable = [[YSTableInofView alloc]initWithFrame:CGRectMake(20, 20, self.view.width - 40, 300)];
    [self.yinShuaTable loadTitles:@[@"项目",@"单价"]];
    [self.yinShuaTable loadRowTitlesTwo:@[@"单色",@"双色",@"四色",@"晒上版"]];
    
    NSString *danSeString = self.currentGongJia.danSe;
    NSString *sanSeString = self.currentGongJia.shuangSe;
    NSString *siSeString = self.currentGongJia.siSe;
    NSString *ShaiString = self.currentGongJia.shaiShangBan;
    
    [self.yinShuaTable loadSecondRowTitles:@[danSeString,sanSeString,siSeString,ShaiString]];
    self.yinShuaTable.infoDelegate = self;
    [self.yinShuaTable loadRows:@[@2] withColor:RED];
    [self.yinShuaTable loadRows:@[@2] withCanBeModeify:YES];
    [self.mainScrollview addSubview:self.yinShuaTable];
    
    self.puGongJiaTable = [[YSTableInofView alloc]initWithFrame:CGRectMake(20, self.yinShuaTable.bottom + 20, self.view.width - 40, 300)];
    [self.puGongJiaTable loadTitles:@[@"项目",@"骑马订",@"铁丝平订",@"胶订",@"锁胶"]];
    [self.puGongJiaTable loadRowTitlesFive:@[@"16开",@"32开"]];
    self.puGongJiaTable.hasExternColor = NO;
    
    NSString *stQi = self.currentGongJia.sixteenQiMa;
    NSString *etQi = self.currentGongJia.eighteenQiMa;
    
    NSString *stTs = self.currentGongJia.sixteenTieSiPing;
    NSString *etTs = self.currentGongJia.eighteenTieSiPing;
    
    NSString *stJD = self.currentGongJia.sixteenJiao;
    NSString *etJD = self.currentGongJia.eighteenJiao;
    
    NSString *stSJ = self.currentGongJia.sixteenSuoJiao;
    NSString *etSJ = self.currentGongJia.eighteenSuoJiao;
    
    [self.puGongJiaTable loadSecondRowTitles:@[stQi,etQi]];
    [self.puGongJiaTable loadThirdRowTitles:@[stTs,etTs]];
    [self.puGongJiaTable loadForthRowTitles:@[stJD,etJD]];
    [self.puGongJiaTable loadFifthRowTitles:@[stSJ,etSJ]];
    self.puGongJiaTable.infoDelegate = self;
    [self.puGongJiaTable loadRows:@[@2,@3,@4,@5] withCanBeModeify:YES];
    [self.puGongJiaTable loadRows:@[@2,@3,@4,@5] withColor:RED];
    [self.mainScrollview addSubview:self.puGongJiaTable];
    
    self.jzGongJiaTable = [[YSTableInofView alloc]initWithFrame:CGRectMake(20, self.puGongJiaTable.bottom + 20, self.view.width - 40, 300)];
    [self.jzGongJiaTable loadTitles:@[@"项目",@"金额"]];
    [self.jzGongJiaTable loadRowTitlesTwo:@[@"装订",@"上封",@"堵头布",@"荷兰板",@"环衬",@"圆脊"]];
    
    NSString *zhuangDingPrice = self.currentGongJia.zhuangDing;
    NSString *shangFengPrice = self.currentGongJia.shangFeng;
    NSString *dutouPrice = self.currentGongJia.duTouBu;
    NSString *helanPrice = self.currentGongJia.heLanBan;
    NSString *huanChen = self.currentGongJia.huanChen;
    NSString *yuanJi = self.currentGongJia.yuanJi;
    
    [self.jzGongJiaTable loadSecondRowTitles:@[zhuangDingPrice, shangFengPrice, dutouPrice, helanPrice, huanChen, yuanJi]];
    self.jzGongJiaTable.infoDelegate = self;
    [self.jzGongJiaTable loadRows:@[@2] withColor:RED];
    [self.jzGongJiaTable loadRows:@[@2] withCanBeModeify:YES];
    [self.mainScrollview addSubview:self.jzGongJiaTable];
    
    //添加工艺列表
    self.gongYiGongJia = [[YSTableInofView alloc]initWithFrame:CGRectMake(20, self.jzGongJiaTable.bottom + 20, self.view.width - 40, 300)];
    [self.gongYiGongJia loadTitles:@[@"项目",@"单价"]];
    [self.gongYiGongJia loadRowTitlesTwo:@[@"光膜",@"亚膜",@"UV",@"磨砂",@"起鼓",@"烫金",@"烫金版出片",@"贴标",@"塑封"]];
    [self.mainScrollview addSubview:self.gongYiGongJia];
    [self.gongYiGongJia loadRows:@[@2] withCanBeModeify:YES];
    [self.gongYiGongJia loadRows:@[@2] withColor:RED];
    self.gongYiGongJia.infoDelegate = self;
    
    
    NSString *guangMo = self.currentGongJia.guangMo;
    NSString *yaMo = self.currentGongJia.yaMo;
    NSString *uv = self.currentGongJia.UV;
    NSString *mosha = self.currentGongJia.moSha;
    NSString *qigu = self.currentGongJia.qiGu;
    NSString *tangJin = self.currentGongJia.tangJin;
    
    NSArray *perPerice = @[guangMo,yaMo,uv,mosha,qigu,tangJin];
    [self.gongYiGongJia loadSecondRowTitles:perPerice];
    
    [self.mainScrollview contentSizeToFit];
    
    self.puGongJiaTable.top = self.yinShuaTable.bottom + 30;
    self.jzGongJiaTable.top = self.puGongJiaTable.bottom + 30;
    self.gongYiGongJia.top = self.jzGongJiaTable.bottom + 30;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)tableInfoDidFinishLayout:(YSTableInofView *)tableInfo{
    self.puGongJiaTable.top = self.yinShuaTable.bottom + 50;
    self.jzGongJiaTable.top = self.puGongJiaTable.bottom + 50;
    self.gongYiGongJia.top = self.jzGongJiaTable.bottom + 50;
}


-(NSArray *)numberAry{
    
    //装订的数量 印张＊印量
    NSInteger yinZhang = [self.currentBook.yinzhangNum integerValue];
    NSInteger yinLiang = [self.currentBook.yinLiangNum integerValue];
    NSInteger zhuangDingNum = yinZhang * yinLiang;
    NSInteger kSize = [self.currentBook.kSize integerValue];
    NSInteger hlbNum = yinLiang / kSize;
    NSInteger hcNum = (yinLiang / kSize) * 2;
    
    //数量
    NSString *zhuangDingNumStr = [@(zhuangDingNum) stringValue];
    
    //上封
    NSString *shangfengNum = self.currentBook.yinLiangNum;
    
    //堵头布
    NSString *dutoubuNum = self.currentBook.yinLiangNum;
    
    //荷兰板
    NSString *helanbanNum = [@(hlbNum) stringValue];
    
    //环衬
    NSString *huanchenNum = [@(hcNum)stringValue];
    
    //圆脊
    NSString *yuanJiNum = self.currentBook.yinLiangNum;
    
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

//工艺的数量数组
-(NSArray *)gongYiNumberValues{
    
    NSInteger yinliang = 0;
    if ([self.currentBook.fmKsize isEqualToString:@"1"]) {
        yinliang = [self.currentBook.yinLiangNum integerValue];
    }else{
        if ([self.currentBook.fmKsize integerValue] / 2 <= 0) {
            yinliang = 0;
        }else
            yinliang = [self.currentBook.yinLiangNum integerValue] / ([self.currentBook.fmKsize integerValue] / 2);
    }
    
    //光膜 //亚膜 //UV //磨砂
    NSString *guangMoNumString  = [@(yinliang) stringValue];
    NSString *yaMonumString     = [@(yinliang) stringValue];
    NSString *UVNumString       = [@(yinliang) stringValue];
    NSString *moShaString       = [@(yinliang) stringValue];
    
    //起鼓
    NSString *qiGuNumString = self.currentBook.yinLiangNum;
    //烫金
//    NSInteger tangJinWidth = [self.tangJinInputView.firstInput.text integerValue];
//    NSInteger tangJinHeight = [self.tangJinInputView.secondInput.text integerValue];
    NSInteger tangJinWidth = 1;
    NSInteger tangJinHeight = 1;
    NSString *tangJingValue = [NSString stringWithFormat:@"%ld平方厘米",tangJinWidth * tangJinHeight];
    
    NSString *tangJinBanChuPianValue = @"";
    
    //贴标 //塑封
    NSString *tieBiaoNumString = self.currentBook.yinLiangNum;
    NSString *suBiaoNumString = self.currentBook.yinLiangNum;
    
    return @[
             guangMoNumString,
             yaMonumString,
             UVNumString,
             moShaString,
             qiGuNumString,
             tangJingValue,
             tangJinBanChuPianValue,
             tieBiaoNumString,
             suBiaoNumString
             ];
}

-(NSArray *)gongYiPerPrice{
    
    return @[
             @"0.4",
             @"0.5",
             @"0.5",
             @"0.65",
             @"0.05",
             @"0.003元/平方厘米",
             @"50",
             @"0.1",
             @"0.3"
             ];
}

-(NSArray *)jinEValues{
    
    NSArray *numbers = [self gongYiNumberValues];
    NSArray *prices = [self gongYiPerPrice];
    NSMutableArray *finalAry = [@[]mutableCopy];
    for (int i = 0; i < numbers.count; i++) {
        //数量
        NSString *number = [numbers objectAtIndex:i];
        if ([number isValid] == NO) {
            number = @"0";
        }else{
            if ([number containSubstring:@"平方厘米"]) {
                number = [number removeSubstring:@"平方厘米"];
            }
        }
        NSInteger numberInteger = [number integerValue];
        
        //单价
        NSString *price = [prices objectAtIndex:i];
        if ([price isValid] == NO) {
            price = @"0";
        }else{
            if ([price containsString:@"元/平方厘米"]) {
                price = [price removeSubstring:@"元/平方厘米"];
            }
        }
        CGFloat priceFloat = [price floatValue];
        CGFloat finalPrice = priceFloat * numberInteger;
        [finalAry addObject:[NSString stringWithFormat:@"%.2f",finalPrice]];
    }
    return finalAry;
}

-(void)modifyBtnClicked:(id)sender{
    //这里需要他妈哒保存工价
    NSArray *array = [self.yinShuaTable valuesForRowTitle:@"单价"];
    self.currentGongJia.danSe = array[0];
    self.currentGongJia.shuangSe = array[1];
    self.currentGongJia.siSe = array[2];
    self.currentGongJia.shaiShangBan = array[3];
    
    NSArray *qiMaAry = [self.puGongJiaTable valuesForRowTitle:@"骑马订"];
    NSArray *tieSiAry = [self.puGongJiaTable valuesForRowTitle:@"铁丝平订"];
    NSArray *jiaoAry = [self.puGongJiaTable valuesForRowTitle:@"胶订"];
    NSArray *suoJiao = [self.puGongJiaTable valuesForRowTitle:@"锁胶"];
    self.currentGongJia.sixteenQiMa = qiMaAry[0];
    self.currentGongJia.eighteenQiMa = qiMaAry[1];
    
    self.currentGongJia.sixteenTieSiPing = tieSiAry[0];
    self.currentGongJia.eighteenTieSiPing = tieSiAry[1];
    
    self.currentGongJia.sixteenJiao = jiaoAry[0];
    self.currentGongJia.eighteenJiao = jiaoAry[1];
    
    self.currentGongJia.sixteenSuoJiao = suoJiao[0];
    self.currentGongJia.eighteenSuoJiao = suoJiao[1];
    
    NSArray *jingZhuangAry = [self.jzGongJiaTable valuesForRowTitle:@"金额"];
    self.currentGongJia.zhuangDing = jingZhuangAry[0];
    self.currentGongJia.shangFeng = jingZhuangAry[1];
    self.currentGongJia.duTouBu = jingZhuangAry[2];
    self.currentGongJia.heLanBan = jingZhuangAry[3];
    self.currentGongJia.huanChen = jingZhuangAry[4];
    self.currentGongJia.yuanJi = jingZhuangAry[5];
    
    NSArray *gongyiAry = [self.gongYiGongJia valuesForRowTitle:@"单价"];
    self.currentGongJia.guangMo = gongyiAry[0];
    self.currentGongJia.yaMo = gongyiAry[1];
    self.currentGongJia.UV = gongyiAry[2];
    self.currentGongJia.moSha = gongyiAry[3];
    self.currentGongJia.qiGu = gongyiAry[4];
    self.currentGongJia.tangJin = gongyiAry[5];
    
    [self.currentGongJia saveStandGongJia];
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - lazy actions ------

-(YSBookObject *)currentBook{

    if (_currentBook == nil) {
        AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _currentBook = appdele.rootVC.currentBook;
    }
    return _currentBook;
}



@end
