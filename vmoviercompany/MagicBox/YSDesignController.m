//
//  YSDesignController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/25.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSDesignController.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "YSCustomInputView.h"
#import "UIViewController+VMKit.h"
#import "AppDelegate.h"
#import "VMovieKit.h"
#import "YSJSQController.h"
#import "YSHuiZongView.h"

@interface YSDesignController ()

@property (nonatomic, strong, readwrite) TPKeyboardAvoidingScrollView *mainScrollview;

@property (nonatomic, assign, readwrite) NSInteger wholeNum;

@property (nonatomic, strong, readwrite) NSMutableArray *inputNumAry;

@property (nonatomic, strong, readwrite) UILabel *zhengWenLabel;

@property (nonatomic, strong, readwrite) UILabel *fengMianLabel;

@property (nonatomic, strong, readwrite) CALayer *lineLayer;

@property (nonatomic, strong, readwrite) UILabel *maxLabel;

@property (nonatomic, strong, readwrite) YSBookObject *currentBook;


@property (nonatomic, strong, readwrite) YSHuiZongView *huiZongView;
@property (nonatomic, strong, readwrite) NSString *paiBanJinE;
@property (nonatomic, strong, readwrite) NSString *sheJiFei;
@end

@implementation YSDesignController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self indentiferNavBack];
    self.title = @"设计费用";
    
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

    self.mainScrollview = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.huiZongView.height)];
    [self.view addSubview:self.mainScrollview];
    self.view.backgroundColor = WHITE;
    float yoffset = 20;

    //正文的数量是印张＊开数
    NSInteger zwYingzhang = [self.currentBook.yinzhangNum integerValue];
    NSInteger zwKsize = [self.currentBook.kSize integerValue];
    NSString *zwNum = [NSString stringWithFormat:@"%ld",zwYingzhang * zwKsize];
    
    NSString *zwDanJia = [self.currentBook.shejifeizwDanJia isValid] ? self.currentBook.shejifeizwDanJia : @"0";
    NSString *zwQiTa = [self.currentBook.shejifeizwQiTa isValid] ? self.currentBook.shejifeizwQiTa : @"0";
    NSString *zwJinE = [self.currentBook.shejifeizwJinE isValid] ? self.currentBook.shejifeizwJinE : @"0";
    
    NSString *fmNum = [self.currentBook.shejifeifmShuLiang isValid] ? self.currentBook.shejifeifmShuLiang : @"0";
    NSString *fmDanjia = [self.currentBook.shejifeifmDanJia isValid] ? self.currentBook.shejifeifmDanJia : @"0";
    NSString *fmQita = [self.currentBook.shejifeifmQiTa isValid] ? self.currentBook.shejifeifmQiTa : @"0";
    NSString *fmJinE = [self.currentBook.shejifeifmJinE isValid] ? self.currentBook.shejifeifmJinE : @"0";
    
    NSArray *arry = @[
                      @{@"title":@"数量",@"value":zwNum},
                      @{@"title":@"单价",@"value":zwDanJia},
//                      @{@"title":@"其他费用",@"value":zwQiTa},
                      @{@"title":@"金额",@"value":zwJinE},
                      
//                      @{@"title":@"数量",@"value":fmNum},
                      @{@"title":@"单价",@"value":fmDanjia},
//                      @{@"title":@"其他费用",@"value":fmQita},
//                      @{@"title":@"封面设计费",@"value":fmJinE},
                      ];
    
    for (int i = 0; i < arry.count; i ++) {
        YSCustomInputView *inputView = nil;
        inputView = [[NSBundle mainBundle]loadNibNamed:@"YSCustomInputView" owner:nil options:nil].lastObject;
        if (i == 0) {
            [self.mainScrollview addSubview:self.zhengWenLabel];
        }
        if (i == 2) {
            [self.mainScrollview addSubview:self.fengMianLabel];
        }
        
        
        if (i == 2 || i == 7) {
            inputView.userInteractionEnabled = NO;
            inputView.inputTextField.enabled = NO;
            [inputView inputShowType];
        }
        inputView.tag = i;
        [inputView loadTitle:arry[i][@"title"] defaultValue:arry[i][@"value"]];
        inputView.frame = CGRectMake(10, yoffset, self.view.width - 40, inputView.height);
        [self.mainScrollview  addSubview:inputView];
        yoffset += inputView.height + 20;
        if (i == 2) {
            yoffset += 30;
        }
        [self.inputNumAry addObject:inputView];
    }
    [self.mainScrollview contentSizeToFit];
    self.huiZongView.bottom = self.view.height;
    
    
    self.paiBanJinE = zwJinE;
    self.sheJiFei = fmDanjia;
    
    [self.huiZongView loadValues:@[self.paiBanJinE, self.sheJiFei]];
    YSCustomInputView *customView = [self.inputNumAry objectAtIndex:3];
    self.fengMianLabel.bottom = customView.top - 10;
    
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
    NSString *zwMoney = bookObj.shejifeizwJinE;
    NSString *fmMoney = bookObj.shejifeifmDanJia;
    self.wholeNum = [zwMoney integerValue] + [fmMoney integerValue];
    [self.jsqVC getValueFromSheJiFei:[@(self.wholeNum) stringValue]];
}

