//
//  YSJSQController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/7.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSJSQController.h"
#import "YSStaticInfoView.h"
#import "UIViewController+VMKit.h"
#import "YSPaperDetailCostController.h"
#import "YSGaoChouController.h"
#import "YSBaseInfoController.h"
#import "YSYinShuaController.h"
#import "YSYinShuaController.h"
#import "YSDesignController.h"
#import "YSFaHuoTuiHuoController.h"
#import "YSQiTaController.h"
#import "YSGongYiController.h"
#import "AppDelegate.h"
#import "YSBookObject.h"
#import "YSFenXiViewController.h"

/**
 * 所有页面添加保存按钮，计算的时候不保存，保存按钮是一个计算保存的按钮
 *
 */

@interface YSJSQController ()<YSBaseInfoControllerDelegate>
@property (nonatomic, strong, readwrite) UILabel *moneyLabel;
@property (nonatomic, strong, readwrite) UIButton *huiZongBtn;

@property (nonatomic, strong, readwrite) UIScrollView *bgScrollview;


@property (nonatomic, strong, readwrite) YSStaticInfoView *baseView;
@property (nonatomic, strong, readwrite) YSStaticInfoView *paperView;
@property (nonatomic, strong, readwrite) YSStaticInfoView *gaoChou;

@property (nonatomic, strong, readwrite) YSStaticInfoView *manager;
@property (nonatomic, strong, readwrite) YSStaticInfoView *des;

@property (nonatomic, strong, readwrite) YSStaticInfoView *print;

@property (nonatomic, strong, readwrite) YSStaticInfoView *gongyi;
@property (nonatomic, strong, readwrite) YSStaticInfoView *qita;

@property (nonatomic, strong, readwrite) YSStaticInfoView *fahuotuihuo;


@property (nonatomic, strong, readwrite) NSString *paperMoney;
@property (nonatomic, strong, readwrite) NSString *gaoFeiMoney;
@property (nonatomic, strong, readwrite) NSString *sheJiMoney;
@property (nonatomic, strong, readwrite) NSString *yinShuaMoney;
@property (nonatomic, strong, readwrite) NSString *gongYiMoney;
@property (nonatomic, strong, readwrite) NSString *qiTaMoney;
@property (nonatomic, strong, readwrite) NSString *faXingMoney;
@property (nonatomic, strong, readwrite) NSString *zongZhichuMoney;
@property (nonatomic, strong, readwrite) NSString *dccbMoney;
@property (nonatomic, strong, readwrite) NSString *fxsrMoney;
@property (nonatomic, strong, readwrite) NSString *bbdMoney;
@property (nonatomic, strong, readwrite) NSString *yinliMoney;

@end

