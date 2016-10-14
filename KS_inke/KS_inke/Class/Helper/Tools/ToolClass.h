//
//  ToolClass.h
//  YunYuZhiJia
//
//  Created by 苏荷 on 14/12/3.
//  Copyright (c) 2014年 苏荷. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface ToolClass : NSObject

+ (UIViewController*)viewController:(UIView *)view;

//读取用户信息
+ (NSDictionary *)getUserInfo;
//用户信息
+ (void)saveUserInfo:(NSDictionary *)userInfoDic;

//判断邮箱是否可用
+(BOOL)isValidateEmail:(NSString *)email;
//添加meun导航

+ (void)setAnimationOfSwingAroundWith:(UIView *)view;

+ (void)fastAnimationOfSwingAroundWith:(UIView *)view;

+ (NSString *)getVerificationCode;

//提示成功提问 成功收藏 成功点赞
+ (void)tipAnimationWith:(NSString *)title;
//判断合法的电话号码
+ (BOOL)checkTel:(NSString *)str;

//判断输入是否为空格
+(BOOL)isEmpty:(NSString *) str;

//交互式请求登陆
+(BOOL) isLogin:(UIViewController *)viewController;
//获取用户id
+ (NSString * )getUserId;
//+(BOOL) isFirst;

//是否游客登录
+ (BOOL)isVisitor;

//判断是否为整形数字
+ (BOOL)isPureInt:(NSString *)string;

+(NSString *)urlencode:(NSString *) str;

+ (NSDictionary *)pictureWidthAndHeight:(NSString *)str;

//压缩图片
+ (UIImage *)imageWithMaxSide:(CGFloat)length sourceImage:(UIImage *)image;

//根据生日得到星座
+ (NSString*)getConstellationFromBirthday:(NSDate*)birthday;

// 根据颜色16进制数值得到UIColor
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;


+ (NSString *)md5:(NSString *)str;

+(BOOL)isFirst;

+(void)saveAccount:(NSDictionary *)account;

+ (NSDictionary *)getAccount;

+(NSString *)number:(float) price;

+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;


+ (UIViewController *)currentViewController;

+(UIImage*)createImageWithColor:(UIColor*)color;



@end
