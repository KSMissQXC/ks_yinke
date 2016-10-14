//
//  KSLiveHandler.m
//  KS_inke
//
//  Created by 耳动人王 on 16/10/10.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSLiveHandler.h"
#import "KSLive.h"
#import "KSAd.h"
#import "KSLocationManager.h"


@implementation KSLiveHandler

+(void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    
    [KSRequestTool GET:API_HotLive parameters:nil progress:^(NSProgress * _Nonnull progress) {
        
    } success:^(NSURLSessionTask * _Nullable task, id  _Nullable json) {
        
        if ([json[@"dm_error"] integerValue]) {
            if (failed) {
                failed(json[@"error_msg"]);
            }
        }else{
            //将回来的数据转换成json数据
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
//            
//            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            KSLog(@"%@",jsonStr);
            
            NSArray *liveArray = [KSLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            if (success) {
                success(liveArray);
            }
        }
    } failure:^(NSURLSessionTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
}

+(void)excuteGetNearByTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = @"85149891";
    paramDict[@"latitude"] = [KSLocationManager sharedLocationManager].lat;
    paramDict[@"longitude"] = [KSLocationManager sharedLocationManager].lon;
    
    
    [KSRequestTool GET:API_NearLive parameters:paramDict progress:^(NSProgress * _Nonnull progress) {
    } success:^(NSURLSessionTask * _Nullable task, id  _Nullable json) {
        
        if ([json[@"dm_error"] integerValue]) {
            if (failed) {
                failed(json[@"error_msg"]);
            }
        }else{
            NSArray *liveArray = [KSLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            if (success) {
                success(liveArray);
            }
        }
    } failure:^(NSURLSessionTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
}

+(void)excuteGetAdImageByTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    
    
    [KSRequestTool GET:API_Advertise parameters:nil progress:^(NSProgress * _Nonnull progress) {
    } success:^(NSURLSessionTask * _Nullable task, id  _Nullable json) {
        
        if ([json[@"dm_error"] integerValue]) {
            if (failed) {
                failed(json[@"error_msg"]);
            }
        }else{
           KSAd *ad = [KSAd mj_objectWithKeyValues:json[@"resources"][0]];
            if (success) {
                success(ad);
            }
        }
    } failure:^(NSURLSessionTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];

    
}









@end
