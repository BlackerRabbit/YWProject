//
//  YSYinShuaController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/21.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSYinShuaController.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "YSCustomInputView.h"
#import "UIViewController+VMKit.h"
#import "YSJSQController.h"
#import "YSBookObject.h"
#import "AppDelegate.h"
#import "YSSelectTableViewController.h"
#import "YSYSZDGJController.h"
#import "YSTableInofView.h"
#import "YSHuiZongView.h"

@interface YSYinShuaController ()<YSTableInfoDelegate>
@property (nonatomic, strong, readwrite) TPKeyboardAvoidingScrollView *mainScrollview;

@property (nonatomic, assign, readwrite) NSInteger wholeNum;

@property (nonatomic, strong, readwrite) NSMutableArray *inputNumAry;

@property (nonatomic, strong, readwrite) CALayer *lineLayer;

@property (nonatomic, strong, readwrite) UILabel *maxLabel;

@property (nonatomic, strong, readwrite) YSBookObject *currentBook;

@property (nonatomic, strong, readwrite) NSString *tcpZhiBan;

@property (nonatomic, strong, readwrite) NSString *zwValue;

@property (nonatomic, strong, readwrite) NSString *fmValue;

@property (nonatomic, strong, readwrite) NSString *fmzbValue;

//工价
@property (nonatomic, strong, readwrite) YSTableInofView *yinShuaTable;

@property (nonatomic, strong, readwrite) YSTableInofView *jzGongJiaTable;

@property (nonatomic, strong, readwrite) YSTableInofView *puGongJiaTable;

@property (nonatomic, strong, readwrite) UILabel *yinshuGongJiaLabel;

@property (nonatomic, strong, readwrite) UILabel *zhuangDingLabel;

@property (nonatomic, strong, readwrite) UILabel *jinZhuangLabel;

//汇总
@property (nonatomic, strong, readwrite) YSHuiZongView *huiZongView;

@property (nonatomic, strong, readwrite) NSString *yinShuaValue;
@property (nonatomic, strong, readwrite) NSString *zhuangDingValue;
/*
 */
@property (nonatomic, strong, readwrite) NSString *zwCTPValue;
@property (nonatomic, strong, readwrite) NSString *zwYinShuaValue;
@property (nonatomic, strong, readwrite) NSString *fmCTPValue;
@property (nonatomic, strong, readwrite) NSString *fmYinShuaValue;





/*
//正文是16开，封面是8开

//正文CTP制版的费用 印张 ＊（1或2）＊ 单价(先默认为90) ＊ 色数(内文的色数)
NSInteger ctpValue = yinZhangNum * shiFouDoubleNum * 90 * nyseshuNum;
//    [VMTools alertMessage:[NSString stringWithFormat:@"ctp value is %ld",ctpValue]];

//正文印刷费用  印张 ＊ 千印数（3千起，不足补3千，足了补1千）＊ 色数 ＊ （1或2（是否对开）) ＊ 单价（默认18）
NSInteger zhengwenValue = yinZhangNum * (yinLiangNum / 1000) * nyseshuNum * shiFouDoubleNum * 18;
//    [VMTools alertMessage:[NSString stringWithFormat:@"zheng wen value is %ld",zhengwenValue]];

//封面有底价，如果不足底价，按底价计算
//封面印刷费用 印张 ＊ 千印数（印量 ／（封面开数／2（必然对开）））＊ 色数 ＊ （1 或 2（是否双面印刷））＊ 单价（默认18）
NSInteger fengmianValue = 1 * ((yinLiangNum / (16 / 2))) / 1000 * fmseshuNum * fmShiFouDoubleNum * 18;
//    [VMTools alertMessage:[NSString stringWithFormat:@"feng mian value is %ld",fengmianValue]];

//封面CTP制版的费用 色数 ＊ 是否双面 ＊ 单价(默认为90)
NSInteger fengMianZhiBanValue = 1 * fmseshuNum * fmShiFouDoubleNum * 90;
//    [VMTools alertMessage:[NSString stringWithFormat:@"feng mian ctp value is %ld",fengMianZhiBanValue]];

*/


@end

