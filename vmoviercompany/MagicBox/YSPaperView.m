//
//  YSPaperView.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/6/22.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSPaperView.h"
#import "YSPaper.h"
#import "YSBookKSize.h"

/**
 *  整张纸的宽高比为：1.4
 */



@interface YSPaperView ()
@property (nonatomic, strong, readwrite) YSPaper *currentPaper;
@property (nonatomic, strong, readwrite) YSBookKSize *currentKSize;
@property (nonatomic, assign, readwrite) BOOL canBeDuiKai;

@property (nonatomic, assign, readwrite) BOOL externThree;
@property (nonatomic, assign, readwrite) BOOL externForteen;


@end

@implementation YSPaperView

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.currentKSize = [[YSBookKSize alloc]init];
        
    }
    return self;
}

-(void)showWithkSize:(YSBookKSize *)kSize{
    if (kSize == nil) {
        return;
    }
    self.currentKSize = kSize;
    [self setNeedsDisplay];
}

-(void)showCanBeDuiKai:(BOOL)canBeDuiKai{
    self.canBeDuiKai = canBeDuiKai;
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画边框
    CGContextSetLineWidth(context, .5);
    CGContextSetStrokeColorWithColor(context, COLORA(151, 151, 151).CGColor);
    CGContextSetFillColorWithColor(context, COLOR(160, 160, 160, .3).CGColor);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, self.width, 0);
    CGContextAddLineToPoint(context, self.width, self.height);
    CGContextAddLineToPoint(context, 0, self.height);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    //根据paper来画图
    NSInteger xNumber = self.currentKSize.widthNum;
    NSInteger yNumber = self.currentKSize.heightNum;
    float xoffset = 0.0;
    
    if (xNumber > 0) {
       xoffset = self.width / xNumber;
    }
    float yoffset = 0.0;
    if (yNumber > 0) {
        yoffset = self.height / yNumber;
    }
    float xmove = xoffset;
    float ymove = yoffset;
    CGContextMoveToPoint(context, 0, 0);
    for (int i = 0 ; i < xNumber; i++) {
        
        CGContextMoveToPoint(context, xoffset, 0);
        CGContextAddLineToPoint(context, xoffset, self.height);
        xoffset += xmove;
    }
    
    for (int i = 0; i < yNumber; i++) {
        CGContextMoveToPoint(context, 0, yoffset);
        CGContextAddLineToPoint(context, self.width, yoffset);
        yoffset += ymove;
    }
    CGContextStrokePath(context);
    CGContextFillPath(context);
    CGContextClosePath(context);

    
    CGContextRef fillContext = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(fillContext, COLOR(200, 200, 200, .2).CGColor);
    
    
    //根据是否能对开来填充颜色
    if (self.currentKSize.canBeDuiKai) {
        if (self.currentKSize.isThreeDouble) {
            CGContextFillRect(fillContext, CGRectMake(2 * xmove, 0, xmove, self.height));
           
        }else if (self.currentKSize.isForthDouble){
            //这是另一种处理模式
            CGContextFillRect(fillContext, CGRectMake(0, self.height / 2.f, self.width, self.height / 2.f));
        }else{
            CGContextFillRect(fillContext, CGRectMake(self.width / 2.f, 0, self.width / 2.f, self.height));
        }
        
    }else{
    
    }
    
    CGContextClosePath(fillContext);
}




@end
