//
//  YSCustomInputView.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/13.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSCustomInputView.h"

@interface YSCustomInputView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, copy, readwrite) InputViewClickBlock clickBlock;
@property (nonatomic, copy, readwrite) InputViewClickWithParmBlock paramBlock;

@property (nonatomic, copy, readwrite) InputViewClickFinishParamBlock finishBlock;

@property (nonatomic, copy, readwrite) InputViewDoubleFinishParamBlock doublBlock;

@property (nonatomic, strong, readwrite) UIPickerView *pickerView;
@property (nonatomic, strong, readwrite) NSMutableArray *dataAry;

@property (nonatomic, strong, readwrite) UIButton *confirmBtn;

@property (nonatomic, strong, readwrite) UIView *selectView;
//@property (nonatomic, strong, readwrite) UIButton *cancleBtn;

@end

@implementation YSCustomInputView

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(void)awakeFromNib{
    [super awakeFromNib];
    UILabel *label = [self viewWithTag:1000];
    self.titleLabel = label;
    
    UITextField *inputTextField = [self viewWithTag:5000];
    UITextField *firstInput = [self viewWithTag:2000];
    UILabel *infoLabel = [self viewWithTag:3000];
    UITextField *secondInput = [self viewWithTag:4000];
    
    self.inputTextField = inputTextField;
    self.firstInput = firstInput;
    self.infoLabel = infoLabel;
    self.secondInput = secondInput;
    
    self.inputTextField.layer.borderWidth = .5;
    self.inputTextField.layer.borderColor = COLORA(207, 207, 207).CGColor;
    
    self.firstInput.layer.borderWidth = .5;
    self.secondInput.layer.borderWidth = .5;
    
    self.firstInput.layer.borderColor = COLORA(207, 207, 207).CGColor;
    self.secondInput.layer.borderColor = COLORA(207, 207, 207).CGColor;

    self.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.firstInput.keyboardType = UIKeyboardTypeNumberPad;
    self.secondInput.keyboardType = UIKeyboardTypeNumberPad;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardApearNotificationReceived:) name:UIKeyboardWillShowNotification object:nil];
}

-(void)loadTitle:(NSString *)title defaultValue:(NSString *)value{
    self.titleLabel.text = title;
    if ([value isValid]) {
        self.inputTextField.text = value;
    }
}

-(void)loadTitle:(NSString *)title defaultValue1:(NSString *)value1 value2:(NSString *)value2{
    self.titleLabel.text = title;
    self.firstInput.text = value1;
    self.secondInput.text = value2;
}

-(void)inputShowType{
    self.inputTextField.layer.borderColor = CLEAR.CGColor;
    self.inputTextField.backgroundColor = COLORA(240, 240, 240);
    self.userInteractionEnabled = NO;
    self.inputTextField.enabled = NO;
}

-(void)canNotModifyType{
    self.inputTextField.layer.borderColor = CLEAR.CGColor;
    self.inputTextField.enabled = NO;
    
    self.firstInput.layer.borderColor = CLEAR.CGColor;
    self.secondInput.layer.borderColor = CLEAR.CGColor;
    self.firstInput.enabled = NO;
    self.secondInput.enabled = NO;
}

-(NSInteger)number{
    
    return [self.inputTextField.text integerValue];
}

-(NSString *)inputText{
    
    if (self.inputTextField) {
        return self.inputTextField.text;
    }else{
        NSString *inputText = [NSString stringWithFormat:@"%@x%@",self.firstInput.text,self.secondInput.text];
        return inputText;
    }
}

+(YSCustomInputView *)doubleInputView{
    YSCustomInputView *inputView = [[[NSBundle mainBundle]loadNibNamed:@"YSCustomInputView" owner:nil options:nil] objectAtIndex:0];
    return inputView;
}

+(YSCustomInputView *)doubleInputViewWithParamClickBlock:(InputViewDoubleFinishParamBlock)block{
    YSCustomInputView *inputView = [[[NSBundle mainBundle]loadNibNamed:@"YSCustomInputView" owner:nil options:nil] objectAtIndex:0];
    inputView.firstInput.enabled = NO;
    inputView.secondInput.enabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:inputView action:@selector(doubleInputViewTapped:)];
    [inputView addGestureRecognizer:tap];
    inputView.doublBlock = block;
    return inputView;
}



