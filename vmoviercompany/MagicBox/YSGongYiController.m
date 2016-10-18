//
//  YSGongYiController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/21.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSGongYiController.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "YSCustomInputView.h"
#import "UIViewController+VMKit.h"
#import "AppDelegate.h"
#import "VMovieKit.h"
#import "YSSelectTableViewController.h"
#import "YSTableInofView.h"
#import "YSHuiZongView.h"


@interface YSGongYiController ()
@property (nonatomic, strong, readwrite) TPKeyboardAvoidingScrollView *mainScrollview;

@property (nonatomic, assign, readwrite) NSInteger wholeNum;

@property (nonatomic, strong, readwrite) NSMutableArray *inputNumAry;

@property (nonatomic, strong, readwrite) UILabel *zhengWenLabel;

@property (nonatomic, strong, readwrite) UILabel *fengMianLabel;

@property (nonatomic, strong, readwrite) CALayer *lineLayer;

@property (nonatomic, strong, readwrite) UILabel *maxLabel;

@property (nonatomic, strong, readwrite) YSBookObject *currentBook;

@property (nonatomic, strong, readwrite) YSCustomInputView *customInputView;

@property (nonatomic, strong, readwrite) YSTableInofView *gongYiGongJia;

@property (nonatomic, strong, readwrite) YSCustomInputView *tangJinInputView;

//汇总
@property (nonatomic, strong, readwrite) YSHuiZongView *huiZongView;

@property (nonatomic, strong, readwrite) NSString *gongYiValue;

@end

@implementation YSGongYiController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE;
    [self indentiferNavBack];
    self.title = @"工艺费用";
    
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

    [self.view addSubview:self.huiZongView];
    
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.currentBook = appdele.rootVC.currentBook;
    
    self.gongYiValue = [self.currentBook.gongYiMoney isValid]? self.currentBook.gongYiMoney : @"0";
    [self.huiZongView loadValues:@[self.gongYiValue]];
    
    self.mainScrollview = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.huiZongView.height)];
    [self.view addSubview:self.mainScrollview];
    
    self.huiZongView.bottom = self.view.height;
   
    float yoffset = 20;
    NSArray *tangJinAry = nil;
    NSString *tangJinWidth = @"";
    NSString *tangJinHeight = @"";
    if ([self.currentBook.tangJin isValid]) {
        tangJinAry = [self.currentBook.tangJin componentsSeparatedByString:@"x"];
        tangJinWidth = tangJinAry[0];
        tangJinHeight = tangJinAry.lastObject;
    }
    NSArray *arry = @[
                      @{@"title":@"光膜",@"value":self.currentBook.guangMo},
                      @{@"title":@"亚膜",@"value":self.currentBook.yaMo},
                      @{@"title":@"UV",@"value":self.currentBook.UV},
                      @{@"title":@"磨砂",@"value":self.currentBook.moSha},
                      @{@"title":@"起凸压凹",@"value":self.currentBook.qiTuYaAo},
//                      @{@"title":@"压纹",@"value":self.currentBook.yaWen},
//                      @{@"title":@"UV/磨砂出片",@"value":self.currentBook.uvMoShaChuPian},
                      @{@"title":@"烫金版出片",@"value":self.currentBook.tangJinBanChuPian},
                      @{@"title":@"烫金",@"value1":tangJinWidth,@"value2":tangJinHeight},
                      @{@"title":@"贴标",@"value":self.currentBook.tieBiao},
                      @{@"title":@"塑封",@"value":[self.currentBook.zdShiFouSuFeng isValid] ? self.currentBook.zdShiFouSuFeng : @"否"}
                      ];
    WEAKSELF;
    for (int i = 0; i < arry.count; i ++) {
        
        YSCustomInputView *inputView = nil;
        NSString *title = arry[i][@"title"];
        if ([title isEqualToString:@"烫金"]) {
            inputView = [YSCustomInputView doubleInputView];
            [inputView loadTitle:arry[i][@"title"] defaultValue1:tangJinWidth value2:tangJinHeight];
            self.tangJinInputView = inputView;
        }else{
            
            inputView = [YSCustomInputView selectInputViewWithParamClickBlock:^(YSCustomInputView *inputView){
                [weakSelf selectedCustomInputClicked:inputView];
            }];
            [inputView loadTitle:arry[i][@"title"] defaultValue:arry[i][@"value"]];
        }
        
        inputView.tag = i;
        inputView.frame = CGRectMake(10, yoffset, self.view.width - 40, inputView.height);
        [self.mainScrollview  addSubview:inputView];
        yoffset += inputView.height + 20;
        [self.inputNumAry addObject:inputView];
    }
    YSCustomInputView *lastInputView = [self.inputNumAry lastObject];
    
    
    //添加工艺列表
    self.gongYiGongJia = [[YSTableInofView alloc]initWithFrame:CGRectMake(20, lastInputView.bottom + 30, self.view.width - 40, 430)];
    [self.gongYiGongJia loadTitles:@[@"项目",@"数量",@"单价",@"金额"]];
    [self.gongYiGongJia loadRowTitles:@[@"光膜",@"亚膜",@"UV",@"磨砂",@"起鼓",@"烫金",@"烫金版出片",@"贴标",@"塑封"]];
    [self.mainScrollview addSubview:self.gongYiGongJia];

    //工艺的数量计算
    
    [self.mainScrollview contentSizeToFit];
    
    
    NSArray *numberValues = [self gongYiNumberValues];
    NSArray *perPerice = [self gongYiPerPrice];
    NSArray *monPrice = [self jinEValues];
    
    [self.gongYiGongJia loadSecondRowTitles:numberValues];
    [self.gongYiGongJia loadThirdRowTitles:perPerice];
    [self.gongYiGongJia loadForthRowTitles:monPrice];
}

