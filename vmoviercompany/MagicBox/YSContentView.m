//
//  YSContentView.m
//  MagicBox
//
//  Created by 蒋正峰 on 2016/10/14.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSContentView.h"
#import <UIImageView+WebCache.h>

@interface YSContentView ()
@property (nonatomic, strong, readwrite) NSString *contentURL;
@end


@implementation YSContentView


-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.bookImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 101, 101)];
        self.bookImg.layer.borderWidth = .5f;
        self.bookImg.layer.borderColor = COLOR(226, 226, 226, 1).CGColor;
        [self addSubview:self.bookImg];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bookImg.right + 8, 0, self.width - 30 - 8 - 101, 45)];
        self.nameLabel.numberOfLines = 2;
        self.nameLabel.textColor = COLORA(100, 100, 100);
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.nameLabel];
        
        self.desLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bookImg.right + 8, self.nameLabel.bottom, self.nameLabel.width, self.bookImg.height - self.nameLabel.bottom)];
        self.desLabel.font = [UIFont systemFontOfSize:14];
        self.desLabel.textColor = COLORA(160, 160, 160);
        self.desLabel.numberOfLines = 3;
        [self addSubview:self.desLabel];
        
    }
    return self;
}
/*
 {
 "id": 5,
 "status": null,
 "title": "中国再次进行陆基中段反导实验？国防部回应",
 "typeId": 1,
 "authorId": 15,
 "hot": 1,
 "recomm": 1,
 "url": "http://139.196.100.29:8080/xgo/static/news/20160930/5.html",
 "commNum": null,
 "praiseNum": null,
 "publishDate": "2016-09-29 23:26:40",
 "summary": "国防部新闻局局长、国防部新闻发言人杨宇军大校答记者问。国防部新闻局局长、国防部新闻发言人杨宇军大校答记者问。",
 "author": "可耐小姑凉",
 "listImg": "http://139.196.100.29:8080/xgo/upload/2016/09/29/1475162949789.png?r=20160929232909"
 }
 */


-(void)loadValues:(NSDictionary *)values{
    
    NSString *imgUrl = values[@"listImg"];
    NSString *name = values[@"title"];
    NSString *des = values[@"summary"];
    [self.bookImg sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    self.nameLabel.text = name;
    self.desLabel.text = des;
    self.contentURL = values[@"url"];
}

+(CGFloat)contentViewHeight{

    return 101;
}



@end
