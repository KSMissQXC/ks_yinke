//
//  KSCacheTool.m
//  KS_inke
//
//  Created by 耳动人王 on 2016/10/12.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSCacheTool.h"
#define advertiseImage @"adImage"


@implementation KSCacheTool

+(NSString *)getAdImageStr{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:advertiseImage];
    
}

+(void)saveAdImageStr:(NSString *)str{
    
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:advertiseImage];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


@end