//工艺的数量数组
-(NSArray *)gongYiNumberValues{
    
    NSInteger yinliang = 0;
    NSInteger fmKaisize = 0;
    if ([self.currentBook.fmKsize isValid]) {
        fmKaisize = [self.currentBook.fmKsize integerValue];
    }else
        fmKaisize = [self.currentBook.kSize integerValue] / 2;
    
    
    if (fmKaisize == 1) {
        yinliang = [self.currentBook.yinLiangNum integerValue];
    }else{
        if (fmKaisize / 2 <= 0) {
            yinliang = 0;
        }else
            yinliang = [self.currentBook.yinLiangNum integerValue] / (fmKaisize / 2);
    }
    
    //光膜 //亚膜 //UV //磨砂
    NSString *guangMoNumString  = [@(yinliang) stringValue];
    NSString *yaMonumString     = [@(yinliang) stringValue];
    NSString *UVNumString       = self.currentBook.yinLiangNum;
    NSString *moShaString       = self.currentBook.yinLiangNum;
    
    //起鼓
    NSString *qiGuNumString = self.currentBook.yinLiangNum;
    //烫金
    NSInteger tangJinWidth = [self.tangJinInputView.firstInput.text integerValue];
    NSInteger tangJinHeight = [self.tangJinInputView.secondInput.text integerValue];
    NSString *tangJingValue = [NSString stringWithFormat:@"%ld",tangJinWidth * tangJinHeight];
    NSString *tangJinBanChuPianValue = @"1";
    
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
    
    NSString *guangMoPrice = self.currentBook.bookGongJia.guangMo;
    NSString *yaMoPrice = self.currentBook.bookGongJia.yaMo;
    NSString *uv = self.currentBook.bookGongJia.UV;
    NSString *moSha = self.currentBook.bookGongJia.moSha;
    NSString *qiGu = self.currentBook.bookGongJia.qiGu;
    NSString *tangJin = [NSString stringWithFormat:@"%@元/平方厘米",self.currentBook.bookGongJia.tangJin];
    NSString *tjbcp = self.currentBook.bookGongJia.tangJinBanChuPian;
    NSString *tieBiao = self.currentBook.bookGongJia.tieBiao;
    NSString *suFeng = self.currentBook.bookGongJia.suFeng;
    
    return @[
             guangMoPrice,
             yaMoPrice,
             uv,
             moSha,
             qiGu,
             tangJin,
             tjbcp,
             tieBiao,
             suFeng
             ];
}

