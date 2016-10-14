//
//  KSLiveHandler.h
//  KS_inke
//
//  Created by 耳动人王 on 16/10/10.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSBaseHandler.h"

@interface KSLiveHandler : KSBaseHandler
+(void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

+(void)excuteGetNearByTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

+(void)excuteGetAdImageByTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;


@end
