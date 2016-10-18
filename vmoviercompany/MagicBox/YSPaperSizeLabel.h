//
//  YSPaperSizeLabel.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/9.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSPaperSizeLabel : UILabel
-(void)loadValues:(NSArray *)values;
//这里的str是用,号连接的字符串
-(void)loadValueString:(NSString *)str;
@end