-(NSArray *)jinEValues{
    
//    NSArray *numbers = [self.gongYiGongJia valuesForRowTitle:@"数量"];
//    NSArray *prices  = [self.gongYiGongJia valuesForRowTitle:@"单价"];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.jsqVC getValueFromGongYi:[NSString stringWithFormat:@"%@",self.gongYiValue]];
}

-(void)updatePaperWithBaseInfo{
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSBookObject *bookObj = appdele.rootVC.currentBook;
    
    bookObj.guangMo = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:0] inputText];
    bookObj.yaMo = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:1] inputText];
    
    bookObj.UV = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:2] inputText];
    bookObj.moSha = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:3] inputText];
    
    bookObj.qiTuYaAo = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:4] inputText];
    bookObj.yaWen = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:5] inputText];
    
    bookObj.uvMoShaChuPian = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:6] inputText];
    bookObj.tangJinBanChuPian = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:7] inputText];
    
    bookObj.tangJin = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:8] inputText];
    
    bookObj.gongYiMoney = self.gongYiValue;
//    bookObj.gongYiHuiZong = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:9] inputText];
}

-(YSCustomInputView *)customInputViewWithTitle:(NSString *)title withTag:(NSInteger)tag{
    for (YSCustomInputView *inputView in self.inputNumAry) {
        if ([inputView.titleLabel.text isEqualToString:title]) {
            if (inputView.tag == tag) {
                return inputView;
            }
        }
    }
    return nil;
}


-(void)selectedCustomInputClicked:(YSCustomInputView *)customeView{
    
    NSArray *arry = @[@"是",@"否"];
    [customeView clickWithDatas:arry completeBlock:^(YSCustomInputView *customInputView, NSString *result) {
        
    }];
    
    /*
    if (customeView == nil) {
        [VMTools alertMessage:@"customeview为空！"];
        return;
    }
    YSSelectTableViewController *selectedTC = [[YSSelectTableViewController alloc]init];
    selectedTC.dataAry = @[@"是",@"否"];
    selectedTC.block = ^(NSString *name){
        customeView.inputTextField.text = name;
    };
    [self.navigationController pushViewController:selectedTC animated:YES];
     */
}

-(void)getFinalValue{
    
    //首先刷新工价
    
    NSArray *numberValues = [self gongYiNumberValues];
    NSArray *perPerice = [self gongYiPerPrice];
    NSArray *monPrice = [self jinEValues];
    [self.gongYiGongJia loadSecondRowTitles:numberValues];
    [self.gongYiGongJia loadThirdRowTitles:perPerice];
    [self.gongYiGongJia loadForthRowTitles:monPrice];
    
    //基本都是x法和加法，根据具体的工价来算
    YSCustomInputView *guangMo = [self customInputViewWithTitle:@"光膜" withTag:0];
    YSCustomInputView *yaMo = [self customInputViewWithTitle:@"亚膜" withTag:1];
    YSCustomInputView *UV = [self customInputViewWithTitle:@"UV" withTag:2];
    YSCustomInputView *moSha = [self customInputViewWithTitle:@"磨砂" withTag:3];
    YSCustomInputView *qituaoya = [self customInputViewWithTitle:@"起凸压凹" withTag:4];
    YSCustomInputView *tangJinBan = [self customInputViewWithTitle:@"烫金版出片" withTag:5];
    YSCustomInputView *tangJin = [self customInputViewWithTitle:@"烫金" withTag:6];
    YSCustomInputView *tieBiao = [self customInputViewWithTitle:@"贴标" withTag:7];
    YSCustomInputView *suFeng = [self customInputViewWithTitle:@"塑封" withTag:8];
    
    CGFloat number = 0;
    
    NSArray *numberAry = [self.gongYiGongJia valuesForRowTitle:@"金额"];
    if ([guangMo.inputText isEqualToString:@"是"]) {
        number += [[numberAry objectAtIndex:0] floatValue];
    }
    
    if ([yaMo.inputText isEqualToString:@"是"]) {
        number += [[numberAry objectAtIndex:1] floatValue];
    }
    
    if ([UV.inputText isEqualToString:@"是"]) {
        number += [[numberAry objectAtIndex:2] floatValue];
    }
    
    if ([moSha.inputText isEqualToString:@"是"]) {
        number += [[numberAry objectAtIndex:3] floatValue];
    }
    
    if ([qituaoya.inputText isEqualToString:@"是"]) {
        number += [[numberAry objectAtIndex:4] floatValue];
    }
    number += [[numberAry objectAtIndex:5] floatValue];
    if ([tangJinBan.inputText isEqualToString:@"是"]) {
        number += [[numberAry objectAtIndex:6] floatValue];
    }
    if ([tieBiao.inputText isEqualToString:@"是"]) {
        number += [[numberAry objectAtIndex:7] floatValue];
    }
    
    if ([suFeng.inputText isEqualToString:@"是"]) {
        number += [[numberAry objectAtIndex:8] floatValue];
    }
    self.gongYiValue = [NSString stringWithFormat:@"%.2f",number];
}

