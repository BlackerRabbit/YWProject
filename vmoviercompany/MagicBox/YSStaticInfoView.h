//
//  YSStaticInfoView.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/7.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StaticInfoViewHandler)();

typedef NS_ENUM(NSInteger, StaticInfoStatus){
    StaticInfoTypeNormal    = 0, //正常的状态
    StaticInfoTypeDisable   = 1, //disable的状态
    StaticInfoTypeShowInfo  = 2, //展示信息的状态
};


@interface YSStaticInfoView : UIView

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *valueLabel;
@property (nonatomic, strong, readwrite) UIImageView *arrow;

@property (nonatomic, assign, readwrite) StaticInfoStatus currentStatus;

+(YSStaticInfoView *)staticInfoViewWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder withClickHandler:(StaticInfoViewHandler)hanlder;
-(void)loadValue:(NSString *)value;

-(void)staticInfoViewWithType:(StaticInfoStatus)status;


@end
