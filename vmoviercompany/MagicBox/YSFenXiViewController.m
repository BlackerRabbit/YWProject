//
//  YSFenXiViewController.m
//  MagicBox
//
//  Created by 蒋正峰 on 2016/10/8.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSFenXiViewController.h"
#import "YSBookObject.h"
#import "AppDelegate.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "UIViewController+VMKit.h"
#import "WXApi.h"
#import "VMovieKit.h"

@interface YSFenXiViewController ()
@property (nonatomic, strong, readwrite) YSBookObject *currentBook;
@property (nonatomic, strong, readwrite) TPKeyboardAvoidingScrollView *bgScrollView;

@property (nonatomic, strong, readwrite) NSMutableArray *valuesAry;

@property (nonatomic, strong, readwrite) UIButton *saveBtn;
@property (nonatomic, strong, readwrite) UIButton *shareBtn;

@end

@implementation YSFenXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self indentiferNavBack];
    self.view.backgroundColor = WHITE;
    self.bgScrollView = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 75)];
    [self.view addSubview:self.bgScrollView];
    self.bgScrollView.backgroundColor = WHITE;
    
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.currentBook = appdele.rootVC.currentBook;
    self.title = self.currentBook.bookName;
    NSString *zwMoney = self.currentBook.zwMoney;
    NSString *fmMoney = self.currentBook.fmMoney;
    UIView *paper = [self createWithTitle:@"纸张费用：" value:[self.valuesAry objectAtIndex:0]];
    paper.top = 20;
    [self.bgScrollView addSubview:paper];
    
    UIView *gaoChou = [self createWithTitle:@"稿酬费用：" value:[self.valuesAry objectAtIndex:1]];
    gaoChou.top = paper.bottom + 10;
    [self.bgScrollView addSubview:gaoChou];
    
    UIView *sheJi = [self createWithTitle:@"设计费用：" value:[self.valuesAry objectAtIndex:2]];
    sheJi.top = gaoChou.bottom + 10;
    [self.bgScrollView addSubview:sheJi];
    
    UIView *yinShua = [self createWithTitle:@"印刷设计：" value:[self.valuesAry objectAtIndex:3]];
    yinShua.top = sheJi.bottom + 10;
    [self.bgScrollView addSubview:yinShua];
    
    UIView *gongYi = [self createWithTitle:@"工艺费用：" value:[self.valuesAry objectAtIndex:4]];
    gongYi.top = yinShua.bottom + 10;
    [self.bgScrollView addSubview:gongYi];
    
    UIView *qiTa = [self createWithTitle:@"其他费用：" value:[self.valuesAry objectAtIndex:5]];
    qiTa.top = gongYi.bottom + 10;
    [self.bgScrollView addSubview:qiTa];
    
    UIView *faXing = [self createWithTitle:@"发行费：" value:[self.valuesAry objectAtIndex:6]];
    faXing.top = qiTa.bottom + 10;
    [self.bgScrollView addSubview:faXing];
    
    CALayer *line = [CALayer layer];
    line.frame = CGRectMake(0, faXing.bottom + 20, self.view.width, .5);
    line.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.bgScrollView.layer addSublayer:line];
    
    UIView *zongZhiChu = [self creatBigTitle:@"总支出：" value:[self.valuesAry objectAtIndex:7]];
    zongZhiChu.top = faXing.bottom + 40;
    [self.bgScrollView addSubview:zongZhiChu];
    
    UIView *dccbView = [self creatBigTitle:@"单册成本：" value:[self.valuesAry objectAtIndex:8]];
    dccbView.top = zongZhiChu.bottom + 10;
    [self.bgScrollView addSubview:dccbView];
    
    UIView *fxsrView = [self creatBigTitle:@"发行收入：" value:[self.valuesAry objectAtIndex:9]];
    fxsrView.top = dccbView.bottom + 10;
    [self.bgScrollView addSubview:fxsrView];
    
    UIView *bbdView = [self creatBigTitle:@"保本点：" value:[self.valuesAry objectAtIndex:10]];
    bbdView.top = fxsrView.bottom + 10;
    [self.bgScrollView addSubview:bbdView];
    
    UIView *ylView = [self creatBigTitle:@"盈利：" value:[self.valuesAry objectAtIndex:11]];
    ylView.top = bbdView.bottom + 10;
    [self.bgScrollView addSubview:ylView];
    [self.bgScrollView contentSizeToFit];
    
    
    CALayer *line2 = [CALayer layer];
    line2.backgroundColor = line.backgroundColor;
    line2.frame = CGRectMake(0, self.view.height - 64 - 75, self.view.width, .5);
    [self.view.layer addSublayer:line2];
    
    self.saveBtn.bottom = self.view.height - 20 - 64;
    self.saveBtn.left = 60;
    self.shareBtn.right = self.view.width - 60 ;
    self.shareBtn.bottom = self.saveBtn.bottom;
    [self.view addSubview:self.saveBtn];
    [self.view addSubview:self.shareBtn];
    
    
    // Do any additional setup after loading the view.
    

}

