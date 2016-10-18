//
//  YSADViewController.h
//  MagicBox
//
//  Created by 蒋正峰 on 16/9/17.
//  Copyright © 2016年 vmovier. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ADViewShouldShowBlock)(BOOL result);
typedef void(^ADViewFindImageCompleteBlock)(UIImage *image , NSString *imgPath , VMError *error);

@interface YSADViewController : UIViewController

-(void)ADViewControllerRequestWithResultBlock:(ADViewShouldShowBlock)block;


@end
