//
//  YSBookObject.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/18.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSBookObject.h"
/*
@"NAME":@"",
@"KSIZE":@"",
@"BOOKSIZE":@"",
@"WORKERPRICE":@""
*/

#import "VMovieKit.h"




#define kBOOKNAME @"NAME"
#define kKSIZE @"kSIZE"
#define kBOOKSIZE @"BOOKSIZE"
#define kWORKPRICE @"WORKPRICE"

@interface YSBookObject ()
@property (nonatomic, strong, readwrite) VMDataBaseManager *dbManager;
@end

@implementation YSBookObject

-(id)init{
    self = [super init];
    if (self) {
        self.finalyMoney = @"0";
        
        self.bookName = @"";
        self.quanKaiSize = @"889x1194";
        self.bookSize = @"147x210";
        self.kSize = @"32";
        self.dingJiaNum = @"45";
        self.yinzhangNum = @"8";
        self.yinLiangNum = @"8000";
        self.zhuangDingWay = @"锁线胶订";
        
        //用纸
        self.zwkezhongNum = @"";
        self.fmkezhongNum = @"";
        self.zwMoney = @"0";
        self.fmMoney = @"0";
        self.zwDunMoney = @"6000";
        self.fmDunMoney = @"6000";
        
        //印刷
        self.zwCTPMoney = @"0";
        self.zwYinShuaMoney = @"0";
        self.fmCTPMoney = @"0";
        self.fmYinShuaMoney = @"0";
        
        //工艺
        self.guangMo = @"否";
        self.yaMo= @"否";
        self.UV = @"否";
        self.moSha = @"否";
        self.qiTuYaAo = @"否";
        self.yaWen = @"否";
        self.uvMoShaChuPian = @"否";
        self.tangJinBanChuPian = @"否";
        self.tangJin = @"";
        self.gongYiHuiZong = @"";
        self.tieBiao = @"否";
        self.suFeng = @"否";
        
        self.xiaoShouShiYangMoney = @"0";
        
        self.gongJiaId = @"-1";
        
        self.dbManager = [VMDataBaseManager shareDBManager];
        if (![self.dbManager hasTable:kBOOKTABLE]) {
            [self.dbManager createTable:kBOOKTABLE withInfo:[self bookTableDictionary]];
        }else{
            [self.dbManager getInfoFromTable:kBOOKTABLE];
        }
    }
    return self;
}

+(YSBookObject *)createNewBook{
    YSBookObject *neBook = [[YSBookObject alloc]init];
    neBook.bookGongJia = [YSGongJiaObject standGongJia];
    neBook.gongJiaId = neBook.bookGongJia.mainID;
    return neBook;
}

+(YSBookObject *)bookFrom:(NSDictionary *)info{
    if (info == nil) {
        return nil;
    }
    YSBookObject *bookObj = [[YSBookObject alloc]init];
    bookObj.bookName = info[kBOOKNAME];
    bookObj.bookSize = info[kBOOKSIZE];
    bookObj.kSize = info[kKSIZE];
    bookObj.workPraise = info[kWORKPRICE];
    return bookObj;
}

-(NSDictionary *)bookInfoToDictionary{
    
    NSDictionary *bookInfo = @{
                               kBOOKNAME:self.bookName,
                               kBOOKSIZE:self.bookSize,
                               kKSIZE:self.kSize,
                               kWORKPRICE:self.workPraise
                               };
    return bookInfo;
}

