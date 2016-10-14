//
//  KSMeHeaderView.m
//  KS_inke
//
//  Created by 耳动人王 on 2016/10/14.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSMeHeaderView.h"

@implementation KSMeHeaderView
+(instancetype)meHeaderView{
    KSMeHeaderView *headV =  [[NSBundle mainBundle] loadNibNamed:@"KSMeHeaderView" owner:nil options:nil].lastObject;
    headV.width = SCREEN_WIDTH;
    headV.height = SCREEN_HEIGHT * 0.4;
    headV.autoresizingMask = UIViewAutoresizingNone;
    return headV;
}


@end
