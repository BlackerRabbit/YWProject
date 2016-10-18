//
//  YSCoverInputView.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/28.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSCoverInputView.h"
#import "VMTools.h"
#import "YSDataCenter.h"

@interface YSCoverInputView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong, readwrite) UITableView *mainTB;
@property (nonatomic, strong, readwrite) UITextField *inputField;
@property (nonatomic, strong, readwrite) NSMutableArray *dataArray;
@property (nonatomic, strong, readwrite) UIButton *closeBtn;
@property (nonatomic, strong, readwrite) UIButton *confirmBtn;
@property (nonatomic, strong, readwrite) NSString *selectedName;
@property (nonatomic, strong, readwrite) YSDataCenter *dataCenter;
@end


@implementation YSCoverInputView


-(id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.closeBtn];
        [self addSubview:self.confirmBtn];
        [self addSubview:self.inputField];
        [self addSubview:self.mainTB];
        self.backgroundColor = COLORA(255, 255, 255);
        self.dataArray = [@[]mutableCopy];
        self.dataCenter = [YSDataCenter shareDataCenter];
        [self.dataArray addObjectsFromArray:[self.dataCenter loadAllNames]];
        [self.mainTB reloadData];
    }
    return self;
}

-(void)setPlaceHolderName:(NSString *)placeHolderName{
    _placeHolderName = placeHolderName;
    self.inputField.text = _placeHolderName;
}


#pragma mark- tableview datasource and delegate------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifer = @"reuseIdentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifer];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = COLORA(70, 70, 70);
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = self.dataArray[indexPath.row];
    self.inputField.text = str;
    self.selectedName = str;
    [self.confirmBtn setTitleColor:COLORA(46,173,250) forState:UIControlStateNormal];
}

#pragma mark - textfield delegate -----

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text isValid]) {
        [self.dataArray insertObject:textField.text atIndex:0];
    }
    textField.text = @"";
    textField.placeholder = [self.dataArray[0] isValid] ? self.dataArray[0] : @"";
    [self.mainTB reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
   [textField resignFirstResponder];
    return YES;
}

-(void)closeBtnClicked:(id)sender{
    if (self.handler) {
        self.handler(self.inputField.text);
    }
    [self.dataCenter saveNames:self.dataArray];
    [self removeFromSuperview];
}

-(void)confirmBtnClicked:(id)sender{
    if ([self.selectedName isValid] == NO) {
        self.selectedName = self.inputField.text;
    }
    if ([self.selectedName isValid] == NO) {
        [VMTools alertMessage:@"请输入正确的名称"];
        return;
    }
    self.handler(self.inputField.text);
    [self.dataCenter saveNames:self.dataArray];
    [self removeFromSuperview];
}

#pragma mark - lazying actions ------

-(UITextField *)inputField{

    if (_inputField == nil) {
        _inputField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, self.width - 40, 40)];
        _inputField.backgroundColor = COLOR(220, 220, 220, .3);
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
        leftView.backgroundColor = CLEAR;
        _inputField.font = [UIFont systemFontOfSize:14];
        _inputField.leftViewMode = UITextFieldViewModeAlways;
        _inputField.textColor = [UIColor lightGrayColor];
        _inputField.leftView = leftView;
        _inputField.placeholder = @"请输入书的名称";
        _inputField.layer.cornerRadius = 2.f;
        [_inputField setReturnKeyType:UIReturnKeyDone];
        [_inputField setDelegate:self];
        
    }
    return _inputField;
}


-(UITableView *)mainTB{
    
    if (_mainTB == nil) {
        _mainTB = [[UITableView alloc]initWithFrame:CGRectMake(10, self.inputField.bottom + 20, self.width - 20, self.height - self.inputField.bottom - 40) style:UITableViewStylePlain];
        _mainTB.delegate = self;
        _mainTB.dataSource = self;
    }
    return _mainTB;
}

-(UIButton *)closeBtn{
    if (_closeBtn == nil) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _closeBtn.frame = CGRectMake(0, 20, 60, 44);
        [_closeBtn setTitleColor:COLORA(55, 55, 55) forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setBackgroundColor:CLEAR];
    }
    return _closeBtn;
}


-(UIButton *)confirmBtn{
    if (_confirmBtn == nil) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _confirmBtn.frame = CGRectMake(0, 20, 60, 44);
        [_confirmBtn setTitleColor:COLORA(55, 55, 55) forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setBackgroundColor:CLEAR];
        _confirmBtn.right = self.width;
    }
    return _confirmBtn;
}

@end
