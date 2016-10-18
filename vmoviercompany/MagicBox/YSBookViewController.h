//
//  YSBookViewController.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/7.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSBookObject;

@interface YSBookViewController : UIViewController
@property (nonatomic, strong, readwrite) YSBookObject *currentBook;
@end
