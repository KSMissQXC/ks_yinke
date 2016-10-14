//
//  MJExtensionConfig.m
//  KS_inke
//
//  Created by 耳动人王 on 16/10/10.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "KSCreator.h"
#import "KSLive.h"

@implementation MJExtensionConfig

+(void)load{
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"idField":@"id"
                 };
    }];
    
    [KSCreator mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"descriptionField":@"description"
                 };
    }];
    
    [KSCreator mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    [KSLive mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    
}

@end
