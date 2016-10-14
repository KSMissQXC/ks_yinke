//
//  KSHomeNearbyCell.h
//  KS_inke
//
//  Created by 耳动人王 on 2016/10/12.
//  Copyright © 2016年 KS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KSLive;
@interface KSHomeNearbyCell : UICollectionViewCell
@property(nonatomic,strong)KSLive *liveItem;
-(void)showAnimation;

@end
