//
//  VMCommonTools.m
//  MagicBox
//
//  Created by 蒋正峰 on 15/12/3.
//  Copyright © 2015年 蒋正峰. All rights reserved.
//

#import "VMCommonTools.h"
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "VMDefinition.h"

#define BundleShortVersionKey @"CFBundleShortVersionString"
#define CPAppBundleVersion [[NSBundle mainBundle] infoDictionary][BundleShortVersionKey]
#define kJumpAppStoreKey @"hasJumped"

@implementation VMCommonTools

+ (BOOL)shouldToAppStore
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *lastVersion = [ud objectForKey:BundleShortVersionKey];
    NSLog(@"lastVersion:%@ integer:%zd -----currentVersion:%@ integer:%zd",lastVersion,[lastVersion integerValue],CPAppBundleVersion,[CPAppBundleVersion integerValue]);
    if (![lastVersion isEqualToString:CPAppBundleVersion]) {
        return YES;
    }
    return ![ud boolForKey:kJumpAppStoreKey];
}

+(void)appstore{

    [self didToAppStore];
}

+ (void)didToAppStore {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:kJumpAppStoreKey];
    [ud synchronize];
}


/*
 请求header中字段说明
 Example:
 Magic-Agent:MagicBoxApp 2.1.0.3 / Android 5.1 / WiFi / 1080x1920
 Note:
 #VmovierApp 版本号 / 系统版本号 / 网络状况 / 分辨率
 Example:
 Auth-Key:nty0nmu4mzdlogrkza
 Note:
 #未登录是不传递，当登录成功时服务器返回一个auth_key
 Example:
 Device-Id:868800027110448
 Note:
 #设备imei
 返回header示例
 Example:
 Set-AuthKey : nty0nmu4mzdlogrkzb
 Note:
 #当用户登录的时候,返回用户的AuthKey;  当退出的时候Set-AuthKey为空; 当未登录状态请求一些需要登录的接口时,Set-AuthKey为空; 其他情况不返回Set-AuthKey
 Example:
 X-Requestid : mzdlogrkza
 Note:
 #请求的唯一标识
 Example:
 X-Server : Magicapi 4 / 1.0
 Note:
 #server信息 魔力盒主机 / API版本号

 */

+(NSDictionary *)requestHeaders{
   
//    NSLog(@"ag=%@ key=%@  device = %@",[VMCommonTools magicAgentInfo],[VMCommonTools authKeyInfo],[VMCommonTools deviceID]);
    NSDictionary *dic = nil;
    if ([[VMCommonTools authKeyInfo] isValid] == NO) {
        dic = @{
                @"Magic-Agent"    :   [VMCommonTools magicAgentInfo],
                @"Device-Id"      :   [[VMCommonTools deviceID] isValid] ? [VMCommonTools deviceID] : @""
                };
    }else{
        dic = @{
                @"Magic-Agent"    :   [VMCommonTools magicAgentInfo],
                @"Auth-Key"       :   [VMCommonTools authKeyInfo],
                @"Device-Id"      :   [[VMCommonTools deviceID] isValid] ? [VMCommonTools deviceID] : @""
                };
    }
    return dic;
}

#pragma mark-
#pragma mark------拼凑Agent信息------

+(NSString *)magicAgentInfo{

    NSString *agentInfo = [NSString stringWithFormat:@"%@ / %@ / %@ / %@",[VMCommonTools appVersion],[VMCommonTools getDeviceInfo],[VMCommonTools networkInfo],[VMCommonTools deviceSize]];
    return agentInfo;
}

+(NSString *)appVersion{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_BundleName = [infoDictionary objectForKey:@"CFBundleName"];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *app_bundleVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    return [NSString stringWithFormat:@"%@App %@(%@)",app_BundleName, app_Version,app_bundleVersion];
}

+(NSString *)getDeviceInfo{
    
    UIDevice *device = [UIDevice currentDevice];
    return [NSString stringWithFormat:@"%@ %@",device.model,device.systemVersion];
}

+(NSString *)networkInfo{
    
    VMovieRequest *request = [VMovieRequest shareRequest];
    switch (request.networkStatus) {
        case VMNetStatusUnKnown:      return @"Unknown"   ;break;
        case VMNetStatusNotReachable: return @"Unknown"   ;break;
        case VMNetStatusMobile:       return @"Mobile"    ;break;
        case VMNetStatusWIFI:         return @"WiFi"      ;break;
        default:                      return @"Unknown"   ;break;
    }
    return @"Unknown";
}

+(NSString *)deviceSize{
    
    NSString *deviceSize = [NSString stringWithFormat:@"%ldx%ld",(long)SCREEN_WIDTH,(long)SCREEN_HEIGHT];
    return deviceSize;
}

#pragma mark-
#pragma mark------auth-key信息------

+(NSString *)authKeyInfo{
    
    return @"";
}

#pragma mark-
#pragma mark------deviceId------

+(NSString *)deviceID{
    return [VMTools getDeviceId];
}

/**
 * @integer,时间值，转换成integer
 * return  a'b"(a分b秒)
 */