-(void)bookLoadInfoFromDic:(NSDictionary *)dic{
    if (dic == nil || dic.count == 0) {
        return;
    }
    self.mainID = dic[@"ID"];
    self.finalyMoney = dic[@"book_finalyMoney"];
    self.bookName = dic[@"book_name"];
    self.kSize = dic[@"book_ksize"];
    self.quanKaiSize = dic[@"book_quanKaisize"];
    self.bookSize = dic[@"book_size"];
    self.workPraise = dic[@"book_price"];
    self.yinzhangNum = dic[@"yinzhangNum"];
    self.yinLiangNum = dic[@"yinLiangNum"];
    self.zhuangDingWay = dic[@"zhuangDingWay"];
    self.dingJiaNum = dic[@"dingJiaNum"];
    self.zwyongZhiNum = dic[@"zwyongZhiNum"];
    self.zwkezhongNum = dic[@"zwkezhongNum"];
    self.zwMoney = dic[@"zwMoney"];
    self.zwDunMoney = dic[@"zwDunMoney"];
    self.fmyongZhiNum = dic[@"fmyongZhiNum"],
    self.fmKsize = dic[@"fmKsize"],
    self.fmkezhongNum = dic[@"fmkezhongNum"],
    self.fmMoney = dic[@"fmMoney"],
    self.fmDunMoney = dic[@"fmDunMoney"];
    self.bansuiLV = dic[@"bansuiLV"],
    self.bansuiGaoChou = dic[@"bansuiGaoChou"],
    self.zishu = dic[@"zishu"],
    self.yuanqianzi = dic[@"yuanqianzi"],
    self.jibenGaoChou = dic[@"jibenGaoChou"],
    self.yuanqianzi = dic[@"yuanqianzi"],
    self.jibenfeiLV = dic[@"jibenfeiLV"],
    self.yinshuGaoChou = dic[@"yinshuGaoChou"],
    self.qitaGaoChouFeiYong = dic[@"qitaGaoChouFeiYong"],
    self.yicixingGaoChou = dic[@"yicixingGaoChou"],
    self.shejifeizwShuLiang = dic[@"shejifeizwShuLiang"],
    self.shejifeizwDanJia = dic[@"shejifeizwDanJia"],
    self.shejifeizwQiTa = dic[@"shejifeizwQiTa"],
    self.shejifeizwJinE = dic[@"shejifeizwJinE"],
    self.shejifeifmShuLiang = dic[@"shejifeifmShuLiang"],
    self.shejifeifmDanJia = dic[@"shejifeifmDanJia"],
    self.shejifeifmQiTa = dic[@"shejifeifmQiTa"],
    self.shejifeifmJinE = dic[@"shejifeifmJinE"],
    self.zdDuiKai = dic[@"zdDuiKai"],
    self.zdNeiWenSeShu = dic[@"zdNeiWenSeShu"],
    self.zdFengMianSeShu = dic[@"zdFengMianSeShu"],
    self.zdFengMianShiFouShuangYe = dic[@"zdFengMianShiFouShuangYe"],
    self.zdFengMianDiJia = dic[@"zdFengMianDiJia"],
    self.zdShiFouSuFeng = dic[@"zdShiFouSuFeng"],
    self.zdMoney = dic[@"zdMoney"];
    self.yinShuaMoney = dic[@"yinShuaMoney"];
    self.zwCTPMoney = dic[@"zwCTPMoney"];
    self.zwYinShuaMoney = dic[@"zwYinShuaMoney"];
    self.fmCTPMoney = dic[@"fmCTPMoney"];
    self.fmYinShuaMoney = dic[@"fmYinShuaMoney"];
    
    
    
    
    
    self.guangMo = dic[@"guangMo"],
    self.yaMo = dic[@"yaMo"],
    self.UV = dic[@"UV"],
    self.moSha = dic[@"moSha"],
    self.qiTuYaAo = dic[@"qiTuYaAo"],
    self.yaWen = dic[@"yaWen"],
    self.uvMoShaChuPian = dic[@"uvMoShaChuPian"],
    self.tangJinBanChuPian = dic[@"tangJinBanChuPian"],
    self.tangJin = dic[@"tangJin"],
    self.gongYiHuiZong = dic[@"gongYiHuiZong"],
    self.suFeng = dic[@"suFeng"],
    self.gongYiMoney = dic[@"gongYiMoney"];
    
    self.guanLiChengBen = dic[@"guanLiChengBen"],
    self.bianluJingfei = dic[@"bianluJingfei"],
    self.qitaMoney = dic[@"qitaMoney"];
    
    self.xiaoshouZheKou = dic[@"xiaoshouZheKou"],
    self.tuiHuoLV = dic[@"tuiHuoLV"];
    self.faHuoTuiHuoMoney = dic[@"faHuoTuiHuoMoney"];
    self.xiaoShouShiYangMoney = dic[@"xiaoShouShiYangMoney"];
    
    self.gongJiaId = dic[@"gongJiaId"];
    
    if ([self.gongJiaId isValid] && ![self.gongJiaId isEqualToString:@"-1"]) {
        self.bookGongJia;
    }
    
    
}




