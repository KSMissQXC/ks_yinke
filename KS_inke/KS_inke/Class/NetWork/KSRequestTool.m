//
//  KSRequestTool.m
//  KS_inke
//
//  Created by 耳动人王 on 16/10/10.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSRequestTool.h"
#import <AFNetworking.h>



@interface KSHttpClient : AFHTTPSessionManager

+(instancetype)sharedClient;

@end

@implementation KSHttpClient



+(instancetype)sharedClient{
    static KSHttpClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        client = [[KSHttpClient alloc] initWithBaseURL:[NSURL URLWithString:SERVER_HOST] sessionConfiguration:configuration];
        //接收参数类型
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        //设置超时时间
        client.requestSerializer.timeoutInterval = 15;
        //安全策略
        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    
    return client;
    
}

@end

@implementation KSRequestTool


+(void)GET:(NSString *)urlStr parameters:(NSDictionary *)params progress:(RequestProgress)downLoadProgress success:(RequestSucess)success failure:(RequestFailure)failure{
    
    [[KSHttpClient sharedClient] GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        if (downLoadProgress) {
            downLoadProgress(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
    }];
}

+(void)POST:(NSString *)urlStr parameters:(NSDictionary *)params progress:(RequestProgress)progress success:(RequestSucess)success failure:(RequestFailure)failure{
    
    [[KSHttpClient sharedClient] POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            progress(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
        
    }];
}

+(void)downloadWithPath:(NSString *)path progress:(RequestProgress)progress success:(RequestSucess)success failure:(RequestFailure)failure{
    //获取完整的路径
    NSString *URLStr = [SERVER_HOST stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:URLStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downTask = [[KSHttpClient sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //获取沙盒路径
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(nil,error);
            }
        }else{
            if (success) {
                success(nil,filePath.path);
            }
        }
    }];
    
    [downTask resume];
    
}


+(void)uploadImageWithPath:(NSString *)path parameters:(NSDictionary *)params thumbName:(NSString *)imageKey image:(UIImage *)image success:(RequestSucess)success progress:(RequestProgress)progress failure:(RequestFailure)failure{
    
    //获取完整的url路径
    NSString * urlString = [SERVER_HOST stringByAppendingPathComponent:path];
    NSData * data = UIImagePNGRepresentation(image);

    
    [[KSHttpClient sharedClient] POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:imageKey fileName:@"01.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
    }];
    
    
}












@end