+(NSString *)getTimeStringWithTimeInt:(long long)timeInt
{
    NSInteger minuteInt = timeInt/60;
    NSInteger secondInt = timeInt%60;
    NSString * subStr = nil;
    if (secondInt < 10)
    {
        subStr = [NSString stringWithFormat:@"0%ld",(long)secondInt];
    }
    else
    {
        subStr = [NSString stringWithFormat:@"%ld",(long)secondInt];
    }
    NSString * timeStr = [NSString stringWithFormat:@"%ld'%@\"",(long)minuteInt,subStr];
    return timeStr;
}
/**
 * @fileSize ,文件大小，NSInterger
 * return 单位为 G,M，K，B
 */
+(NSString *)getFileSizeStringWithFileSize:(long long)fileSize
{

    if(fileSize<1024*1024*1024)
    {
        return [NSString stringWithFormat:@"%.1fM",fileSize/1024.0/1024.0];
    }
    else
    {
        return [NSString stringWithFormat:@"%.1fG",fileSize/1024.0/1024.0/1024.0];
    }
}
/**
 *  次数转换 ,
 *
 */
+(NSString *)getCountStringWithIntegerCount:(long long)count
{
    if (count<10000) {
        return [NSString stringWithFormat:@"%lld",count];
    }
    else if(count<100000)
    {
        return [NSString stringWithFormat:@"%.1f万",count * 1.0 / 10000];
    }
    else
    {
        return [NSString stringWithFormat:@"%lld万",count/10000];
    }
    
}
/**
 *  @label ,需要计算的文本长度的标签
 *  return 根据标签文本字符串的长度和字体大小计算出的长度
 */
+(CGSize)getLabelTextSizeWithLabel:(UILabel *)label
{
    NSDictionary * attrbutesDict = @{NSFontAttributeName:label.font};
    CGSize maxSize = CGSizeMake(MAXFLOAT, 200);
    CGRect rect;
    rect= [label.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrbutesDict context:nil];
    return rect.size;
    
}

/**
 *    获取评论日期
 *    @dateCount ,日期时间
 *    return T<1分钟   显示“刚刚”
             1<=T<2分钟   显示“1分钟前”（1-59分钟）
             1<=T<2小时   显示“1小时前”（1-23小时）
             1<=T<2天   显示“1天前”（1-6天）
             7天<=T    显示月日“03-03”
 */
+(NSString *)getDateStringWithDateCount:(long long)dateCount
{
    NSDate * nowDate = [NSDate date];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:dateCount];
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:date];
    NSLog(@"timeInterval  ==  %f",timeInterval);
    if (timeInterval < 60) {    //小于一分钟
        return @"刚刚";
    }
    if (timeInterval < 60*60) { //小于一小时
        NSString * timeStr = [NSString stringWithFormat:@"%.0f分钟前",timeInterval/60.0];
        NSLog(@"time str = %@",timeStr);
        return timeStr;
    }
    if (timeInterval < 60*60*24) {//小于一天
       NSString * timeStr = [NSString stringWithFormat:@"%.0f小时前",((int)timeInterval)/(60.0*60)];
       NSLog(@"time str = %@",timeStr);
       return timeStr;
    }
    if (timeInterval < 60*60*24*7) {//小于一周
        NSString * timeStr = [NSString stringWithFormat:@"%.0f天前",timeInterval/(60.0*60*24)];
        NSLog(@"time str = %@",timeStr);
        return timeStr;
    }
   
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString * dateString = [formatter stringFromDate:date];
    //一周以前
    NSString * timeStr = [dateString substringWithRange:NSMakeRange(5, 5)];
    NSArray * timeArr = [timeStr componentsSeparatedByString:@"-"];
    if (timeArr.count>=2) {
        NSString * returnStr = [NSString stringWithFormat:@"%d月%d日",[timeArr[0] intValue],[timeArr[1] intValue]];
        return returnStr;
    }
    return nil;
}
/**
 *  有闪烁次数的动画
 */
+ (CAAnimationGroup *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time;
{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    
    animation.toValue=[NSNumber numberWithFloat:0.2];
    
    animation.fromValue=[NSNumber numberWithFloat:0.2];
    
    animation.toValue=[NSNumber numberWithFloat:1.0];
    
    animation.repeatCount=repeatTimes;
    
    animation.duration = time;
    
    animation.removedOnCompletion = YES;
    
    animation.fillMode = kCAFillModeRemoved;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation.autoreverses = YES;
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[animation];
    animationGroup.duration = time;
    animationGroup.repeatCount=repeatTimes;
    
    return  animationGroup;
}


+(NSString *)imageUrl:(NSString *)url withSize:(CGSize)size{
    if ([url isValid] == NO) {
        return url;
    }
    
    NSString *finaStr = [NSString stringWithFormat:@"%@@%dw_%dh",url,(int)size.width,(int)size.height];
    NSLog(@"换算后的imageurl is %@",finaStr);
    return finaStr;
}

/**
 *  获取app最上层的vc
 */
+ (UIViewController *)appTopViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

/**
 *  获取时间戳
 *
 *  @param date date数据
 *
 *  @return 时间戳字符串
 */
+ (NSString *)getTimeWith:(NSDate *)date {
    CGFloat time;
    time = (long)[date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.f",time];
}

/**
 *  返回动画效果
 *
 *  @return 帧动画
 */
+ (CATransition *)addCubeAnimation;
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //        transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    return transition;
}

@end
