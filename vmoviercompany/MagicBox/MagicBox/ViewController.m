//
//  ViewController.m
//  MagicBox
//
//  Created by 蒋正峰 on 15/11/2.
//  Copyright © 2015年 蒋正峰. All rights reserved.
//
#import "ViewController.h"

#import <MBProgressHUD.h>
#import <AFNetworking.h>
#import <QuartzCore/QuartzCore.h>

#define kRequestPort @"http://service.test.vmovier.com/Magicapi/Test/testForYe"




@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataAry;
@property (nonatomic, strong) NSMutableArray *selectedCell;
@property (nonatomic, strong) NSMutableArray *requestAry;
@property (nonatomic, strong) NSMutableDictionary *paramDic;
@property (nonatomic, strong) AFHTTPRequestOperation *current;
@property (nonatomic, strong) NSMutableArray *operationAry;

@property (nonatomic, strong) NSMutableDictionary *operationDic;
@property (nonatomic, strong) NSMutableDictionary *uploadDic;
@property (nonatomic, strong) NSMutableDictionary *operationDic2;
@property (nonatomic, strong) NSMutableDictionary *operationDic3;

@property (nonatomic, assign) NSInteger operation1;
@property (nonatomic, assign) NSInteger operation2;
@property (nonatomic, assign) NSInteger operation3;

@property (nonatomic, assign) NSInteger operationImg;
@property (nonatomic, assign) BOOL canCancle;

@property (nonatomic, strong) UITextView  *logTextView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _operationAry = [@[]mutableCopy];
    _operationDic = [@{}mutableCopy];
    _uploadDic = [@{}mutableCopy];
    _operationDic2 = [@{}mutableCopy];
    _operationDic3 = [@{}mutableCopy];
    
    
    _dataAry = [@[]mutableCopy];
    _selectedCell = [@[]mutableCopy];
    _requestAry = [@[]mutableCopy];
    _paramDic = [@{}mutableCopy];
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width / 2 , self.view.height) style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    //[self.view addSubview:self.mainTableView];
    
    self.logTextView = [[UITextView alloc]initWithFrame:CGRectMake(self.mainTableView.right, 0, self.view.width/2, self.view.height)];
    self.logTextView.userInteractionEnabled = NO;
    self.logTextView.backgroundColor = [UIColor lightGrayColor];
    self.logTextView.textColor = [UIColor blackColor];
    [self.view addSubview:self.logTextView];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = CGRectMake(0, 0, 50, 30);
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addBtn setTitle:@"add" forState:UIControlStateNormal];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn addTarget:self action:@selector(sendAllBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    sendBtn.frame = CGRectMake(0, 0, 60, 30);
    [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendBtn setTitle:@"sendAll" forState:UIControlStateNormal];
    
    UIBarButtonItem *addBar = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    UIBarButtonItem *sendBar = [[UIBarButtonItem alloc]initWithCustomView:sendBtn];
    [self.navigationItem setRightBarButtonItems:@[addBar,sendBar]];
    
    float offset = 20;
    for (int i = 0; i < 8; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor darkGrayColor]];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        NSString *btnTitle;
        switch (i) {
            case 0:btnTitle = @"post";break;
            case 1:btnTitle = @"cancle post";break;
            case 2:btnTitle = @"post image";break;
            case 3:btnTitle = @"cancle image";break;
            case 4:btnTitle = @"post1";break;
            case 5:btnTitle = @"cancle post1";break;
            case 6:btnTitle = @"post2";break;
            case 7:btnTitle = @"cancle post2";break;
                
            default:
                break;
        }
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        btn.tag = i;
        btn.width = 130;
        btn.height = 30;
        btn.top = offset;
        btn.left = 20;
        offset += 45;
        [self.view addSubview:btn];
 
    }
}


