//
//  YSHuiZongView.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/9/28.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSHuiZongView : UIView

+(YSHuiZongView *)huiZongViewWithTitles:(NSArray *)titles;

-(void)loadValues:(NSArray *)values;

@end
