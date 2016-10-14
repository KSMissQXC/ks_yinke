//
//  KSTabBar.h
//  KS_inke
//
//  Created by 耳动人王 on 16/10/9.
//  Copyright © 2016年 KS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KSTabBar;

typedef NS_ENUM(NSInteger,KSTabBarItemType){
    KSTabBarItemMid = 10,
    KSTabBarItemHome = 100,
    KSTabBarItemMe
};

@protocol KSTabBarDelegate <NSObject>
-(void)tabBar:(KSTabBar *)tabBar ClickButton:(KSTabBarItemType)buttonType;
@end


@interface KSTabBar : UIView
@property(nonatomic,weak)id <KSTabBarDelegate> delegate;

@end
