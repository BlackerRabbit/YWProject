//
//  YSContentView.h
//  MagicBox
//
//  Created by 蒋正峰 on 2016/10/14.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSContentView : UIView

@property (nonatomic, strong, readwrite) UIImageView *bookImg;
@property (nonatomic, strong, readwrite) UILabel *nameLabel;
@property (nonatomic, strong, readwrite) UILabel *desLabel;



-(void)loadValues:(NSDictionary *)values;

+(CGFloat)contentViewHeight;

@end
