//
//  YSHuiZongView.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/9/28.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSHuiZongView.h"

@interface YSHuiZongView ()
@property (nonatomic, strong, readwrite) CALayer *lineLayer;

@property (nonatomic, strong, readwrite) NSArray *titlesAry;
@property (nonatomic, strong, readwrite) NSMutableArray *labelsAry;
@property (nonatomic, strong, readwrite) NSMutableArray *contentAry;

@property (nonatomic, strong, readwrite) UILabel *huizongLabel;

@end



@implementation YSHuiZongView

+(YSHuiZongView *)huiZongViewWithTitles:(NSArray *)titles{
    YSHuiZongView *huizong = [[YSHuiZongView alloc]initWithFrame:CGRectZero];
    huizong.titlesAry = titles;
    huizong.width = SCREEN_WIDTH;
    [huizong buildUI];
    return huizong;
}

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.labelsAry = [@[]mutableCopy];
        self.contentAry = [@[]mutableCopy];
    }
    return self;
}

-(void)buildUI{
    
    [self.labelsAry removeAllObjects];
    for (int i = 0; i < self.titlesAry.count; i++) {
        NSString *str = self.titlesAry[i];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.font = [UIFont systemFontOfSize:16];
        label.numberOfLines = 1;
        label.text = [NSString stringWithFormat:@"%@:",str];
        [label sizeToFit];
        [self addSubview:label];
        [self.labelsAry addObject:label];
        
        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        contentLabel.font = [UIFont boldSystemFontOfSize:16];
        contentLabel.numberOfLines = 1;
        [self addSubview:contentLabel];
        [self.contentAry addObject:contentLabel];
    }
    
    //排列ui
    if (self.huizongLabel.superview == nil) {
        [self addSubview:self.huizongLabel];
    }
    
    self.huizongLabel.top = 20;
    self.huizongLabel.left = 10;
    float offset = self.huizongLabel.bottom + 10;
    for (int i = 0; i < self.labelsAry.count; i++) {
        UILabel *label = self.labelsAry[i];
        label.left = self.huizongLabel.left;
        label.top = offset;
        UILabel *contentLabel = self.contentAry[i];
        contentLabel.top = label.top;
        offset += label.height + 10;
        NSLog(@"%f",label.bottom);
    }
    UILabel *lastLabel = self.labelsAry.lastObject;
    offset = lastLabel.bottom + 10;
    self.height = MAX(offset ,200);
    
    if (self.lineLayer.superlayer == nil) {
        self.lineLayer.frame = CGRectMake(0, 0, self.width, .5);
        [self.layer addSublayer:self.lineLayer];
    }
 
}

-(void)loadValues:(NSArray *)values{
    
    UILabel *lastLabel = nil;
    for (int i = 0; i < values.count; i++) {
        UILabel *label = self.contentAry[i];
        label.frame = CGRectZero;
        label.text = values[i];
        [label sizeToFit];
        
        UILabel *titleLabel = self.labelsAry[i];
        label.left = titleLabel.right + 5;
        label.top = titleLabel.top;
        lastLabel = label;
    }
}

-(CGFloat)huiZongViewHeight{
    return self.height;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}


-(CALayer *)lineLayer{

    if (_lineLayer == nil) {
        _lineLayer = [CALayer layer];
        _lineLayer.frame = CGRectMake(0, 0, self.width, .5);
        _lineLayer.backgroundColor = COLOR(100, 100, 100, .6).CGColor;
    }
    return _lineLayer;
}

-(UILabel *)huizongLabel{
    if (_huizongLabel == nil) {
        
        _huizongLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _huizongLabel.font = [UIFont systemFontOfSize:16];
        _huizongLabel.text = @"汇总：";
        _huizongLabel.numberOfLines = 1;
        [_huizongLabel sizeToFit];
    }
    return _huizongLabel;
}



@end
