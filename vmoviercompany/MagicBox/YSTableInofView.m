//
//  YSTableInofView.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/8/17.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSTableInofView.h"
#import "VMovieKit.h"

#define FONT_SIZE 14
//Universal Links

@interface  YSTableInofView ()
@property (nonatomic, strong, readwrite) NSMutableArray *titlesLabels;
@property (nonatomic, strong, readwrite) NSMutableArray *firstRowLabels;
@property (nonatomic, strong, readwrite) NSMutableArray *secondRowFields;
@property (nonatomic, strong, readwrite) NSMutableArray *thirdRowFields;
@property (nonatomic, strong, readwrite) NSMutableArray *forthRowFields;
@property (nonatomic, strong, readwrite) NSMutableArray *fifthRowFields;
@property (nonatomic, strong, readwrite) UIScrollView *bgScrollView;

@property (nonatomic, strong, readwrite) NSMutableArray *sencondRowValues;
@property (nonatomic, strong, readwrite) NSMutableArray *thirdRowValues;
@property (nonatomic, strong, readwrite) NSMutableArray *forthRowValues;
@property (nonatomic, strong, readwrite) NSMutableArray *fifthRowValues;

//顶栏的标题
@property (nonatomic, strong, readwrite) NSMutableArray *titlesArray;



@property (nonatomic, assign, readwrite) NSInteger titleNumber;

@property (nonatomic, assign, readwrite) CGFloat maxTitleWidth;
@property (nonatomic, assign, readwrite) CGFloat maxFirstRowWidth;
@property (nonatomic, assign, readwrite) CGFloat firstTitleWidth;

//新的设计方法
@property (nonatomic, strong, readwrite) NSMutableArray *allRowsArray;


@property (nonatomic, strong, readwrite) NSMutableArray *externColorRows;
@property (nonatomic, strong, readwrite) UIColor *exterColor;

@property (nonatomic, strong, readwrite) NSMutableArray *modifyRows;
@property (nonatomic, assign, readwrite) BOOL canModifyRows;


@end


@implementation YSTableInofView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self addSubview:self.bgScrollView];
        self.titlesLabels = [@[]mutableCopy];
        self.firstRowLabels = [@[]mutableCopy];
        self.secondRowFields = [@[]mutableCopy];
        self.thirdRowFields = [@[]mutableCopy];
        self.forthRowFields = [@[]mutableCopy];
        self.fifthRowFields = [@[]mutableCopy];
        self.backgroundColor = WHITE;
        
        self.sencondRowValues = [@[]mutableCopy];
        self.thirdRowValues = [@[]mutableCopy];
        self.forthRowValues = [@[]mutableCopy];
        self.fifthRowValues = [@[]mutableCopy];
        self.titlesArray = [@[]mutableCopy];
        
        self.hasExternColor = YES;
        
    }
    return self;
}


-(void)loadTitles:(NSArray *)titles{
    if (titles == nil) {
        return;
    }
    [self.titlesArray addObjectsFromArray:titles];
    self.titleNumber = titles.count;
    [self.titlesLabels removeAllObjects];
    CGFloat currentWidth;
    
    for (int i = 0; i < titles.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.font = [UIFont systemFontOfSize:FONT_SIZE];
        label.textColor = COLORA(51, 51, 51);
        label.numberOfLines = 1;
        label.text = titles[i];
        [label sizeToFit];
        label.width += 10;
        label.height += 20;
        [self addSubview:label];
        [self.titlesLabels addObject:label];
        currentWidth = label.width;
        self.maxTitleWidth = MAX(self.maxTitleWidth, currentWidth);
    }
    self.firstTitleWidth = [self.titlesLabels[0] width];
}

-(void)loadRowTitlesNew:(NSArray *)titles{
    NSInteger count = titles.count;
    CGFloat currentWidth;
    //创建第一列
    NSMutableArray *allarry = [@[]mutableCopy];
    self.allRowsArray = allarry;
    for (int i = 0; i < count; i ++) {
        NSMutableArray *rowAry = [@[]mutableCopy];
        [allarry addObject:rowAry];
        for (int j = 0; j < titles.count; j++) {
            
            //这个是第二列
            UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectZero];
            textField1.backgroundColor = CLEAR;
            textField1.tintColor = [UIColor lightGrayColor];
            textField1.keyboardType = UIKeyboardTypeNumberPad;
            UIView *leftView = [UIView new];
            if (i == 0) {
                textField1.text = titles[i];
                leftView.width = 0;
                [textField1 sizeToFit];
                textField1.width += 16;
            }else
                leftView.width = 10;
            textField1.leftView = leftView;
            textField1.font = [UIFont systemFontOfSize:FONT_SIZE];
            [self.bgScrollView addSubview:textField1];
            [self.secondRowFields addObject:textField1];
            textField1.enabled = NO;
            currentWidth = textField1.width;
            self.maxFirstRowWidth = MAX(self.maxFirstRowWidth, currentWidth);
            
        }
    }
}