@implementation YSYinShuaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self indentiferNavBack];
    self.title = @"印刷装订";
    self.inputNumAry = [@[]mutableCopy];
    
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
    
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.currentBook = appdele.rootVC.currentBook;
    
    
    [self.view addSubview:self.huiZongView];
    self.mainScrollview = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.huiZongView.height - 64)];
    [self.view addSubview:self.mainScrollview];
    
    self.huiZongView.bottom = self.view.height - 64;
    
    self.yinShuaValue = [self.currentBook.yinShuaMoney isValid] ? self.currentBook.yinShuaMoney : @"0";
    self.zhuangDingValue = [self.currentBook.zdMoney isValid] ? self.currentBook.zdMoney : @"0";
    self.zwCTPValue = [self.currentBook.zwCTPMoney isValid] ? self.currentBook.zwCTPMoney : @"0";
    self.zwYinShuaValue = [self.currentBook.zwYinShuaMoney isValid] ? self.currentBook.zwYinShuaMoney : @"0";
    self.fmCTPValue = [self.currentBook.fmCTPMoney isValid] ? self.currentBook.fmCTPMoney : @"0";
    self.fmYinShuaValue = [self.currentBook.fmYinShuaMoney isValid] ? self.currentBook.fmYinShuaMoney : @"0";

    [self.huiZongView loadValues:@[self.zwCTPValue,self.zwYinShuaValue,self.fmCTPValue,self.fmYinShuaValue,self.zhuangDingValue]];
    
    
    self.view.backgroundColor = WHITE;

    float yoffset = 20;
    
    NSString *shifouDuiKai = [self.currentBook.zdDuiKai isValid] ? self.currentBook.zdDuiKai : @"是";
    NSString *neiwenSeShu = [self.currentBook.zdNeiWenSeShu isValid] ? self.currentBook.zdNeiWenSeShu : @"2";
    NSString *fmSeShu = [self.currentBook.zdFengMianSeShu isValid] ? self.currentBook.zdFengMianSeShu : @"4";
    NSString *fmShuangYe = [self.currentBook.zdFengMianShiFouShuangYe isValid] ? self.currentBook.zdFengMianShiFouShuangYe : @"否";
    NSString *fmDijia = [self.currentBook.zdFengMianDiJia isValid] ? self.currentBook.zdFengMianDiJia : @"500";
    
    WEAKSELF;
    NSArray *arry = @[
//                      @{@"title":@"印量",@"value":self.currentBook.yinLiangNum},
                      //内文3千起
//                      @{@"title":@"印张",@"value":self.currentBook.yinzhangNum},
                      @{@"title":@"是否对开",@"value":shifouDuiKai},
                      
                      @{@"title":@"内文色数",@"value":neiwenSeShu},
                      @{@"title":@"封面色数",@"value":fmSeShu},
                      
                      @{@"title":@"封面是否双面",@"value":fmShuangYe},
                      @{@"title":@"封面底价",@"value":fmDijia},
                      ];
    for (int i = 0; i < arry.count; i ++) {
        YSCustomInputView *inputView;
        if (i == 0 || i == 3) {
            inputView = [YSCustomInputView selectInputViewWithParamClickBlock:^(YSCustomInputView *customInput) {
                [weakSelf selecteCustomInputView:customInput];
            }];
        }else if(i == 1 || i == 2){
            inputView = [YSCustomInputView selectInputViewWithParamClickBlock:^(YSCustomInputView *customInput) {
                [weakSelf selecteCustomInputView:customInput];
            }];
        }else
            inputView = [[NSBundle mainBundle]loadNibNamed:@"YSCustomInputView" owner:nil options:nil].lastObject;
        [inputView loadTitle:arry[i][@"title"] defaultValue:arry[i][@"value"]];
        inputView.frame = CGRectMake(10, yoffset, self.view.width - 40, inputView.height);
        [self.mainScrollview  addSubview:inputView];
        yoffset += inputView.height + 20;
        [self.inputNumAry addObject:inputView];
        inputView.tag = i;
    }
    
    YSCustomInputView *lastInput = [self.inputNumAry lastObject];
    self.yinShuaTable = [[YSTableInofView alloc]initWithFrame:CGRectMake(20, lastInput.bottom + 20, self.view.width - 40, 300)];
    self.yinShuaTable.infoDelegate = self;
    [self.yinShuaTable loadTitles:@[@"项目",@"单价"]];
    [self.yinShuaTable loadRowTitlesTwo:@[@"单色",@"双色",@"四色",@"晒上版"]];
    self.yinShuaTable.clipsToBounds = YES;
    
    //印刷工价
    NSString *danSe = self.currentBook.bookGongJia.danSe;
    NSString *shuangSe = self.currentBook.bookGongJia.shuangSe;
    NSString *siSe = self.currentBook.bookGongJia.siSe;
    NSString *shaiShangBan = self.currentBook.bookGongJia.shaiShangBan;
    
    [self.yinShuaTable loadSecondRowTitles:@[danSe,shuangSe,siSe,shaiShangBan]];
    [self.mainScrollview addSubview:self.yinShuaTable];
    [self.yinShuaTable loadRows:@[@2] withColor:RED];
    [self.yinShuaTable loadRows:@[@2] withCanBeModeify:YES];
    
    self.puGongJiaTable = [[YSTableInofView alloc]initWithFrame:CGRectMake(20, self.yinShuaTable.bottom + 20, self.view.width - 40, 300)];
    self.puGongJiaTable.infoDelegate = self;
    [self.puGongJiaTable loadTitles:@[@"项目",@"骑马订",@"胶订",@"锁胶"]];
    [self.puGongJiaTable loadRowTitles:@[@"16开",@"32开"]];
