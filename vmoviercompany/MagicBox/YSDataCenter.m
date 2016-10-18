//
//  YSDataCenter.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/27.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSDataCenter.h"
#import "VMDataBaseManager.h"
#import "VMovieKit.h"

@interface YSDataCenter ()
@property (nonatomic, strong, readwrite) YSBookObject *currentBook;
@property (nonatomic, strong, readwrite) VMDataBaseManager *dbManager;
@end

@implementation YSDataCenter

//BOOK_LIST:ID,NAME,KSIZE,BOOKSIZE,WORKERPRICE

+(YSDataCenter *)shareDataCenter{
    static YSDataCenter *manager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[YSDataCenter alloc]init];
    });
    return manager;
}

-(id)init{
    self = [super init];
    if (self) {
        [self setupDataBase];
        return self;
    }
    return nil;
}

-(void)setupDataBase{
    VMDataBaseManager *dbManager = [VMDataBaseManager shareDBManager];
    BOOL bookList = [dbManager hasTable:kBOOKTABLE];
    if (!bookList) {
        [dbManager createTable:kBOOKTABLE withInfo:[self.currentBook bookTableDictionary]];
    }
}

-(NSDictionary *)findLastBook{
    
    VMDataBaseManager *dbManager = [VMDataBaseManager shareDBManager];
    NSDictionary *bookInfo = [dbManager getInfoFromTable:kBOOKTABLE].lastObject;
    return bookInfo;
}


-(NSArray *)allBooksInTheList{
    VMDataBaseManager *dbManager = [VMDataBaseManager shareDBManager];
    NSArray *allboks = [dbManager getInfoFromTable:kBOOKTABLE];
    NSMutableArray *finalBooks = [@[]mutableCopy];
    for (int i = 0; i < allboks.count; i++) {
        NSDictionary *dic = allboks[i];
        [finalBooks insertObject:dic atIndex:0];
    }
    return [finalBooks copy];

}

-(NSArray *)loadAllNames{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[VMTools documentPath] stringByAppendingPathComponent:@"name.text"]];
    return array;
}

-(void)saveNames:(NSArray *)names{
    BOOL result = [names writeToFile:[[VMTools documentPath]stringByAppendingPathComponent:@"name.text"] atomically:YES];
    if (NO == result) {
        [VMTools alertMessage:@"保存失败！"];
    }
}

#pragma mrak - book actions ------

-(BOOL)saveAsNewBook:(YSBookObject *)book{
    
    if (book == nil) {
        return NO;
    }
    return [self.dbManager writeInfo:[book bookTableDictionary] toTable:kBOOKTABLE];
}

-(BOOL)updateAsNewBook:(YSBookObject *)book{
    if (book == nil) {
        return NO;
    }
    return [self.dbManager updateTable:kBOOKTABLE withDictionary:[book bookTableDictionary] referKey:@"ID" referValue:book.mainID];
}

-(YSBookObject *)currentBook{
    if (_currentBook == nil) {
        _currentBook = [[YSBookObject alloc]init];
    }
    return _currentBook;
}

-(VMDataBaseManager *)dbManager{
    if (_dbManager == nil) {
        _dbManager = [VMDataBaseManager shareDBManager];
    }
    return _dbManager;
}


@end