-(NSDictionary *)bookTableDictionary{
    
    return @{
             @"book_name":[self.bookName isValid]?self.bookName:@"",
             @"book_finalyMoney":[self.finalyMoney isValid]?self.finalyMoney:@"",
             @"book_ksize":[self.kSize isValid]?self.kSize:@"",
             @"book_quanKaisize":[self.quanKaiSize isValid]?self.quanKaiSize:@"",
             @"book_size":[self.bookSize isValid]?self.bookSize:@"",
             @"book_price":[self.workPraise isValid]?self.workPraise:@"",
             @"yinzhangNum":[self.yinzhangNum isValid]?self.yinzhangNum:@"",
             @"yinLiangNum":[self.yinLiangNum isValid]?self.yinLiangNum:@"",
             @"zhuangDingWay":[self.zhuangDingWay isValid]?self.zhuangDingWay:@"",
             @"dingJiaNum":[self.dingJiaNum isValid]?self.dingJiaNum:@"",
             @"zwyongZhiNum":[self.zwyongZhiNum isValid]?self.zwyongZhiNum:@"",
             @"zwkezhongNum":[self.zwkezhongNum isValid]?self.zwkezhongNum:@"",
             @"zwMoney":[self.zwMoney isValid]?self.zwMoney:@"",
             @"zwDunMoney":[self.zwDunMoney isValid]?self.zwDunMoney:@"",
             @"fmyongZhiNum":[self.fmyongZhiNum isValid]?self.fmyongZhiNum:@"",
             @"fmKsize":[self.fmKsize isValid]?self.fmKsize:@"",
             @"fmkezhongNum":[self.fmkezhongNum isValid]?self.fmkezhongNum:@"",
             @"fmMoney":[self.fmMoney isValid]?self.fmMoney:@"",
             @"fmDunMoney":[self.fmDunMoney isValid]?self.fmDunMoney:@"",
             @"bansuiLV":[self.bansuiLV isValid]?self.bansuiLV:@"",
             @"bansuiGaoChou":[self.bansuiGaoChou isValid]?self.bansuiGaoChou:@"",
             @"zishu":[self.zishu isValid]?self.zishu:@"",
             @"yuanqianzi":[self.yuanqianzi isValid]?self.yuanqianzi:@"",
             @"jibenGaoChou":[self.jibenGaoChou isValid]?self.jibenGaoChou:@"",
             @"yuanqianzi":[self.yuanqianzi isValid]?self.yuanqianzi:@"",
             @"jibenfeiLV":[self.jibenfeiLV isValid]?self.jibenfeiLV:@"",
             @"yinshuGaoChou":[self.yinshuGaoChou isValid]?self.yinshuGaoChou:@"",
             @"qitaGaoChouFeiYong":[self.qitaGaoChouFeiYong isValid]?self.qitaGaoChouFeiYong:@"",
             @"yicixingGaoChou":[self.yicixingGaoChou isValid]?self.yicixingGaoChou:@"",
             @"shejifeizwShuLiang":[self.shejifeizwShuLiang isValid]?self.shejifeizwShuLiang:@"",
             @"shejifeizwDanJia":[self.shejifeizwDanJia isValid]?self.shejifeizwDanJia:@"",
             @"shejifeizwQiTa":[self.shejifeizwQiTa isValid]?self.shejifeizwQiTa:@"",
             @"shejifeizwJinE":[self.shejifeizwJinE isValid]?self.shejifeizwJinE:@"",
             @"shejifeifmShuLiang":[self.shejifeifmShuLiang isValid]?self.shejifeifmShuLiang:@"",
             @"shejifeifmDanJia":[self.shejifeifmDanJia isValid]?self.shejifeifmDanJia:@"",
             @"shejifeifmQiTa":[self.shejifeifmQiTa isValid]?self.shejifeifmQiTa:@"",
             @"shejifeifmJinE":[self.shejifeifmJinE isValid]?self.shejifeifmJinE:@"",
             @"zdDuiKai":[self.zdDuiKai isValid]?self.zdDuiKai:@"",
             @"zdNeiWenSeShu":[self.zdNeiWenSeShu isValid]?self.zdNeiWenSeShu:@"",
             @"zdFengMianSeShu":[self.zdFengMianSeShu isValid]?self.zdFengMianSeShu:@"",
             @"zdFengMianShiFouShuangYe":[self.zdFengMianShiFouShuangYe isValid]?self.zdFengMianShiFouShuangYe:@"",
             @"zdFengMianDiJia":[self.zdFengMianDiJia isValid]?self.zdFengMianDiJia:@"",
             @"zdShiFouSuFeng":[self.zdShiFouSuFeng isValid]?self.zdShiFouSuFeng:@"",
             
             @"zwCTPMoney":[self.zwCTPMoney isValid]?self.zwCTPMoney:@"",
             @"zwYinShuaMoney":[self.zwYinShuaMoney isValid]?self.zwYinShuaMoney:@"",
             @"fmCTPMoney":[self.fmCTPMoney isValid]?self.fmCTPMoney:@"",
             @"fmYinShuaMoney":[self.fmYinShuaMoney isValid]?self.fmYinShuaMoney:@"",
             
             
             @"guangMo":[self.guangMo isValid]?self.guangMo:@"",
             @"yaMo":[self.yaMo isValid]?self.yaMo:@"",
             @"UV":[self.UV isValid]?self.UV:@"",
             @"moSha":[self.moSha isValid]?self.moSha:@"",
             @"qiTuYaAo":[self.qiTuYaAo isValid]?self.qiTuYaAo:@"",
             @"yaWen":[self.yaWen isValid]?self.yaWen:@"",
             @"uvMoShaChuPian":[self.uvMoShaChuPian isValid]?self.uvMoShaChuPian:@"",
             @"tangJinBanChuPian":[self.tangJinBanChuPian isValid]?self.tangJinBanChuPian:@"",
             @"tangJin":[self.tangJin isValid]?self.tangJin:@"",
             @"suFeng":[self.suFeng isValid]?self.suFeng:@"",
             @"gongYiHuiZong":[self.gongYiHuiZong isValid]?self.gongYiHuiZong:@"",
             @"guanLiChengBen":[self.guanLiChengBen isValid]?self.guanLiChengBen:@"",
             @"bianluJingfei":[self.bianluJingfei isValid]?self.bianluJingfei:@"",
             @"xiaoshouZheKou":[self.xiaoshouZheKou isValid]?self.xiaoshouZheKou:@"",
             @"tuiHuoLV":[self.tuiHuoLV isValid]?self.tuiHuoLV:@"",
             @"faHuoTuiHuoMoney":[self.faHuoTuiHuoMoney isValid]?self.faHuoTuiHuoMoney:@"0",
             @"qitaMoney":[self.qitaMoney isValid]?self.qitaMoney:@"0",
             @"gongYiMoney":[self.gongYiMoney isValid]?self.gongYiMoney:@"0",
             @"zdMoney":[self.zdMoney isValid]?self.zdMoney:@"0",
             @"yinShuaMoney":[self.yinShuaMoney isValid]?self.yinShuaMoney:@"0",
             @"xiaoShouShiYangMoney":[self.xiaoShouShiYangMoney isValid]?self.xiaoShouShiYangMoney:@"0",
             @"gongJiaId":[self.gongJiaId isValid]?self.gongJiaId:@"-1",
             };
}


-(void)saveCurrentBook{
    NSDictionary *dic = [self bookTableDictionary];
    [self.dbManager replaceInfo:dic toTable:kBOOKTABLE];
    [self.bookGongJia saveBookGongJia];
}


-(YSGongJiaObject *)bookGongJia{
    if (_bookGongJia == nil) {
        if ([self.gongJiaId isValid] == NO || [self.gongJiaId isEqualToString:@"-1"]) {
            _bookGongJia = [YSGongJiaObject standGongJia];
        }else
            _bookGongJia = [YSGongJiaObject gongJiaWithID:self.gongJiaId];
    }
    return _bookGongJia;
}




@end