//    self.puGongJiaTable.hasExternColor = NO;
    //装订工价
    NSString *stQi = self.currentBook.bookGongJia.sixteenQiMa;
    NSString *etQi = self.currentBook.bookGongJia.eighteenQiMa;
    
    NSString *stJD = self.currentBook.bookGongJia.sixteenJiao;
    NSString *etJD = self.currentBook.bookGongJia.eighteenJiao;
    
    NSString *stSJ = self.currentBook.bookGongJia.sixteenSuoJiao;
    NSString *etSJ = self.currentBook.bookGongJia.eighteenSuoJiao;
    
    [self.puGongJiaTable loadSecondRowTitles:@[stQi,etQi]];
    [self.puGongJiaTable loadThirdRowTitles:@[stJD,etJD]];
    [self.puGongJiaTable loadForthRowTitles:@[stSJ,etSJ]];
    [self.puGongJiaTable loadRows:@[@2,@3,@4] withCanBeModeify:YES];
    [self.puGongJiaTable loadRows:@[@2,@3,@4] withColor:RED];
    [self.mainScrollview addSubview:self.puGongJiaTable];
    
  
    
    
    self.jzGongJiaTable = [[YSTableInofView alloc]initWithFrame:CGRectMake(20, self.puGongJiaTable.bottom + 20, self.view.width - 40, 300)];
    [self.jzGongJiaTable loadTitles:@[@"项目",@"数量",@"单价",@"金额"]];
    [self.jzGongJiaTable loadRowTitles:@[@"装订",@"上封",@"堵头布",@"荷兰板",@"环衬",@"圆脊"]];
    [self.jzGongJiaTable loadSecondRowTitles:[self numberAry]];
    
    NSString *zhuangDingPrice = self.currentBook.bookGongJia.zhuangDing;
    NSString *shangFengPrice = self.currentBook.bookGongJia.shangFeng;
    NSString *dutouPrice = self.currentBook.bookGongJia.duTouBu;
    NSString *helanPrice = self.currentBook.bookGongJia.heLanBan;
    NSString *huanChen = self.currentBook.bookGongJia.huanChen;
    NSString *yuanJi = self.currentBook.bookGongJia.yuanJi;
    
    [self.jzGongJiaTable loadThirdRowTitles:@[zhuangDingPrice,shangFengPrice,dutouPrice,helanPrice,huanChen,yuanJi]];
    [self.jzGongJiaTable loadForthRowTitles:[self jingZhuangGongJiaJinE]];
    self.jzGongJiaTable.infoDelegate = self;
    [self.mainScrollview addSubview:self.jzGongJiaTable];
   
    
    self.puGongJiaTable.top = self.yinShuaTable.bottom + 30;
    self.jzGongJiaTable.top = self.puGongJiaTable.bottom + 30;
    
    [self.mainScrollview addSubview:self.yinshuGongJiaLabel];
    [self.mainScrollview addSubview:self.zhuangDingLabel];
    [self.mainScrollview addSubview:self.jinZhuangLabel];
    
    [self.mainScrollview contentSizeToFit];

    // Do any additional setup after loading the view.
}


