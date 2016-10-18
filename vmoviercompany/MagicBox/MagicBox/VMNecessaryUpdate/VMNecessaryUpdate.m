//
//  VMNecessaryUpdate.m
//  MagicBox
//
//  Created by 刘冲 on 15/12/26.
//  Copyright © 2015年 蒋正峰. All rights reserved.
//

#import "VMNecessaryUpdate.h"
#import "SDImageCache.h"        //获取网络图片的本地缓存
#import "SDWebImageManager.h"   //下载图片

@implementation VMNecessaryUpdate

+(void)updateEmotionKeyBoard
{
    [VMRequestHelper requestGetURL:@"/Option/get?key=emotion" completeBlock:^(id vmRequest, id responseObj) {
        NSLog(@"表情键盘申请成功");
        
        NSMutableDictionary * allEmotionDic = [NSMutableDictionary dictionary];//存放所有表情的字典
        id keyBoardDict = responseObj;
        if (keyBoardDict) {
            if ([keyBoardDict isKindOfClass:[NSDictionary class]]) {
                NSArray * emotionArr = keyBoardDict[@"data"];
                //移除所有字典
                [allEmotionDic removeAllObjects];
                NSMutableArray * txtArray = [NSMutableArray array];
                for (NSDictionary * subDict in emotionArr) {
                        NSString * text = [NSString stringWithFormat:@"[%@]",subDict[@"txt"]];
                        [txtArray addObject:text];
                        [allEmotionDic setObject:subDict[@"url"] forKey:text];
                }
            }
        }
        
        for (NSDictionary * dict in responseObj[@"data"]) {
//            if ([dict[@"is_show"] integerValue] == 1) {
                NSString * urlString = dict[@"url"];
                UIImage * image = [[SDImageCache sharedImageCache]imageFromMemoryCacheForKey:urlString];
                if (image == nil) {
                    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:urlString] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                        
                    }];
                }
//            }
        }
    } errorBlock:^(VMError *error) {
        
    }];

}

@end
