//
//  YSDataCenter.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/27.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSBookObject.h"

@interface YSDataCenter : NSObject

+(YSDataCenter *)shareDataCenter;

#pragma mark- 名字相关的方法 ------

-(NSArray *)loadAllNames;
-(void)saveNames:(NSArray *)names;

#pragma mark- book相关的方法 ------

-(NSDictionary *)findLastBook;
-(NSArray *)allBooksInTheList;

-(BOOL)saveAsNewBook:(YSBookObject *)book;
-(BOOL)updateAsNewBook:(YSBookObject *)book;

@end
