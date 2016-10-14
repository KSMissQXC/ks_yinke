//
//  KSHomeLiveHotCell.m
//  KS_inke
//
//  Created by 耳动人王 on 16/10/11.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSHomeLiveHotCell.h"
#import "KSLive.h"

@interface KSHomeLiveHotCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *userLocalLabel;

@property (weak, nonatomic) IBOutlet UILabel *lookNumberLabel;

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UIImageView *liveStatusImageView;



@end



@implementation KSHomeLiveHotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.width = SCREEN_WIDTH;
    [self layoutIfNeeded];
    
//    NSLog(@"%f",self.headIconImageView.width);
    self.headIconImageView.layer.cornerRadius = self.headIconImageView.width * 0.5;
    self.headIconImageView.layer.masksToBounds = YES;
    
    
}


-(void)setLiveItem:(KSLive *)liveItem{
    _liveItem = liveItem;
//    liveItem.cellHeight = CGRectGetMaxY(self.coverImageView.frame);
    self.userNameLabel.text = liveItem.creator.nick;
    self.userLocalLabel.text = liveItem.city;
    self.lookNumberLabel.text = [@(liveItem.onlineUsers) stringValue];
    [self.headIconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,liveItem.creator.portrait] ] placeholderImage:[UIImage imageNamed:@"default_room"]];
    
     [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,liveItem.creator.portrait] ] placeholderImage:[UIImage imageNamed:@"default_room"]];
    
    
}


@end
