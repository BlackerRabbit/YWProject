//
//  YSBaseInfoController.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/20.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPKeyboardAvoidingScrollView;
@class YSJSQController;
@class YSBaseInfoController;

@protocol YSBaseInfoControllerDelegate <NSObject>

-(void)baseInfoControllerWillDismiss:(YSBaseInfoController *)baseInfo;

@end


@interface YSBaseInfoController : UIViewController

@property (nonatomic, strong, readwrite) TPKeyboardAvoidingScrollView *mainScrollview;
@property (nonatomic, weak, readwrite) YSJSQController *jsqVC;

@property (nonatomic, weak, readwrite) id<YSBaseInfoControllerDelegate>delegate;

@end
