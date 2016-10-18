//
//  YSTableInofView.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/17.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSTableInofView;

@protocol YSTableInfoDelegate <NSObject>

-(void)tableInfoDidFinishLayout:(YSTableInofView *)tableInfo;

@end

@interface YSTableInofView : UIView

@property (nonatomic, assign, readwrite) BOOL hasExternColor;
@property (nonatomic, weak, readwrite) id<YSTableInfoDelegate>infoDelegate;


//上面的栏目
-(void)loadTitles:(NSArray *)titles;


//上面只有两行的时候调用
-(void)loadRowTitlesTwo:(NSArray *)titles;

//左边第一竖行的内容
-(void)loadRowTitles:(NSArray *)titles;

// 当上面有五行的时候调用的方法
-(void)loadRowTitlesFive:(NSArray *)titles;


//左边第二竖行的内容
-(void)loadSecondRowTitles:(NSArray *)titles;

//左边第三竖行的内容
-(void)loadThirdRowTitles:(NSArray *)titles;

//左边第四行的内容
-(void)loadForthRowTitles:(NSArray *)titles;
-(void)loadFifthRowTitles:(NSArray *)titles;


-(NSArray *)valuesForRowTitle:(NSString *)title;



//特殊颜色的列们
-(void)loadRows:(NSArray *)rows withColor:(UIColor *)color;

//可以被修改的列们
-(void)loadRows:(NSArray *)rows withCanBeModeify:(BOOL)modify;








@end
