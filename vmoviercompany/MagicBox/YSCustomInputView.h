//
//  YSCustomInputView.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/13.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSCustomInputView;
typedef NS_ENUM(NSInteger, YSInputViewType){

    InputViewTypeNormal = 0,
    InputViewTypeDoubleInput = 1,
    InputViewTypeSelect = 2
};

typedef void(^InputViewClickBlock)();

typedef void(^InputViewClickWithParmBlock)(YSCustomInputView *customInput);

typedef void(^InputViewClickFinishParamBlock)(YSCustomInputView *customInputView , NSString *result);

typedef void(^InputViewDoubleFinishParamBlock)(YSCustomInputView *customInputView , NSString *result);


@interface YSCustomInputView : UIView
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UITextField *inputTextField;
@property (nonatomic, assign, readwrite) NSInteger number;
@property (nonatomic, strong, readwrite) NSString *inputText;


#pragma mark - 两个输入项目的textfield -----
@property (strong, nonatomic)  UITextField *firstInput;
@property (strong, nonatomic)  UILabel *infoLabel;
@property (strong, nonatomic)  UITextField *secondInput;


-(void)loadTitle:(NSString *)title defaultValue:(NSString *)value;

-(void)loadTitle:(NSString *)title defaultValue1:(NSString *)value1 value2:(NSString *)value2;




+(YSCustomInputView *)doubleInputView;

+(YSCustomInputView *)doubleInputViewWithParamClickBlock:(InputViewDoubleFinishParamBlock)block;


+(YSCustomInputView *)selectInputViewWithClickBlock:(InputViewClickBlock)block;

+(YSCustomInputView *)selectInputViewWithParamClickBlock:(InputViewClickWithParmBlock)block;

-(void)clickWithDatas:(NSArray *)data completeBlock:(InputViewClickFinishParamBlock)finishBlock;


-(void)inputShowType;

-(void)canNotModifyType;


-(void)closeKeyBoard;



@end
