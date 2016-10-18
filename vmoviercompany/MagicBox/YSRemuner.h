//
//  YSRemuner.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/4.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSRemuner : NSObject
@property (nonatomic, assign, readwrite) CGFloat pricePerThousand;
@property (nonatomic, assign, readwrite) CGFloat words;
//费率
@property (nonatomic, assign, readwrite) CGFloat feeLV;
//基本稿酬
@property (nonatomic, assign, readwrite) CGFloat baseRemuner;
@property (nonatomic, assign, readwrite) CGFloat banSuiLV;
//版税稿酬
@property (nonatomic, assign, readwrite) CGFloat banSuiRemuner;

//其他费用
@property (nonatomic, assign, readwrite) CGFloat otherFee;
//一次性稿酬
@property (nonatomic, assign, readwrite) CGFloat onceRemuner;

//发行基本信息
//销售折扣
@property (nonatomic, assign, readwrite) CGFloat saleoff;
//退货率
@property (nonatomic, assign, readwrite) CGFloat returnOff;

//管理基本信息
//管理成本
@property (nonatomic, assign, readwrite) CGFloat managerFee;
//编录经费
@property (nonatomic, assign, readwrite) CGFloat bianluFee;


+(YSRemuner *)quickRemuner;
+(YSRemuner *)loadRemuner;
+(YSRemuner *)dictionaryToReum:(NSDictionary *)dic;
-(BOOL)saveRemuner;
-(BOOL)deleteRemuner;
-(NSDictionary *)resumToDictionary;



@end
