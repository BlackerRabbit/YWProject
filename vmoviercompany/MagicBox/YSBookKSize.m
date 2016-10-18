//
//  YSBookKSize.m
//  MagicBox
//
//  Created by 蒋正峰 on 16/7/8.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import "YSBookKSize.h"
#import "AppDelegate.h"

@interface YSBookKSize ()

@end

@implementation YSBookKSize
-(id)init{
    self = [super init];
    if (self) {
        self.widthNum = 5;
        self.heightNum = 7;
        self.kSize = 4;
    }
    return self;
}


+(YSBookKSize *)KSizeOne{
    return [YSBookKSize KSizeWithWidth:1 height:1 kSize:1];
}

+(YSBookKSize *)KSizeTwo{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:2 height:1 kSize:2];
}

+(YSBookKSize *)KSizeThreeHeng{
    return [YSBookKSize KSizeWithWidth:1 height:3 kSize:3];
}

+(YSBookKSize *)KSizeThreeShu{
    return [YSBookKSize kSizeWithExternThree];
}

+(YSBookKSize *)KSizeFour{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:2 height:2 kSize:4];
}

+(YSBookKSize *)KSizeFourHeng{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:4 height:1 kSize:4];
}

+(YSBookKSize *)KSizeFive{
    return [YSBookKSize KSizeWithWidth:5 height:1 kSize:5];
}

+(YSBookKSize *)KSizeSixFirst{
    return [YSBookKSize KSizeWithWidth:3 height:2 kSize:6];
}

+(YSBookKSize *)KSizeSixSecond{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:2 height:3 kSize:6];
}

+(YSBookKSize *)KSizeSixThird{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:6 height:1 kSize:6];
}

+(YSBookKSize *)KSizeEightHeng{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:4 height:2 kSize:8];
}

+(YSBookKSize *)KSizeEightShu{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:2 height:4 kSize:8];
}


#pragma mark - 9 KSize

+(YSBookKSize *)KSizeNigh{
    return [YSBookKSize KSizeWithWidth:3 height:3 kSize:9];
}

#pragma mark - 10 KSize

+(YSBookKSize *)KSizeTenSecond{
    return [YSBookKSize KSizeWithWidth:5 height:2 kSize:10];
}
+(YSBookKSize *)KSizeTenThird{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:2 height:5 kSize:10];
}


+(YSBookKSize *)KSizeTwelveFirst{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:6 height:2 kSize:12];
}

+(YSBookKSize *)KSizeTwelveSecond{
    return [YSBookKSize KSizeWithWidth:3 height:4 kSize:12];
}

+(YSBookKSize *)KSizeTwelveThird{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:4 height:3 kSize:12];
}

#pragma mark - 14 KSize

+(YSBookKSize *)KSizeForteenFirst{
    return [YSBookKSize KSizeWithWidth:7 height:2 kSize:14];
}

+(YSBookKSize *)KSizeForteenThird{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:2 height:7 kSize:14];
}

#pragma mark - 15 KSize -

+(YSBookKSize *)KSizeFifteenThird{
    return [YSBookKSize KSizeWithWidth:5 height:3 kSize:15];
}

+(YSBookKSize *)KSizeFifteenForth{
    return [YSBookKSize KSizeWithWidth:3 height:5 kSize:15];
}


#pragma mark - 16 KSize -

+(YSBookKSize *)KSizeSixteenFirst{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:4 height:4 kSize:16];
}

+(YSBookKSize *)KSizeSixteenThird{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:8 height:2 kSize:16];
}

#pragma mark - 18 KSize -

+(YSBookKSize *)KSizeEighteenFirst{
    return [YSBookKSize KSizeWithWidth:3 height:6 kSize:18];
}

+(YSBookKSize *)KSizeEighteenThird{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:6 height:3 kSize:18];
}

+(YSBookKSize *)KSizeEighteenFifth{
    return [YSBookKSize KSizeWithWidth:9 height:2 kSize:18];
}

#pragma mark - 20 KSize -

+(YSBookKSize *)KSizeTwentyThird{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:10 height:2 kSize:20];
}

+(YSBookKSize *)KSizeTwentyForth{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:4 height:5 kSize:20];
}

