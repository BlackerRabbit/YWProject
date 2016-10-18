//
//  AppDelegate.h
//  MagicBox
//
//  Created by 蒋正峰 on 15/11/2.
//  Copyright © 2015年 蒋正峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "YSRootViewController.h"
@class YSRootViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong, readwrite) NSArray *allLocalData;


@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) YSRootViewController *rootVC;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, copy) void(^backgroundTransferCompletionHandler)();
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

