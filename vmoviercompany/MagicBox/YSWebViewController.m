//
//  YSWebViewController.m
//  MagicBox
//
//  Created by 蒋正峰 on 2016/10/16.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSWebViewController.h"
#import "VMovieKit.h"
#import "UIViewController+VMKit.h"

@interface YSWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong, readwrite) UIWebView *mainWeb;
@end

@implementation YSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self indentiferNavBack];
    
    self.mainWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
    [self.view addSubview:self.mainWeb];
    self.mainWeb.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.mainWeb loadRequest:request];
    
    [self.view makeToastActivity];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"关注微信公众号" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 0, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn sizeToFit];
    [btn setTitleColor:COLORA(50, 50, 50) forState:UIControlStateNormal];
    if (self.shouldNotHasRightBar == NO) {
        [self rightNavWithView:btn];
    }
  
//    [self rightNavWithView]
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


-(void)webViewDidStartLoad:(UIWebView *)webView{

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.view hideToastActivity];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.view hideToastActivity];
}

-(void)btnClicked:(id)sender{
    UIPasteboard *past = [UIPasteboard generalPasteboard];
    past.string = @"微信公众号";
    [VMTools alertMessage:@"已成功复制到剪贴板"];
}


@end
