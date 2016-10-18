//
//  YSBookKSize.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/8.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BOOK_KTYPE){
    kHengKai = 0,
    kShuKai  = 1,
};

@interface YSBookKSize : NSObject

@property (nonatomic, assign, readwrite) NSInteger kSize;
@property (nonatomic, assign, readwrite) BOOK_KTYPE type;
//横的被开了多少
@property (nonatomic, assign, readwrite) NSInteger widthNum;
//竖着被开了多少
@property (nonatomic, assign, readwrite) NSInteger heightNum;
//能否被对开
@property (nonatomic, assign, readwrite) BOOL canBeDuiKai;
//特殊标记，是否是3-2
@property (nonatomic, assign, readwrite) BOOL isThreeDouble;
//特殊标记，是否是14-1
@property (nonatomic, assign, readwrite) BOOL isForthDouble;





//下面是很多工厂方法，专门用来生产ksize的。
//4开的

/**
 *  将目前所有支持的开本进行一个集中反回
 *
 *  @return 一个里面存储着所有有效开本数据的数组
 */
+(NSArray *)allValidkSize;

//书的尺寸
+(NSArray *)bookRealSize;

+(NSArray *)avildKsizeWithRealSize:(NSInteger)kSize;

+(NSArray *)allWholePageSize;

+(NSArray *)allBookAndTheKSize;


+(NSArray *)loadDataFromBundlePackage;

@end