-(void)btnClicked:(UIButton *)sender{
    
    switch (sender.tag) {
        case 0:{
            self.operation1++;
        
            NSString *key = [NSString stringWithFormat:@"%ld",(long)self.operation1];
            
            [VMRequestHelper requestPostURL:@"Test/testForYe"
                                  paramDict:@{@"long":@"40"}
                           withOperationKey:key
                        operationDictionary:self.operationDic
                              completeBlock:^(id vmRequest, id responseObj) {
                                  [self.operationDic removeObjectForKey:key];
                                  self.logTextView.text = [NSString jsonStringFrom:responseObj];
                              } errorBlock:^(VMError *error) {
                                  [self.operationDic removeObjectForKey:key];
                                  self.logTextView.text = error.errorReason;
                                  
                              }];
            self.logTextView.text = @"test/testforye?long=40";
        }break;
        case 1:{
            
            
            NSArray *array = self.operationDic.allKeys;
            NSString *key;
            if (array.count > 0 ) {
                key = array[0];
                [VMRequestHelper cancleOperation:self.operationDic[key]];
                self.logTextView.text = @"operation 被取消了";
                [self.operationDic removeObjectForKey:key];
            }else
                self.logTextView.text = @"啊，已经没有operation可以取消了";
        
        }break;
        case 2:{
            
            self.operationImg++;
            /*
            NSDate *date = [NSDate date];
            NSString *str = [NSString stringWithFormat:@"%@%ld",date,sender.tag];
             */
            NSString *str = [NSString stringWithFormat:@"%ld",(long)self.operationImg];
            UIImage *img = [UIImage imageNamed:@"ahaha.jpg"];
            NSData *data = UIImageJPEGRepresentation(img, 0.7);
            
            [VMRequestHelper requestPostURL:@"Test/testForYe"
                                  paramDict:@{@"long":@"1",@"test_img":data}
                                   withFile:YES
                           withOperationKey:str
                        operationDictionary:self.uploadDic
                              completeBlock:^(id vmRequest, id responseObj) {
                
                self.logTextView.text = [NSString jsonStringFrom:responseObj];
                                  [self.operationDic removeObjectForKey:str];
            } errorBlock:^(VMError *error) {
                [self.operationDic removeObjectForKey:str];
                self.logTextView.text = error.errorReason;

            }];
                 self.logTextView.text = [NSString stringWithFormat:@"%@",data];
        }break;
        case 3:{
            
            NSArray *array = self.uploadDic.allKeys;
            if (array.count > 0) {
                NSString *str = array[0];
                [VMRequestHelper cancleOperation:self.uploadDic[str]];
                [self.uploadDic removeObjectForKey:str];
                self.logTextView.text = [NSString stringWithFormat:@"上传被取消了，我去啊。。"];
            }else
                self.logTextView.text = @"我去啊，已经没有上传的请求可以被取消了";
        }break;
            
        case 4:{
            /*
            NSDate *date = [NSDate date];
            NSString *str = [NSString stringWithFormat:@"%@%ld",date,sender.tag];
             */
            self.operation2++;
            NSString *str = [NSString stringWithFormat:@"%ld",(long)self.operation2];
            [VMRequestHelper requestPostURL:@"Test/testForYe"
                                  paramDict:@{@"long":@"10"}
                           withOperationKey:str
                        operationDictionary:self.operationDic2
                              completeBlock:^(id vmRequest, id responseObj) {
                                  [self.operationDic2 removeObjectForKey:str];
                                  self.logTextView.text = [NSString jsonStringFrom:responseObj];
                              } errorBlock:^(VMError *error) {
                                  [self.operationDic2 removeObjectForKey:str];
                                  self.logTextView.text = error.errorReason;
                                  
                              }];
            self.logTextView.text = @"test/testforye?long=10";
        }break;
        case 5:{
            
            
            NSArray *array = self.operationDic2.allKeys;
            if (array.count > 0) {
                NSString *key = array[0];
                [VMRequestHelper cancleOperation:self.operationDic2[key]];
                [self.operationDic2 removeObjectForKey:key];
                self.logTextView.text = @"operation 被取消了";

            }else
                self.logTextView.text = @"已经木有operation可以被取消了";
            
        }break;
        case 6:{
            /*
            NSDate *date = [NSDate date];
            NSString *str = [NSString stringWithFormat:@"%@%ld",date,sender.tag];
             */
            self.operation3++;
            NSString *str = [NSString stringWithFormat:@"%ld",(long)self.operation3];
            [VMRequestHelper requestPostURL:@"Test/testForYe"
                                  paramDict:@{@"long":@"5"}
                           withOperationKey:str
                        operationDictionary:self.operationDic3
                              completeBlock:^(id vmRequest, id responseObj) {
                                  [self.operationDic3 removeObjectForKey:str];
                                  self.logTextView.text = [NSString jsonStringFrom:responseObj];
                              } errorBlock:^(VMError *error) {
                                  [self.operationDic3 removeObjectForKey:str];
                                  self.logTextView.text = error.errorReason;
                                  
                              }];
            self.logTextView.text = @"test/testforye?long=5";
        }break;
        case 7:{
            
            NSArray *array = [self.operationDic3 allKeys];
            if (array.count) {
                NSString *str = [array objectAtIndex:0];
                [VMRequestHelper cancleOperation:self.operationDic3[str]];
                [self.operationDic3 removeObjectForKey:str];
                self.logTextView.text = @"operation 被取消了";
            }else
                self.logTextView.text = @"啊哈哈哈，已经没有operation可以被取消啦！！！！";
        }break;
            
        default:
            break;
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-
#pragma mark------tableview delegate------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellReuseIdentifer = @"cellReuseIdentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifer];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sendBtn addTarget:self action:@selector(sendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        sendBtn.frame = CGRectMake(tableView.frame.size.width - 60, 7, 60, 30);
        sendBtn.tag = 30003;
        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:sendBtn];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
  }

-(void)selectedBtnClicked:(id)sender{

    
}

-(void)sendBtnClicked:(id)sender{
    UIButton *btn = (UIButton *)sender;
    
    BOOL findCell = NO;
    UIView *temp = btn;
    while (!findCell) {
        UIView *view = temp.superview;
        if ([[view class]isSubclassOfClass:[UITableViewCell class]]) {
            findCell = YES;
        }
        temp = view;
    }
    UITableViewCell *cell = (UITableViewCell *)temp;
    NSIndexPath *path = [self.mainTableView indexPathForCell:cell];
    
    
    if ([btn.titleLabel.text isEqualToString:@"cancle"]) {

        [VMRequestHelper cancleOperation:self.operationDic[[NSString stringWithFormat:@"%ld",(long)path.row]]];
        self.canCancle = NO;
        [btn setTitle:@"发送" forState:UIControlStateNormal];
        [self.operationDic removeObjectForKey:@(path.row)];
        return;
    }
    self.canCancle = YES;
    [btn setTitle:@"cancle" forState:UIControlStateNormal];
    

    NSDictionary *dic = [_dataAry objectAtIndex:path.row];
    [VMRequestHelper requestPostURL:@"Test/testForYe" paramDict:dic[@"dic"] withOperationKey:[NSString stringWithFormat:@"%ld",(long)path.row] operationDictionary:self.operationDic
                      completeBlock:^(id vmRequest, id responseObj) {
                          
                      } errorBlock:^(VMError *error) {
                          
                      }];
    
}

-(void)addBtnClicked:(id)sender{
   

}

-(void)sendAllBtnClicked:(id)sender{
}





@end