-(void)jiSuanBtnClicked:(id)sender{
    [self getFinalValue];
    [self.huiZongView loadValues:@[self.zwCTPValue,self.zwYinShuaValue,self.fmCTPValue,self.fmYinShuaValue,self.zhuangDingValue]];
}

-(void)saveBtnClicked:(id)sender{
    [self updatePaperWithBaseInfo];
}


-(void)tableInfoDidFinishLayout:(YSTableInofView *)tableInfo{
    NSLog(@"working tableInfo is ===>> %@",tableInfo);
    
    
    
    YSCustomInputView *lastInput = [self.inputNumAry lastObject];
    self.yinShuaTable.top = lastInput.bottom + 50;
    self.puGongJiaTable.top = self.yinShuaTable.bottom + 50;
    self.jzGongJiaTable.top = self.puGongJiaTable.bottom + 50;
    
    self.yinshuGongJiaLabel.bottom = self.yinShuaTable.top - 5;
    self.zhuangDingLabel.bottom = self.puGongJiaTable.top - 5;
    self.jinZhuangLabel.bottom = self.jzGongJiaTable.top - 5;

    [self.mainScrollview contentSizeToFit];
    self.mainScrollview.contentSize = CGSizeMake(self.mainScrollview.contentSize.width,self.mainScrollview.contentSize.height + 30);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.jsqVC getValueFromYinShuaZhuangDing:[NSString stringWithFormat:@"%@ %@",self.yinShuaValue,self.zhuangDingValue]];
}

-(void)updatePaperWithBaseInfo{
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSBookObject *bookObj = appdele.rootVC.currentBook;
    
    bookObj.zdDuiKai = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:0] inputText];
    bookObj.zdNeiWenSeShu = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:1] inputText];
    
    bookObj.zdFengMianSeShu = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:2] inputText];
    bookObj.zdFengMianShiFouShuangYe = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:3] inputText];
    
    bookObj.zdFengMianDiJia = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:4] inputText];

    bookObj.yinShuaMoney = self.yinShuaValue;
    bookObj.zdMoney = self.zhuangDingValue;
    
    //保存工价
    
    //这里需要他妈哒保存工价
    NSArray *array = [self.yinShuaTable valuesForRowTitle:@"单价"];
    self.currentBook.bookGongJia.danSe = array[0];
    self.currentBook.bookGongJia.shuangSe = array[1];
    self.currentBook.bookGongJia.siSe = array[2];
    self.currentBook.bookGongJia.shaiShangBan = array[3];
    
    NSArray *qiMaAry = [self.puGongJiaTable valuesForRowTitle:@"骑马订"];
//    NSArray *tieSiAry = [self.puGongJiaTable valuesForRowTitle:@"铁丝平订"];
    NSArray *jiaoAry = [self.puGongJiaTable valuesForRowTitle:@"胶订"];
    NSArray *suoJiao = [self.puGongJiaTable valuesForRowTitle:@"锁胶"];
    self.currentBook.bookGongJia.sixteenQiMa = qiMaAry[0];
    self.currentBook.bookGongJia.eighteenQiMa = qiMaAry[1];
    
//    self.currentBook.bookGongJia.sixteenTieSiPing = tieSiAry[0];
//    self.currentBook.bookGongJia.eighteenTieSiPing = tieSiAry[1];
    
    self.currentBook.bookGongJia.sixteenJiao = jiaoAry[0];
    self.currentBook.bookGongJia.eighteenJiao = jiaoAry[1];
    
    self.currentBook.bookGongJia.sixteenSuoJiao = suoJiao[0];
    self.currentBook.bookGongJia.eighteenSuoJiao = suoJiao[1];
    
    NSArray *jingZhuangAry = [self.jzGongJiaTable valuesForRowTitle:@"单价"];
    self.currentBook.bookGongJia.zhuangDing = jingZhuangAry[0];
    self.currentBook.bookGongJia.shangFeng = jingZhuangAry[1];
    self.currentBook.bookGongJia.duTouBu = jingZhuangAry[2];
    self.currentBook.bookGongJia.heLanBan = jingZhuangAry[3];
    self.currentBook.bookGongJia.huanChen = jingZhuangAry[4];
    self.currentBook.bookGongJia.yuanJi = jingZhuangAry[5];
    
    //汇总价格
    self.currentBook.zwCTPMoney = self.zwCTPValue;
    self.currentBook.zwYinShuaMoney = self.zwYinShuaValue;
    self.currentBook.fmCTPMoney = self.fmCTPValue;
    self.currentBook.fmYinShuaMoney = self.fmYinShuaValue;
    
