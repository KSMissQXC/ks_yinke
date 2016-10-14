//
//  KSHomeNearbyCell.m
//  KS_inke
//
//  Created by 耳动人王 on 2016/10/12.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSHomeNearbyCell.h"
#import "KSLive.h"


@interface KSHomeNearbyCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;




@end

@implementation KSHomeNearbyCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setLiveItem:(KSLive *)liveItem{
    _liveItem = liveItem;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,liveItem.creator.portrait]] placeholderImage:[UIImage imageNamed:@"default_room"]];
//    KSLog(@"--%@",liveItem.distance);
    self.distanceLabel.text = liveItem.distance;
}

-(void)showAnimation{
    if (self.liveItem.isShow) return;
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:0.25 animations:^{
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
        self.liveItem.show = YES;
    }];

}







@end
