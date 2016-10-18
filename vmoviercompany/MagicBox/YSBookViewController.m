//
//  YSBookViewController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/7.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSBookViewController.h"
#import "VMCommonTools.h"
#import "VMCommenDefinition.h"
#import "YSIndexController.h"
#import "YSDataCenter.h"
#import "YSHistoryController.h"
#import "YSStaticInfoView.h"
#import "YSCoverInputView.h"
#import "YSBookObject.h"
#import "YSCustomInputView.h"
#import "YSRootViewController.h"
#import "AppDelegate.h"
#import "YSPeopleValueController.h"
#import "YSPaperViewController.h"
#import "YSContentView.h"
#import "VMRequestHelper.h"
#import "VMCyclesScrollview.h"
#import "YSWebViewController.h"



@interface YSBookViewController ()
@property (nonatomic, strong, readwrite) UIButton *creBtn;
@property (nonatomic, strong, readwrite) UIButton *paperBtn;

@property (nonatomic, strong, readwrite) YSDataCenter *dataCenter;

@property (nonatomic, strong, readwrite) UIButton *historyBtn;
@property (nonatomic, strong, readwrite) UIButton *gongJiaBtn;

@property (nonatomic, strong, readwrite) YSPeopleValueController *peopleValueVC;


@property (nonatomic, strong, readwrite) UIView *infoCellView;


@property (nonatomic, strong, readwrite) UIImageView *bookImgView;
@property (nonatomic, strong, readwrite) UILabel *bookName;
@property (nonatomic, strong, readwrite) UILabel *bookInfo;
@property (nonatomic, strong, readwrite) VMCyclesScrollview *cyclesView;
@property (nonatomic, strong, readwrite) NSMutableArray *cyclesAry;


@end

@implementation YSBookViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self useMethodToFindBlackLineAndHind];
    self.dataCenter = [YSDataCenter shareDataCenter];
    self.view.backgroundColor = WHITE;

    [self.view addSubview:self.creBtn];
    [self.view addSubview:self.paperBtn];
    self.creBtn.top = 80;
    self.creBtn.center = CGPointMake(self.view.center.x, self.creBtn.center.y);
    
    self.paperBtn.top = self.creBtn.bottom + 60;
    self.paperBtn.center = CGPointMake(self.creBtn.center.x, self.paperBtn.center.y);

    // Do any additional setup after loading the view.
    
    if (iPhone5) {
        self.creBtn.top -= 30;
        self.paperBtn.top -= 40;
    }
    
    if (iPhone4) {
        self.creBtn.top -= 70;
        self.paperBtn.top -= 120;
    }
    
    
    
    
    self.historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.historyBtn.frame = CGRectMake(0, 0, 40, 30);
    self.historyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.historyBtn addTarget:self action:@selector(historyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.historyBtn setTitle:@"历史" forState:UIControlStateNormal];
    [self.historyBtn setTitleColor:COLORA(50, 50, 50) forState:UIControlStateNormal];
    [self.historyBtn setBackgroundColor:CLEAR];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.historyBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
    self.gongJiaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.gongJiaBtn.frame = CGRectMake(0, 0, 40, 30);
    self.gongJiaBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.gongJiaBtn addTarget:self action:@selector(gongjiaBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.gongJiaBtn setTitle:@"工价" forState:UIControlStateNormal];
    [self.gongJiaBtn setTitleColor:COLORA(50, 50, 50) forState:UIControlStateNormal];
    [self.gongJiaBtn setBackgroundColor:CLEAR];
    
    UIBarButtonItem *rigthItem = [[UIBarButtonItem alloc]initWithCustomView:self.gongJiaBtn];
    self.navigationItem.rightBarButtonItem = rigthItem;
    NSDictionary *dic = @{
                          @"typeId":@"1",
                          @"hot":@"1",
                          @"recomm":@"1",
                          @"page.pageNo":@"1",
                          @"page.pageSize":@"10"
                          
                          };
    
    [VMRequestHelper requestPostURL:@"anon/news-list" paramDict:dic completeBlock:^(id vmRequest, id responseObj) {
        NSDictionary *dic = responseObj[@"result"];
        NSArray *list = dic[@"list"];
        [self creatCycleViewWithAry:list];
    } errorBlock:^(VMError *error) {
        
    }];
    YSContentView *content = [[YSContentView alloc]initWithFrame:CGRectMake(0, self.view.height - [YSContentView contentViewHeight] - 20 - 64, self.view.width, [YSContentView contentViewHeight])];
