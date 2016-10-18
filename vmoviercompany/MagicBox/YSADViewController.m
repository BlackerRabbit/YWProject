//
//  YSADViewController.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/9/17.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSADViewController.h"
#import <UIImageView+WebCache.h>
#import "VMovieKit.h"
#import "VMRequestHelper.h"
#import "YSWebViewController.h"

@interface YSADViewController ()
@property (nonatomic, strong, readwrite) UIImageView *mainImg;
@property (nonatomic, strong, readwrite) NSTimer *timer;
@property (nonatomic, strong, readwrite) NSString *adString;

@property (nonatomic, strong, readwrite) UIButton *skipBtn;
@property (nonatomic, strong, readwrite) VMTimerLabel *timeLabel;

@end

@implementation YSADViewController

-(void)dealloc{
    NSLog(@"YSADViewController dealloc");
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    if (self.timeLabel) {
        [self.timeLabel startTimer];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainImg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.mainImg];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainImgTapped:)];
    self.mainImg.userInteractionEnabled = YES;
    [self.mainImg addGestureRecognizer:tap];
    
    self.skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [self.skipBtn addTarget:self action:@selector(skipBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.skipBtn setFrame:CGRectMake(0, 0, 70, 40)];
    [self.skipBtn setBackgroundColor:CLEAR];
    self.skipBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.skipBtn setTitleColor:COLOR(100, 100, 100, 1) forState:UIControlStateNormal];
    self.skipBtn.right = self.view.width - 20;
    self.skipBtn.top = 64;
    [self.view addSubview:self.skipBtn];
    
    WEAKSELF;
    self.timeLabel = [[VMTimerLabel alloc]initWithFrame:CGRectMake(30, 64, 20, 20)];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = COLORA(100, 100, 100);
    self.timeLabel.beginNum = 0;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.endNum = 5;
    self.timeLabel.jumpNum = 1;
    [self.timeLabel cycloViewWithBorderWidth:0.5];
    self.timeLabel.center = self.skipBtn.center;
    self.timeLabel.bottom = self.skipBtn.top - 5;
    self.timeLabel.block = ^(){
        [weakSelf removeAD];
    };
    
    
    [self.view addSubview:self.timeLabel];
    
    NSDictionary *dic = @{@"page.pageNo":@"1",@"page.pageSize":@"10"};
    [VMRequestHelper requestPostURL:@"anon/ad-list" paramDict:dic completeBlock:^(id vmRequest, id responseObj) {
        NSInteger code = [responseObj[@"code"] integerValue];
        if (code != 0) {
            [self removeAD];
            return ;
        }
        NSString *photo = responseObj[@"result"][@"list"][0][@"photo"];
        self.adString = responseObj[@"result"][@"list"][0][@"adUrl"];
        [self.mainImg sd_setImageWithURL:[NSURL URLWithString:photo]];
    } errorBlock:^(VMError *error) {
        [self removeAD];
    }];
}

-(void)mainImgTapped:(UITapGestureRecognizer *)tap{
    if ([self.adString isValid] == NO) {
        return;
    }
    [self.timeLabel pauseTimer];
    YSWebViewController *web = [[YSWebViewController alloc]init];
    web.url = self.adString;
    web.shouldNotHasRightBar = YES;
    [self.navigationController pushViewController:web animated:YES];
}


-(void)removeAD{
    [self.navigationController.view removeFromSuperview];
    [self.navigationController removeFromParentViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)skipBtnClicked:(id)sender{
    [self removeAD];
}

-(void)ADViewControllerRequestWithResultBlock:(ADViewShouldShowBlock)block{
    if (block) {
        
    }
    //首先是向接口请求数据，如果有数据，则进入请求图片的流程，如果没有数据，则直接跳过ad页面。
}

-(void)getImageWithURL:(NSString *)URL withCompleteBlock:(ADViewFindImageCompleteBlock)block{

    //首先根据url在本地查找相关的图片和链接信息。
    NSString *sugestName = [[URL componentsSeparatedByString:@"/"] lastObject];
    NSString *filePath = [[VMTools documentPath] stringByAppendingPathComponent:@"images"];
    NSString *imgPath = [filePath stringByAppendingPathComponent:sugestName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL fileExist = [manager fileExistsAtPath:imgPath];
    if (fileExist) {
        UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
        if (block) {
            block(image, imgPath, nil);
        }
    }else{
        UIImage *image = [UIImage imageWithURL:URL timeOut:5];
        NSData *imgData = [NSData dataWithContentOfURL:URL timeOut:5 withError:nil];
        
        if (image) {
            //将图片保存到本地目录，并用url作为文件名
            
            BOOL fileExist = [manager fileExistsAtPath:filePath];
            if (!fileExist) {
                [manager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            [imgData writeToFile:[filePath stringByAppendingPathComponent:sugestName] atomically:YES];
            if (block) {
                block(image, imgPath, nil);
            }
        }else{
            VMError *error = [[VMError alloc]init];
            error.errorCode = kVMRequestFail;
            error.errorReason = @"图片下载失败";
            block(nil, nil, error);
        }
    }
}

-(UIImageView *)mainImg{
    if (_mainImg == nil) {
        _mainImg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    }
    return _mainImg;
}



@end
