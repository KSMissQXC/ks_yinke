//
//  KSBaseHandler.h
//  KS_inke
//
//  Created by 耳动人王 on 16/10/10.
//  Copyright © 2016年 KS. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  处理完成事件
 */
typedef void(^CompleteBlock)();

/**
 *  处理事件成功
 *
 */
typedef void(^SuccessBlock)(id obj);

/**
 *  处理失败结果
 *
 */

typedef void(^FailedBlock)(id obj);


@interface KSBaseHandler : NSObject



@end