//    [self.currentBook.bookGongJia saveBookGongJia];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)moneyLabelTapped:(UITapGestureRecognizer *)tap{

    [self getFinalValue];
}

-(void)priceLabelTapped:(UITapGestureRecognizer *)tap{
    YSYSZDGJController *yszdgjVC = [[YSYSZDGJController alloc]init];
    [self.navigationController pushViewController:yszdgjVC animated:YES];
}

-(void)getFinalValue{
    //晒上版的费用
    YSCustomInputView *yinLiang = [self customInputViewWithTitle:@"印量"];
    YSCustomInputView *yinZhang = [self customInputViewWithTitle:@"印张"];
    YSCustomInputView *shifouDouble = [self customInputViewWithTitle:@"是否对开"];
    YSCustomInputView *nyseshu = [self customInputViewWithTitle:@"内文色数"];
    YSCustomInputView *fmseshu = [self customInputViewWithTitle:@"封面色数"];
    YSCustomInputView *fmShifouDouble = [self customInputViewWithTitle:@"封面是否双面"];
    YSCustomInputView *fmDijia = [self customInputViewWithTitle:@"封面底价"];
    YSCustomInputView *sufeng = [self customInputViewWithTitle:@"是否塑封"];
   
//    NSInteger yinLiangNum = [yinLiang number];
//    NSInteger yinZhangNum = [yinZhang number];
    
    NSInteger yinLiangNum = [self.currentBook.yinLiangNum integerValue];
    NSInteger yinZhangNum = [self.currentBook.yinzhangNum integerValue];
    
    NSInteger shiFouDoubleNum = [shifouDouble.inputText isEqualToString:@"是"] ? 2 : 1;//暂时全部按照2来算
    NSInteger nyseshuNum = [nyseshu number];
    NSInteger fmseshuNum = [fmseshu number];
    NSInteger fmShiFouDoubleNum = [fmShifouDouble.inputText isEqualToString:@"是"] ? 2 : 1;//暂时全部按照1来算
    NSInteger fmDijiaNum = [fmDijia number];
    NSInteger sufengNum = 1;//暂时按照不来算
    
    NSInteger zwKaiShu = [self.currentBook.kSize integerValue];
    NSInteger fmKaiShu = [self.currentBook.fmKsize integerValue];
    
    NSArray *seShuDanJia = [self.yinShuaTable valuesForRowTitle:@"单价"];
    NSInteger index = 0;
    if (nyseshuNum == 1) {
        index = 0;
    }else if (nyseshuNum == 2){
        index = 1;
    }else if (nyseshuNum == 4){
        index = 2;
    }
    CGFloat neyeDanJia = [[seShuDanJia objectAtIndex:index] floatValue];
    CGFloat shaiSHangban = [[seShuDanJia objectAtIndex:3]floatValue];
    
    
    
    
    
//    CGFloat nydanjia =
    
    //正文是16开，封面是8开
    
    //正文CTP制版的费用 印张 ＊（1或2）＊ 单价(先默认为90) ＊ 色数(内文的色数)
    NSInteger ctpValue = yinZhangNum * shiFouDoubleNum * shaiSHangban * nyseshuNum;
//    [VMTools alertMessage:[NSString stringWithFormat:@"ctp value is %ld",ctpValue]];

    //正文印刷费用  印张 ＊ 千印数（3千起，不足补3千，足了补1千）＊ 色数 ＊ （1或2（是否对开）) ＊ 单价（默认18）
    NSInteger zhengwenValue = yinZhangNum * (yinLiangNum / 1000) * nyseshuNum * shiFouDoubleNum * neyeDanJia;
//    [VMTools alertMessage:[NSString stringWithFormat:@"zheng wen value is %ld",zhengwenValue]];

    //封面有底价，如果不足底价，按底价计算
    //封面印刷费用 1印张 ＊ 千印数（（印量 * 2）／封面开数）＊ 色数 ＊ （1 或 2（是否双面印刷））＊ 单价（默认18）
    
    NSInteger qianYinshu = ((yinLiangNum * 2) / fmKaiShu) / 1000 >= 1 ? (yinLiangNum / (zwKaiShu / 2)) / 1000 : 1;
    //这是封面的印刷费用。
    NSInteger fengmianValue = 1 * qianYinshu * fmseshuNum * fmShiFouDoubleNum * neyeDanJia;
//    [VMTools alertMessage:[NSString stringWithFormat:@"feng mian value is %ld",fengmianValue]];
    
    //封面CTP制版的费用 色数 ＊ 是否双面 ＊ 单价(默认为90)
    NSInteger fengMianZhiBanValue = 1 * fmseshuNum * fmShiFouDoubleNum * shaiSHangban;
//    [VMTools alertMessage:[NSString stringWithFormat:@"feng mian ctp value is %ld",fengMianZhiBanValue]];
    
    //封面的底价括封面的CTP的价格
    
    NSInteger finalFengMianMoney = MAX(fengmianValue + fengMianZhiBanValue, 500);

    self.tcpZhiBan = [@(ctpValue) stringValue];
    
    self.zwValue = [@(zhengwenValue) stringValue];
    
    self.fmValue = [@(fengmianValue) stringValue];
    
    self.fmzbValue = [@(fengMianZhiBanValue) stringValue];
    
    self.zwCTPValue = [@(ctpValue) stringValue];
    self.zwYinShuaValue = [@(zhengwenValue) stringValue];
    self.fmCTPValue = [@(fengMianZhiBanValue) stringValue];
    self.fmYinShuaValue = [@(fengmianValue) stringValue];
    
    
    self.yinShuaValue = [@(ctpValue + zhengwenValue + finalFengMianMoney) stringValue];
    
    /*
     @"胶订",
     @"骑马订",
     @"锁线胶订",
     @"精装圆脊",
     @"精装方脊",
     @"软精装",
     */
    
    //装订费用 = 印张 * 印量 * 工价
    
    
    NSString *zhuangDing = self.currentBook.zhuangDingWay;
    CGFloat number = 0;
    if ([zhuangDing isEqualToString:@"胶订"]) {
        NSArray *priceary = [self.puGongJiaTable valuesForRowTitle:@"胶订"];
        NSInteger index = 0;
        if (zwKaiShu >= 32) {
            zwKaiShu = 32;
            index = 1;
        }else if (zwKaiShu <= 16) {
            zwKaiShu = 16;
            index = 0;
        }else{
            zwKaiShu = 16;
            index = 0;
        }
        
        CGFloat price = [priceary[index] floatValue];
        number = price * yinLiangNum * yinZhangNum;
        
    }else if ([zhuangDing isEqualToString:@"骑马订"]){
        NSArray *priceary = [self.puGongJiaTable valuesForRowTitle:@"骑马订"];
        NSInteger index = 0;
        if (zwKaiShu >= 32) {
            zwKaiShu = 32;
            index = 1;
        }else if (zwKaiShu <= 16) {
            zwKaiShu = 16;
            index = 0;
        }else{
            zwKaiShu = 16;
            index = 0;
        }
        
        CGFloat price = [priceary[index] floatValue];
        number = price * yinLiangNum * yinZhangNum;

    
    }else if ([zhuangDing isEqualToString:@"锁线胶订"]){
        NSArray *priceary = [self.puGongJiaTable valuesForRowTitle:@"锁胶"];
        NSInteger index = 0;
        if (zwKaiShu >= 32) {
            zwKaiShu = 32;
            index = 1;
        }else if (zwKaiShu <= 16) {
            zwKaiShu = 16;
            index = 0;
        }else{
            zwKaiShu = 16;
            index = 0;
        }
        
        CGFloat price = [priceary[index] floatValue];
        number = price * yinLiangNum * yinZhangNum;
    
    }else if ([zhuangDing isEqualToString:@"精装圆脊"]){
        NSArray *jingZhuangValueAry = [self.jzGongJiaTable valuesForRowTitle:@"金额"];
        
        for (NSString *str in jingZhuangValueAry) {
            number += [str floatValue];
        }
    }else if ([zhuangDing isEqualToString:@"精装方脊"]){
        NSArray *jingZhuangValueAry = [self.jzGongJiaTable valuesForRowTitle:@"金额"];
        NSMutableArray *checkAry = [jingZhuangValueAry mutableCopy];
        [checkAry removeLastObject];
        for (NSString *str in checkAry) {
            number += [str floatValue];
        }
    }else if ([zhuangDing isEqualToString:@"软精装"]){
        NSArray *jingZhuangValueAry = [self.jzGongJiaTable valuesForRowTitle:@"金额"];
        NSMutableArray *checkAry = [jingZhuangValueAry mutableCopy];
#warning 软精装的选项---
        
        
        [checkAry removeLastObject];
        for (NSString *str in checkAry) {
            number += [str floatValue];
        }
    }
    
    self.zhuangDingValue = [NSString stringWithFormat:@"%.0f",number];
}


