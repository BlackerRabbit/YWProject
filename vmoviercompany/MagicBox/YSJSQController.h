//
//  YSJSQController.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/7.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSBookObject.h"

@interface YSJSQController : UIViewController

@property (nonatomic, strong, readwrite) YSBookObject *currentBook;
//从基本里面拿数据
-(void)getValueFromBaseInfo:(NSString *)value;



-(void)getNumberFromPaper:(NSInteger)number;
-(void)getNumberFromGaoChou:(NSInteger)number;

-(void)getPlaceHolderInfoFromGaoChou:(NSString *)gaochou;

-(void)getValueFromSheJiFei:(NSString *)value;

-(void)getValueFromYinShuaZhuangDing:(NSString *)value;


-(void)getValueFromGongYi:(NSString *)value;

-(void)getValueFromQiTa:(NSString *)value;

-(void)getValueFromFaHuoTuiHuo:(NSString *)value;
@end