+(YSBookKSize *)KSizeTwentySix{
    return [YSBookKSize KSizeWithWidth:5 height:4 kSize:20];
}


#pragma mark - 24 KSize -

+(YSBookKSize *)KSizeTwentyFourSecond{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:4 height:6 kSize:24];
}

+(YSBookKSize *)KSizeTwentyFourThird{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:6 height:4 kSize:24];
}

+(YSBookKSize *)KSizeTwentyFourForth{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:8 height:3 kSize:24];
}

#pragma mark - 25 KSize -

+(YSBookKSize *)KSizeTwentyFiveForth{
    return [YSBookKSize KSizeWithWidth:5 height:5 kSize:25];
}


#pragma mark - 28 KSize -

+(YSBookKSize *)KSizeTwentyEight{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:4 height:7 kSize:28];
}


#pragma mark - 30 KSize -

+(YSBookKSize *)KSizeThirtyFirst{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:6 height:5 kSize:30];
}

+(YSBookKSize *)KSizeThirtySecond{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:10 height:3 kSize:30];
}


#pragma mark - 32 KSize -

+(YSBookKSize *)KSizeThirtyTwoFirst{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:8 height:4 kSize:32];
}

+(YSBookKSize *)KSizeThirtyTwoSecond{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:4 height:8 kSize:32];
}

#pragma mark - 36 KSize -

+(YSBookKSize *)KSizeThirtySixFirst{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:6 height:6 kSize:36];
}

#pragma mark - 40 KSize -

+(YSBookKSize *)KSizeFortyFirst{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:10 height:4 kSize:40];
}

+(YSBookKSize *)KSizeFortySecond{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:8 height:5 kSize:40];
}

#pragma mark - 42 KSize -

+(YSBookKSize *)KSizeFortyTwo{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:6 height:7 kSize:42];
}

#pragma mark - 48 KSize -

+(YSBookKSize *)KSizeFortyEightFirst{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:6 height:8 kSize:48];
}

+(YSBookKSize *)KSizeFortyEightSecond{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:8 height:6 kSize:48];
}

+(YSBookKSize *)KSizeFortyEightThird{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:12 height:4 kSize:48];
}

#pragma mark - 50 KSize -

+(YSBookKSize *)KSizeFifty{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:10 height:5 kSize:50];
}

#pragma mark - 56 KSize -

+(YSBookKSize *)KSizeFiftySix{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:8 height:7 kSize:56];
}

#pragma mark - 60 KSize -

+(YSBookKSize *)KSizeSixtyFirst{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:6 height:10 kSize:60];
}

+(YSBookKSize *)KSizeSixtySecond{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:10 height:6 kSize:60];
}

#pragma mark - 64 KSize -

+(YSBookKSize *)KSizeSixtyFour{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:8 height:8 kSize:64];
}

#pragma mark - 72 KSize -

+(YSBookKSize *)KSizeSevenTyTwo{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:12 height:6 kSize:72];
}

#pragma mark - 80 KSize -

+(YSBookKSize *)KSizeEightyFirst{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:8 height:10 kSize:80];
}

+(YSBookKSize *)KSizeEightySecond{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:10 height:8 kSize:80];
}

#pragma mark - 96 KSize -

+(YSBookKSize *)KSizeNightySix{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:16 height:6 kSize:96];
}

#pragma mark - 100 KSize -

+(YSBookKSize *)KSizeOneHoundred{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:10 height:10 kSize:100];
}

#pragma mark - 128 KSize -

+(YSBookKSize *)KSizeOneHoundredTwentyEight{
    return [YSBookKSize KSizeCanDuiKaiWithWidth:16 height:8 kSize:128];
}


+(YSBookKSize *)KSizeWithWidth:(NSInteger)width
                        height:(NSInteger)height
                         kSize:(NSInteger)kSize{
    
    YSBookKSize *kSizeBook = [[YSBookKSize alloc]init];
    kSizeBook.widthNum = width;
    kSizeBook.heightNum = height;
    kSizeBook.kSize = kSize;
    return kSizeBook;
}