//    [self.view addSubview:content];
    
    [content loadValues:@{
                          @"title":@"天啊，地球要爆炸啦。你们怕不怕啊，哎呀我去，你们怎么可以一点都不怕啊。我的上帝啊",
                          @"summary":@"天啊，地球要爆炸啦。你们怕不怕啊，哎呀我去，球要爆炸啦。你们怕不怕啊，哎呀我去，你你们怎么可以一点都不怕啊。我的上帝啊"
                          
                          }];
    /*
     
     -(void)loadValues:(NSDictionary *)values{
     
     NSString *imgUrl = values[@"listImg"];
     NSString *name = values[@"title"];
     NSString *des = values[@"summary"];
     [self.bookImg sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
     self.nameLabel.text = name;
     self.desLabel.text = des;
     self.contentURL = values[@"url"];
     }

     */
    CALayer *lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(0, content.top - 20, self.view.width, .5);
    lineLayer.backgroundColor = COLORA(200, 200, 200).CGColor;
    [self.view.layer addSublayer:lineLayer];
    
    
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT;

    
}

-(void)creatCycleViewWithAry:(NSArray *)array{
    if (array == nil || array.count == 0) {
        return;
    }
    self.cyclesAry = [@[]mutableCopy];
    for (int i = 0; i < array.count; i++) {
        YSContentView *contentView = [[YSContentView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, [YSContentView contentViewHeight])];
        [contentView loadValues:array[i]];
        [self.cyclesAry addObject:contentView];
    }
    VMCyclesScrollview *cycles = [[VMCyclesScrollview alloc]initWithFrame:CGRectMake(0, self.view.height - [YSContentView contentViewHeight] - 20, self.view.width, [YSContentView contentViewHeight]) animationDuration:3];
    [self.view addSubview:cycles];
    self.cyclesView = cycles;
    [self.cyclesView pauseTimer];
    WEAKSELF;
    cycles.totalPagesCount = ^NSInteger(void){
        return array.count;
    };
    cycles.fetchContentViewAtIndex = ^UIView *(NSInteger index){
        YSContentView *contentView = [[YSContentView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, [YSContentView contentViewHeight])];
        [contentView loadValues:array[index]];
        return contentView;
    };
    
    cycles.TapActionBlock = ^(NSInteger idnex){
        NSDictionary *dic = array[idnex];
        NSString *url = dic[@"url"];
        
        YSWebViewController *web = [[YSWebViewController alloc]init];
        web.url = url;
        [weakSelf.navigationController pushViewController:web animated:YES];
    };
}



