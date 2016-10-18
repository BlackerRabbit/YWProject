//
//  YSPaperDetailCostController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/13.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSPaperDetailCostController.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "YSCustomInputView.h"
#import "UIViewController+VMKit.h"
#import "AppDelegate.h"
#import "VMovieKit.h"
#import "YSBookKSize.h"
#import "YSHuiZongView.h"


@interface YSPaperDetailCostController ()

@property (nonatomic, strong, readwrite) TPKeyboardAvoidingScrollView *mainScrollview;

@property (nonatomic, assign, readwrite) NSInteger wholeNum;

@property (nonatomic, strong, readwrite) NSMutableArray *inputNumAry;

@property (nonatomic, strong, readwrite) UILabel *zhengWenLabel;

@property (nonatomic, strong, readwrite) UILabel *fengMianLabel;

@property (nonatomic, strong, readwrite) CALayer *lineLayer;

@property (nonatomic, strong, readwrite) UILabel *maxLabel;

@property (nonatomic, strong, readwrite) YSBookObject *currentBook;

@property (nonatomic, strong, readwrite) YSBookObject *tempCurrentBook;


@property (nonatomic, strong, readwrite) UIScrollView *bgScrollview;

@property (nonatomic, strong, readwrite) YSHuiZongView *huiZongView;


@property (nonatomic, strong, readwrite) NSString *zwMoney;

@property (nonatomic, strong, readwrite) NSString *fmMoney;


@end

