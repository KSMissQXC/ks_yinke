//
//  ToolClass.m
//  YunYuZhiJia
//
//  Created by 苏荷 on 14/12/3.
//  Copyright (c) 2014年 苏荷. All rights reserved.
//

#import "ToolClass.h"
#import <CommonCrypto/CommonDigest.h>



#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define USER_INFO_KEY @"userInfo"
#define USER_ID_KEY @"userId"
#define ACCOUNT_KEY @"account"

@implementation ToolClass
/**
 * 根据View返回VC
 *
 **/
+ (UIViewController*)viewController:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


//判断是否是有效的邮箱
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//搜索记录动画
+ (void)setAnimationOfSwingAroundWith:(UIView *)view
{
    [UIView animateWithDuration:0.56 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.center = CGPointMake(view.center.x - 10, view.center.y);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            view.center =CGPointMake(view.center.x + 15, view.center.y);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                view.center = CGPointMake(view.center.x - 5, view.center.y);
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
}
//注册界面错误信息的动画提示
+ (void)fastAnimationOfSwingAroundWith:(UIView *)view
{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.center = CGPointMake(view.center.x - 10, view.center.y);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            view.center =CGPointMake(view.center.x + 10, view.center.y);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                view.center = CGPointMake(view.center.x - 10, view.center.y);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    view.center = CGPointMake(view.center.x + 10, view.center.y);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        view.center = CGPointMake(view.center.x, view.center.y);
                    }];
                }];
            }];
        }];
    }];

}
//获取随机验证码
+ (NSString *)getVerificationCode
{
    //    NSArray *strArr = [[NSArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil] ;
    NSArray *strArr = [[NSArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil] ;
    NSMutableString *getStr = [[NSMutableString alloc]initWithCapacity:5];
    for(int i = 0; i < 6; i++) //得到六位随机字符,可自己设长度
    {
        int index = arc4random() % ([strArr count]);  //得到数组中随机数的下标
        [getStr appendString:[strArr objectAtIndex:index]];
        
    }
    NSLog(@"_____验证码:%@",getStr);
    return getStr;
}

//判断合法的电话号码
+ (BOOL)checkTel:(NSString *)str

{
    
    if ([str length] == 0) {
        
        //SHOW_ALERT(@"alert_look_icon", @"请输入电话号码");
        //[ToolClass fastAnimationOfSwingAroundWith:_phoneNumTF];
        return NO;
        
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex =@"^((1[0-9][0-9])|(1[0-9][0-9])|(1[0-9][^4,\\D])|(1[0-9][0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        return NO;
        
    }
    return YES;
    
}
//判断输入是否为空格
+(BOOL)isEmpty:(NSString *) str {
    if (!str) {
        return YES;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}
//读取用户信息
+ (NSDictionary *)getUserInfo
{
    return [USER_DEFAULT objectForKey:USER_INFO_KEY];
}


//

//用户信息
+ (void)saveUserInfo:(NSDictionary *)userInfoDic
{
//    NSLog(@"___________%@",userInfoDic);
    [USER_DEFAULT setObject:userInfoDic forKey:USER_INFO_KEY];
    
    [USER_DEFAULT synchronize];
}

+(void)saveAccount:(NSDictionary *)account
{
    [USER_DEFAULT setObject:account forKey:ACCOUNT_KEY];
    [USER_DEFAULT synchronize];
}

+ (NSDictionary *)getAccount
{
    return [USER_DEFAULT objectForKey:ACCOUNT_KEY];

}


//交互式请求登陆
+(BOOL) isLogin:(UIViewController *)viewController
{
    if ([ToolClass getUserInfo]!=nil) {
        return true;
    }else
    {
        return false;
    }
}


//获取用户id
+ (NSString * )getUserId
{
    NSDictionary *user = [USER_DEFAULT objectForKey:USER_INFO_KEY];
    return [user objectForKey:@"id"];
}

+(BOOL)isFirst
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"];
    // 这里判断是否第一次
    
}



+ (BOOL)isVisitor
{
    if ([[ToolClass getUserId]intValue]<=0) {
        return YES;
    }else{
        return NO;
    }
}

//提示成功提问 成功收藏 成功点赞
+ (void)tipAnimationWith:(NSString *)title
{
    UIWindow * win = [[[UIApplication sharedApplication] delegate] window];
    UILabel *likeLable;
    if (likeLable == nil) {
        UILabel *likeLable=[[UILabel alloc]init];
        
        likeLable.backgroundColor=[UIColor blackColor];
        likeLable.layer.cornerRadius = 5;
        likeLable.layer.masksToBounds = YES;
        likeLable.alpha=0.8;
        likeLable.textAlignment=NSTextAlignmentCenter;
        likeLable.font=[UIFont systemFontOfSize:12];
        likeLable.text=title;
        CGRect rect =[title boundingRectWithSize:CGSizeMake(1000, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        likeLable.bounds = CGRectMake(0, 0, rect.size.width + 20, 30);
        //[likeLable sizeToFit];
        likeLable.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT - 100);
        
        likeLable.textColor=[UIColor whiteColor];
        
        [UIView animateWithDuration:2 animations:^{
            //            likeLable.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-80);
            likeLable.alpha = 1;
        } completion:^(BOOL finished)
         {
             [UIView animateWithDuration:1 animations:^{
                 [likeLable removeFromSuperview];
             }];
         }];
        
        [win addSubview:likeLable];
    }
    
}


//判断是否为整形数字
+ (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+(NSString *)urlencode:(NSString *) str
{
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[str UTF8String];
    unsigned long sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}
//解析 图片宽高
+ (NSDictionary *)pictureWidthAndHeight:(NSString *)str
{
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return  result;
    
}
//压缩图片
+ (UIImage *)imageWithMaxSide:(CGFloat)length sourceImage:(UIImage *)image
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize imgSize = CWSizeReduce(image.size, length);
    UIImage *img = nil;
    
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, scale);  // 创建一个 bitmap context
    
    [image drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)
            blendMode:kCGBlendModeNormal alpha:1.0];              // 将图片绘制到当前的 context 上
    
    img = UIGraphicsGetImageFromCurrentImageContext();            // 从当前 context 中获取刚绘制的图片
    UIGraphicsEndImageContext();
    
    return img;
}
static inline
CGSize CWSizeReduce(CGSize size, CGFloat limit)   // 按比例减少尺寸
{
    CGFloat max = MAX(size.width, size.height);
    if (max < limit) {
        return size;
    }
    
    CGSize imgSize;
    CGFloat ratio = size.height / size.width;
    
    if (size.width > size.height) {
        imgSize = CGSizeMake(limit, limit*ratio);
    } else {
        imgSize = CGSizeMake(limit/ratio, limit);
    }
    
    return imgSize;
}
/*
 
 MD5加密
 
 */

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (char)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(NSString *)number:(float) price
{
    NSString *priceStr = [NSString stringWithFormat:@"%.1f",price];
    if (priceStr.length>=9) {
        return [NSString stringWithFormat:@"%@万",[priceStr substringToIndex:priceStr.length-6]];
    }
    return priceStr;
}

