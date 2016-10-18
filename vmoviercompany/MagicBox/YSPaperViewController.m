//
//  YSPaperViewController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/8.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSPaperViewController.h"
#import "YSPaper.h"
#import "YSPaperView.h"
#import "UIViewController+VMKit.h"
#import "YSSelectedView.h"

@interface YSPaperViewController ()<UIScrollViewDelegate,YSSelectedDelegate>
@property (nonatomic, strong, readwrite) UIScrollView *paperScrollView;
@property (nonatomic, strong, readwrite) YSPaperView *paperView;
@property (nonatomic, strong, readwrite) NSMutableArray *labelsAry;
@property (nonatomic, strong, readwrite) UIView *pointView;
@property (nonatomic, strong, readwrite) UIColor *selectedColor;
@property (nonatomic, strong, readwrite) UIColor *normalColor;
@property (nonatomic, assign, readwrite) NSInteger currentKSize;
@property (nonatomic, strong, readwrite) UIWebView *mainWebView;

@property (nonatomic, strong, readwrite) UIScrollView *labelScrollView;
@property (nonatomic, strong, readwrite) YSSelectedView *selectedView;

@end

@implementation YSPaperViewController

-(void)pagePointsWithNumber:(NSInteger)num{

    if (self.pointView == nil) {
        self.pointView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2.f, 44)];
        self.pointView.backgroundColor = CLEAR;
    }
    
    [self.pointView removeAllSubview];
    
    float distance = 12;
    float width = 8;
    
    float xoffset = (self.pointView.width - num * width - ((num - 1) * 12) )/ 2.f;
    
    for (int i = 0; i < num; i++) {
        UIView *point = [UIView new];
        point.backgroundColor = COLORA(143, 143, 143);
        point.width = 8;
        point.height = 8;
        point.top = 18;
        [self.pointView addSubview:point];
        point.left = xoffset;
        xoffset += point.width ;
        
        xoffset += distance;
        [point cycloViewWithBorderWidth:0];
    }
    self.navigationItem.titleView = self.pointView;
}

-(void)updateSelectedPage:(NSInteger)page{
    
    for (UIView *point in self.pointView.subviews) {
        [point setBackgroundColor:self.normalColor];
    }
    UIView *view = (UIView *)self.pointView.subviews[page];
    [view setBackgroundColor:self.selectedColor];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"印刷材料";
    self.selectedColor = COLORA(143, 143, 143);
    self.normalColor = COLORA(210, 210, 210);
    
    
    [self indentiferNavBack];
    self.labelsAry = [@[]mutableCopy];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.paperScrollView];
    [self.view addSubview:self.labelScrollView];
  
    self.view.backgroundColor = WHITE;
    
    NSArray *bookSize = [[YSBookKSize avildKsizeWithRealSize:1] firstObject][@"pageSize"];
    [self updateLabelsWithData:bookSize];
    

    YSSelectedView *selView = [[YSSelectedView alloc]initWithFrame:CGRectMake(0, self.view.height - 64 - 40,self.view.width , 60)];
    selView.selectedDelegate = self;
    [self.view addSubview:selView];
    self.selectedView = selView;
    
    //创建view
    NSArray *array = [YSBookKSize avildKsizeWithRealSize:1];
    NSMutableArray *workAry = [@[]mutableCopy];
    for (NSDictionary *dic in array) {
        [workAry addObject:[dic objectForKey:@"ksize"]];
    }
    [self updatePaperViewWithArray:workAry];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updatePaperViewWithArray:(NSArray *)workAry{

    [self.paperScrollView removeAllSubview];
    float offset = 0;
    for (int i = 0; i < workAry.count; ++i) {
        YSPaperView *paper = [[YSPaperView alloc]initWithFrame:CGRectMake(offset + 26, 0, self.view.width - 52, (self.view.width - 52) * (6.0f / 9))];
        [self.paperScrollView addSubview:paper];
        paper.layer.borderWidth = 4.f;
        paper.layer.borderColor = COLORA(151, 151, 151).CGColor;
        paper.backgroundColor = WHITE;
        [paper showWithkSize:workAry[i]];
        offset += self.view.width;
        self.paperScrollView.contentSize = CGSizeMake(offset,0);
    }
}

