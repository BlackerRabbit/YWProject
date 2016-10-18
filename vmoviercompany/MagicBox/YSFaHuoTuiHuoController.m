//
//  YSFaHuoTuiHuoController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/25.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSFaHuoTuiHuoController.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "YSCustomInputView.h"
#import "UIViewController+VMKit.h"
#import "AppDelegate.h"
#import "VMovieKit.h"
#import "YSHuiZongView.h"



@interface YSFaHuoTuiHuoController ()
@property (nonatomic, strong, readwrite) TPKeyboardAvoidingScrollView *mainScrollview;

@property (nonatomic, assign, readwrite) NSInteger wholeNum;

@property (nonatomic, strong, readwrite) NSMutableArray *inputNumAry;

@property (nonatomic, strong, readwrite) UILabel *zhengWenLabel;

@property (nonatomic, strong, readwrite) UILabel *fengMianLabel;

@property (nonatomic, strong, readwrite) CALayer *lineLayer;

@property (nonatomic, strong, readwrite) UILabel *maxLabel;

@property (nonatomic, strong, readwrite) YSBookObject *currentBook;

@property (nonatomic, strong, readwrite) YSHuiZongView *huiZongView;

@property (nonatomic, copy, readwrite) NSString *xiaoShouShiYangValue;
@property (nonatomic, strong, readwrite) NSString *shiYangFaXingFeiValue;
@property (nonatomic, strong, readwrite) NSString *maYangFaXingFeiValue;


@property (nonatomic, copy, readwrite) NSString *faXingFeiValue;
@property (nonatomic, copy, readwrite) NSString *tuiHuoShiYangValue;





@end

@implementation YSFaHuoTuiHuoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self indentiferNavBack];
    self.title = @"发货退货";
    
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
    self.huiZongView.bottom = self.view.height;
    
    self.mainScrollview = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.huiZongView.height)];
    [self.view addSubview:self.mainScrollview];
    self.view.backgroundColor = WHITE;
    
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.currentBook = appdele.rootVC.currentBook;
    
    NSString *zheKou = [[self.currentBook.xiaoshouZheKou isValid] ? self.currentBook.xiaoshouZheKou : @"0" stringByAppendingString:@"%"];
    NSString *tuiHuo = [[self.currentBook.tuiHuoLV isValid] ? self.currentBook.tuiHuoLV : @"0" stringByAppendingString:@"%"];
    NSString *faXingFei = [[self.currentBook.faxingFei isValid] ? self.currentBook.faxingFei : @"0" stringByAppendingString:@"%"];

    float yoffset = 20;
    //销售折扣：2，2.5，3，3.5，4，4.1，4.2，4.3....6.5，7，7.5，8   （1-10）
    //发行费：1%-20%
    //退货率：1%-30%
    
    
    
    NSArray *arry = @[
                      @{@"title":@"销售折扣",@"value":zheKou},
                      @{@"title":@"发行费",@"value":faXingFei},
                      @{@"title":@"退货率",@"value":tuiHuo},
                      ];
    
    for (int i = 0; i < arry.count; i ++) {
        YSCustomInputView *inputView = nil;
        WEAKSELF;
        inputView = [YSCustomInputView selectInputViewWithParamClickBlock:^(YSCustomInputView *customInput) {
            [weakSelf clickKSize:customInput];
        }];
        inputView.tag = i;
        [inputView loadTitle:arry[i][@"title"] defaultValue:arry[i][@"value"]];
        inputView.frame = CGRectMake(10, yoffset, self.view.width - 40, inputView.height);
        [self.mainScrollview  addSubview:inputView];
        yoffset += inputView.height + 20;
        if (i == 3) {
            yoffset += 30;
        }
        [self.inputNumAry addObject:inputView];
    }
    [self.mainScrollview contentSizeToFit];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self updatePaperWithBaseInfo];
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSBookObject *bookObj = appdele.rootVC.currentBook;
    NSString *xiaoshouZheKou = bookObj.xiaoshouZheKou;
    NSString *tuiHuoLV = bookObj.tuiHuoLV;
    [self.jsqVC getValueFromFaHuoTuiHuo:[NSString stringWithFormat:@"%@",self.faXingFeiValue]];
}

