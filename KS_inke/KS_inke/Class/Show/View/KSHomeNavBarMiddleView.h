//
//  KSHomeNavBarMiddleView.h
//  KS_inke
//
//  Created by 耳动人王 on 16/10/9.
//  Copyright © 2016年 KS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSHomeNavBarMiddleView;

typedef NS_ENUM(NSInteger,KSHomeNavBarMiddleViewItemType) {
    KSHomeNavBarMiddleViewItemFocus = 0,//关注
    KSHomeNavBarMiddleViewItemHot ,//热门
    KSHomeNavBarMiddleViewItemNearby//附近
    
    
};
@protocol KSHomeNavBarMiddleViewDelegate <NSObject>

-(void)homeNavBarMiddleView:(KSHomeNavBarMiddleView *)middleView clickMiddleBtn:(KSHomeNavBarMiddleViewItemType)itemType;

@end


@interface KSHomeNavBarMiddleView : UIView

@property(nonatomic,weak)id<KSHomeNavBarMiddleViewDelegate> delegate;


-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

-(void)scrollToDestinationWithIndex:(KSHomeNavBarMiddleViewItemType)index;


@end