@implementation YSPaperDetailCostController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self indentiferNavBack];
    self.title = @"纸张费用";
    
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
    self.zwMoney = [NSString stringWithString:self.currentBook.zwMoney];
    self.fmMoney = [NSString stringWithString:self.currentBook.fmMoney];
    
    self.mainScrollview = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.huiZongView.height)];
    [self.view addSubview:self.mainScrollview];
    self.huiZongView.bottom = self.view.height;
    [self.view addSubview:self.huiZongView];
    [self.huiZongView loadValues:@[self.zwMoney,self.fmMoney]];
    
    
    self.view.backgroundColor = WHITE;
    float yoffset = 20;
    
    NSString *paperSize = self.currentBook.quanKaiSize;
    NSArray *array = nil;
    NSString *sizeWidth = nil;
    NSString *sizeHeight = nil;
    NSString *fmSizeWidth = nil;
    NSString *fmSizeHeight = nil;
    if ([paperSize isValid] && [paperSize containSubstring:@"x"]) {
        array = [paperSize componentsSeparatedByString:@"x"];
        sizeWidth = array[0];
        sizeHeight = array[1];
    }else{
        sizeWidth = @"0";
        sizeHeight = @"0";
    }
    
    fmSizeWidth = [@([sizeWidth integerValue] ) stringValue];
    fmSizeHeight = [@([sizeHeight integerValue] ) stringValue];
    NSString *zwKsie = [self.currentBook.kSize isValid] ? self.currentBook.kSize : @"0";
    NSString *zwkezhongStr = [self.currentBook.zwkezhongNum isValid] ? self.currentBook.zwkezhongNum : @"0";
    NSString *fmkezhongStr = [self.currentBook.fmkezhongNum isValid] ? self.currentBook.fmkezhongNum : @"0";
    
    NSString *fmkSize = [@([zwKsie integerValue] / 2) stringValue];
  

    NSString *zwMoneyStr = [self.currentBook.zwMoney isValid] ? self.currentBook.zwMoney : @"";
    NSString *fmMoneyStr = [self.currentBook.fmMoney isValid] ? self.currentBook.fmMoney : @"";
    
    NSString *zwDunMoneyStr = self.currentBook.zwDunMoney;
    NSString *fmDunMoneyStr = self.currentBook.fmDunMoney;
    
    NSArray *arry = @[
                      @{@"title":@"用纸",@"value1":sizeWidth,@"value2":sizeHeight},
                      @{@"title":@"开数",@"value":zwKsie},
                      @{@"title":@"克重",@"value":zwkezhongStr},
                      @{@"title":@"吨价",@"value":zwDunMoneyStr},
                      @{@"title":@"金额",@"value":zwMoneyStr},
                      
                      @{@"title":@"用纸",@"value1":fmSizeWidth,@"value2":fmSizeHeight},
                      @{@"title":@"开数",@"value":fmkSize},
                      @{@"title":@"克重",@"value":fmkezhongStr},
                      @{@"title":@"吨价",@"value":fmDunMoneyStr},
                      @{@"title":@"金额",@"value":fmMoneyStr},
                      ];
    WEAKSELF;
    for (int i = 0; i < arry.count; i ++) {
        YSCustomInputView *inputView = nil;
        if (i == 0) {
            [self.mainScrollview addSubview:self.zhengWenLabel];
            inputView = [YSCustomInputView doubleInputView];
            [inputView loadTitle:arry[i][@"title"] defaultValue1:arry[i][@"value1"] value2:arry[i][@"value2"]];
            [inputView canNotModifyType];
        }else if (i == 5) {
            [self.mainScrollview addSubview:self.fengMianLabel];
            inputView = [YSCustomInputView doubleInputViewWithParamClickBlock:^(YSCustomInputView *customInputView, NSString *result) {
                [weakSelf loadMorePaperKSizeWith:customInputView];
            }];
            [inputView loadTitle:arry[i][@"title"] defaultValue1:arry[i][@"value1"] value2:arry[i][@"value2"]];
        }else if (i == 6){
            inputView = [YSCustomInputView selectInputViewWithParamClickBlock:^(YSCustomInputView *customInput) {
                [weakSelf loadMoreKsizeWithInputView:customInput];
            }];
            
        } else{
            inputView = [[NSBundle mainBundle]loadNibNamed:@"YSCustomInputView" owner:nil options:nil].lastObject;
        }
        if (i == 1) {
            [inputView canNotModifyType];
        }
        
        if (i == 4 || i == 9) {
            inputView.userInteractionEnabled = NO;
            inputView.inputTextField.enabled = NO;
            [inputView  inputShowType];
        }
        inputView.tag = i;
        [inputView loadTitle:arry[i][@"title"] defaultValue:arry[i][@"value"]];
        inputView.frame = CGRectMake(10, yoffset, self.view.width - 40, inputView.height);
        [self.mainScrollview  addSubview:inputView];
        yoffset += inputView.height + 20;
        if (i == 4) {
            yoffset += 30;
        }
        [self.inputNumAry addObject:inputView];
    }
    [self.mainScrollview contentSizeToFit];
    YSCustomInputView *customView = self.inputNumAry[5];
    self.fengMianLabel.bottom = customView.top - 10;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self updatePaperWithBaseInfo];
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSBookObject *bookObj = appdele.rootVC.currentBook;
    NSString *zwMoney = bookObj.zwMoney;
    NSString *fmMoney = bookObj.fmMoney;
    self.wholeNum = [zwMoney integerValue] + [fmMoney integerValue];
    [self.jsqVC getNumberFromPaper:self.wholeNum];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


-(void)loadMorePaperKSizeWith:(YSCustomInputView *)inputView{
    
    NSArray *array = [YSBookKSize allWholePageSize];
    [inputView clickWithDatas:array completeBlock:^(YSCustomInputView *customInputView, NSString *result) {
        
    }];
}

-(void)loadMoreKsizeWithInputView:(YSCustomInputView *)inputView{
    NSArray *array = [YSBookKSize allBookAndTheKSize];
    [inputView clickWithDatas:array completeBlock:^(YSCustomInputView *customInputView, NSString *result) {
        
    }];
}

#pragma mark - btn actions ------

-(void)jiSuanBtnClicked:(id)sender{
    [self getFinalValue];
    [self.huiZongView loadValues:@[self.zwMoney,self.fmMoney]];
}

