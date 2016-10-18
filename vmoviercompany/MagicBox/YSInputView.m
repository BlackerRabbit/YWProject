//
//  YSInputView.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/4.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSInputView.h"
#import "VMCommonTools.h"
#import "VMCommenDefinition.h"
@interface YSInputView ()

@end

@implementation YSInputView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        
    }
    return self;

}



#pragma mark- lazy loading ------

-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLab.backgroundColor = CLEAR;
        _titleLab.font = [UIFont systemFontOfSize:13];
        _titleLab.textColor = COLOR(51, 51, 51, 1);
    }
    return _titleLab;
}

-(UITextField *)inputField{
    if (_inputField == nil) {
        
    }
    return _inputField;
}

-(UIButton *)moreBtn{
    if (_moreBtn == nil) {
        
    }
    return _moreBtn;
}



@end
