//
//  VMCommenDefinition.h
//  MagicBox
//
//  Created by 蒋正峰 on 15/12/2.
//  Copyright © 2015年 蒋正峰. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APPSTORE_URL @"https://itunes.apple.com/us/app/mo-li-he/id702959821?mt=8"


#pragma mark-
#pragma mark------http request host------

//首页card的请求
#define recommend_video @"Recommend"

#pragma mark-
#pragma mark------commen seetings------


#pragma mark - 线上的参数配置
#ifdef DEBUG
#define kUMClickAppkey                 @"563ad374e0f55ab4e1004c50"   //友盟统计的测试参数
#define kCrashReporterAppId            @"900019010"                  //捕捉线上crash的appid
#define kApnsCertName       @"magicBoxDevelopPush"     //环信的开发推送

#elif MagicDebug
#define kUMClickAppkey                 @"5232c54c56240bb3910159c9"   //友盟统计的线上参数
#define kCrashReporterAppId            @"900003692"                  //捕捉线上crash的appid
#define kApnsCertName       @"magicBoxProductionPush" //环信的线上推送

#else
#define kUMClickAppkey                 @"5232c54c56240bb3910159c9"   //友盟统计的线上参数
#define kCrashReporterAppId            @"900003692"                  //捕捉线上crash的appid
#define kApnsCertName       @"magicBoxProductionPush" //环信的线上推送
#endif

#define kEaseMobAppKey                 @"vmovier#magic"              //环信的appkey
#define SinaWBUserID                   @"5155643931"                 //新浪关注key

#pragma mark - 其他的参数配置

//视频播放完成通知
#define kAVPlayerFinishNotification    @"kAVPlayerFinishNotification"
//本地视频播放完成且分享点击完毕后的通知
#define kLocalPlayerFinishShareNotification  @"kLocalPlayerFinishShareNotification"


//视频的链接
#define kAVPlayerVideoUrl              @"kAVPlayerVideoUrl"
//视频的当前播放时间
#define kAVPlayerCurrentTime           @"kAVPlayerCurrentTime"
//视频的总时间
#define kAVPlayerTotalTime             @"kAVPlayerTotalTime"

//账号被顶掉的通知
#define kAccountOutNotification        @"kAccountOutNotification"

//退出登录通知
#define kLogOutNotification            @"kLogOutNotification"

//账号重新登录
#define kReLoginNotification           @"kReLoginNotification"

//赞回复私信未读消息数变化的通知
#define kUnreadCountChangeNotification @"kUnreadCountChangeNotification"

//tabbar显示红点
#define kRedShow                       @"kRedShow"

//隐藏的版本
#define kHiddenVersion                 @"HiddenVersion"

//刷新Tabbar
#define kRefreshViewNotification     @"kRefreshViewNotification"

//是否显示好评提示框
#define kShowPraise                    @"kShowPraise"

//线上链接用于隐藏版的同步请求
#define kHiddenUrlStr                  @"https://magicapi.vmovier.cc/magicapiv2/"

//存放表情键盘value值的
#define kEmotionKeyboardObject         @"EmotionKeyboard"


//存放所有表情的字典，用来表情的key - value
#define kAllEmotionDictObject          @"allEmotionDict"

//登录方式
#define kLoginWay                      @"kLoginWay"

//第三方登录的用户id
#define kLoginUniqid                   @"kLoginUniqid"

#define kUpdateAvatar                  @"kUpdateAvatar"

/**
 *键值，用来区分是否为检测掉线的接口
 */
#define kVMCheckForceLogoutKey         @"VMCheckForceLogoutKey"
#define kVMCheckForceLogoutValue       @"VMCheckForceLogoutValue"

/**
 *视频详情申请成功
 */
#define kVideoDetailSuccessObject      @"VideoDetailSuccess"

/**
 *  喜欢，评论点赞，新评论，历史通知
 */
#define kMovieCollection               @"kMovieCollection"
#define kAddNewComment                 @"kAddNewComment"
#define kCommentOperate                @"kCommentOperate"
#define kAddHistory                    @"kAddHistory"

#define commentPadding  (([UIScreen mainScreen].bounds.size.width > 320)?14:12)

#define commentInsert   UIEdgeInsetsMake(commentPadding, commentPadding, commentPadding, commentPadding)

