//
//  YSPaper.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/6/22.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSBookKSize.h"

typedef NS_ENUM(NSInteger, kPAPER_TYPE){

    kPaperSizeHengKai = 0,
    kPaperSizeShuKai  = 1,
};


@interface YSPaper : NSObject
/**
 *  宽度
 */
@property (nonatomic, strong, readwrite) NSString *width;
/**
 *  长度
 */
@property (nonatomic, strong, readwrite) NSString *length;

/**
 *  开数
 */
@property (nonatomic, assign, readwrite) NSInteger kSize;

/**
 *  单价
 */
@property (nonatomic, strong, readwrite) NSString *pricePerUnit;

/**
 *  参考宽度
 */
@property (nonatomic, strong, readwrite) NSString *suggestWidth;
/**
 *  参考长度
 */
@property (nonatomic, strong, readwrite) NSString *suggestLength;
/**
 *  成品书的宽度
 */
@property (nonatomic, strong, readwrite) NSString *bookWidth;
/**
 *  成品书的长度
 */
@property (nonatomic, strong, readwrite) NSString *bookLength;

/**
 *  根据开数反回一个特定类型的纸张
 *
 *  @param kSize 纸张的开数，size,传入的相应纸张的大小
 *
 *  @return yspaper
 */

+(YSPaper *)paperWithPaperkInfo:(YSBookKSize *)bookKsize;


@end
