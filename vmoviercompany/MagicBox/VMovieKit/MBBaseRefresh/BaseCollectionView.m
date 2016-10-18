//
//  BaseCollectionView.m
//  pulldownDemo
//
//  Created by 李国志 on 15/11/10.
//  Copyright © 2015年 LGZ. All rights reserved.
//

#import "BaseCollectionView.h"
#import "MBRefreshAutoFooter.h"
#import "MBRefreshHeader.h"
#import "MBRefreshShockFooter.h"


static  NSString *const CollectionViewCellIdentifier = @"VmovierCollection";

@implementation BaseCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)awakeFromNib {
    [self creatSubViews];
}

- (void)creatSubViews {
    self.delegate = self;
    self.dataSource = self;
    
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    
    self.mj_header = [MBRefreshHeader headerWithRefreshingBlock:^{
        if (_pullDownBlock) {
            _pullDownBlock(self);
        }
    }];
    
//    self.mj_footer = [MBRefreshAutoFooter footerWithRefreshingBlock:^{
//        if (_pullUpBlock) {
//            _pullUpBlock(self);
//        }
//    }];

    self.mj_footer = [MBRefreshShockFooter footerWithRefreshingBlock:^{
        if (_pullUpBlock) {
            _pullUpBlock(self);
        }
    }];
}


#pragma mark - UICollectionViewDelegate And UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


@end
