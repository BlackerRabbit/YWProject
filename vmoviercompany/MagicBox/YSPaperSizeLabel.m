//
//  YSPaperSizeLabel.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/9.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSPaperSizeLabel.h"

@implementation YSPaperSizeLabel

-(void)loadValues:(NSArray *)values{

    if (values == nil || values.count == 0) {
        return;
    }
    NSString *valueStr = [values componentsJoinedByString:@"\n"];
    self.numberOfLines = values.count;
    self.text = valueStr;
    self.textAlignment = NSTextAlignmentRight;
    [self sizeToFit];
    self.textColor = COLORA(54, 54, 54);
}

//这里的str是用,号连接的字符串
-(void)loadValueString:(NSString *)str{
    if ([str containsString:@","]) {
        [self loadValues:[str componentsSeparatedByString:@","]];
    }else
        self.text = str;
}

@end
