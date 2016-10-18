//
//  VMDefinition.h
//  MagicBox
//
//  Created by 蒋正峰 on 15/11/18.
//  Copyright © 2015年 蒋正峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define VMRED COLOR(255,151,185,1)
#define VMDBLUE COLOR(75,189,232,1)
#define COLORA(r,g,b) (COLOR(r,g,b,1))
#define CLEAR [UIColor clearColor]
#define WHITE [UIColor whiteColor]
#define BLACK [UIColor blackColor]
#define BLUE  [UIColor blueColor]
#define RED [UIColor redColor]
#define GREEN [UIColor greenColor]
#define YELLOW [UIColor yellowColor]
/**
 设置十六进制颜色值
 */
#define UICOLOR_RGB_Alpha(_color,_alpha) [UIColor colorWithRed:((_color>>16)&0xff)/255.0f green:((_color>>8)&0xff)/255.0f blue:(_color&0xff)/255.0f alpha:_alpha]

//通过三色值获取颜色对象
#define COLOR(r,g,b,a) ([UIColor colorWithRed:(float)r/255.f green:(float)g/255.f blue:(float)b/255.f alpha:a])

#define kFONTSIZE(SIZE) [UIFont systemFontOfSize:(SIZE)]
#define FONT(SIZE) [UIFont getRegularSansFont:(SIZE)]
#define WIDTH_HEIGHT_SCALE 16/9.0f


#define IOS7   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

//获取build id
#define kBundleVersion  [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]
//获取版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//系统版本等于
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]==NSOrderedSame)
//系统版本大于
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]==NSOrderedDescending)
//系统版本大于或等于
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)
//系统版本小于
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]==NSOrderedAscending)
//系统版本小于或等于
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]!=NSOrderedDescending)
//系统版本
#define SYSTEM_VERSION                              ([[[UIDevice currentDevice] systemVersion] floatValue])

#define iPhone4 ([UIScreen mainScreen].bounds.size.height==480)

#define iPhone4Land (MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width)==480)


#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5Land ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size )|| CGSizeEqualToSize(CGSizeMake(1136, 640), [[UIScreen mainScreen] currentMode].size) : NO)




#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) ) : NO)

#define iPhone6Land ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334),[[UIScreen mainScreen] currentMode].size )|| CGSizeEqualToSize(CGSizeMake(1334, 750), [[UIScreen mainScreen] currentMode].size) : NO)




#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?(CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6PLand ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208),[[UIScreen mainScreen] currentMode].size )|| CGSizeEqualToSize(CGSizeMake(2208, 1242), [[UIScreen mainScreen] currentMode].size) : NO)



#define iPhone6plusBigModel ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) ) : NO)

#define iPhone6PBigModelLand ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001),[[UIScreen mainScreen] currentMode].size )|| CGSizeEqualToSize(CGSizeMake(2001, 1125), [[UIScreen mainScreen] currentMode].size) : NO)




#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define CONTENT_WIDTH_CONSTAIN  ([[UIScreen mainScreen] bounds].size.width-76)//图文解析限定每行的宽度
#ifdef DEBUG
#define JHLog(format, ...) NSLog( @"%@\n> %@\n-----------------\n", NSStringFromSelector(_cmd), [NSString stringWithFormat:(format), ##__VA_ARGS__])
#else
#define JHLog(format, ...)
#endif


#define AppDelegateEntity ((AppDelegate *)[UIApplication sharedApplication].delegate)

/**
 *  设置自己为weak状态
 */
//#define WEAKSELF typeof(self) __weak weakSelf = self;

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


//delegate 检测
#define kCheckSafeDelegate(__delegate,__SEL)\
if (__delegate && [__delegate respondsToSelector:@selector(__SEL)])\
{

#define kEndCheckDelegate }
//end delegate 检测

//判断是否为空
#define ISNULLARRAY(arr) (arr == nil || (NSObject *)arr == [NSNull null] || arr.count == 0)
#define ISNULLOBJ(obj)   (obj == nil || (NSObject *)obj == [NSNull null])
#define ISNULLSTR(str)   (str == nil || (NSObject *)str == [NSNull null] || str.length == 0)


//弧度值
#define degreesToRadian(x) (M_PI * (x) / 180.0)
//block
#define WEAKSELF __weak typeof(self)  weakSelf = self;
#define STRONGSELF __strong typeof(weakSelf) strongSelf = weakSelf;

/**
 获取appdelegate
 */
#define AppDelegateEntity ((AppDelegate *)[UIApplication sharedApplication].delegate)


