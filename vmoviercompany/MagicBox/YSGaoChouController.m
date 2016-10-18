//
//  YSGaoChouController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/14.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSGaoChouController.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "YSCustomInputView.h"
#import "UIViewController+VMKit.h"
#import "YSJSQController.h"
#import "YSBookObject.h"
#import "AppDelegate.h"
#import "YSHuiZongView.h"

@interface YSGaoChouController ()
@property (nonatomic, strong, readwrite) TPKeyboardAvoidingScrollView *mainScrollview;

@property (nonatomic, assign, readwrite) NSInteger wholeNum;

@property (nonatomic, strong, readwrite) NSMutableArray *inputNumAry;

@property (nonatomic, strong, readwrite) CALayer *lineLayer;

@property (nonatomic, strong, readwrite) UILabel *maxLabel;

@property (nonatomic, strong, readwrite) YSHuiZongView *huiZongView;

@property (nonatomic, strong, readwrite) NSString *banSuiGaoChou;
@property (nonatomic, strong, readwrite) NSString *yinShuGaoChou;
@property (nonatomic, strong, readwrite) NSString *jiBenGaoChou;

@end

@implementation YSGaoChouController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self indentiferNavBack];
    self.title = @"稿酬费用";
    
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
    
    self.mainScrollview = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.huiZongView.height)];
    [self.view addSubview:self.mainScrollview];
    self.view.backgroundColor = WHITE;
    
    
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSBookObject *book = appdele.rootVC.currentBook;
    
    float yoffset = 20;
    NSArray *arry = @[
                      @{@"title":@"定价",@"value":([book.dingJiaNum isValid] ? book.dingJiaNum : @"")},
                      
                      @{@"title":@"版税率",@"value":[book.bansuiLV isValid] ? book.bansuiLV : @""},
                      @{@"title":@"版税稿酬",@"value":[book.bansuiGaoChou isValid] ? book.bansuiGaoChou : @"0"},
                      
                      @{@"title":@"千字数",@"value":[book.zishu isValid] ? book.zishu : @""},
                      @{@"title":@"元/千字",@"value":[book.yuanqianzi isValid] ? book.yuanqianzi : @""},
                      
                      @{@"title":@"基本费率",@"value":[book.jibenfeiLV isValid] ? book.jibenfeiLV : @""},
                      @{@"title":@"基本稿酬",@"value":[book.jibenGaoChou isValid] ? book.jibenGaoChou : @"0"},
                    
                      @{@"title":@"印数稿酬",@"value":[book.yinshuGaoChou isValid] ? book.yinshuGaoChou : @"0"},
                      
                      @{@"title":@"其他费用",@"value":[book.qitaGaoChouFeiYong isValid] ? book.qitaGaoChouFeiYong : @"0"},
                      @{@"title":@"一次性稿酬",@"value":[book.yicixingGaoChou isValid] ? book.yicixingGaoChou : @"0"},
                      ];
    WEAKSELF;
    for (int i = 0; i < arry.count; i ++) {
        YSCustomInputView *inputView = nil;
        if ( i == 1 || i ==5) {
            inputView = [YSCustomInputView selectInputViewWithParamClickBlock:^(YSCustomInputView *customInput) {
                [weakSelf shuiLvInputViewTapped:customInput];
            }];
        }else{
            inputView = [[NSBundle mainBundle]loadNibNamed:@"YSCustomInputView" owner:nil options:nil].lastObject;
        }

        [inputView loadTitle:arry[i][@"title"] defaultValue:arry[i][@"value"]];
        inputView.frame = CGRectMake(10, yoffset, self.view.width - 40, inputView.height);
        [self.mainScrollview  addSubview:inputView];
        yoffset += inputView.height + 20;
        [self.inputNumAry addObject:inputView];
        inputView.tag = i;
        
        NSString *inputTitle = arry[i][@"title"];
        if ([inputTitle isEqualToString:@"版税稿酬"] || [inputTitle isEqualToString:@"基本稿酬"] || [inputTitle isEqualToString:@"印数稿酬"]) {
            [inputView inputShowType];
        }
    }
    [self.mainScrollview contentSizeToFit];
    
    self.huiZongView.bottom = self.view.height;
    
    
    self.banSuiGaoChou = [[self.inputNumAry[2] inputTextField] text];
    self.jiBenGaoChou = [[self.inputNumAry[6] inputTextField] text];
    self.yinShuGaoChou = [[self.inputNumAry[7] inputTextField] text];
    
    
    [self.huiZongView loadValues:@[self.banSuiGaoChou, self.jiBenGaoChou, self.yinShuGaoChou]];
    

    // Do any additional setup after loading the view.
}