-(void)saveBtnClicked:(id)sender{
    [self updatePaperWithBaseInfo];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)updatePaperWithBaseInfo{
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSBookObject *bookObj = appdele.rootVC.currentBook;
    
    bookObj.zwyongZhiNum = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:0] inputText];
    bookObj.kSize = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:1] inputText];
    bookObj.zwkezhongNum = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:2] inputText];
    bookObj.zwDunMoney = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:3]inputText];
    bookObj.zwMoney = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:4] inputText];
    
    bookObj.fmyongZhiNum = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:5] inputText];
    bookObj.fmKsize = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:6] inputText];
    
    bookObj.fmkezhongNum = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:7] inputText];
    bookObj.fmDunMoney = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:8]inputText];
    bookObj.fmMoney = [(YSCustomInputView *)[self.inputNumAry objectAtIndex:9] inputText];
}


-(void)moneyLabelTapped:(UITapGestureRecognizer *)tap{
    [self updatePaperWithBaseInfo];
    [self getFinalValue];
}


-(NSArray *)getFinalValue{
    
    YSBookObject *book = self.jsqVC.currentBook;
    
    YSCustomInputView *zwYongZhi = [self customInputViewWithTitle:@"用纸" withTag:0];
    YSCustomInputView *zwKaishu = [self customInputViewWithTitle:@"开数" withTag:1];
    YSCustomInputView *zwKeZhong = [self customInputViewWithTitle:@"克重" withTag:2];
    YSCustomInputView *zwDunMoney = [self customInputViewWithTitle:@"吨价" withTag:3];
    YSCustomInputView *zwJinE = [self customInputViewWithTitle:@"金额"withTag:4];
    
    YSCustomInputView *fmYongZhi = [self customInputViewWithTitle:@"用纸"withTag:5];
    YSCustomInputView *fmKaiShu = [self customInputViewWithTitle:@"开数" withTag:6];
    YSCustomInputView *fmKeZhong = [self customInputViewWithTitle:@"克重" withTag:7];
    YSCustomInputView *fmDunMoney = [self customInputViewWithTitle:@"吨价" withTag:8];
    YSCustomInputView *fmJinE = [self customInputViewWithTitle:@"金额" withTag:9];
    
    
    NSString * zwYongZhiNum = [zwYongZhi inputText];
    NSArray *zwyongzhiAry = [zwYongZhiNum componentsSeparatedByString:@"x"];
    
    NSInteger zwKaiShuNum = [zwKaishu number];
    NSInteger zwKeZhongNum = [zwKeZhong number];
    NSInteger zwJinENum = [zwJinE number];
    NSInteger zwDunMoneyNum = [zwDunMoney number];
    
    NSInteger zwPaperWidth = [zwyongzhiAry[0] integerValue];
    NSInteger zwPaperHeight = [zwyongzhiAry[1] integerValue];
    
    NSString * fmYongZhiNum = [fmYongZhi inputText];
    NSArray *fmyongzhiAry = [fmYongZhiNum componentsSeparatedByString:@"x"];
    NSInteger fmDunMoneyNum = [fmDunMoney number];
    NSInteger fmPaperWidth = [fmyongzhiAry[0] integerValue];
    NSInteger fmPaperHeight = [fmyongzhiAry[1] integerValue];
    
    //印张，印量，正文的
    NSInteger zwYingZhangNum = [self.currentBook.yinzhangNum integerValue];
    NSInteger zwYingLiangNum = [self.currentBook.yinLiangNum integerValue];
    //正文的金额 （（印张 ＊ 印量）／ 2 ＊ 加放（千分之三）（用纸张数））
    NSInteger zhiLiangNumber = ((zwYingZhangNum * zwYingLiangNum) / 2 ) * 1.003; //用纸的总张数 克重默认128
    CGFloat paperArea =(((zwPaperWidth * zwPaperHeight)*1.f / (1000 * 1000)*1.f )* zhiLiangNumber * zwKeZhongNum) * 1.f / (1000 * 1000) * 1.f;//吨数
    //给个默认吨价，为6000
    CGFloat finalValie = zwDunMoneyNum * paperArea;
//    [VMTools alertMessage:[NSString stringWithFormat:@"zheng wen value is %f",finalValie]];
    
    //正文的令价
    //令数 用纸张数 ／ 500
    CGFloat zwLingShu = zhiLiangNumber * 1.f / 500.f;
//    [VMTools alertMessage:[NSString stringWithFormat:@"zheng wen ling shu  is %f",zwLingShu]];
    
    //吨令转换，已吨为已知条件
    CGFloat dunLinChange = zwLingShu / paperArea;
//    [VMTools alertMessage:[NSString stringWithFormat:@"zheng wen dun ling zhuan huan  value is %f",dunLinChange]];
    
    //令价 吨价/吨令转换
    CGFloat lingValue = zwDunMoneyNum * 1.f / dunLinChange;
//    [VMTools alertMessage:[NSString stringWithFormat:@"zheng wen ling jia value is %f",lingValue]];
    

    
//    NSInteger fmYongZhiNum = [fmYongZhi number];
    NSInteger fmKaiShuNum = [fmKaiShu number];
    NSInteger fmKeZhongNum = [fmKeZhong number];
    NSInteger fmJinENum = [fmJinE number];
    //封面的金额 （印量 ／ 封面开数 ＊ 加放（千分之三）（用纸张数））
    NSInteger fmZhiLiangNum = ((zwYingLiangNum * 1.f) / fmKaiShuNum) * 1.003;
    CGFloat fmArea = (((fmPaperWidth * fmPaperHeight)*1.f / (1000 * 1000)*1.f )* fmZhiLiangNum * fmKeZhongNum) * 1.f / (1000 * 1000) * 1.f;//吨数
    //给个默认吨价，为6000
    CGFloat fmfinalValie = fmDunMoneyNum * fmArea;
//    [VMTools alertMessage:[NSString stringWithFormat:@"feng mian value is %f",fmfinalValie]];
    
    //封面的令价
    //令数 用纸张数 ／ 500
    CGFloat fmLingShu = fmZhiLiangNum * 1.f / 500.f;
//    [VMTools alertMessage:[NSString stringWithFormat:@"feng mian ling shu value is %f",zwLingShu]];
    
    //吨令转换，已吨为已知条件
    CGFloat fmDunLinChange = fmLingShu / fmArea;
//    [VMTools alertMessage:[NSString stringWithFormat:@"feng mian dun ling zhuan huan  value is %f",fmDunLinChange]];
    
    //令价 吨价/吨令转换
    CGFloat fmlingValue = fmDunMoneyNum * 1.f / fmDunLinChange;
//    [VMTools alertMessage:[NSString stringWithFormat:@"feng mian ling jia value is %f",fmlingValue]];
    
    zwJinE.inputTextField.text = [NSString stringWithFormat:@"%.2f",finalValie];
    fmJinE.inputTextField.text = [NSString stringWithFormat:@"%.2f",fmfinalValie];
    
    self.zwMoney = [zwJinE.inputTextField.text isValid] ? zwJinE.inputTextField.text  : @"0";
    self.fmMoney = [fmJinE.inputTextField.text isValid] ? fmJinE.inputTextField.text  : @"0";
    
    return @[@(finalValie),@(fmfinalValie)];
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
        _zhengWenLabel.text = @"  正文";
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
        _fengMianLabel.text = @"  封面";
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
        _huiZongView = [YSHuiZongView huiZongViewWithTitles:@[@"正文用纸",@"封面用纸"]];
    }
    return _huiZongView;
}

-(UIScrollView *)bgScrollview{

    if (_bgScrollview == nil) {
        _bgScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.height, 0)];
    }
    return _bgScrollview;
}

@end