+(YSCustomInputView *)selectInputViewWithClickBlock:(InputViewClickBlock)block{
    YSCustomInputView *inputView = (YSCustomInputView *)[[[NSBundle mainBundle] loadNibNamed:@"YSCustomInputView" owner:nil options:nil] lastObject];
    inputView.inputTextField.enabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:inputView action:@selector(inputViewTapped:)];
    [inputView addGestureRecognizer:tap];
    inputView.clickBlock = block;
    return inputView;
}

+(YSCustomInputView *)selectInputViewWithParamClickBlock:(InputViewClickWithParmBlock)block{
    YSCustomInputView *inputView = (YSCustomInputView *)[[[NSBundle mainBundle] loadNibNamed:@"YSCustomInputView" owner:nil options:nil] lastObject];
    inputView.inputTextField.enabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:inputView action:@selector(inputViewTapped:)];
    [inputView addGestureRecognizer:tap];
    inputView.paramBlock = block;
    return inputView;
}


-(void)closeKeyBoard{
    [self.inputTextField resignFirstResponder];
    [self.firstInput resignFirstResponder];
    [self.secondInput resignFirstResponder];
    [self.pickerView removeFromSuperview];
}


-(void)doubleInputViewTapped:(UITapGestureRecognizer *)tap{
    if (self.doublBlock) {
        self.doublBlock(self,self.inputText);
        self.finishBlock(self, self.inputText);
    }
}


-(void)inputViewTapped:(UITapGestureRecognizer *)tap{
    if (self.clickBlock) {
        self.clickBlock();
    }else if (self.paramBlock){
        self.paramBlock(self);
    }
}

-(void)clickWithDatas:(NSArray *)data completeBlock:(InputViewClickFinishParamBlock)finishBlock{
    
    [self.dataAry removeAllObjects];
    [self.dataAry addObjectsFromArray:data];
    
    for (UIView *view in self.viewController.view.subviews) {
        if ([[view class] isSubclassOfClass:[UIPickerView class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (UIView *inputView in self.superview.subviews) {
        if ([[inputView class]isSubclassOfClass:[YSCustomInputView class]]) {
            YSCustomInputView *cusInput = (YSCustomInputView *)inputView;
            [cusInput closeKeyBoard];
        }
    }
    
    [self.viewController.view addSubview:self.pickerView];
    [self.pickerView reloadAllComponents];
    self.finishBlock = finishBlock;
}

-(void)keyBoardApearNotificationReceived:(NSNotification *)no{
    if (self.pickerView.superview) {
        [self.pickerView removeFromSuperview];
    }
}

#pragma mark - pickerview delegate and datasources ------

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataAry.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataAry[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSString *text = self.dataAry[row];
    if (self.inputTextField) {
        self.inputTextField.text = text;
    }else if (self.firstInput && self.secondInput){
    
        if ([text containSubstring:@"x"]) {
            NSArray *textAry = [text componentsSeparatedByString:@"x"];
            self.firstInput.text = textAry[0];
            self.secondInput.text = textAry.lastObject;
        }else{
            self.firstInput.text = @"0";
            self.secondInput.text = @"0";
        }
    }
}

-(void)confirmBtnClicked:(id)sender{


}

-(UIView *)selectView{
    if (_selectView == nil) {
        _selectView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 200, SCREEN_WIDTH, 230)];
        _selectView.backgroundColor = COLOR(250, 250, 250, .7);
        [_selectView addSubview:self.confirmBtn];
        [_selectView addSubview:self.pickerView];
        self.confirmBtn.right = _selectView.width;
        self.pickerView.top = self.confirmBtn.bottom;
    }
    return _selectView;
}

-(UIButton *)confirmBtn{
    if (_confirmBtn == nil) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setFrame:CGRectMake(0, 0, 40, 18)];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_confirmBtn setBackgroundColor:COLOR(46, 173, 250, 1)];
        [_confirmBtn setTitleColor:WHITE forState:UIControlStateNormal];
    }
    return _confirmBtn;
}



-(UIPickerView *)pickerView{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 200, SCREEN_WIDTH, 200)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = WHITE;
    }
    return _pickerView;
}

-(NSMutableArray *)dataAry{
    if (_dataAry == nil) {
        _dataAry = [@[]mutableCopy];
    }
    return _dataAry;
}



@end