-(void)jiSuanBtnClicked:(id)sneder{

    [self getFinalValue];
    [self.huiZongView loadValues:@[self.gongYiValue]];
}

-(void)saveBtnClicked:(id)sender{
    [self updatePaperWithBaseInfo];
    
    //保存所有的属性
    YSCustomInputView *guangMo = [self customInputViewWithTitle:@"光膜" withTag:0];
    YSCustomInputView *yaMo = [self customInputViewWithTitle:@"亚膜" withTag:1];
    YSCustomInputView *UV = [self customInputViewWithTitle:@"UV" withTag:2];
    YSCustomInputView *moSha = [self customInputViewWithTitle:@"磨砂" withTag:3];
    YSCustomInputView *qituaoya = [self customInputViewWithTitle:@"起凸压凹" withTag:4];
    YSCustomInputView *yaWen = [self customInputViewWithTitle:@"压纹" withTag:5];
    YSCustomInputView *uvMosha = [self customInputViewWithTitle:@"UV/磨砂出片" withTag:6];
    YSCustomInputView *tangJinBan = [self customInputViewWithTitle:@"烫金版出片" withTag:7];
    YSCustomInputView *tangJin = [self customInputViewWithTitle:@"烫金" withTag:8];
    YSCustomInputView *suFeng = [self customInputViewWithTitle:@"塑封" withTag:9];
    
    self.currentBook.guangMo = guangMo.inputText;
    self.currentBook.yaMo = yaMo.inputText;
    self.currentBook.UV = UV.inputText;
    
    self.currentBook.moSha = moSha.inputText;
    self.currentBook.qiTuYaAo = qituaoya.inputText;
    self.currentBook.yaWen = yaWen.inputText;
    
    self.currentBook.uvMoShaChuPian = uvMosha.inputText;
    self.currentBook.tangJinBanChuPian = tangJinBan.inputText;
    self.currentBook.tangJin = tangJin.inputText;
    self.currentBook.zdShiFouSuFeng = suFeng.inputText;
    //保存工价
    NSArray *gongJiaAry = [self.gongYiGongJia valuesForRowTitle:@"单价"];
    self.currentBook.bookGongJia.guangMo = gongJiaAry[0];
    self.currentBook.bookGongJia.yaMo = gongJiaAry[1];
    self.currentBook.bookGongJia.UV = gongJiaAry[2];
    self.currentBook.bookGongJia.moSha = gongJiaAry[3];
    self.currentBook.bookGongJia.qiGu = gongJiaAry[4];
    self.currentBook.bookGongJia.tangJin = gongJiaAry[5];
    
//    [self.currentBook.bookGongJia saveBookGongJia];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -line actions ------

-(CALayer *)lineLayer{
    if (_lineLayer == nil) {
        _lineLayer = [CALayer layer];
        _lineLayer.backgroundColor = COLOR(200, 200, 200, 1).CGColor;
        _lineLayer.frame = CGRectMake(0, self.mainScrollview.bottom + 1, self.view.width, .5);
    }
    return _lineLayer;
}

-(YSHuiZongView *)huiZongView{
    
    if (_huiZongView == nil) {
        _huiZongView = [YSHuiZongView huiZongViewWithTitles:@[@"工艺费用"]];
    }
    return _huiZongView;
}


@end
