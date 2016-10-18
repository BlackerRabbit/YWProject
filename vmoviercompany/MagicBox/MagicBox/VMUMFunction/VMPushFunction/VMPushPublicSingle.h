//
//  PushPublicSingle.h
//  PublicPush
//
//  Created by 李国志 on 15/12/8.
//  Copyright © 2015年 LGZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiPushSDK.h"

@protocol VMPushPublicSingleDelegate <NSObject>

@optional
- (void)pushReceiveNotification:(NSDictionary *)userInfo;

@end

@interface VMPushPublicSingle : NSObject <MiPushSDKDelegate>

@property (nonatomic, assign) id <VMPushPublicSingleDelegate> pushDelegate;

+ (instancetype)sharePushPublicSingle;

/**
 *以下方法暂适合小米推送.其他推送可稍作修改
 */
- (void)registerMiPushWithObject;   //注册对象
- (void)bindDeviceToken:(NSData *)deviceToken; //设备Token
- (void)handleReceiveRemoteNotification:(NSDictionary *)userInfo; //用于与长连接的去重(小米推送使用)
- (void)stopPushMessage; //停止推送消息


@end
