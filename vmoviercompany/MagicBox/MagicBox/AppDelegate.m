//
//  AppDelegate.m
//  MagicBox
//
//  Created by 蒋正峰 on 15/11/2.
//  Copyright © 2015年 蒋正峰. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

#import <Foundation/Foundation.h>


#import "VMNavigationController.h"

#import <AFNetworking.h>
#import "VMCommonTools.h"
#import <UMFeedback.h>
#import "VMNecessaryUpdate.h"
#import "YSBookKSize.h"
#import "WXApi.h"

static NSString *kConversationChatter = @"ConversationChatter";


#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define IOS_8_OR_LATER   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define _IPHONE80_ 80000

@interface AppDelegate () <NSURLConnectionDataDelegate,NSURLConnectionDelegate,WXApiDelegate>

@property (nonatomic, strong) VMDownLoadManager *downloadManager;
@property (nonatomic, strong) NSMutableData *requestData;

/**是否有推送，如果有，则不显示启动页，没有则显示
 */
@property (nonatomic, assign) BOOL hasPushNotification;

@end

@implementation AppDelegate

#define kStopLoading @"StopLoading"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [WXApi registerApp:@""];
    
    self.allLocalData = [YSBookKSize loadDataFromBundlePackage];

    YSRootViewController *rootVC = [[YSRootViewController alloc]init];
    self.rootVC = rootVC;
    VMNavigationController *rootNav = [[VMNavigationController alloc] initWithRootViewController:rootVC];
    rootNav.navigationBarHidden = YES;
    [self.window setRootViewController:rootNav];
    [self.window makeKeyAndVisible];
    return YES;
    
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
    return [WXApi handleOpenURL:url delegate:self];
}

@end