+(YSBookKSize *)KSizeCanDuiKaiWithWidth:(NSInteger)width
                                 height:(NSInteger)height
                                  kSize:(NSInteger)kSize{
    
    YSBookKSize *kSizeBook = [[YSBookKSize alloc]init];
    kSizeBook.widthNum = width;
    kSizeBook.heightNum = height;
    kSizeBook.kSize = kSize;
    kSizeBook.canBeDuiKai = YES;
    return kSizeBook;
}

+(YSBookKSize *)kSizeWithExternThree{
    YSBookKSize *kSizeBook = [YSBookKSize KSizeWithWidth:3 height:1 kSize:3];
    kSizeBook.canBeDuiKai = YES;
    kSizeBook.isThreeDouble = YES;
    return kSizeBook;
}


+(YSBookKSize *)kSizeWithExternFourteen{
    YSBookKSize *kSizeBook = [YSBookKSize KSizeWithWidth:7 height:2 kSize:14];
    kSizeBook.canBeDuiKai = YES;
    kSizeBook.isForthDouble = YES;
    return kSizeBook;
}





+(NSArray *)allValidkSize{
    return @[];
}


+(NSDictionary *)allkSizeDictionary{
    
    return @{
             @"1":@[@{@"ksize":[YSBookKSize KSizeOne],
                      @"pageSize":[self bookRealSizeWithKSize:1 andIndex:0]
                    }],
             
             @"2":@[@{@"ksize":[YSBookKSize KSizeTwo],
                      @"pageSize":[self bookRealSizeWithKSize:2 andIndex:0]
                    }],
             
             @"3":@[
                     @{@"ksize":[YSBookKSize KSizeThreeHeng],
                       @"pageSize":[self bookRealSizeWithKSize:3 andIndex:1]},
                     @{@"ksize":[YSBookKSize KSizeThreeShu],
                       @"pageSize":[self bookRealSizeWithKSize:3 andIndex:2]},
                    ],
             
             @"4":@[
                     @{@"ksize":[YSBookKSize KSizeFour],
                       @"pageSize":[self bookRealSizeWithKSize:4 andIndex:1]},
                     @{@"ksize":[YSBookKSize KSizeFourHeng],
                       @"pageSize":[self bookRealSizeWithKSize:4 andIndex:2]
                       }],
             @"5":@[@{@"ksize":[YSBookKSize KSizeFive],
                      @"pageSize":[self bookRealSizeWithKSize:5 andIndex:0]
                      }],
             @"6":@[
                     @{@"ksize":[YSBookKSize KSizeSixFirst],
                       @"pageSize":[self bookRealSizeWithKSize:6 andIndex:1]},
                     @{@"ksize":[YSBookKSize KSizeSixSecond],
                       @"pageSize":[self bookRealSizeWithKSize:6 andIndex:2]
                       },
                     @{@"ksize":[YSBookKSize KSizeSixThird],
                       @"pageSize":[self bookRealSizeWithKSize:6 andIndex:3]
                       }],
             
             @"8":@[
                     @{@"ksize":[YSBookKSize KSizeEightHeng],
                       @"pageSize":[self bookRealSizeWithKSize:8 andIndex:1]},
                     @{@"ksize":[YSBookKSize KSizeEightShu],
                       @"pageSize":[self bookRealSizeWithKSize:8 andIndex:2]
                       }],
             
             @"9":@[
                     @{@"ksize":[YSBookKSize KSizeNigh],
                       @"pageSize":[self bookRealSizeWithKSize:9 andIndex:0]}
                     ],
             
             @"10":@[
                     @{@"ksize":[YSBookKSize KSizeTenSecond],
                       @"pageSize":[self bookRealSizeWithKSize:10 andIndex:1]},
                     @{@"ksize":[YSBookKSize KSizeTenThird],
                       @"pageSize":[self bookRealSizeWithKSize:10 andIndex:2]
                       }
                     ],
        
             @"12":@[
                     @{@"ksize":[YSBookKSize KSizeTwelveFirst],
                       @"pageSize":[self bookRealSizeWithKSize:12 andIndex:1]},
                     @{@"ksize":[YSBookKSize KSizeTwelveSecond],
                       @"pageSize":[self bookRealSizeWithKSize:12 andIndex:2]},
                     @{@"ksize":[YSBookKSize KSizeTwelveThird],
                       @"pageSize":[self bookRealSizeWithKSize:12 andIndex:3]
                       }],
             @"14":@[  @{@"ksize":[YSBookKSize KSizeForteenFirst],
                         @"pageSize":[self bookRealSizeWithKSize:14 andIndex:1]},
                       @{@"ksize":[YSBookKSize KSizeForteenThird],
                         @"pageSize":[self bookRealSizeWithKSize:14 andIndex:2]},
                       ],
             
             @"15":@[  @{@"ksize":[YSBookKSize KSizeFifteenThird],
                         @"pageSize":[self bookRealSizeWithKSize:15 andIndex:1]},
                       @{@"ksize":[YSBookKSize KSizeFifteenForth],
                         @"pageSize":[self bookRealSizeWithKSize:15 andIndex:2]},
                       ],
             
             @"16":@[ @{@"ksize":[YSBookKSize KSizeSixteenFirst],
                        @"pageSize":[self bookRealSizeWithKSize:16 andIndex:1]},
                      @{@"ksize":[YSBookKSize KSizeSixteenThird],
                        @"pageSize":[self bookRealSizeWithKSize:16 andIndex:2]},],
             
             @"18":@[ @{@"ksize":[YSBookKSize KSizeEighteenFirst],
                        @"pageSize":[self bookRealSizeWithKSize:18 andIndex:1]},
                      @{@"ksize":[YSBookKSize KSizeEighteenThird],
                        @"pageSize":[self bookRealSizeWithKSize:18 andIndex:2]},
                      @{@"ksize":[YSBookKSize KSizeEighteenFifth],
                        @"pageSize":[self bookRealSizeWithKSize:18 andIndex:3]
                        }],
             @"20":@[ @{@"ksize":[YSBookKSize KSizeTwentyThird],
                        @"pageSize":[self bookRealSizeWithKSize:20 andIndex:1]},
                      @{@"ksize":[YSBookKSize KSizeTwentyForth],
                        @"pageSize":[self bookRealSizeWithKSize:20 andIndex:2]},
                      @{@"ksize":[YSBookKSize KSizeTwentySix],
                        @"pageSize":[self bookRealSizeWithKSize:20 andIndex:3]
                        }],
             
             @"24":@[@{@"ksize":[YSBookKSize KSizeTwentyFourSecond],
                       @"pageSize":[self bookRealSizeWithKSize:24 andIndex:1]},
                     @{@"ksize":[YSBookKSize KSizeTwentyFourThird],
                       @"pageSize":[self bookRealSizeWithKSize:24 andIndex:2]},
                     @{@"ksize":[YSBookKSize KSizeTwentyFourForth],
                       @"pageSize":[self bookRealSizeWithKSize:24 andIndex:3]
                       }],
             
             @"25":@[
                     @{@"ksize":[YSBookKSize KSizeTwentyFiveForth],
                       @"pageSize":[self bookRealSizeWithKSize:25 andIndex:0]}
                     ],
       
             @"28":@[ @{@"ksize":[YSBookKSize KSizeTwentyEight],
                        @"pageSize":[self bookRealSizeWithKSize:28 andIndex:0]}
                      ],
             
             @"30":@[@{@"ksize":[YSBookKSize KSizeThirtyFirst],
                       @"pageSize":[self bookRealSizeWithKSize:30 andIndex:1]},
                     @{@"ksize":[YSBookKSize KSizeThirtySecond],
                       @"pageSize":[self bookRealSizeWithKSize:30 andIndex:2]},
                    ],
          
             @"32":@[@{@"ksize":[YSBookKSize KSizeThirtyTwoFirst],
                       @"pageSize":[self bookRealSizeWithKSize:32 andIndex:1]
                       },
                     @{@"ksize":[YSBookKSize KSizeThirtyTwoSecond],
                       @"pageSize":[self bookRealSizeWithKSize:32 andIndex:2]
                       }],
             @"36":@[@{@"ksize":[YSBookKSize KSizeThirtySixFirst],
                       @"pageSize":[self bookRealSizeWithKSize:36 andIndex:0]
                       }],
             @"40":@[@{@"ksize":[YSBookKSize KSizeFortyFirst],
                       @"pageSize":[self bookRealSizeWithKSize:40 andIndex:1]
                       },
                     @{@"ksize":[YSBookKSize KSizeFortySecond],
                       @"pageSize":[self bookRealSizeWithKSize:40 andIndex:2]
                       }],
             
             @"42":@[@{@"ksize":[YSBookKSize KSizeFortyTwo],
                       @"pageSize":[self bookRealSizeWithKSize:42 andIndex:0]
                       }],
             
             @"48":@[@{@"ksize":[YSBookKSize KSizeFortyEightFirst],
                       @"pageSize":[self bookRealSizeWithKSize:48 andIndex:1]
                       },
                     @{@"ksize":[YSBookKSize KSizeFortyEightSecond],
                       @"pageSize":[self bookRealSizeWithKSize:48 andIndex:2]
                       },
                     @{@"ksize":[YSBookKSize KSizeFortyEightThird],
                       @"pageSize":[self bookRealSizeWithKSize:48 andIndex:3]
                       }],
             @"50":@[@{@"ksize":[YSBookKSize KSizeFifty],
                       @"pageSize":[self bookRealSizeWithKSize:50 andIndex:0]
                       }],
             @"56":@[@{@"ksize":[YSBookKSize KSizeFiftySix],
                       @"pageSize":[self bookRealSizeWithKSize:56 andIndex:0]
                       }],
             @"60":@[@{@"ksize":[YSBookKSize KSizeSixtyFirst],
                       @"pageSize":[self bookRealSizeWithKSize:60 andIndex:1]
                       },
                     @{@"ksize":[YSBookKSize KSizeSixtySecond],
                       @"pageSize":[self bookRealSizeWithKSize:60 andIndex:2]
                       }],
             @"64":@[@{@"ksize":[YSBookKSize KSizeSixtyFour],
                       @"pageSize":[self bookRealSizeWithKSize:64 andIndex:0]
                       }],
             @"72":@[@{@"ksize":[YSBookKSize KSizeSevenTyTwo],
                       @"pageSize":[self bookRealSizeWithKSize:72 andIndex:0]
                       }],
             @"80":@[@{@"ksize":[YSBookKSize KSizeEightyFirst],
                       @"pageSize":[self bookRealSizeWithKSize:80 andIndex:1]
                       },
                     @{@"ksize":[YSBookKSize KSizeEightySecond],
                       @"pageSize":[self bookRealSizeWithKSize:80 andIndex:2]
                       }],
             @"96":@[@{@"ksize":[YSBookKSize KSizeNightySix],
                       @"pageSize":[self bookRealSizeWithKSize:96 andIndex:0]
                       }],
             @"100":@[@{@"ksize":[YSBookKSize KSizeOneHoundred],
                        @"pageSize":[self bookRealSizeWithKSize:100 andIndex:0]
                        }],
             @"128":@[@{@"ksize":[YSBookKSize KSizeOneHoundredTwentyEight],
                        @"pageSize":[self bookRealSizeWithKSize:128 andIndex:0]
                        }],
             };
}



