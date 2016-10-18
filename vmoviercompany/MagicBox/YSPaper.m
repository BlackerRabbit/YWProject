//
//  YSPaper.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/6/22.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSPaper.h"

@implementation YSPaper

//所有成品纸的尺寸
/**
 *  787*1092
 */

/**
 *  900*1280
 */

/**
 * 850*1168
 */

/**
 * 1000*1400
 */

/**
 * 880*1230
 */

/**
 * 890*1240
 */

/**
 * 889 * 1194
 */

/**
 * 800*1100
 */

/**
 * 787*960
 */

/**
 * 710*1000
 */

+(YSPaper *)paperWithPaperkInfo:(YSBookKSize *)bookKsize{

    NSInteger kNumber = bookKsize.kSize;
    NSLog(@"%ld",(long)kNumber);
    switch (bookKsize.type) {
        case kShuKai:break;
        case kHengKai:break;
        default:
            break;
    }
    YSPaper *paper = [[YSPaper alloc]init];
    return paper;
}


@end