//方法二.当设置navigationBar的背景图片或背景色时，使用该方法都可移除黑线，且不会使translucent属性失效
-(void)useMethodToFindBlackLineAndHind{
    UIImageView* blackLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    //隐藏黑线（在viewWillAppear时隐藏，在viewWillDisappear时显示）
    blackLineImageView.hidden = YES;
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view{
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0){
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)historyBtnClicked:(id)sender{
    
    YSHistoryController *history = [[YSHistoryController alloc]init];
    [self.navigationController pushViewController:history animated:YES];
}

-(void)gongjiaBtnClicked:(id)sender{
    
    self.peopleValueVC = [[YSPeopleValueController alloc]init];
    [self.navigationController pushViewController:self.peopleValueVC animated:YES];
}

-(void)creBtnClicked:(id)sender{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    YSCoverInputView *coverInput = [[YSCoverInputView alloc]initWithFrame:window.bounds];
    coverInput.alpha = 0;
    [self.navigationController.view addSubview:coverInput];
    [UIView animateWithDuration:.3 animations:^{
        coverInput.alpha = 1;
    }];
    
    WEAKSELF;
    coverInput.handler = ^(NSString *name){
        if ([name isValid]) {
            weakSelf.bookName.text = name;
            
            AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
            appdele.rootVC.currentBook.bookName = name;
            
            sleep(.5);
            YSIndexController *index = [[YSIndexController alloc]init];
            index.title = name;
            [weakSelf.navigationController pushViewController:index animated:YES];
        }
    };
}

-(void)paperBtnClicked:(id)sender{
    YSPaperViewController *paperVC = [[YSPaperViewController alloc]init];
    [self.navigationController pushViewController:paperVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - lazying actions ------

-(UIImageView *)bookView{

    if (_bookImgView == nil) {
        _bookImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 320)];
        _bookImgView.backgroundColor = [UIColor clearColor];
        _bookImgView.layer.cornerRadius = 4.f;
        _bookImgView.clipsToBounds = YES;
        [_bookImgView setImage:[UIImage imageNamed:@"book_cover"]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bookViewTapped:)];
        _bookImgView.userInteractionEnabled = YES;
        [_bookImgView addGestureRecognizer:tap];
    }
    return _bookImgView;
}

-(UILabel *)bookName{
    if (_bookName == nil) {
        _bookName = [[UILabel alloc]initWithFrame:CGRectZero];
        _bookName.backgroundColor = CLEAR;
        _bookName.textAlignment = NSTextAlignmentCenter;
        _bookName.font = [UIFont systemFontOfSize:20];
        _bookName.numberOfLines = 1;
        _bookName.text = @"《书名》";
        _bookName.adjustsFontSizeToFitWidth = YES;
        _bookName.width = self.bookView.width - 40;
        _bookName.height = 24;
        [_bookName setTextColor:WHITE];
        _bookName.center = CGPointMake(self.bookView.width / 2.f, self.bookView.height / 2.f);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bookNameTapped:)];
        _bookName.userInteractionEnabled = YES;
        [_bookName addGestureRecognizer:tap];
    }
    return _bookName;
}


-(UIButton *)creBtn{
    if (_creBtn == nil) {
        _creBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_creBtn setImage:[UIImage imageNamed:@"xinjian_nor"] forState:UIControlStateNormal];
        [_creBtn setImage:[UIImage imageNamed:@"xinjian_pre"] forState:UIControlStateSelected];
        [_creBtn addTarget:self action:@selector(creBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        float widthScale = SCREEN_WIDTH / self.view.width;
        
        _creBtn.frame = CGRectMake(0, 0, 120 * widthScale, 120 * widthScale);
    }
    return _creBtn;
}

-(UIButton *)paperBtn{
    if (_paperBtn == nil) {
        _paperBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_paperBtn setImage:[UIImage imageNamed:@"kailiao_nor"] forState:UIControlStateNormal];
        [_paperBtn setImage:[UIImage imageNamed:@"kailiao_pre"] forState:UIControlStateSelected];
        [_paperBtn addTarget:self action:@selector(paperBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        float widthScale = SCREEN_WIDTH / self.view.width;
        
        _paperBtn.frame = CGRectMake(0, 0, 120 * widthScale, 120 * widthScale);

    }
    return _paperBtn;
}

-(UIView *)infoCellView{

    if (_infoCellView == nil) {
        _infoCellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 160)];
        _infoCellView.backgroundColor = WHITE;
        CALayer *lineLayer = [CALayer layer];
        lineLayer.frame = CGRectMake(0, 0, self.view.width, .5);
        lineLayer.backgroundColor = COLORA(100, 100, 100).CGColor;
        [_infoCellView.layer addSublayer:lineLayer];
    }
    return _infoCellView;
}

-(UIImageView *)bookImgView{
    if (_bookImgView == nil) {
        
    }
    return _bookImgView;
}







@end