-(YSCustomInputView *)customInputViewWithTitle:(NSString *)title{
    for (YSCustomInputView *inputView in self.inputNumAry) {
        if ([inputView.titleLabel.text isEqualToString:title]) {
            return inputView;
        }
    }
    return nil;
}

-(void)selecteCustomInputView:(YSCustomInputView *)customInput{
    
    NSString *str = customInput.titleLabel.text;
    if ([str containSubstring:@"是否"]) {
        [customInput clickWithDatas:@[@"是",@"否"] completeBlock:^(YSCustomInputView *customInputView, NSString *result) {
            
        }];
    }else{
        [customInput clickWithDatas:@[@"1",@"2",@"4"] completeBlock:^(YSCustomInputView *customInputView, NSString *result) {
            
        }];
    }
    

    /*
    if (customInput == nil) {
        [VMTools alertMessage:@"customeview为空！"];
        return;
    }
    YSSelectTableViewController *selectedTC = [[YSSelectTableViewController alloc]init];
    selectedTC.dataAry = @[@"是",@"否"];
    selectedTC.block = ^(NSString *name){
        customInput.inputTextField.text = name;
    };
    [self.navigationController pushViewController:selectedTC animated:YES];
     */
}


#pragma mark - lazying actions ------

-(CALayer *)lineLayer{
    if (_lineLayer == nil) {
        _lineLayer = [CALayer layer];
        _lineLayer.backgroundColor = COLOR(100, 100, 100, .6).CGColor;
        _lineLayer.frame = CGRectMake(0, self.view.height - 200, self.view.width, .5);
    }
    return _lineLayer;
}

