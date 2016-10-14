//
//  KSRequestTool.h
//  KS_inke
//
//  Created by 耳动人王 on 16/10/10.
//  Copyright © 2016年 KS. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef  void(^ _Nullable RequestProgress)(NSProgress *progress);
typedef void(^_Nullable RequestSucess)(NSURLSessionTask *_Nullable task,id _Nullable json);
typedef void(^_Nullable RequestFailure)(NSURLSessionTask *_Nullable task,NSError *error);



@interface KSRequestTool : NSObject

//GET网络请求
+(void)GET:(NSString * _Nullable)urlStr parameters:(NSDictionary * _Nullable)params progress:(RequestProgress)downLoadProgress success:(RequestSucess)success failure :(RequestFailure)failure;

//POST请求
+(void)POST:(NSString * _Nullable)urlStr parameters:(NSDictionary * _Nullable)params progress:(RequestProgress)progress success:(RequestSucess)success failure:(RequestFailure)failure;

//下载
+(void)downloadWithPath:(NSString *_Nullable)path progress:(RequestProgress)progress success:(RequestSucess)success failure:(RequestFailure)failure;

//上传图片
+(void)uploadImageWithPath:(NSString *_Nullable)path parameters:(NSDictionary *_Nullable)params thumbName:(NSString *_Nullable)imageKey image:(UIImage *_Nullable)image success:(RequestSucess)
success progress:(RequestProgress)progress failure:(RequestFailure)failure;


/**
 - (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
 parameters:(nullable id)parameters
 constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
 progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
 success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
 failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
 */



@end

NS_ASSUME_NONNULL_END