-(void)loadRowTitlesTwo:(NSArray *)titles{
    CGFloat currentWidth;
    //创建第一列
    for (int i = 0; i < titles.count; i++) {
        
        //这个是第一列
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.font = [UIFont systemFontOfSize:FONT_SIZE];
        label.textColor = COLORA(51, 51, 51);
        label.numberOfLines = 1;
        label.text = titles[i];
        [label sizeToFit];
        label.width += 16;
        label.height += 16;
        [self.bgScrollView addSubview:label];
        [self.firstRowLabels addObject:label];
        currentWidth = label.width;
        self.maxFirstRowWidth = MAX(self.maxFirstRowWidth, currentWidth);
        
        //这个是第二列
        UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectZero];
        textField1.backgroundColor = CLEAR;
        textField1.tintColor = [UIColor lightGrayColor];
        textField1.keyboardType = UIKeyboardTypeNumberPad;
        UIView *leftView = [UIView new];
        leftView.width = 10;
        textField1.leftView = leftView;
        textField1.font = [UIFont systemFontOfSize:FONT_SIZE];
        [self.bgScrollView addSubview:textField1];
        [self.secondRowFields addObject:textField1];
        textField1.enabled = NO;
    }

}

-(void)loadRowTitlesFive:(NSArray *)titles{
    
    CGFloat currentWidth;
    //创建第一列
    
    NSInteger titleNumber = titles.count;
    
    
    for (int i = 0; i < titles.count; i++) {
        
        //这个是第一列
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.font = [UIFont systemFontOfSize:FONT_SIZE];
        label.textColor = COLORA(51, 51, 51);
        label.numberOfLines = 1;
        label.text = titles[i];
        [label sizeToFit];
        label.width += 16;
        label.height += 16;
        [self.bgScrollView addSubview:label];
        [self.firstRowLabels addObject:label];
        currentWidth = label.width;
        self.maxFirstRowWidth = MAX(self.maxFirstRowWidth, currentWidth);
        
        //这个是第二列
        UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectZero];
        textField1.backgroundColor = CLEAR;
        textField1.tintColor = [UIColor lightGrayColor];
        textField1.keyboardType = UIKeyboardTypeNumberPad;
        UIView *leftView = [UIView new];
        leftView.width = 10;
        textField1.leftView = leftView;
        textField1.font = [UIFont systemFontOfSize:FONT_SIZE];
        [self.bgScrollView addSubview:textField1];
        [self.secondRowFields addObject:textField1];
        textField1.enabled = NO;

        //这个是第三列
        UITextField *textField2 = [[UITextField alloc]initWithFrame:CGRectZero];
        textField2.backgroundColor = CLEAR;
        textField2.tintColor = [UIColor lightGrayColor];
        textField2.keyboardType = UIKeyboardTypeNumberPad;
        UIView *leftView2 = [UIView new];
        leftView2.width = 10;
        textField2.leftView = leftView2;
        textField2.font = [UIFont systemFontOfSize:FONT_SIZE];
        [self.bgScrollView addSubview:textField2];
        [self.thirdRowFields addObject:textField2];
        textField2.textColor = RED;
        textField2.backgroundColor = COLOR(244, 244, 244, .7);
        textField2.layer.borderWidth = .5f;
        textField2.layer.borderColor = COLORA(244, 244, 244).CGColor;

        
        //这个是第四列
        UITextField *textField3 = [[UITextField alloc]initWithFrame:CGRectZero];
        textField3.backgroundColor = CLEAR;
        textField3.tintColor = [UIColor lightGrayColor];
        textField3.keyboardType = UIKeyboardTypeNumberPad;
        UIView *leftView3 = [UIView new];
        leftView3.width = 10;
        textField3.leftView = leftView3;
        textField3.font = [UIFont systemFontOfSize:FONT_SIZE];
        [self.bgScrollView addSubview:textField3];
        [self.forthRowFields addObject:textField3];
        textField3.enabled = NO;
        
        //这个是第五列
        UITextField *textField4 = [[UITextField alloc]initWithFrame:CGRectZero];
        textField4.backgroundColor = CLEAR;
        textField4.tintColor = [UIColor lightGrayColor];
        textField4.keyboardType = UIKeyboardTypeNumberPad;
        UIView *leftView4 = [UIView new];
        leftView4.width = 10;
        textField4.leftView = leftView4;
        textField4.font = [UIFont systemFontOfSize:FONT_SIZE];
        [self.bgScrollView addSubview:textField4];
        [self.fifthRowFields addObject:textField4];
        textField4.enabled = NO;
    }
}


