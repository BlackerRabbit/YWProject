//
//  YSStaticInfoView.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/7.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSStaticInfoView.h"

@interface YSStaticInfoView ()
@property (nonatomic, copy) StaticInfoViewHandler handler;
@property (nonatomic, strong, readwrite) CALayer *lineLayer;

@property (nonatomic, strong, readwrite) UIFont *normalFont;
@property (nonatomic, strong, readwrite) UIColor *normalColor;

@property (nonatomic, strong, readwrite) UIColor *disableColor;

@property (nonatomic, strong, readwrite) UIFont *placeHolderFont;
@property (nonatomic, strong, readwrite) UIColor *placeHolderColor;

@property (nonatomic, strong, readwrite) UIFont *placeHolderShowFont;


@end

@implementation YSStaticInfoView

+(YSStaticInfoView *)staticInfoViewWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder withClickHandler:(StaticInfoViewHandler)hanlder{
    
    YSStaticInfoView *infoView = [[NSBundle mainBundle]loadNibNamed:@"YSStaticInfoView" owner:nil options:nil].lastObject;
    UILabel *titleLabel = [infoView viewWithTag:1000];
    UILabel *valueLabel = [infoView viewWithTag:2000];
    
    infoView.titleLabel = titleLabel;
    infoView.valueLabel = valueLabel;
    
    valueLabel.text = placeHolder;
    titleLabel.text = title;
    
    infoView.valueLabel.font = infoView.placeHolderFont;
    infoView.valueLabel.textColor = infoView.placeHolderColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:infoView action:@selector(infoViewTapped:)];
    infoView.userInteractionEnabled = YES;
    [infoView addGestureRecognizer:tap];
    
    if (hanlder) {
        infoView.handler = hanlder;
    }
    return infoView;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.width = SCREEN_WIDTH;
    self.height = 40;
}

-(void)loadValue:(NSString *)value{
    self.valueLabel.font = self.normalFont;
    self.valueLabel.textColor = self.normalColor;
    self.valueLabel.text = value;
    [self staticInfoViewWithType:StaticInfoTypeShowInfo];
}

-(void)infoViewTapped:(UITapGestureRecognizer *)tap{
    self.handler();
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.lineLayer.superlayer == nil) {
        CALayer *lineLayer = [CALayer layer];
        lineLayer.frame = CGRectMake(0, self.titleLabel.bottom, self.valueLabel.width, 1);
        lineLayer.backgroundColor = COLORA(223, 223, 223).CGColor;
        [self.layer addSublayer:lineLayer];
        self.lineLayer = lineLayer;
    }
    self.lineLayer.frame = CGRectMake(self.valueLabel.left, self.height - .5, self.valueLabel.width, .5);
}



-(void)staticInfoViewWithType:(StaticInfoStatus)status{
    
    self.currentStatus = status;
    switch (self.currentStatus) {
        case StaticInfoTypeNormal:{
            //正常的状态，标题颜色不变，展示区的字体不变
            self.titleLabel.textColor = self.normalColor;
            self.valueLabel.font = self.placeHolderFont;
            self.userInteractionEnabled = YES;
        
        }break;
        
        
        case StaticInfoTypeDisable:{
            //不可编辑的状态，主要是标题变灰色，点击无效果
            self.titleLabel.textColor = self.disableColor;
            self.valueLabel.font = self.placeHolderFont;
            self.userInteractionEnabled = NO;
        }break;
            
        case StaticInfoTypeShowInfo:{
            //展示信息的状态，主要是标题颜色不变，但是展示区的字体需要变大
            self.titleLabel.textColor = self.normalColor;
            self.valueLabel.font = self.placeHolderShowFont;
            self.userInteractionEnabled = YES;
            
        }break;
    
        default:
            break;
    }
}


#pragma mark - lazy actions ------

-(UIFont *)normalFont{
    if (_normalFont == nil) {
        _normalFont = [UIFont systemFontOfSize:17];
    }
    return _normalFont;
}

-(UIFont *)placeHolderFont{
    if (_placeHolderFont == nil) {
        _placeHolderFont = [UIFont systemFontOfSize:14];
    }
    return _placeHolderFont;
}

-(UIColor *)normalColor{
    if (_normalColor == nil) {
        _normalColor = COLORA(51, 51, 51);
    }
    return _normalColor;
}

-(UIColor *)placeHolderColor{
    if (_placeHolderColor == nil) {
        _placeHolderColor = COLORA(210, 210, 210);
    }
    return _placeHolderColor;
}

-(UIColor *)disableColor{

    if (_disableColor == nil) {
        _disableColor = COLORA(200, 200, 200);
    }
    return _disableColor;
}

-(UIFont *)placeHolderShowFont{

    if (_placeHolderShowFont == nil) {
        _placeHolderShowFont = [UIFont systemFontOfSize:16];
    }
    return _placeHolderShowFont;
}



@end