-(void)shuiLvInputViewTapped:(YSCustomInputView *)inputView{
    NSArray *array = @[
                       @"1%",
                       @"2%",
                       @"3%",
                       @"4%",
                       @"5%",
                       @"6%",
                       @"7%",
                       @"8%",
                       @"9%",
                       @"10%",
                       @"11%",
                       @"12%",
                       @"13%",
                       @"14%",
                       @"15%",
                       @"16%",
                       @"17%",
                       @"18%",
                       @"19%",
                       @"20%",
                       @"21%",
                       @"22%",
                       @"23%",
                       @"24%",
                       @"25%",
                       @"26%",
                       @"27%",
                       @"28%",
                       @"29%",
                       @"30%",
                       ];
    [inputView clickWithDatas:array completeBlock:^(YSCustomInputView *customInputView, NSString *result) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self updatePaperWithBaseInfo];
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSBookObject *bookObj = appdele.rootVC.currentBook;
    NSString *bansuiGaochou = bookObj.bansuiGaoChou;
    NSString *jibenGaoChou = bookObj.jibenGaoChou;
    NSString *yinshuGaoChou = bookObj.yinshuGaoChou;
    self.wholeNum = [bansuiGaochou floatValue] + [jibenGaoChou floatValue] + [yinshuGaoChou floatValue];
    [self.jsqVC getNumberFromGaoChou:self.wholeNum];
}

-(void)jiSuanBtnClicked:(id)sender{
    [self getFinalValue];
    [self.huiZongView loadValues:@[self.banSuiGaoChou, self.jiBenGaoChou, self.yinShuGaoChou]];
}

-(void)saveBtnClicked:(id)sender{
    [self updatePaperWithBaseInfo];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)updatePaperWithBaseInfo{
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSBookObject *bookObj = appdele.rootVC.currentBook;
    
    bookObj.dingJiaNum = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:0] inputText];
    
    bookObj.bansuiLV = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:1] inputText];
    
    bookObj.bansuiGaoChou = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:2] inputText];
    bookObj.zishu = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:3] inputText];
    
    bookObj.yuanqianzi = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:4] inputText];
    bookObj.jibenfeiLV = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:5] inputText];
    
    bookObj.jibenGaoChou = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:6] inputText];
    bookObj.yinshuGaoChou = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:7] inputText];
    
    bookObj.qitaGaoChouFeiYong = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:8] inputText];
    bookObj.yicixingGaoChou = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:9] inputText];
}

-(void)moneyTapped:(UITapGestureRecognizer *)tap{

    [self getFinalValue];
}

-(void)getFinalValue{
    
//    YSBookObject *book = self.jsqVC.currentBook;
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSBookObject *book = appdele.rootVC.currentBook;
    
    //基本稿酬： 字数 ＊ 元 ／ 千字
    YSCustomInputView *wordNum = [self customInputViewWithTitle:@"千字数"];
    YSCustomInputView *moneyNum = [self customInputViewWithTitle:@"元/千字"];
    YSCustomInputView *jibenNum = [self customInputViewWithTitle:@"基本稿酬"];
    
    jibenNum.inputTextField.text = [NSString stringWithFormat:@"%.2f",([wordNum number] * [moneyNum number] * 1.f)];
    jibenNum.inputTextField.enabled = NO;
    
    //版税稿酬：固定书价 ＊ 版税率 ＊ 印量（个为单位）
    YSCustomInputView *bansuiLvNum = [self customInputViewWithTitle:@"版税率"];
    YSCustomInputView *bansuiGCNum = [self customInputViewWithTitle:@"版税稿酬"];
    
    NSInteger bansuiLvInter = [[[[bansuiLvNum inputText]componentsSeparatedByString:@"%"] objectAtIndex:0] integerValue];
    
    NSString *bansui = [NSString stringWithFormat:@"%.2f",(bansuiLvInter * .01f) * [book.dingJiaNum integerValue]* [book.yinLiangNum integerValue]];
    bansuiGCNum.inputTextField.text = bansui;
    
    //印数稿酬：基本稿酬 ＊ 费率 ＊ 千册（不足一千按一千算）
    YSCustomInputView *yinshuGCNum = [self customInputViewWithTitle:@"印数稿酬"];
    YSCustomInputView *jibenFLNum = [self customInputViewWithTitle:@"基本费率"];
    
    NSInteger jibenFLInteger = [[[[jibenFLNum inputText]componentsSeparatedByString:@"%"]objectAtIndex:0] integerValue];
    
    NSString *yinshu = [NSString stringWithFormat:@"%.2f",jibenNum.number * (jibenFLInteger * .01f) * (([book.yinLiangNum integerValue] >= 1000 ? [book.yinLiangNum integerValue] : 1000) / 1000)];
    yinshuGCNum.inputTextField.text = yinshu;
    
    self.banSuiGaoChou = [bansui isValid] ? bansui : @"0";
    self.jiBenGaoChou = [jibenNum.inputTextField.text isValid] ? jibenNum.inputTextField.text : @"0";
    self.yinShuGaoChou = [yinshu isValid] ? yinshu : @"0";
}

-(YSCustomInputView *)customInputViewWithTitle:(NSString *)title{
    for (YSCustomInputView *inputView in self.inputNumAry) {
        if ([inputView.titleLabel.text isEqualToString:title]) {
            return inputView;
        }
    }
    return nil;
}



#pragma mark - lazying actions ------

-(YSHuiZongView *)huiZongView{

    if (_huiZongView == nil) {
        _huiZongView = [YSHuiZongView huiZongViewWithTitles:@[@"版税稿酬",@"基本稿酬",@"印数稿酬"]];
    }
    return _huiZongView;
}




@end