+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

/**
 *  根据生日返回星座
 *
 *  @param birthday 出生日期
 *
 *  @return 星座
 */
+ (NSString*)getConstellationFromBirthday:(NSDate*)birthday{
    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comp1 = [myCal components:NSCalendarUnitMonth| NSCalendarUnitDay fromDate:birthday];
    
    NSInteger month = [comp1 month];
    
    
    NSInteger day = [comp1 day];
    
    return [self getAstroWithMonth:month day:day];
}

//得到星座的算法
+ (NSString *)getAstroWithMonth:(NSInteger)m day:(NSInteger)d{
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    
    NSString *astroFormat = @"102123444543";
    
    NSString *result;
    
    if (m<1||m>12||d<1||d>31){
        
        return @"错误日期格式!";
        
    }
    
    if(m==2 && d>29)
        
    {
        
        return @"错误日期格式!!";
        
    }else if(m==4 || m==6 || m==9 || m==11) {
        
        if (d>30) {
            
            return @"错误日期格式!!!";
            
        }
        
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    return [result stringByAppendingString:@"座"];
    
}

// 根据颜色16进制数值得到UIColor
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}







+ (UIViewController *)currentViewController
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // modal展现方式的底层视图不同
    // 取到第一层时，取到的是UITransitionView，通过这个view拿不到控制器
    UIView *firstLayoutContainerView = [keyWindow.subviews firstObject];
    UIView *secondLayoutContainerView = [firstLayoutContainerView.subviews firstObject];
    UIViewController *vc = [self parentControllerFrom:secondLayoutContainerView];
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)vc;
        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
            return [nav.viewControllers lastObject];
        } else {
            return tab.selectedViewController;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.viewControllers lastObject];
    } else {
        return vc;
    }
    return nil;
}

+ (UIViewController *)parentControllerFrom:(UIView *)subV{
    UIResponder *responder = [subV nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}



+(UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}







@end