-(void)loadRowTitles:(NSArray *)titles{
    
    CGFloat currentWidth;
    //创建第一列
    
    NSInteger titleNumber = titles.count;
    
    
    for (int i = 0; i < titles.count; i++) {
        
        //这个是第一列
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.font = [UIFont systemFontOfSize:FONT_SIZE];
        label.textColor = COLORA(51, 51, 51);
        label.numberOfLines = 1;
        label.text = titles[i];
        [label sizeToFit];
        label.width += 16;
        label.height += 16;
        [self.bgScrollView addSubview:label];
        [self.firstRowLabels addObject:label];
        currentWidth = label.width;
        self.maxFirstRowWidth = MAX(self.maxFirstRowWidth, currentWidth);
        
        //这个是第二列
        UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectZero];
        textField1.backgroundColor = CLEAR;
        textField1.tintColor = [UIColor lightGrayColor];
        textField1.keyboardType = UIKeyboardTypeNumberPad;
        UIView *leftView = [UIView new];
        leftView.width = 10;
        textField1.leftView = leftView;
        textField1.font = [UIFont systemFontOfSize:FONT_SIZE];
        [self.bgScrollView addSubview:textField1];
        [self.secondRowFields addObject:textField1];
        textField1.enabled = NO;

        //这个是第三列
        UITextField *textField2 = [[UITextField alloc]initWithFrame:CGRectZero];
        textField2.backgroundColor = CLEAR;
        textField2.tintColor = [UIColor lightGrayColor];
        textField2.keyboardType = UIKeyboardTypeNumberPad;
        UIView *leftView2 = [UIView new];
        leftView2.width = 10;
        textField2.leftView = leftView2;
        textField2.font = [UIFont systemFontOfSize:FONT_SIZE];
        [self.bgScrollView addSubview:textField2];
        [self.thirdRowFields addObject:textField2];
        textField2.textColor = RED;
        textField2.backgroundColor = COLOR(244, 244, 244, .7);
        textField2.layer.borderWidth = .5f;
        textField2.layer.borderColor = COLORA(244, 244, 244).CGColor;
  
        
        //这个是第四列
        UITextField *textField3 = [[UITextField alloc]initWithFrame:CGRectZero];
        textField3.backgroundColor = CLEAR;
        textField3.tintColor = [UIColor lightGrayColor];
        textField3.keyboardType = UIKeyboardTypeNumberPad;
        UIView *leftView3 = [UIView new];
        leftView3.width = 10;
        textField3.leftView = leftView3;
        textField3.font = [UIFont systemFontOfSize:FONT_SIZE];
        [self.bgScrollView addSubview:textField3];
        [self.forthRowFields addObject:textField3];
        textField3.enabled = NO;
    }
}

-(void)workWidthWithLabels:(NSArray *)labels withExterIndex:(NSInteger)index{
    float width = 0;
    for (UILabel *label in labels) {
        width += label.width;
    }
    
    float exterWidth = self.width - width;
    NSInteger moreCount = labels.count;
    float eachExter = exterWidth / 2.f;
    float otherExter = exterWidth / (2 * (moreCount - 1));
    
    for (int i = 0 ; i < labels.count; i++) {
        UILabel *label = labels[i];
        if (i == index) {
            label.width += eachExter;
        }else
            label.width += otherExter;
    }
}

//左边第二竖行的内容
-(void)loadSecondRowTitles:(NSArray *)titles{
    [self.sencondRowValues removeAllObjects];
    [self.sencondRowValues addObjectsFromArray:titles];
    [self setNeedsLayout];
}

//左边第三竖行的内容
-(void)loadThirdRowTitles:(NSArray *)titles{
    [self.thirdRowValues removeAllObjects];
    [self.thirdRowValues addObjectsFromArray:titles];
    [self setNeedsLayout];
}

//左边第四行的内容
-(void)loadForthRowTitles:(NSArray *)titles{
    [self.forthRowValues removeAllObjects];
    [self.forthRowValues addObjectsFromArray:titles];
    [self setNeedsLayout];
}

-(void)loadFifthRowTitles:(NSArray *)titles{
    [self.fifthRowValues removeAllObjects];
    [self.fifthRowValues addObjectsFromArray:titles];
    [self setNeedsLayout];
}


