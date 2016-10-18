//
//  YSIndexController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/8.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSIndexController.h"
#import "YSJSQController.h"
#import "YSPaperViewController.h"
#import "UIViewController+VMKit.h"
#import "YSPeopleValueController.h"
#import "YSCoverInputView.h"
#import "YSBookObject.h"

@interface YSIndexController ()
@property (nonatomic, strong, readwrite) UIButton *paperBtn;
@property (nonatomic, strong, readwrite) UIButton *peopleBtn;
@property (nonatomic, strong, readwrite) UIButton *jiSuanQiBtn;
@end

@implementation YSIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self indentiferNavBack];
    
//    self.title = @"书名";
    self.view.backgroundColor = WHITE;
//    [self.view addSubview:self.paperBtn];
//    [self.view addSubview:self.peopleBtn];
    [self.view addSubview:self.jiSuanQiBtn];
    /*
    self.peopleBtn.center = CGPointMake(self.view.width / 2.f, self.view.height / 2.f - 104);
    
    self.paperBtn.center = self.peopleBtn.center;
    self.paperBtn.bottom -= 90;
    
    self.jiSuanQiBtn.center = self.peopleBtn.center;
    self.jiSuanQiBtn.top += 90;
    */
    self.jiSuanQiBtn.center = CGPointMake(self.view.width / 2.f, self.view.height / 2.f - 104);
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"修改名称" forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 100, 30)];
    [rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundColor:CLEAR];
    [rightBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    // Do any additional setup after loading the view.
    
    
    //万事具备之后，辣么，让我们开始来创建一本新书吧！！！
    YSBookObject *bookObj = [[YSBookObject alloc]init];
    bookObj.bookName = [self.title isValid] ? self.title : @"";
    self.bookObject = bookObj;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- button actions ------

-(void)rightBtnClicked:(id)sender{
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
            weakSelf.title = name;
        }
    };
}

-(void)paperBtnClicked:(id)sender{
    YSPaperViewController *paper = [[YSPaperViewController alloc]init];
    [self.navigationController pushViewController:paper animated:YES];
}

-(void)peopleBtnClicked:(id)sender{
    YSPeopleValueController *peopleValue = [[YSPeopleValueController alloc]init];
    [self.navigationController pushViewController:peopleValue animated:YES];
}

-(void)jiSuanQiBtnClicked:(id)sender{

    YSJSQController *jsq = [[YSJSQController alloc]init];
    [self.navigationController pushViewController:jsq animated:YES];
    
}


#pragma mark- lazying actions ------

-(UIButton *)paperBtn{
    if (_paperBtn == nil) {
        _paperBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_paperBtn setTitleColor:COLOR(51, 51, 51, 1) forState:UIControlStateNormal];
        [_paperBtn addTarget:self action:@selector(paperBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_paperBtn setTitle:@"印刷开料" forState:UIControlStateNormal];
        _paperBtn.frame = CGRectMake(0, 0, self.view.width - 140, 50);
        _paperBtn.backgroundColor = COLORA(245, 245, 245);
        _paperBtn.layer.cornerRadius = 4.f;
        _paperBtn.layer.masksToBounds = YES;
    }
    return _paperBtn;
}

-(UIButton *)peopleBtn{
    if (_peopleBtn == nil) {
        _peopleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_peopleBtn setTitleColor:COLOR(51, 51, 51, 1) forState:UIControlStateNormal];
        [_peopleBtn addTarget:self action:@selector(peopleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_peopleBtn setTitle:@"核对工价" forState:UIControlStateNormal];
        _peopleBtn.frame = CGRectMake(0, 0, self.view.width - 140, 50);
        _peopleBtn.backgroundColor = COLORA(245, 245, 245);
        _peopleBtn.layer.cornerRadius = 4.f;
        _peopleBtn.layer.masksToBounds = YES;
    }
    return _peopleBtn;
}

-(UIButton *)jiSuanQiBtn{
    if (_jiSuanQiBtn == nil) {
        _jiSuanQiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jiSuanQiBtn addTarget:self action:@selector(jiSuanQiBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [_jiSuanQiBtn setImage:[UIImage imageNamed:@"suanfa_nor"] forState:UIControlStateNormal];
        [_jiSuanQiBtn setImage:[UIImage imageNamed:@"suanfa_pre"] forState:UIControlStateSelected];
        
        [_jiSuanQiBtn sizeToFit];
        _jiSuanQiBtn.height += 30;
        _jiSuanQiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_jiSuanQiBtn setImageEdgeInsets:UIEdgeInsetsMake(-30, 0, 0, 0)];
        
        UIImage *img = [UIImage imageNamed:@"suanfa_nor"];
        [_jiSuanQiBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_jiSuanQiBtn setTitleColor:COLORA(100, 100, 100) forState:UIControlStateNormal];
        [_jiSuanQiBtn setTitle:@"成本计算器" forState:UIControlStateNormal];
        [_jiSuanQiBtn setTitleEdgeInsets:UIEdgeInsetsMake(img.size.height, 0, 0, 0)];
//        _jiSuanQiBtn.frame = CGRectMake(0, 0, self.view.width - 140, 50);
        _jiSuanQiBtn.backgroundColor = CLEAR;
        _jiSuanQiBtn.layer.cornerRadius = 4.f;
        _jiSuanQiBtn.layer.masksToBounds = YES;
        
        [self verticalImageAndTitle:4 button:_jiSuanQiBtn];
    }
    return _jiSuanQiBtn;
}

- (void)verticalImageAndTitle:(CGFloat)spacing button:(UIButton *)btn
{
    btn.titleLabel.backgroundColor = CLEAR;
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize textSize = [btn.titleLabel.text sizeWithFont:btn.titleLabel.font];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}


@end
