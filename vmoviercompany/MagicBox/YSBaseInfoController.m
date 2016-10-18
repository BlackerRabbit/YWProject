//
//  YSBaseInfoController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/20.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSBaseInfoController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "UIViewController+VMKit.h"
#import "YSCustomInputView.h"
#import "YSJSQController.h"
#import "AppDelegate.h"
#import "YSBookObject.h"
#import "YSSelectTableViewController.h"
#import "VMovieKit.h"
#import "YSBookKSize.h"

@interface YSBaseInfoController ()

@property (nonatomic, strong, readwrite) NSMutableArray *inputAry;

@property (nonatomic, strong, readwrite) CALayer *lineLayer;
@property (nonatomic, strong, readwrite) NSString *huiZong;

@property (nonatomic, strong, readwrite) YSCustomInputView *paperKsizeInput;
@property (nonatomic, strong, readwrite) YSCustomInputView *zhuangdingInput;

@property (nonatomic, strong, readwrite) YSCustomInputView *quanKsizeInput;

@property (nonatomic, strong, readwrite) YSCustomInputView *quanKaiPaperInput;

@property (nonatomic, strong, readwrite) UIButton *saveBtn;

@end

@implementation YSBaseInfoController

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self updatePaperWithBaseInfo];
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSBookObject *bookObj = appdele.rootVC.currentBook;

    //更新jsq页面的信息
    NSString *value = [NSString stringWithFormat:@"%@开 %@ %@ %@册 %@ %@元",bookObj.kSize,bookObj.quanKaiSize,bookObj.yinzhangNum,bookObj.yinLiangNum,bookObj.zhuangDingWay,bookObj.dingJiaNum];
    [self.jsqVC getValueFromBaseInfo:value];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF;
    self.title = @"基本信息";
    [self indentiferNavBack];
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.saveBtn.frame = CGRectMake(0, 0, 50, 30);
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn addTarget:self action:@selector(saveBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.saveBtn setBackgroundColor:CLEAR];
    [self.saveBtn setTitleColor:COLORA(45, 45, 45) forState:UIControlStateNormal];
    [self rightNavWithView:self.saveBtn];
    
    self.inputAry = [@[]mutableCopy];
    self.mainScrollview = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
    [self.view addSubview:self.mainScrollview];
    self.view.backgroundColor = WHITE;
    float yoffset = 20;
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSRootViewController *root = appdele.rootVC;
    YSBookObject *bookOj = root.currentBook;
    NSString *paperSize = bookOj.bookSize;
    NSArray *array = nil;
    NSString *sizeWidth = nil;
    NSString *sizeHeight = nil;
    if ([paperSize isValid] && [paperSize containSubstring:@"x"]) {
        array = [paperSize componentsSeparatedByString:@"x"];
        sizeWidth = array[0];
        sizeHeight = array[1];
    }else{
        sizeWidth = @"0";
        sizeHeight = @"0";
    }
    
    NSString *quanKaiSizeWidth = nil;
    NSString *quanKaiSizeHeight = nil;
    NSString *quanKaiSize = root.currentBook.quanKaiSize;
    if ([quanKaiSize containSubstring:@"x"]) {
        quanKaiSizeWidth = [[quanKaiSize componentsSeparatedByString:@"x"] objectAtIndex:0];
        quanKaiSizeHeight = [[quanKaiSize componentsSeparatedByString:@"x"] lastObject];
    }else{
        quanKaiSizeWidth = @"0";
        quanKaiSizeHeight = @"0";
    }
    
    NSArray *arry = @[
                      @{@"title":@"开本",@"value":[root.currentBook.kSize isValid] ? bookOj.kSize : @"0"},
                      @{@"title":@"用纸尺寸",@"value":quanKaiSizeWidth,@"value1":quanKaiSizeHeight},
                      @{@"title":@"尺寸",@"value":sizeWidth,@"value1":sizeHeight},
                      @{@"title":@"印张",@"value":[bookOj.yinzhangNum isValid] ? bookOj.yinzhangNum : @"0"},
                      @{@"title":@"印量",@"value":[bookOj.yinLiangNum isValid] ? bookOj.yinLiangNum : @"0"},
                      @{@"title":@"装订方式",@"value":[bookOj.zhuangDingWay isValid] ? bookOj.zhuangDingWay : @"0"},
                      @{@"title":@"定价",@"value":[bookOj.dingJiaNum isValid] ? bookOj.dingJiaNum : @"0"},
                      ];
    for (int i = 0; i < arry.count; i ++) {
        YSCustomInputView *inputView;
        if (i == 0) {
            inputView = [YSCustomInputView selectInputViewWithParamClickBlock:^(YSCustomInputView *customInput) {
                [weakSelf clickKSize];
            }];
            self.paperKsizeInput = inputView;
            [inputView loadTitle:arry[i][@"title"] defaultValue:arry[i][@"value"]];
        }else if (i == 1) {
            inputView = [YSCustomInputView doubleInputViewWithParamClickBlock:^(YSCustomInputView *customInputView, NSString *result) {
                [weakSelf paperWholePaperClicked:customInputView withResult:result];
            }];
            [inputView loadTitle:arry[i][@"title"] defaultValue1:arry[i][@"value"] value2:arry[i][@"value1"]];
            self.quanKaiPaperInput = inputView;
        }else if (i == 2){
            inputView = [YSCustomInputView doubleInputView];
            [inputView loadTitle:arry[i][@"title"] defaultValue1:arry[i][@"value"] value2:arry[i][@"value1"]];
        }else if (i == 5){
            inputView = [YSCustomInputView selectInputViewWithParamClickBlock:^(YSCustomInputView *customInput) {
                [weakSelf clickZhuangDingWay];
            }];
            self.zhuangdingInput = inputView;
            [inputView loadTitle:arry[i][@"title"] defaultValue:arry[i][@"value"]];
        }else {
            inputView = [[NSBundle mainBundle]loadNibNamed:@"YSCustomInputView" owner:nil options:nil].lastObject;
            [inputView loadTitle:arry[i][@"title"] defaultValue:arry[i][@"value"]];
        }
        inputView.frame = CGRectMake(10, yoffset, self.view.width - 40, inputView.height);
        [self.mainScrollview addSubview:inputView];
        yoffset += inputView.height + 20;
        [self.inputAry addObject:inputView];
    }
    [self.mainScrollview contentSizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewControllerWilPop{
    if (self.delegate) {
        [self.delegate baseInfoControllerWillDismiss:self];
    }
}


-(void)saveBtnClicked:(id)sender{
    
    [self updatePaperWithBaseInfo];
    if (self.delegate) {
        [self.delegate baseInfoControllerWillDismiss:self];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)paperWholePaperClicked:(YSCustomInputView *)customInputView withResult:(NSString *)result{
    
    NSArray *pickAry = [YSBookKSize allWholePageSize];
    [customInputView clickWithDatas:pickAry completeBlock:^(YSCustomInputView *customInputView, NSString *result) {
        
    }];
}

-(void)updatePaperWithBaseInfo{
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSBookObject *bookObj = appdele.rootVC.currentBook;
    
    bookObj.kSize = [(YSCustomInputView *)[self.inputAry objectAtIndex:0] inputText];
    bookObj.quanKaiSize = [(YSCustomInputView *)[self.inputAry objectAtIndex:1]inputText];
    bookObj.bookSize = [(YSCustomInputView *)[self.inputAry objectAtIndex:2] inputText];
    
    bookObj.yinzhangNum = [(YSCustomInputView *)[self.inputAry objectAtIndex:3] inputText];
    bookObj.yinLiangNum = [(YSCustomInputView *)[self.inputAry objectAtIndex:4] inputText];
    
    bookObj.zhuangDingWay = [(YSCustomInputView *)[self.inputAry objectAtIndex:5] inputText];
    bookObj.dingJiaNum = [(YSCustomInputView *)[self.inputAry objectAtIndex:6] inputText];
}

-(void)clickKSize{
    
    NSArray *pickAry = @[
                         @"1",
                         @"2",
                         @"3",
                         @"4",
                         @"6",
                         @"8",
                         @"10",
                         @"12",
                         @"14",
                         @"16",
                         @"18",
                         @"20",
                         @"24",
                         @"26",
                         @"28",
                         @"32",
                         @"36",
                         @"40",
                         @"42",
                         @"48",
                         @"50",
                         @"56",
                         @"60",
                         @"64"
                         ];
    [self.paperKsizeInput clickWithDatas:pickAry completeBlock:^(YSCustomInputView *customInputView, NSString *result) {
        
        
    }];
}

-(void)clikQuanKaiSize{
    NSArray *paperSizeAry = @[
                              
                              
                              
                              ];

}

-(void)clickZhuangDingWay{
    NSArray *pickAry = @[
                         @"胶订",
                         @"骑马订",
                         @"锁线胶订",
                         @"精装圆脊",
                         @"精装方脊",
                         @"软精装",
                         ];

    
    [self.zhuangdingInput clickWithDatas:pickAry completeBlock:^(YSCustomInputView *customInputView, NSString *result) {
        
    }];
}

@end
