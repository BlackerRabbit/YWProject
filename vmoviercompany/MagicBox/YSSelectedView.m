//
//  YSSelectedView.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/13.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSSelectedView.h"
#import "YSBookKSize.h"
@interface YSSelectedView ()
@property (nonatomic, strong, readwrite) UILabel *centerLabel;
@property (nonatomic, strong, readwrite) NSMutableArray *labelsAry;

@property (nonatomic, strong, readwrite) UILabel *kSizeActionLabel;

@property (nonatomic, strong, readwrite) UILabel *preSelectedLabel;
@end

@implementation YSSelectedView

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    self.labelsAry = [@[]mutableCopy];
    [self buildUI];
    return self;
}


-(void)buildUI{
    self.mainScrollview = [[UIScrollView alloc]initWithFrame:self.bounds];
    self.mainScrollview.delegate = self;
    self.mainScrollview.decelerationRate = .2;
    [self addSubview:self.mainScrollview];
    
    self.centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, self.height)];
    self.centerLabel.center = CGPointMake(self.center.x, self.height / 2.f);
    
    self.centerLabel.backgroundColor = WHITE;
    [self loadDatas:[YSBookKSize allBookAndTheKSize]];
}

-(void)loadDatas:(NSArray *)datas{
    float offset = 0;
    for (int i = 0; i < datas.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(offset, 5, 30, self.height - 5)];
        label.backgroundColor = CLEAR;
        label.font = [UIFont systemFontOfSize:12];
        label.text = [NSString stringWithFormat:@"%@",datas[i]];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 1;
        [label sizeToFit];
        if (label.width < 30) {
            label.width = 30;
        }
        label.width += 10;
        offset += label.width;
        [self.mainScrollview addSubview:label];
        self.mainScrollview.contentSize = CGSizeMake(label.right, 0);
        [self.labelsAry addObject:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTapped:)];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tap];
    }
    self.mainScrollview.contentSize = CGSizeMake(self.mainScrollview.contentSize.width, 0);
    
    //让我们把ksize这个鬼东西放进去！
    UILabel *firstLabel = self.labelsAry[0];
    [self.mainScrollview  addSubview:self.kSizeActionLabel];
    self.kSizeActionLabel.top = self.mainScrollview.height - self.kSizeActionLabel.height;
    self.kSizeActionLabel.center = CGPointMake(firstLabel.center.x, self.kSizeActionLabel.center.y);
    
    self.selectedLabel = firstLabel;
    self.selectedLabel.backgroundColor = [UIColor lightGrayColor];
    [self.mainScrollview bringSubviewToFront:self.kSizeActionLabel];
}

-(UILabel *)kSizeActionLabel{
    if (_kSizeActionLabel == nil) {
        _kSizeActionLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _kSizeActionLabel.backgroundColor = CLEAR;
        _kSizeActionLabel.font = [UIFont systemFontOfSize:12];
        _kSizeActionLabel.textColor = COLORA(70, 70, 70);
        _kSizeActionLabel.text = @"开";
        [_kSizeActionLabel sizeToFit];
    }
    return _kSizeActionLabel;
}

-(void)labelTapped:(UITapGestureRecognizer *)tap{
    self.selectedLabel.backgroundColor = CLEAR;
    UILabel *label = (UILabel *)tap.view;
    if ([self.selectedDelegate respondsToSelector:@selector(selectedView:didSelectedSize:)]) {
        [self.selectedDelegate selectedView:self didSelectedSize:[label.text integerValue]];
    }
    self.selectedLabel = label;
    self.selectedLabel.backgroundColor = [UIColor lightGrayColor];
    
    
}







@end
