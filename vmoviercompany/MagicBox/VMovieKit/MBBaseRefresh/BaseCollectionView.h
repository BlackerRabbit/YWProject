//
//  BaseCollectionView.h
//  pulldownDemo
//
//  Created by 李国志 on 15/11/10.
//  Copyright © 2015年 LGZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"

@class BaseCollectionView;

typedef void (^CollectionPullDownBlock)(BaseCollectionView *collectionView);
typedef void (^CollectionPullUpBlock)(BaseCollectionView *collectionView);

@interface BaseCollectionView : UICollectionView <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) CollectionPullDownBlock pullDownBlock;
@property (nonatomic, copy) CollectionPullUpBlock   pullUpBlock;

@end
