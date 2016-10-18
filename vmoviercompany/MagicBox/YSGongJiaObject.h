//
//  YSGongJiaObject.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/9/4.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kBOOKGONGJIA @"kBOOKGONGJIA"
#define kSTANDBOOKGONGJIA @"kSTANDBOOKGONGJIA"


typedef void(^GongJiaCompleteBlock)(NSString *mainID);

@interface YSGongJiaObject : NSObject


@property (nonatomic, strong, readwrite) NSString *mainID;

//印刷工价
@property (nonatomic, strong, readwrite) NSString *danSe;
@property (nonatomic, strong, readwrite) NSString *shuangSe;
@property (nonatomic, strong, readwrite) NSString *siSe;
@property (nonatomic, strong, readwrite) NSString *shaiShangBan;

//普通装订工价
@property (nonatomic, strong, readwrite) NSString *sixteenQiMa;
@property (nonatomic, strong, readwrite) NSString *sixteenTieSiPing;
@property (nonatomic, strong, readwrite) NSString *sixteenJiao;
@property (nonatomic, strong, readwrite) NSString *sixteenSuoJiao;

@property (nonatomic, strong, readwrite) NSString *eighteenQiMa;
@property (nonatomic, strong, readwrite) NSString *eighteenTieSiPing;
@property (nonatomic, strong, readwrite) NSString *eighteenJiao;
@property (nonatomic, strong, readwrite) NSString *eighteenSuoJiao;


//精装工价
@property (nonatomic, strong, readwrite) NSString *zhuangDing;
@property (nonatomic, strong, readwrite) NSString *shangFeng;
@property (nonatomic, strong, readwrite) NSString *duTouBu;
@property (nonatomic, strong, readwrite) NSString *heLanBan;
@property (nonatomic, strong, readwrite) NSString *huanChen;
@property (nonatomic, strong, readwrite) NSString *yuanJi;

//工艺
@property (nonatomic, strong, readwrite) NSString *guangMo;
@property (nonatomic, strong, readwrite) NSString *yaMo;
@property (nonatomic, strong, readwrite) NSString *UV;
@property (nonatomic, strong, readwrite) NSString *moSha;
@property (nonatomic, strong, readwrite) NSString *qiGu;
@property (nonatomic, strong, readwrite) NSString *tangJin;
@property (nonatomic, strong, readwrite) NSString *tangJinBanChuPian;
@property (nonatomic, strong, readwrite) NSString *tieBiao;
@property (nonatomic, strong, readwrite) NSString *suFeng;

+(YSGongJiaObject *)standGongJia;

+(YSGongJiaObject *)gongJiaWithID:(NSString *)gongJiaID;


-(void)loadByDefaultValues;
-(NSArray *)loadStandGongJiaPrics;
-(NSArray *)loadFromDB;

-(void)saveStandGongJia;
-(void)saveBookGongJia;

@end
