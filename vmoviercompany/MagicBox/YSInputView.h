//
//  YSInputView.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/4.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSInputView : UIView

@property (nonatomic, strong, readwrite) UILabel *titleLab;
@property (nonatomic, strong, readwrite) UITextField *inputField;
@property (nonatomic, strong, readwrite) UIButton *moreBtn;

@property (nonatomic, strong, readwrite) NSString *currentValue;




@end
