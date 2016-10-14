//
//  KSAdView.m
//  KS_inke
//
//  Created by 耳动人王 on 2016/10/12.
//  Copyright © 2016年 KS. All rights reserved.
//

#import "KSAdView.h"
#import "KSLiveHandler.h"
#import "KSAd.h"
#import "KSCacheTool.h"
#import <SDWebImageManager.h>


@interface KSAdView ()

@property (weak, nonatomic) IBOutlet UIImageView *adImageView;

@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;


@property (nonatomic, strong) dispatch_source_t timer;


@end

@implementation KSAdView

static NSInteger showTime = 3;

+(instancetype)adView{
    return [[NSBundle mainBundle] loadNibNamed:@"KSAdView" owner:nil options:nil].lastObject;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //1.显示广告
    [self showAdImage];
    
    //2.下载广告
    [self downAdImage];

    //3.开启倒计时
    [self startTimer];
    
}

-(void)showAdImage{
   NSString *imageStr = [KSCacheTool getAdImageStr];
    UIImage *adImage = nil;
    if ([imageStr hasPrefix:@"http"]) {
        adImage = [[SDWebImageManager sharedManager
                             ].imageCache imageFromDiskCacheForKey:imageStr];
    }else{
        NSString * filePath = [NSString stringWithFormat:@"%@%@",IMAGE_HOST,imageStr];
        adImage = [[SDWebImageManager sharedManager
                    ].imageCache imageFromDiskCacheForKey:filePath];
        
    }
       NSLog(@"%@---%@",imageStr,adImage);
    
    if (adImage) {
        self.adImageView.image = adImage;
        [self startTimer];
    }else{
        self.hidden = YES;
    }

}

-(void)downAdImage{
    [KSLiveHandler excuteGetAdImageByTaskWithSuccess:^(id obj) {
        
        KSAd *ad = obj;
//        NSLog(@"--%@",ad.image);
        NSURL *imageUrl = nil;
        if (ad.image == nil || [ad.image isEqualToString:@""]) {
            ad.image = @"http://img05.tooopen.com/images/20140604/sy_62331342149.jpg";
           imageUrl = [NSURL URLWithString:ad.image];
        }else{
           imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,ad.image]];
        }
        if ([ad.image isEqualToString:[KSCacheTool getAdImageStr]]) return ;
        
        NSLog(@"%@",imageUrl);
        [[SDWebImageManager sharedManager] downloadImageWithURL:imageUrl options:SDWebImageAvoidAutoSetImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//            KSLog(@"下载成功---%zd",cacheType);
            //保存到沙盒
//            NSLog(@"%@",image);
            [KSCacheTool saveAdImageStr:ad.image];
            if (self.hidden) {
                [self disMiss];
            }
        }];
        
        
    } failed:^(id obj) {
        KSLog(@"下载失败");
        [self disMiss];

    }];
}

-(void)startTimer{
    __block NSUInteger timeout = showTime + 1;

    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeout <= 0) {
            self.timer = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self disMiss];
            });
            
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.countDownLabel.text = [NSString stringWithFormat:@"跳过 %zd",timeout];
            });
            timeout-- ;
        }

    });
    
    dispatch_resume(timer);
    self.timer = timer;
    
}

-(void)disMiss{
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];

    }];
}




-(void)dealloc{
    KSLog(@"%s",__func__);
}











@end