@implementation YSJSQController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE;
    [self indentiferNavBack];
    [self.view addSubview:self.bgScrollview];
    self.title = @"计算器";
    
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.currentBook = appdele.rootVC.currentBook;
    
    WEAKSELF;
    YSStaticInfoView *baseInfo = [YSStaticInfoView staticInfoViewWithTitle:@"*  基本信息" placeHolder:@"开本 尺寸 印张 印量 装订方式 定价" withClickHandler:^{
        [weakSelf baseDetail];
    }] ;
    
    YSStaticInfoView *paper = [YSStaticInfoView staticInfoViewWithTitle:@"1  纸张费用" placeHolder:@"正文纸张 封面纸张" withClickHandler:^{
        [weakSelf paperDetail];
    }] ;
    YSStaticInfoView *gaochou = [YSStaticInfoView staticInfoViewWithTitle:@"2  稿酬费用" placeHolder:@"版税稿酬 基本稿酬 印数稿酬" withClickHandler:^{
        [weakSelf gaochouDetail];
    }];
    YSStaticInfoView *des = [YSStaticInfoView staticInfoViewWithTitle:@"3  设计费用" placeHolder:@"正文排版 封面排版" withClickHandler:^{
        [weakSelf designDetail];
    }];
    YSStaticInfoView *print = [YSStaticInfoView staticInfoViewWithTitle:@"4  印刷装订" placeHolder:@"印刷费用 装订费用" withClickHandler:^{
        [weakSelf yinshuaDetail];
    }];
    
    YSStaticInfoView *gongyi = [YSStaticInfoView staticInfoViewWithTitle:@"5  工艺费用" placeHolder:@"工艺相关" withClickHandler:^{
        [weakSelf gongyiDetail];
    }];
    
    YSStaticInfoView *qita = [YSStaticInfoView staticInfoViewWithTitle:@"6  其他费用" placeHolder:@"管理费用 其他费用" withClickHandler:^{
        [weakSelf qitaDetail];
    }];
    
    YSStaticInfoView *fahuotuihuo = [YSStaticInfoView staticInfoViewWithTitle:@"7  发货退货" placeHolder:@"销售折扣 退货率" withClickHandler:^{
        [weakSelf fahuotuihuoDetail];
    }];
    
    self.baseView = baseInfo;
    self.paperView = paper;
    self.gaoChou = gaochou;
    self.des = des;
    self.print = print;
    self.gongyi = gongyi;
    self.qita = qita;
    self.fahuotuihuo = fahuotuihuo;
    
    float offset = 20;
  
    float baseTop = 50;
    if (iPhone4 || iPhone5 || iPhone6) {
        baseTop = 15;
    }
    baseInfo.top = baseTop;
    paper.top = baseInfo.bottom + offset;
    gaochou.top = paper.bottom + offset;
    des.top = gaochou.bottom + offset;
    print.top = des.bottom + offset;
    gongyi.top = print.bottom + offset;
    qita.top = gongyi.bottom + offset;
    fahuotuihuo.top = qita.bottom + offset;

    [self.bgScrollview addSubview:baseInfo];
    [self.bgScrollview addSubview:paper];
    [self.bgScrollview addSubview:gaochou];
    [self.bgScrollview addSubview:des];
    [self.bgScrollview addSubview:print];
    [self.bgScrollview addSubview:gongyi];
    [self.bgScrollview addSubview:qita];
    [self.bgScrollview addSubview:fahuotuihuo];
    
    self.bgScrollview.contentSize = CGSizeMake(self.view.width,fahuotuihuo.bottom + 10);
    
    for (UIView *view in self.bgScrollview.subviews) {
        if ([[view class] isSubclassOfClass:[YSStaticInfoView class]]) {
            YSStaticInfoView *infoView = (YSStaticInfoView *)view;
            [infoView staticInfoViewWithType:StaticInfoTypeDisable];
        }
    }
    
    [self.baseView staticInfoViewWithType:StaticInfoTypeNormal];


    CALayer *lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(0, self.view.height - 110 - 64, self.view.width, 1);
    lineLayer.backgroundColor = COLORA(224, 224, 224).CGColor;
    [self.view.layer addSublayer:lineLayer];
    
    UILabel *payOff = [[UILabel alloc]initWithFrame:CGRectMake(27, lineLayer.frame.origin.y + 20, 100, 14)];
    payOff.textColor = COLORA(60, 60, 60);
    payOff.font = [UIFont systemFontOfSize:12];
    payOff.text = @"总支出：";
    [self.view addSubview:payOff];
    
    self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(27, payOff.bottom + 4, self.view.width - 100, 54)];
    self.moneyLabel.textColor = COLORA(60, 60, 60);
    self.moneyLabel.font = [UIFont systemFontOfSize:50];
    
    NSString *finalMoney = self.currentBook.finalyMoney;
    NSString *attmoney = [NSString stringWithFormat:@"%@元",finalMoney];
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:attmoney];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:[attmoney rangeOfString:@"元"]];
    self.moneyLabel.attributedText = att;
    [self.view addSubview:self.moneyLabel];
    
    self.huiZongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.huiZongBtn setTitle:@"分析" forState:UIControlStateNormal];
    [self.huiZongBtn setBackgroundColor:COLORA(245, 245, 245)];
    [self.huiZongBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.huiZongBtn setTitleColor:COLORA(60, 60, 60) forState:UIControlStateNormal];
    [self.huiZongBtn setFrame:CGRectMake(0, 0, 54, 30)];
    self.huiZongBtn.right = self.view.width - 20;
    self.huiZongBtn.center = CGPointMake(self.huiZongBtn.center.x, self.moneyLabel.center.y);
    [self.view addSubview:self.huiZongBtn];
    self.huiZongBtn.layer.cornerRadius = 2.f;
    self.huiZongBtn.layer.masksToBounds = YES;
    self.huiZongBtn.layer.borderWidth = .5;
    self.huiZongBtn.layer.borderColor = COLORA(207, 207, 207).CGColor;
    [self.huiZongBtn addTarget:self action:@selector(huiZongBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.paperView.height = 40;
    
    [self.view bringSubviewToFront:self.paperView];
    
    
    // Do any additional setup after loading the view.
}

-(void)huiZongBtnClicked:(id)sender{
    
    self.paperMoney = [self.paperView.valueLabel.text containSubstring:@"正文"] ? @"0" : self.paperView.valueLabel.text;
    self.gaoFeiMoney = [self.gaoChou.valueLabel.text containSubstring:@"稿酬"] ? @"0" : self.gaoChou.valueLabel.text;
    self.sheJiMoney = [self.des.valueLabel.text containSubstring:@"正文"] ? @"0" : self.des.valueLabel.text;
    NSString *yinShuaValue = [self.print.valueLabel.text containSubstring:@"印刷"] ? @"0" : self.print.valueLabel.text;
    if ([yinShuaValue isEqualToString:@"0"]) {
        self.yinShuaMoney = @"0";
    }else
        self.yinShuaMoney = [@([[[yinShuaValue componentsSeparatedByString:@" "] objectAtIndex:0] integerValue] + [[[yinShuaValue componentsSeparatedByString:@" "] objectAtIndex:1] integerValue])stringValue];
    
    self.gongYiMoney = [self.gongyi.valueLabel.text containSubstring:@"工艺"] ? @"0" : self.gongyi.valueLabel.text;
    self.qiTaMoney = [self.qita.valueLabel.text containSubstring:@"费用"] ? @"0" : self.qita.valueLabel.text;
    self.faXingMoney = [self.fahuotuihuo.valueLabel.text containSubstring:@"销售"] ? @"0" : self.fahuotuihuo.valueLabel.text;
    
    self.zongZhichuMoney = [self.moneyLabel.text removeSubstring:@"元"];
    
    //单册成本：总支出 ／ 印量
    
    //保本点：总支出 ／ （单价 * 销售折扣）
    
    //盈利：销售实洋 - 总支出
    
    //发行收入 ：销售实洋
    
    //改名的新书
    
    CGFloat xszkValue = [self.currentBook.xiaoshouZheKou floatValue] / 100.f;
    CGFloat fxValue = [self.currentBook.faxingFei floatValue] / 100.f;
    CGFloat thlValue = [self.currentBook.tuiHuoLV floatValue] / 100.f;
    
    CGFloat danCeMoney = [self.zongZhichuMoney floatValue] / [self.currentBook.yinLiangNum integerValue];
    self.dccbMoney = [NSString stringWithFormat:@"%.2f",danCeMoney];
    
    
    self.fxsrMoney = self.currentBook.xiaoShouShiYangMoney;
    CGFloat baoBenDianMoney = 0;
    if ([self.currentBook.workPraise floatValue] * xszkValue == 0) {
        baoBenDianMoney = 0;
    }else
        baoBenDianMoney = [self.zongZhichuMoney floatValue] / ([self.currentBook.workPraise floatValue] * xszkValue);
    self.bbdMoney = [NSString stringWithFormat:@"%.2f",baoBenDianMoney];
    
    self.yinliMoney =[NSString stringWithFormat:@"%.2f",[self.fxsrMoney floatValue] - [self.zongZhichuMoney floatValue]];
    
    NSArray *array = @[
                       self.paperMoney,
                       self.gaoFeiMoney,
                       self.sheJiMoney,
                       self.yinShuaMoney,
                       self.gongYiMoney,
                       self.qiTaMoney,
                       self.faXingMoney,
                       self.zongZhichuMoney,
                       self.dccbMoney,
                       self.fxsrMoney,
                       self.bbdMoney,
                       self.yinliMoney
                       ];
    
    YSFenXiViewController *fenXiVC = [[YSFenXiViewController alloc]init];
    [fenXiVC loadValues:array];
    [self.navigationController pushViewController:fenXiVC animated:YES];
}

//这是一个比较傻逼的方法，就是每次反回来都会重新调用下，来计算总成本
-(void)recheckPrice{
    
    CGFloat paperValue = [self.currentBook.zwMoney floatValue] + [self.currentBook.fmMoney floatValue];
    CGFloat gaoFeiValue = [self.currentBook.bansuiGaoChou floatValue] + [self.currentBook.jibenGaoChou floatValue] + [self.currentBook.yinshuGaoChou floatValue] + [self.currentBook.qitaGaoChouFeiYong floatValue] + [self.currentBook.yicixingGaoChou floatValue];
    CGFloat desMoney = [self.currentBook.shejifeizwJinE floatValue] + [self.currentBook.shejifeifmJinE floatValue];
    CGFloat yinShuaMoney = [self.currentBook.zdMoney floatValue];
    CGFloat gongYiMoney = [self.currentBook.gongYiMoney floatValue];
    CGFloat qitaMoney = [self.currentBook.qitaMoney floatValue];
    CGFloat faHuoTuiHuoMoney = [self.currentBook.faHuoTuiHuoMoney floatValue];
    
    CGFloat finalMoneyValue = paperValue + gaoFeiValue + desMoney + yinShuaMoney + gongYiMoney + qitaMoney + faHuoTuiHuoMoney;
    self.currentBook.finalyMoney = [[NSNumber numberWithInteger:finalMoneyValue] stringValue];
    
    NSString *finalMoney = self.currentBook.finalyMoney;
    NSString *attmoney = [NSString stringWithFormat:@"%@元",finalMoney];
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:attmoney];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:[attmoney rangeOfString:@"元"]];
    self.moneyLabel.attributedText = att;
}


