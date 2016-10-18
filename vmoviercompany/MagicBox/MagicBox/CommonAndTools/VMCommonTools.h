//
//  VMCommonTools.h
//  MagicBox
//
//  Created by 蒋正峰 on 15/12/3.
//  Copyright © 2015年 蒋正峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VMCommonTools : NSObject
+ (BOOL)shouldToAppStore;
+ (void)didToAppStore;
+(void)appstore;
+(NSString *)appVersion;

+(NSDictionary *)requestHeaders;
+(NSString *)magicAgentInfo;

/**获取到device的id
 */
+(NSString *)deviceID;

/**
 * @timeInt,时间值，转换成long long
 * return  a'b"(a分b秒)
 */

+(NSString *)getTimeStringWithTimeInt:(long long)timeInt;

/**
 * @fileSize ,文件大小，NSInterger
 * return 单位为 G,M，K，B
 */
+(NSString *)getFileSizeStringWithFileSize:(long long)fileSize;
/**
 *  次数转换 
 *
 */
+(NSString *)getCountStringWithIntegerCount:(long long)count;

/**
 *  @label ,需要计算的文本长度的标签
 *  return 根据标签文本字符串的长度和字体大小计算出的size,
 *  最大的size默认是 （MAXFLOUT ，200）,为了就是让其长度无限长
 */
+(CGSize)getLabelTextSizeWithLabel:(UILabel *)label;

/**
 *    获取评论日期
 *    @dateCount ,日期时间
 *   return  T<1分钟   显示“刚刚”
             1<=T<2分钟   显示“1分钟前”（1-59分钟）
             1<=T<2小时   显示“1小时前”（1-23小时）
             1<=T<2天   显示“1天前”（1-6天）
             7天<=T    显示月日“03-03”
 */
+(NSString *)getDateStringWithDateCount:(long long)dateCount;
/**
 *  有闪烁次数的动画
 */
+ (CAAnimationGroup *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time;


/**
 *
 */

+(NSString *)imageUrl:(NSString *)url withSize:(CGSize)size;

/**
 *  获取app最上层的vc
 */
+ (UIViewController *)appTopViewController;

/**
 *  获取当前系统的时间戳
 *
 *  @param date 当前时间
 *
 *  @return 时间的秒数字符串
 */
+ (NSString *)getTimeWith:(NSDate *)date;

/**
 *  返回动画效果
 *
 *  @return 帧动画
 */
+ (CATransition *)addCubeAnimation;

@end