-(NSArray *)valuesForRowTitle:(NSString *)title{

    if ([self.titlesArray containsObject:title]) {
        NSInteger index = [self.titlesArray indexOfObject:title];
        NSMutableArray *valuesAry = [@[]mutableCopy];
        if (index == 1) {
            //则说明是第二列的内容取second
            for (UITextField *field in self.secondRowFields) {
                [valuesAry addObject:[field.text isValid] ? field.text : @"1"];
            }
        }else if (index == 2){
            //则说明是第二列的内容取second
            for (UITextField *field in self.thirdRowFields) {
                [valuesAry addObject:[field.text isValid] ? field.text : @"0"];
            }
        }else if (index == 3){
            for (UITextField *field in self.forthRowFields) {
                [valuesAry addObject:[field.text isValid] ? field.text : @"0"];
            }
        }else if (index == 4){
        
            for (UITextField *field in self.fifthRowFields) {
                [valuesAry addObject:[field.text isValid]?field.text: @"0"];
            }
        }
        return valuesAry;
    }
    return nil;
}

-(void)layoutByValues{
    if (self.allRowsArray.count == 0 || self.allRowsArray == nil) {
        return;
    }
    NSInteger index = 2;
    if (self.titlesLabels.count <= 2) {
        index = self.titlesLabels.count - 1;
    }
    
    [self workWidthWithLabels:self.titlesLabels withExterIndex:index];
    float finalFirstRowWdth = MAX(self.firstTitleWidth, self.maxFirstRowWidth);
    float offset = 0;
    for (int i = 0; i < self.titlesLabels.count; i++) {
        UILabel *label = self.titlesLabels[i];
        if (i == 1) {
            if (offset < finalFirstRowWdth) {
                offset = finalFirstRowWdth;
            }
        }
        label.left = offset;
        offset += label.width;
        label.top = 0;
    }
    
    UILabel *title = self.titlesLabels[0];
    self.bgScrollView.top = title.bottom;
    self.bgScrollView.height = self.height - title.bottom;
    float yoffset = 0;
    NSMutableArray *firstRowAry = self.allRowsArray[0];
    for (int i = 0; i < firstRowAry.count ; i++) {
        UILabel *label = firstRowAry[i];
        label.left = title.left;
        label.top = yoffset;
        yoffset += label.height + 10;
    }
    
    for (int i = 1; i < self.allRowsArray.count; i++) {
        NSMutableArray *ary = self.allRowsArray[i];
        for (int j = 0; j < ary.count; j++) {
            UITextField *field = [self.secondRowFields objectAtIndex:i];
            UILabel *lable = self.firstRowLabels[i];
            field.top = lable.top;
            field.height = lable.height;
            field.left = [self.titlesLabels[1] left];
            field.width = [self.titlesLabels[1] width];
            if (self.sencondRowValues) {
                if (self.sencondRowValues.count > i) {
                    field.text = self.sencondRowValues[i];
                }
            }
        }
    }
}

//特殊颜色的列们
-(void)loadRows:(NSArray *)rows withColor:(UIColor *)color{

    if (self.externColorRows == nil) {
        self.externColorRows = [@[]mutableCopy];
    }
    [self.externColorRows removeAllObjects];
    [self.externColorRows addObjectsFromArray:rows];
    self.exterColor = color;
    [self setNeedsLayout];
}

