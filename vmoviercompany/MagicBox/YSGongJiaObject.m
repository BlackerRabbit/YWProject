//
//  YSGongJiaObject.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/9/4.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSGongJiaObject.h"
#import "VMDataBaseManager.h"

@interface YSGongJiaObject ()
@property (nonatomic, strong, readwrite) VMDataBaseManager *dbManager;
@property (nonatomic, assign, readwrite) BOOL hasStandDB;

@end

@implementation YSGongJiaObject

-(id)init{

    if (self = [super init]) {
        [self loadByDefaultValues];
        if (![self.dbManager hasTable:kSTANDBOOKGONGJIA]) {
            [self.dbManager createTable:kSTANDBOOKGONGJIA withInfo:[self gongJiaTableDictionary]];
        }
        if (![self.dbManager hasTable:kBOOKGONGJIA]) {
            [self.dbManager createTable:kBOOKGONGJIA withInfo:[self gongJiaTableDictionary]];
        }
        return self;
    }
    return nil;
}

-(VMDataBaseManager *)dbManager{
    if (_dbManager == nil) {
        _dbManager = [VMDataBaseManager shareDBManager];
    }
    return _dbManager;
}

+(YSGongJiaObject *)standGongJia{
    
    YSGongJiaObject *gongJiaPric = [[YSGongJiaObject alloc]init];
    NSArray *standDBAry = [gongJiaPric loadStandGongJiaPrics];
    NSDictionary *dic = standDBAry.lastObject;
    if (dic.count == 0 || [dic[@"danSe"]isValid] == NO) {
        [gongJiaPric loadByDefaultValues];
    }else
        [gongJiaPric gongJiaLoadInfoFromDic:dic];
    return gongJiaPric;
}


+(YSGongJiaObject *)gongJiaWithID:(NSString *)gongJiaID{
    if ([gongJiaID isValid] == NO) {
        [VMTools alertMessage:@"工价不存在"];
        return nil;
    }
    YSGongJiaObject *gongJia = [[YSGongJiaObject alloc]init];
    [gongJia gongJiaLoadInfoFromDic:[[gongJia loadFromDBWithId:gongJiaID]lastObject]];
    return gongJia;
}


-(void)loadByDefaultValues{
    
    self.danSe = @"10";
    self.shuangSe = @"18";
    self.siSe = @"24";
    self.shaiShangBan = @"90";
    
    self.sixteenQiMa = @"0.02";
    self.sixteenTieSiPing = @"0.022";
    self.sixteenJiao = @"0.025";
    self.sixteenSuoJiao = @"0.03";
    
    self.eighteenQiMa = @"0.025";
    self.eighteenTieSiPing = @"0.028";
    self.eighteenJiao = @"0.03";
    self.eighteenSuoJiao = @"0.04";
    
    self.zhuangDing = @"0.03";
    self.shangFeng = @"2";
    self.duTouBu = @"0.2";
    self.heLanBan = @"13";
    self.huanChen = @"2";
    self.yuanJi = @"1";
    
    self.guangMo = @"0.4";
    self.yaMo = @"0.5";
    self.UV = @"0.5";
    self.moSha = @"0.65";
    self.qiGu = @"0.05";
    self.tangJin = @"0.003";//元/平方厘米
    self.tangJinBanChuPian = @"50";
    self.tieBiao = @"0.1";
    self.suFeng = @"0.3";
}


-(void)saveStandGongJia{
    [self.dbManager replaceInfo:[self gongJiaTableDictionary] toTable:kSTANDBOOKGONGJIA];
}


-(void)saveBookGongJia{
    BOOL replaceResult = [self.dbManager replaceInfo:[self gongJiaTableDictionary] toTable:kBOOKGONGJIA];
}


-(NSArray *)loadFromDB{
    
    return [self loadFromDBWithName:kBOOKGONGJIA];
}

-(NSArray *)loadFromDBWithId:(NSString *)mainId{
    return [self.dbManager getInfoByKey:@"ID" value:mainId fromTable:kBOOKGONGJIA];
}

-(NSArray *)loadStandGongJiaPrics{
    
    return [self loadFromDBWithName:kSTANDBOOKGONGJIA];
}

-(NSArray *)loadFromDBWithName:(NSString *)dbName{

      return [self.dbManager getInfoFromTable:dbName];
}

-(NSDictionary *)gongJiaTableDictionary{
    return @{
             @"danSe":self.danSe,
             @"shuangSe":self.shuangSe,
             @"siSe":self.siSe,
             @"shaiShangBan":self.shaiShangBan,
             
             @"sixteenQiMa":self.sixteenQiMa,
             @"sixteenTieSiPing":self.sixteenTieSiPing,
             @"sixteenJiao":self.sixteenJiao,
             @"sixteenSuoJiao":self.sixteenSuoJiao,
             
             @"eighteenQiMa":self.eighteenQiMa,
             @"eighteenTieSiPing":self.eighteenTieSiPing,
             @"eighteenJiao":self.eighteenJiao,
             @"eighteenSuoJiao":self.eighteenSuoJiao,
             
             @"zhuangDing":self.zhuangDing,
             @"shangFeng":self.shangFeng,
             @"duTouBu":self.duTouBu,
             @"heLanBan":self.heLanBan,
             @"huanChen":self.huanChen,
             @"yuanJi":self.yuanJi,
             
             @"guangMo":self.guangMo,
             @"yaMo":self.yaMo,
             @"UV":self.UV,
             @"moSha":self.moSha,
             @"qiGu":self.qiGu,
             @"tangJin":self.tangJin,
             @"tangJinBanChuPian":self.tangJinBanChuPian,
             @"tieBiao":self.tieBiao,
             @"suFeng":self.suFeng,
             };
}

-(void)gongJiaLoadInfoFromDic:(NSDictionary *)dic{
    
    if (dic == nil || dic.count == 0) {
        
        [self loadByDefaultValues];
        return;
    }
    self.mainID = dic[@"ID"];
    self.danSe = dic[@"danSe"];
    self.shuangSe = dic[@"shuangSe"];
    self.siSe = dic[@"siSe"];
    self.shaiShangBan = dic[@"shaiShangBan"];
    
    self.sixteenQiMa = dic[@"sixteenQiMa"];
    self.sixteenTieSiPing = dic[@"sixteenTieSiPing"];
    self.sixteenJiao = dic[@"sixteenJiao"];
    self.sixteenSuoJiao = dic[@"sixteenSuoJiao"];
    
    self.eighteenQiMa = dic[@"eighteenQiMa"];
    self.eighteenTieSiPing = dic[@"eighteenTieSiPing"];
    self.eighteenJiao = dic[@"eighteenJiao"];
    self.eighteenSuoJiao = dic[@"eighteenSuoJiao"];
    
    self.zhuangDing = dic[@"zhuangDing"];
    self.shangFeng = dic[@"shangFeng"];
    self.duTouBu = dic[@"duTouBu"];
    self.heLanBan = dic[@"heLanBan"];
    self.huanChen = dic[@"huanChen"];
    self.yuanJi = dic[@"yuanJi"];
    
    self.guangMo = dic[@"guangMo"];
    self.yaMo = dic[@"yaMo"];
    self.UV = dic[@"UV"];
    self.moSha = dic[@"moSha"];
    self.qiGu = dic[@"qiGu"];
    self.tangJin = dic[@"tangJin"];
    self.tangJinBanChuPian = dic[@"tangJinBanChuPian"];
    self.tieBiao = dic[@"tieBiao"];
    self.suFeng = dic[@"suFeng"];
}

@end
