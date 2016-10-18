//
//  YSBookObject.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/18.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSGongJiaObject.h"

#define kBOOKTABLE @"YSBOOKS"

@interface YSBookObject : NSObject


@property (nonatomic, strong, readwrite) YSGongJiaObject *bookGongJia;
@property (nonatomic, strong, readwrite) NSString *gongJiaId;

//id信息，完全是打酱油的信息
@property (nonatomic, strong, readwrite) NSString *mainID;

@property (nonatomic, strong, readwrite) NSString *finalyMoney; //总成本

//base信息
@property (nonatomic, strong, readwrite) NSString *bookName;        //书名
@property (nonatomic, strong, readwrite) NSString *kSize;           //开本
@property (nonatomic, strong, readwrite) NSString *quanKaiSize;     //用纸尺寸
@property (nonatomic, strong, readwrite) NSString *bookSize;        //书的尺寸
@property (nonatomic, strong, readwrite) NSString *workPraise;      //书的定价

@property (nonatomic, strong, readwrite) NSString *yinzhangNum;     //印张
@property (nonatomic, strong, readwrite) NSString *yinLiangNum;     //印量

@property (nonatomic, strong, readwrite) NSString *zhuangDingWay;   //装订方式
@property (nonatomic, strong, readwrite) NSString *dingJiaNum;      //定价

//纸张信息
@property (nonatomic, strong, readwrite) NSString *zwquanKaiChiCun;
@property (nonatomic, strong, readwrite) NSString *zwyongZhiNum;
@property (nonatomic, strong, readwrite) NSString *zwkezhongNum;
@property (nonatomic, strong, readwrite) NSString *zwMoney;

@property (nonatomic, strong, readwrite) NSString *zwDunMoney;

@property (nonatomic, strong, readwrite) NSString *fmyongZhiNum;
@property (nonatomic, strong, readwrite) NSString *fmKsize;
@property (nonatomic, strong, readwrite) NSString *fmkezhongNum;
@property (nonatomic, strong, readwrite) NSString *fmMoney;
@property (nonatomic, strong, readwrite) NSString *fmDunMoney;

//稿酬费用
@property (nonatomic, strong, readwrite) NSString *bansuiLV;
@property (nonatomic, strong, readwrite) NSString *bansuiGaoChou;
@property (nonatomic, strong, readwrite) NSString *zishu;
@property (nonatomic, strong, readwrite) NSString *yuanqianzi;
@property (nonatomic, strong, readwrite) NSString *jibenGaoChou;
@property (nonatomic, strong, readwrite) NSString *jibenfeiLV;
@property (nonatomic, strong, readwrite) NSString *yinshuGaoChou;
@property (nonatomic, strong, readwrite) NSString *qitaGaoChouFeiYong;
@property (nonatomic, strong, readwrite) NSString *yicixingGaoChou;

//设计费用
@property (nonatomic, strong, readwrite) NSString *shejifeizwShuLiang;
@property (nonatomic, strong, readwrite) NSString *shejifeizwDanJia;
@property (nonatomic, strong, readwrite) NSString *shejifeizwQiTa;
@property (nonatomic, strong, readwrite) NSString *shejifeizwJinE;

@property (nonatomic, strong, readwrite) NSString *shejifeifmShuLiang;
@property (nonatomic, strong, readwrite) NSString *shejifeifmDanJia;
@property (nonatomic, strong, readwrite) NSString *shejifeifmQiTa;
@property (nonatomic, strong, readwrite) NSString *shejifeifmJinE;

//印刷装订
@property (nonatomic, strong, readwrite) NSString *zdDuiKai;
@property (nonatomic, strong, readwrite) NSString *zdNeiWenSeShu;
@property (nonatomic, strong, readwrite) NSString *zdFengMianSeShu;
@property (nonatomic, strong, readwrite) NSString *zdFengMianShiFouShuangYe;
@property (nonatomic, strong, readwrite) NSString *zdFengMianDiJia;
@property (nonatomic, strong, readwrite) NSString *zdShiFouSuFeng;

@property (nonatomic, strong, readwrite) NSString *yinShuaMoney;
@property (nonatomic, strong, readwrite) NSString *zdMoney;


@property (nonatomic, strong, readwrite) NSString *zwCTPMoney;
@property (nonatomic, strong, readwrite) NSString *zwYinShuaMoney;
@property (nonatomic, strong, readwrite) NSString *fmCTPMoney;
@property (nonatomic, strong, readwrite) NSString *fmYinShuaMoney;



//工艺相关
@property (nonatomic, strong, readwrite) NSString *guangMo;
@property (nonatomic, strong, readwrite) NSString *yaMo;
@property (nonatomic, strong, readwrite) NSString *UV;
@property (nonatomic, strong, readwrite) NSString *moSha;
@property (nonatomic, strong, readwrite) NSString *qiTuYaAo;
@property (nonatomic, strong, readwrite) NSString *yaWen;
@property (nonatomic, strong, readwrite) NSString *uvMoShaChuPian;
@property (nonatomic, strong, readwrite) NSString *tangJinBanChuPian;
@property (nonatomic, strong, readwrite) NSString *tangJin;
@property (nonatomic, strong, readwrite) NSString *tieBiao;
@property (nonatomic, strong, readwrite) NSString *suFeng;
@property (nonatomic, strong, readwrite) NSString *gongYiHuiZong;


@property (nonatomic, strong, readwrite) NSString *gongYiMoney;

//其他费用
@property (nonatomic, strong, readwrite) NSString *guanLiChengBen;
@property (nonatomic, strong, readwrite) NSString *bianluJingfei;

@property (nonatomic, strong, readwrite) NSString *qitaMoney;

//发货退货
@property (nonatomic, strong, readwrite) NSString *xiaoshouZheKou;
@property (nonatomic, strong, readwrite) NSString *faxingFei;
@property (nonatomic, strong, readwrite) NSString *tuiHuoLV;

@property (nonatomic, strong, readwrite) NSString *faHuoTuiHuoMoney;
@property (nonatomic, strong, readwrite) NSString *xiaoShouShiYangMoney;



+(YSBookObject *)createNewBook;
+(YSBookObject *)bookFrom:(NSDictionary *)info;
-(NSDictionary *)bookInfoToDictionary;
-(NSDictionary *)bookTableDictionary;
-(void)bookLoadInfoFromDic:(NSDictionary *)dic;
-(void)saveCurrentBook;


@end