-(void)jiSuanBtnClicked:(id)sender{
    //这里是计算
    [self getFinalValue];
    YSCustomInputView *zwValue = [self customInputViewWithTitle:@"金额" withTag:2];
    YSCustomInputView *fmValue = [self customInputViewWithTitle:@"单价" withTag:3];
    self.paiBanJinE = zwValue.inputText;
    self.sheJiFei = fmValue.inputText;
    [self.huiZongView loadValues:@[self.paiBanJinE,self.sheJiFei]];
}

-(void)saveBtnClicked:(id)sender{
    [self updatePaperWithBaseInfo];
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)updatePaperWithBaseInfo{
    
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSBookObject *bookObj = appdele.rootVC.currentBook;
    
    bookObj.shejifeizwShuLiang = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:0] inputText];
    bookObj.shejifeizwDanJia = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:1] inputText];
    
//    bookObj.shejifeizwQiTa = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:2] inputText];
    bookObj.shejifeizwJinE = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:2] inputText];
    
//    bookObj.shejifeifmShuLiang = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:4] inputText];
    bookObj.shejifeifmDanJia = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:3] inputText];
    
//    bookObj.shejifeifmQiTa = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:6] inputText];
//    bookObj.shejifeifmJinE = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:7] inputText];
}

-(void)moneyLabelTapped:(UITapGestureRecognizer *)tap{
    [self getFinalValue];
}

-(void)getFinalValue{

    //金额＝数量*单价＋其他费用
    NSInteger number = [[self customInputViewWithTitle:@"数量" withTag:0] number];
    CGFloat price = [[self customInputViewWithTitle:@"单价" withTag:1] number];
    CGFloat zwFinal = price * number;
    
    YSCustomInputView *zwValue = [self customInputViewWithTitle:@"金额" withTag:2];
    zwValue.inputTextField.text = [NSString stringWithFormat:@"%.2f",zwFinal];
    
    //封面金额
    NSInteger fmPrice = [[self customInputViewWithTitle:@"单价" withTag:3] number];
//    CGFloat fmPrice = [[self customInputViewWithTitle:@"单价" withTag:5] number];
//    CGFloat fmOther = [[self customInputViewWithTitle:@"其他费用" withTag:6] number];
    CGFloat fmFinal = fmPrice;
    YSCustomInputView *fmValue = [self customInputViewWithTitle:@"金额" withTag:3];
    fmValue.inputTextField.text = [NSString stringWithFormat:@"%.2f",fmFinal];
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

#pragma mark - lazy actions ------

-(UILabel *)zhengWenLabel{
    if (_zhengWenLabel == nil) {
        _zhengWenLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _zhengWenLabel.textColor = COLORA(71, 71, 71);
        _zhengWenLabel.font = [UIFont systemFontOfSize:16];
        _zhengWenLabel.text = @"  排版设计费用";
        _zhengWenLabel.textAlignment = NSTextAlignmentLeft;
        [_zhengWenLabel sizeToFit];
    }
    return _zhengWenLabel;
}

-(UILabel *)fengMianLabel{
    if (_fengMianLabel == nil) {
        _fengMianLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _fengMianLabel.textColor = COLORA(71, 71, 71);
        _fengMianLabel.font = [UIFont systemFontOfSize:16];
        _fengMianLabel.text = @"  封面设计费";
        _fengMianLabel.textAlignment = NSTextAlignmentLeft;
        [_fengMianLabel sizeToFit];
    }
    return _fengMianLabel;
}

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

-(YSHuiZongView *)huiZongView{
    
    if (_huiZongView == nil) {
        _huiZongView = [YSHuiZongView huiZongViewWithTitles:@[@"排版金额",@"封面设计费"]];
    }
    return _huiZongView;
}



@end
