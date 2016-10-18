//
//  PushPublicSingle.m
//  PublicPush
//
//  Created by 李国志 on 15/12/8.
//  Copyright © 2015年 LGZ. All rights reserved.
//

#import "VMPushPublicSingle.h"
#import "VMovieKit.h"

@implementation VMPushPublicSingle

+ (instancetype)sharePushPublicSingle {
    static VMPushPublicSingle *pushPublicSingle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pushPublicSingle = [[VMPushPublicSingle alloc] init];
    });
    
    return pushPublicSingle;
}

//注册对象
- (void)registerMiPushWithObject {
    // 只启动APNs.
    [MiPushSDK registerMiPush:self];
    // 同时启用APNs跟应用内长连接
//    [MiPushSDK registerMiPush:self type:0 connect:YES];
}

//设备Token
- (void)bindDeviceToken:(NSData *)deviceToken {
    // 注册APNS成功, 注册deviceToken
    [MiPushSDK bindDeviceToken:deviceToken];
//    NSString *string  = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""] stringByReplacingOccurrencesOfString: @" " withString: @""];
    // 设置别名
    NSString *uuid = [VMTools getDeviceId];
    [MiPushSDK setAlias:uuid];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = uuid;
}


//用于与长连接的去重(小米推送使用)
- (void)handleReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 使用此方法后，所有消息会进行去重，然后通过miPushReceiveNotification:回调返回给App
//    [MiPushSDK handleReceiveRemoteNotification:userInfo];
}

//停止推送消息
- (void)stopPushMessage {
    //客户端设备注销
    [MiPushSDK unregisterMiPush];
}


#pragma mark - MiPushSDKDelegate

- (void)miPushRequestSuccWithSelector:(NSString *)selector data:(NSDictionary *)data
{
    // 请求成功
    VMLogWarn(@"推送请求成功selector = %@ data = %@",selector,data);
}

- (void)miPushRequestErrWithSelector:(NSString *)selector error:(int)error data:(NSDictionary *)data
{
    // 请求失败
    VMLogWarn(@"推送请求失败成功selector = %@ data = %@",selector,data);

}

//- (void)miPushReceiveNotification:(NSDictionary *)data {
//    //收到数据进行操作
//    if (self.pushDelegate && [self.pushDelegate respondsToSelector:@selector(pushReceiveNotification:)]) {
//        [self.pushDelegate pushReceiveNotification:data];
//    }
//}


@end