+(NSArray *)avildKsizeWithRealSize:(NSInteger)kSize{
    NSString *kSizeString = [NSString stringWithFormat:@"%ld",kSize];
    return [self allkSizeDictionary][kSizeString];
}

+(NSArray *)bookRealSizeWithKSize:(NSInteger)kSize andIndex:(NSInteger)index{

    AppDelegate *appdele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSArray *allKsizeArray = appdele.allLocalData;
    NSString *ksizeKey = nil;
    if (index == 0) {
        ksizeKey = [NSString stringWithFormat:@"%ld",kSize];
    }else{
        ksizeKey = [NSString stringWithFormat:@"%ld-%ld",kSize,index];
    }
    
    for (NSDictionary *dic in allKsizeArray) {
        if (dic[ksizeKey]) {
            return dic[ksizeKey];
        }
    }
    
    return @[];
}


+(NSArray *)allWholePageSize{
    return @[
             @"787x1092",
             @"900x1280",
             
             @"850x1168",
             @"1000x1400",
             
             @"880x1230",
             @"890x1240",
             
             @"889x1194",
             @"800x1100",
             
             @"787x960",
             @"710x1000"
             ];
}

+(NSArray *)allBookAndTheKSize{
    return @[
             @"1",
             @"2",
             @"3",
             @"4",
             @"5",
             @"6",
             @"8",
             @"9",
             @"10",
             @"12",
             @"14",
             @"15",
             @"16",
             @"18",
             @"20",
             @"24",
             @"25",
             @"28",
             @"30",
             @"32",
             @"36",
             @"40",
             @"42",
             @"48",
             @"50",
             @"56",
             @"60",
             @"64",
             @"72",
             @"80",
             @"96",
             @"100",
             @"128"
             ];
}