-(UILabel *)maxLabel{
    if (_maxLabel == nil) {
        _maxLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _maxLabel.font = [UIFont systemFontOfSize:20];
        
    }
    return _maxLabel;
}

-(UILabel *)yinshuGongJiaLabel{

    if (_yinshuGongJiaLabel == nil) {
        _yinshuGongJiaLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _yinshuGongJiaLabel.backgroundColor = CLEAR;
        _yinshuGongJiaLabel.text = @"  印刷工价";
        _yinshuGongJiaLabel.font = [UIFont boldSystemFontOfSize:14];
        [_yinshuGongJiaLabel sizeToFit];
    }
    return _yinshuGongJiaLabel;
}



-(UILabel *)zhuangDingLabel{
    
    if (_zhuangDingLabel == nil) {
        _zhuangDingLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _zhuangDingLabel.backgroundColor = CLEAR;
        _zhuangDingLabel.text = @"  普通装订工价";
        _zhuangDingLabel.font = [UIFont boldSystemFontOfSize:14];
        [_zhuangDingLabel sizeToFit];
    }
    return _zhuangDingLabel;
}


-(UILabel *)jinZhuangLabel{
    
    if (_jinZhuangLabel == nil) {
        _jinZhuangLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _jinZhuangLabel.backgroundColor = CLEAR;
        _jinZhuangLabel.text = @"  精装工价";
        _jinZhuangLabel.font = [UIFont boldSystemFontOfSize:14];
        [_jinZhuangLabel sizeToFit];
    }
    return _jinZhuangLabel;
}

-(YSHuiZongView *)huiZongView{
    
    if (_huiZongView == nil) {
        _huiZongView = [YSHuiZongView huiZongViewWithTitles:@[@"正文CTP",@"正文印刷成本",@"封面CTP",@"封面印刷",@"装订费用"]];
    }
    return _huiZongView;
}

@end
