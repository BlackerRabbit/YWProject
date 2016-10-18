//
//  YSCoverInputView.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/28.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^InputViewGetNameHandler)(NSString *name);

@interface YSCoverInputView : UIView
@property (nonatomic, strong, readwrite) NSString *placeHolderName;
@property (nonatomic, copy, readwrite) InputViewGetNameHandler handler;
@end
