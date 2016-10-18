//
//  YSSelectedView.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/13.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSSelectedView;

@protocol YSSelectedDelegate <NSObject>

-(void)selectedView:(YSSelectedView *)selectedView didSelectedSize:(NSInteger)kSize;
@end


@interface YSSelectedView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) UIScrollView *mainScrollview;
@property (nonatomic, strong, readwrite) UILabel *selectedLabel;

@property (nonatomic, strong, readwrite) NSArray *dataAry;
@property (nonatomic, weak, readwrite) id<YSSelectedDelegate> selectedDelegate;

@end