-(void)clickKSize:(YSCustomInputView *)customeview{
    NSArray *array;
    NSArray *xszk = @[@"20%",@"25%",@"30%",@"35%",@"40%",@"41%",@"42%",@"43%",@"44%",@"45%",@"46%",@"47%",@"48%",@"49%",@"50%",@"51%",@"52%",@"53%",@"54%",@"55%",@"56%",@"57%",@"58%",@"59%",@"60%",@"61%",@"62%",@"63%",@"64%",@"65%",@"70%",@"75%",@"80%"];
    NSMutableArray *fxary = [@[]mutableCopy];
    for (int i = 1; i <= 20; i++) {
        NSString *str = [NSString stringWithFormat:@"%d%%",i];
        [fxary addObject:str];
    }
    NSMutableArray *thary = [@[]mutableCopy];
    for (int i = 1; i <= 30; i++) {
        NSString *str = [NSString stringWithFormat:@"%d%%",i];
        [thary addObject:str];
    }

    switch (customeview.tag) {
        case 0:array = xszk;break;
        case 1:array = fxary;break;
        case 2:array = thary;break;
        default:
            break;
    }
    [customeview clickWithDatas:array completeBlock:^(YSCustomInputView *customInputView, NSString *result) {
        
    }];
}



-(void)updatePaperWithBaseInfo{
    
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSBookObject *bookObj = appdele.rootVC.currentBook;
    
    YSCustomInputView *xszk = [self customInputViewWithTitle:@"销售折扣" withTag:0];
    YSCustomInputView *fxf = [self customInputViewWithTitle:@"发行费" withTag:1];
    YSCustomInputView *thl = [self customInputViewWithTitle:@"退货率" withTag:2];
    
    bookObj.xiaoshouZheKou = [xszk.inputText removeSubstring:@"%"];
    bookObj.faxingFei = [fxf.inputText removeSubstring:@"%"];
    bookObj.tuiHuoLV = [thl.inputText removeSubstring:@"%"];
    
    
}

-(void)getFinalValue{
    
    YSCustomInputView *xszk = [self customInputViewWithTitle:@"销售折扣" withTag:0];
    YSCustomInputView *fxf = [self customInputViewWithTitle:@"发行费" withTag:1];
    YSCustomInputView *thl = [self customInputViewWithTitle:@"退货率" withTag:2];
    
    CGFloat xszkValue = [[xszk.inputText removeSubstring:@"%"] floatValue] / 100.f;
    CGFloat fxValue = [[fxf.inputText removeSubstring:@"%"] floatValue] / 100.f;
    CGFloat thlValue = [[thl.inputText removeSubstring:@"%"]floatValue] / 100.f;
    
    
    //销售实洋 (印量 - (印量 * 退货率) )  * 单价 * 销售折扣
//    CGFloat value = [self.currentBook.yinLiangNum integerValue] * [self.currentBook.workPraise floatValue] * 
    //发行费（百分比）
    //实洋发行费   印量 * 单价 * 销售折扣 * 发行费
    //码洋发行费   印量 * 单价 * 发行费
    
    NSInteger yinliangNum = [self.currentBook.yinLiangNum integerValue];
    CGFloat danjiaNum = [self.currentBook.workPraise floatValue];
    //销售实洋
    CGFloat xssy = (yinliangNum - (yinliangNum * thlValue)) * danjiaNum * xszkValue;
    //实洋发行费
    CGFloat syfxf = yinliangNum * danjiaNum * xszkValue *fxValue;
    //码洋发行费
    CGFloat myfxf = yinliangNum * danjiaNum * fxValue;
    
    self.xiaoShouShiYangValue = [NSString stringWithFormat:@"%.2f",xssy];
    self.shiYangFaXingFeiValue = [NSString stringWithFormat:@"%.2f",syfxf];
    self.maYangFaXingFeiValue = [NSString stringWithFormat:@"%.2f",myfxf];
}

-(void)jiSuanBtnClicked:(id)sender{

    [self getFinalValue];
    [self.huiZongView loadValues:@[]];
}

-(void)saveBtnClicked:(id)sender{
    [self updatePaperWithBaseInfo];
    [self.navigationController popViewControllerAnimated:YES];
}


-(YSHuiZongView *)huiZongView{
    
    if (_huiZongView == nil) {
        _huiZongView = [YSHuiZongView huiZongViewWithTitles:@[@"销售实洋",@"发行费"]];
    }
    return _huiZongView;
}


@end