//可以被修改的列们
-(void)loadRows:(NSArray *)rows withCanBeModeify:(BOOL)modify{

    if (self.modifyRows == nil) {
        self.modifyRows = [@[]mutableCopy];
    }
    [self.modifyRows removeAllObjects];
    [self.modifyRows addObjectsFromArray:rows];
    self.canModifyRows = modify;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger index = 2;
    if (self.titlesLabels.count <= 2) {
        index = self.titlesLabels.count - 1;
    }
    
    [self workWidthWithLabels:self.titlesLabels withExterIndex:index];
    float finalFirstRowWdth = MAX(self.firstTitleWidth, self.maxFirstRowWidth);
    float offset = 0;
    for (int i = 0; i < self.titlesLabels.count; i++) {
        UILabel *label = self.titlesLabels[i];
        if (i == 1) {
            if (offset < finalFirstRowWdth) {
                offset = finalFirstRowWdth;
            }
        }
        label.left = offset;
        offset += label.width;
        label.top = 0;
    }
    
    UILabel *title = self.titlesLabels[0];
    self.bgScrollView.top = title.bottom;
    self.bgScrollView.height = self.height - title.bottom;
    
    float yoffset = 0;
    for (int i = 0; i < self.firstRowLabels.count ; i++) {
        UILabel *label = self.firstRowLabels[i];
        label.left = title.left;
        label.top = yoffset;
        yoffset += label.height + 10;
    }
    
    yoffset = 0;
    for (int i = 0; i < self.secondRowFields.count; i++) {
        UITextField *field = [self.secondRowFields objectAtIndex:i];
        UILabel *lable = self.firstRowLabels[i];
        field.top = lable.top;
        field.height = lable.height - 10;
        field.left = [self.titlesLabels[1] left];
        field.width = [self.titlesLabels[1] width] - 5;
        field.center = CGPointMake(field.center.x, lable.center.y);
        if (self.sencondRowValues) {
            if (self.sencondRowValues.count > i) {
                field.text = self.sencondRowValues[i];
            }
        }
    }
    
    UITextField *normlaField = self.secondRowFields.lastObject;
    
    
    for (int i = 0; i < self.thirdRowFields.count; i++) {
        UITextField *field = [self.thirdRowFields objectAtIndex:i];
        UILabel *lable = self.firstRowLabels[i];
        field.height = lable.height - 10;
        field.left = [self.titlesLabels[2] left];
        field.width = [self.titlesLabels[2] width] - 5;
        field.center = CGPointMake(field.center.x, lable.center.y);
        
        if (self.thirdRowValues) {
            if (self.thirdRowValues.count > i) {
                field.text = self.thirdRowValues[i];
            }
        }
        
        if (NO == self.hasExternColor) {
            field.backgroundColor = CLEAR;
            field.textColor = normlaField.textColor;
        }
    }
    
    for (int i = 0; i < self.forthRowFields.count; i++) {
        UITextField *field = [self.forthRowFields objectAtIndex:i];
        UILabel *lable = self.firstRowLabels[i];
        field.top = lable.top;
        field.height = lable.height - 10;
        field.left = [self.titlesLabels[3] left];
        field.width = [self.titlesLabels[3] width] - 5;
        field.center = CGPointMake(field.center.x, lable.center.y);
        
        if (self.forthRowValues) {
            if (self.forthRowValues.count > i) {
                field.text = self.forthRowValues[i];
            }
        }
    }
    
    for (int i = 0; i < self.fifthRowFields.count; i++) {
        UITextField *field = [self.fifthRowFields objectAtIndex:i];
        UILabel *lable = self.firstRowLabels[i];
        field.top = lable.top;
        field.height = lable.height - 10;
        field.left = [self.titlesLabels[4] left];
        field.width = [self.titlesLabels[4] width] - 5;
        field.center = CGPointMake(field.center.x, lable.center.y);
        if (self.fifthRowValues) {
            if (self.fifthRowValues.count > i) {
                field.text = self.fifthRowValues[i];
            }
        }
    }
 
    //这里是首先更改字的颜色
    for (NSNumber *number in self.externColorRows) {
        switch ([number integerValue]) {
            case 2:[self setupRowAry:self.secondRowFields withColor:self.exterColor];break;
            case 3:[self setupRowAry:self.thirdRowFields withColor:self.exterColor];break;
            case 4:[self setupRowAry:self.forthRowFields withColor:self.exterColor];break;
            case 5:[self setupRowAry:self.fifthRowFields withColor:self.exterColor];break;
            default:
                break;
        }
    }
    
    for (NSNumber * number in self.modifyRows) {
        switch ([number integerValue]) {
            case 2:[self setupRowAry:self.secondRowFields withCanModif:self.canModifyRows];break;
            case 3:[self setupRowAry:self.thirdRowFields withCanModif:self.canModifyRows];break;
            case 4:[self setupRowAry:self.forthRowFields withCanModif:self.canModifyRows];break;
            case 5:[self setupRowAry:self.fifthRowFields withCanModif:self.canModifyRows];break;
            default:
                break;
        }
    }
    //这里是确定丫的是不是能够修改值
    

    UILabel *firstRowLabel = self.firstRowLabels.lastObject;
    self.height = firstRowLabel.bottom + 45;
    if ([self.infoDelegate respondsToSelector:@selector(tableInfoDidFinishLayout:)]) {
        [self.infoDelegate tableInfoDidFinishLayout:self];
    }
}


-(void)setupRowAry:(NSArray *)row withColor:(UIColor *)color{

    for (UITextField *textField in row ) {
        textField.textColor = color;
    }
}

-(void)setupRowAry:(NSArray *)row withCanModif:(BOOL)canModify{
    for (UITextField *textField in row) {
        textField.enabled = canModify;
        if (canModify) {
            textField.layer.borderColor = COLORA(244, 244, 244).CGColor;
            textField.layer.borderWidth = .5f;
        }else
            textField.layer.borderColor = CLEAR.CGColor;
    }
}



@end