-(void)getValueFromBaseInfo:(NSString *)value{
    self.baseView.valueLabel.text = value;
    [self recheckPrice];
}

-(void)getNumberFromPaper:(NSInteger)number{
    self.paperView.valueLabel.text = [@(number) stringValue];
    
    //需要计算一下价格
    [self recheckPrice];
}

-(void)getNumberFromGaoChou:(NSInteger)number{
    self.gaoChou.valueLabel.text = [@(number) stringValue];
    [self recheckPrice];
}

-(void)getValueFromSheJiFei:(NSString *)value{
    self.des.valueLabel.text = value;
    [self recheckPrice];
}

-(void)getValueFromFaHuoTuiHuo:(NSString *)value{
    self.fahuotuihuo.valueLabel.text = value;
    [self recheckPrice];
}

-(void)getValueFromYinShuaZhuangDing:(NSString *)value{
    self.print.valueLabel.text = value;
    [self recheckPrice];
}

-(void)getValueFromGongYi:(NSString *)value{
    self.gongyi.valueLabel.text = value;
    [self recheckPrice];
}

-(void)getValueFromQiTa:(NSString *)value{
    self.qita.valueLabel.text = value;
    [self recheckPrice];
}

-(void)baseInfoControllerWillDismiss:(YSBaseInfoController *)baseInfo{

    for (UIView *view in self.bgScrollview.subviews) {
        if ([[view class] isSubclassOfClass:[YSStaticInfoView class]]) {
            YSStaticInfoView *infoView = (YSStaticInfoView *)view;
            if (infoView.currentStatus == StaticInfoTypeDisable) {
                [infoView staticInfoViewWithType:StaticInfoTypeNormal];
            }
        }
    }
}


