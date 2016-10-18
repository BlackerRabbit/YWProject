//
//  YSPaperView.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/6/22.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSPaper;
@class YSBookKSize;

@interface YSPaperView : UIView

-(void)showWithkSize:(YSBookKSize *)kSize;
-(void)showCanBeDuiKai:(BOOL)canBeDuiKai;

@end
