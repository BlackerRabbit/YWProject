//
//  YSQiTaController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/21.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSQiTaController.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "YSCustomInputView.h"
#import "UIViewController+VMKit.h"
#import "AppDelegate.h"
#import "VMovieKit.h"
#import "YSHuiZongView.h"


@interface YSQiTaController ()

@property (nonatomic, strong, readwrite) TPKeyboardAvoidingScrollView *mainScrollview;

@property (nonatomic, assign, readwrite) NSInteger wholeNum;

@property (nonatomic, strong, readwrite) NSMutableArray *inputNumAry;

@property (nonatomic, strong, readwrite) UILabel *zhengWenLabel;

@property (nonatomic, strong, readwrite) UILabel *fengMianLabel;

@property (nonatomic, strong, readwrite) CALayer *lineLayer;

@property (nonatomic, strong, readwrite) UILabel *maxLabel;

@property (nonatomic, strong, readwrite) YSBookObject *currentBook;
//汇总
@property (nonatomic, strong, readwrite) YSHuiZongView *huiZongView;

@property (nonatomic, strong, readwrite) NSString *guanliValue;

@property (nonatomic, strong, readwrite) NSString *bianLuValue;

@end

@implementation YSQiTaController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self indentiferNavBack];
    self.title = @"其他费用";
    
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
    
    NSString *guanLiMoney = [self.currentBook.guanLiChengBen isValid] ? self.currentBook.guanLiChengBen : @"0";
    NSString *bianLuMoeny = [self.currentBook.bianluJingfei isValid] ? self.currentBook.bianluJingfei : @"0";
    
    self.guanliValue = guanLiMoney;
    self.bianLuValue = bianLuMoeny;
    
    [self.view addSubview:self.huiZongView];
    
    
    self.mainScrollview = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.huiZongView.height)];
    [self.view addSubview:self.mainScrollview];
    self.huiZongView.bottom = self.view.height;
    [self.huiZongView loadValues:@[self.guanliValue,self.bianLuValue]];
    
    
    
    self.view.backgroundColor = WHITE;
    float yoffset = 20;
    
    NSArray *arry = @[
                      @{@"title":@"管理成本费用",@"value":guanLiMoney},
                      @{@"title":@"编录经费",@"value":bianLuMoeny},
                      ];
    
    for (int i = 0; i < arry.count; i ++) {
        YSCustomInputView *inputView = nil;
        inputView = [[NSBundle mainBundle]loadNibNamed:@"YSCustomInputView" owner:nil options:nil].lastObject;
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


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    CGFloat guanli = [self.guanliValue floatValue];
    CGFloat bianlu = [self.bianLuValue floatValue];
    [self.jsqVC getValueFromQiTa:[NSString stringWithFormat:@"%.0f",guanli+bianlu]];
}

-(void)updatePaperWithBaseInfo{
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSBookObject *bookObj = appdele.rootVC.currentBook;
    bookObj.guanLiChengBen = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:0] inputText];
    bookObj.bianluJingfei = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:1] inputText];
    bookObj.qitaMoney = [NSString stringWithFormat:@"%.2f",[bookObj.guanLiChengBen floatValue] + [bookObj.bianluJingfei floatValue]];
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

-(void)jiSuanBtnClicked:(id)sender{
    [self getFinalValue];
    [self.huiZongView loadValues:@[self.guanliValue, self.bianLuValue]];
}

-(void)saveBtnClicked:(id)sender{
    [self updatePaperWithBaseInfo];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)getFinalValue{
    
    CGFloat managerValue = [[self customInputViewWithTitle:@"管理成本费用" withTag:0] number];
    CGFloat bianluValue = [[self customInputViewWithTitle:@"编录经费" withTag:1] number];
    self.guanliValue = [NSString stringWithFormat:@"%.2f",managerValue];
    self.bianLuValue = [NSString stringWithFormat:@"%.2f",bianluValue];
}


-(YSHuiZongView *)huiZongView{
    
    if (_huiZongView == nil) {
        _huiZongView = [YSHuiZongView huiZongViewWithTitles:@[@"管理费用",@"编录费用"]];
    }
    return _huiZongView;
}



@end