+(NSArray *)loadDataFromBundlePackage{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"shuju" ofType:@"txt"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
    NSArray *firstRankAry = [str componentsSeparatedByString:@"==="];
    //这个用来装所有的数据
    NSMutableArray *dataAry = [@[]mutableCopy];
    for (NSString *rankStr in firstRankAry) {
        NSMutableDictionary *rankDic = [@{}mutableCopy];
        if ([rankStr containSubstring:@"***"]) {
            NSArray *smalAry = [rankStr componentsSeparatedByString:@"***"];
            for (NSString *smallStr in smalAry) {
                if ([smallStr containsString:@")"]) {
                    NSMutableDictionary *objDic = [@{}mutableCopy];
                    NSArray *array = [smallStr componentsSeparatedByString:@")"];
                    NSString *kSizeAllString = array.firstObject;
                    NSString *kSize = [[[kSizeAllString componentsSeparatedByString:@"("] firstObject] replaceString:@"\n" withString:@""];
                    
                    NSString *valueString = [array lastObject];
                    
                    NSArray *allValues = [valueString componentsSeparatedByString:@","];
                    NSMutableArray *valueAry = [@[]mutableCopy];
                    for (NSString *str in allValues) {
                        NSString *cleanValue = [str replaceString:@"\n" withString:@","];
                        NSArray *value = [cleanValue componentsSeparatedByString:@","];
                        NSMutableString *valueMutableStr = [@""mutableCopy];
                        for (NSString *vlaueStr in value) {
                            if (vlaueStr.length > 2) {
                                [valueMutableStr appendFormat:@"%@,",vlaueStr];
                            }
                        }
                        if ([valueMutableStr hasSuffix:@","]) {
                            [valueMutableStr deleteCharactersInRange:NSMakeRange(valueMutableStr.length - 1, 1)];
                        }
                        
                        if (valueMutableStr.length > 2) {
                            [valueAry addObject:valueMutableStr];
                        }
                    }
                    [objDic setObject:valueAry forKey:kSize];
                    [dataAry addObject:objDic];
                }else{
                    NSLog(@"=============>>>>>>");
                }
            }
        }else{
            
            if ([rankStr containsString:@")"]) {
                NSArray *array = [rankStr componentsSeparatedByString:@")"];
                NSString *kSizeAllString = array.firstObject;
                NSString *kSize = [[[kSizeAllString componentsSeparatedByString:@"("] firstObject] replaceString:@"\n" withString:@""];
                NSString *valueString = [array lastObject];
                
                NSArray *allValues = [valueString componentsSeparatedByString:@","];
                NSMutableArray *valueAry = [@[]mutableCopy];
                for (NSString *str in allValues) {
                    NSString *cleanValue = [str replaceString:@"\n" withString:@","];
                    NSArray *value = [cleanValue componentsSeparatedByString:@","];
                    NSMutableString *valueMutableStr = [@""mutableCopy];
                    for (NSString *vlaueStr in value) {
                        if (vlaueStr.length > 2) {
                            [valueMutableStr appendFormat:@"%@,",vlaueStr];
                        }
                    }
                    if ([valueMutableStr hasSuffix:@","]) {
                        [valueMutableStr deleteCharactersInRange:NSMakeRange(valueMutableStr.length - 1, 1)];
                    }

                    if (valueMutableStr.length > 2) {
                        [valueAry addObject:valueMutableStr];
                    }
                }
                [rankDic setObject:valueAry forKey:kSize];
                [dataAry addObject:rankDic];
            }
        }
    }
    return [dataAry copy];
}

+(NSArray *)allPaperSizeFromLocal{
    return @[];

}


@end