-(void)loadValues:(NSArray *)values{

    self.valuesAry = [@[]mutableCopy];
    [self.valuesAry addObjectsFromArray:values];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

-(void)saveBtnClicked:(id)sender{
    NSLog(@"%@",[VMTools documentPath]);
    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YSBookObject *book = appdele.rootVC.currentBook;
    [book saveCurrentBook];
    [VMTools alertMessage:@"保存成功！可以在历史记录里查看"];
}

-(void)shareBtnClicked:(id)sender{
    
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"icon.png"]];
    
    WXImageObject *ext = [WXImageObject object];
    
    UIImage *image = [self.bgScrollView screenShotWithRect:CGRectMake(0, 0, self.bgScrollView.width, self.bgScrollView.contentSize.height) save:NO];
    
    ext.imageData = UIImageJPEGRepresentation(image, .7);
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}

-(UIView *)createWithTitle:(NSString *)title value:(NSString *)value{
    
    UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"FenxiLabelGroup" owner:nil options:nil] lastObject];
    view.height = 30;
    view.width = self.view.width;
    UILabel *titleLabel = [view viewWithTag:100];
    UILabel *valueLabel = [view viewWithTag:200];
    titleLabel.text = title;
    valueLabel.text = value;
    return view;
}

-(UIView *)creatBigTitle:(NSString *)title value:(NSString *)value{
    
    UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"FenxiLabelGroup" owner:nil options:nil] lastObject];
    view.height = 30;
    view.width = self.view.width;
    UILabel *titleLabel = [view viewWithTag:100];
    UILabel *valueLabel = [view viewWithTag:200];
    titleLabel.text = title;
    valueLabel.text = value;
    titleLabel.font = [UIFont systemFontOfSize:22];
    valueLabel.font = [UIFont systemFontOfSize:22];
    return view;
}

-(UIButton *)saveBtn{
    if (_saveBtn == nil) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn addTarget:self action:@selector(saveBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setFrame:CGRectMake(0, 0, 70, 35)];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:COLORA(60, 60, 60) forState:UIControlStateNormal];
        [_saveBtn setBackgroundColor:COLORA(245, 245, 245)];
        _saveBtn.layer.cornerRadius = 4.f;
        _saveBtn.clipsToBounds = YES;
    }
    return _saveBtn;
}

-(UIButton *)shareBtn{
    if (_shareBtn == nil) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_shareBtn setFrame:CGRectMake(0, 0, 70, 35)];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:COLORA(60, 60, 60) forState:UIControlStateNormal];
        [_shareBtn setBackgroundColor:COLORA(245, 245, 245)];
        _shareBtn.layer.cornerRadius = 4.f;
        _shareBtn.clipsToBounds = YES;
    }
    return _shareBtn;
}


@end
