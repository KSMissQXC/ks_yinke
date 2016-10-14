//
//  KSLocationManager.h
//  KS_inke
//
//  Created by 耳动人王 on 2016/10/12.
//  Copyright © 2016年 KS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^KSLocationManagerBlock)(NSString *lat,NSString *lon);

@interface KSLocationManager : NSObject

+(instancetype)sharedLocationManager;

-(void)getLocation:(KSLocationManagerBlock)block;

@property(nonatomic,copy)NSString * lat;
@property(nonatomic,copy)NSString * lon;

@end