-(void)baseDetail{
    YSBaseInfoController *base = [[YSBaseInfoController alloc]init];
    base.jsqVC = self;
    base.delegate = self;
    [self.navigationController pushViewController:base animated:YES];
}

-(void)paperDetail{

    YSPaperDetailCostController *paperDetail = [[YSPaperDetailCostController alloc]init];
    paperDetail.jsqVC = self;
    [self.navigationController pushViewController:paperDetail animated:YES];
}

-(void)gaochouDetail{
    YSGaoChouController *gaochou = [[YSGaoChouController alloc]init];
    gaochou.jsqVC = self;
    [self.navigationController pushViewController:gaochou animated:YES];
}

-(void)designDetail{
    YSDesignController *design = [[YSDesignController alloc]init];
    design.jsqVC = self;
    [self.navigationController pushViewController:design animated:YES];
}

-(void)yinshuaDetail{
    
    YSYinShuaController *yinShua = [[YSYinShuaController alloc]init];
    yinShua.jsqVC = self;
    [self.navigationController pushViewController:yinShua animated:YES];
}

-(void)gongyiDetail{

    YSGongYiController *gongYi = [[YSGongYiController alloc]init];
    gongYi.jsqVC = self;
    [self.navigationController pushViewController:gongYi animated:YES];
}


-(void)qitaDetail{
    YSQiTaController *qita = [[YSQiTaController alloc]init];
    qita.jsqVC = self;
    [self.navigationController pushViewController:qita animated:YES];
}

-(void)fahuotuihuoDetail{
    YSFaHuoTuiHuoController *fahuoVC = [[YSFaHuoTuiHuoController alloc]init];
    fahuoVC.jsqVC = self;
    [self.navigationController pushViewController:fahuoVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazying actions ------

-(YSBookObject *)currentBook{
    if (_currentBook == nil) {
        _currentBook = [[YSBookObject alloc]init];
    }
    return _currentBook;
}

-(UIScrollView *)bgScrollview{
    if (_bgScrollview == nil) {
        _bgScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 110 - 64)];
        _bgScrollview.backgroundColor = WHITE;
    }
    return _bgScrollview;
}



@end
