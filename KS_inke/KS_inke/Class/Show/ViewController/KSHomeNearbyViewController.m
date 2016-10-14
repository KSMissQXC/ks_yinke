//
//  KSHomeNearbyViewController.m
//  KS_inke
//
//  Created by 耳动人王 on 16/10/9.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSHomeNearbyViewController.h"
#import "KSLiveHandler.h"
#import "KSHomeNearbyCell.h"
#import "KSPlayerViewController.h"


#define KMargin 5
#define KItemWidth 100

@interface KSHomeNearbyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *dataArray;


@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;





@end

static NSString *ID = @"KSHomeNearbyCell";
@implementation KSHomeNearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
    
    
}

-(void)initUI{
    [self.collectionView registerNib:[UINib nibWithNibName:ID bundle:nil] forCellWithReuseIdentifier:ID];
    
    NSInteger count = SCREEN_WIDTH / KItemWidth;
    CGFloat etraWidth = (SCREEN_WIDTH - KMargin * (count + 1)) / count;
    self.flowLayout.itemSize = CGSizeMake(etraWidth, etraWidth + 20);
    
}

-(void)loadData{
    [KSLiveHandler excuteGetNearByTaskWithSuccess:^(id obj) {
        self.dataArray = obj;
        [self.collectionView reloadData];
        
    } failed:^(id obj) {
        
    }];
    
}

#pragma mark - 代理
#pragma mark collectionView代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KSHomeNearbyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.liveItem = self.dataArray[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KSHomeNearbyCell *nearbyCell = (KSHomeNearbyCell *)cell;
    [nearbyCell showAnimation];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    KSPlayerViewController *playVc = [[KSPlayerViewController alloc]init];
    playVc.liveItem = self.dataArray[indexPath.item];
    [self.navigationController pushViewController:playVc animated:YES];
    
}







@end