-(void)updateLabelsWithData:(NSArray *)data{
    
    [self.labelsAry makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.labelsAry removeAllObjects];
    
    if (self.labelsAry.count == 0) {
        
        float xoffset = 0;
        float yoffset = 10;
        for (int i = 0; i < 10; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(xoffset, yoffset, 100, 0)];
            label.font = [UIFont systemFontOfSize:18];
            label.backgroundColor = CLEAR;
            label.textAlignment = NSTextAlignmentRight;
            label.numberOfLines = 3;
            [self.labelScrollView addSubview:label];
            [self.labelsAry addObject:label];
            label.textColor = COLORA(60, 60, 60);
        }
    }
    
    for (int i = 0; i < self.labelsAry.count; i++) {
        NSString *str = [data objectAtIndex:i];
        NSString *attStr = [str replaceString:@"," withString:@"\n"];
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:attStr];
        NSArray *textAry = [str componentsSeparatedByString:@","];
        if (textAry.count == 2) {
            NSMutableArray *array = [textAry mutableCopy];
            [array addObject:@", "];
            textAry = [array copy];
        }
        NSRange second = [str rangeOfString:textAry[1]];
        NSRange third = [str rangeOfString:textAry[2]];
        [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:second];
        [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:third];
        [att addAttribute:NSForegroundColorAttributeName value:COLORA(148, 148, 148) range:second];
        [att addAttribute:NSForegroundColorAttributeName value:COLORA(233, 85, 5) range:third];
        
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc]init];
        para.lineSpacing = 1.f;
        para.alignment = NSTextAlignmentRight;
        [att addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, att.length)];

        UILabel *label = [self.labelsAry objectAtIndex:i];
        label.attributedText = att;
        [label sizeToFit];
    }
    UILabel *first = [self.labelsAry objectAtIndex:0];
    first.top = 10;
    first.right = self.view.width / 2.f - 40;
    
    UILabel *second = [self.labelsAry objectAtIndex:1];
    second.top = first.top;
    second.right = self.paperScrollView.right - 40;
    
    float xoffset = first.bottom + 5;
    for ( int i = 2; i < self.labelsAry.count; i++) {
        UILabel *label = [self.labelsAry objectAtIndex:i];
        if (i % 2 == 0) {
            label.top = xoffset;
            label.right = first.right;
        }else{
            label.top = xoffset;
            label.right = second.right;
        }
        if (i % 2) {
            xoffset += label.height + 5;
        }
    }
    UILabel *lastLabel = self.labelsAry.lastObject;
    self.labelScrollView.contentSize = CGSizeMake(self.view.width, lastLabel.bottom);
}

-(void)selectedView:(YSSelectedView *)selectedView didSelectedSize:(NSInteger)kSize{
    self.currentKSize = kSize;
    NSArray *bookSize = [[YSBookKSize avildKsizeWithRealSize:kSize] firstObject][@"pageSize"];
    [self updateLabelsWithData:bookSize];
    NSInteger count = [YSBookKSize avildKsizeWithRealSize:kSize].count;
    [self pagePointsWithNumber:count];
    [self updateSelectedPage:0];
    NSArray *array = [YSBookKSize avildKsizeWithRealSize:kSize];
    NSMutableArray *workAry = [@[]mutableCopy];
    for (NSDictionary *dic in array) {
        [workAry addObject:[dic objectForKey:@"ksize"]];
    }
    [self updatePaperViewWithArray:workAry];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x / self.view.width;
    [self updateSelectedPage:currentPage];
    NSArray *bookSize = [YSBookKSize avildKsizeWithRealSize:self.currentKSize][currentPage][@"pageSize"];
    [self updateLabelsWithData:bookSize];
}

-(void)testWebView{
    self.mainWebView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    NSString *urlString = @"http://mp.weixin.qq.com/s?__biz=MjM5MTA2MzM4Nw==&mid=2247483699&idx=1&sn=e29baf88d569ff8f7f7a05a68f31835f&scene=0#wechat_redirect";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self.mainWebView loadRequest:request];
    [self.view addSubview:self.mainWebView];
}

#pragma mark - lazy loading ------

-(YSPaperView *)paperView{
    if (_paperView == nil) {
        _paperView = [[YSPaperView alloc]initWithFrame:CGRectMake(0, 0, self.view.width - 20,(self.view.width - 20) * (6.0f / 9))];
        
    }
    return _paperView;
}

-(UIScrollView *)paperScrollView{

    if (_paperScrollView == nil) {
        _paperScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, (self.view.width - 40) * (6.0f / 9))];
        _paperScrollView.pagingEnabled = YES;
        _paperScrollView.contentInset = UIEdgeInsetsZero;
        _paperScrollView.backgroundColor = WHITE;
        _paperScrollView.delegate = self;
    }
    return _paperScrollView;
}

-(UIScrollView *)labelScrollView{

    if (_labelScrollView == nil) {
        _labelScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.paperScrollView.bottom, self.view.width, self.view.height - self.paperScrollView.bottom - 60 - 64)];
        _labelScrollView.backgroundColor = WHITE;
    }
    return _labelScrollView;
}



@end
